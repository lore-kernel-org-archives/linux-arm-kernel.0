From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 5 Apr 2018 10:47:08 +0900
Subject: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
In-Reply-To: <5599813d-f83c-d154-287a-c131c48292ca@arm.com>
References: <cover.1495514291.git.panand@redhat.com> <59312080.1090906@arm.com>
 <1963984d-e78e-a5b2-f1a2-fb0a789a505e@redhat.com>
 <CAB=otbT23ySN4VC6G0sBKF5p4SvsnG8PS-C_beBgn8YJUsbw9Q@mail.gmail.com>
 <71f0a333-8bfb-3755-c9fd-e30bf2280339@cisco.com>
 <5599813d-f83c-d154-287a-c131c48292ca@arm.com>
Message-ID: <20180405014707.GB19607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2018 at 02:28:52PM +0100, James Morse wrote:
> Hi Kostiantyn,
> 
> On 04/04/18 13:45, Kostiantyn Iarmak wrote:
> > From: Pratyush Anand <panand@redhat.com>
> >> Date: Fri, Jun 2, 2017 at 5:42 PM
> >> Subject: Re: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
> >> To: James Morse <james.morse@arm.com>
> >> Cc: mark.rutland at arm.com, bhe at redhat.com, kexec at lists.infradead.org,
> >> horms at verge.net.au, dyoung at redhat.com,
> >> linux-arm-kernel at lists.infradead.org
> >>
> >> On Friday 02 June 2017 01:53 PM, James Morse wrote:
> >>> On 23/05/17 06:02, Pratyush Anand wrote:
> >>>> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
> >>>> is around 13MB and initramfs is around 30MB. It takes more than 20 second
> >>>> even when we have -O2 optimization enabled. However, if dcache is enabled
> >>>> during purgatory execution then, it takes just a second in SHA
> >>>> verification.
> >>>>
> >>>> Therefore, these patches adds support for dcache enabling facility during
> >>>> purgatory execution.
> 
> >>> I'm still not convinced we need this. Moving the SHA verification to happen
> >>> before the dcache+mmu are disabled would also solve the delay problem,
> >>
> >> Humm..I am not sure, if we can do that.
> 
> >> When we leave kernel (and enter into purgatory), icache+dcache+mmu are
> >> already disabled. I think, that would be possible when we will be in a
> >> position to use in-kernel purgatory.
> >>
> >>> and we
> >>> can print an error message or fail the syscall.
> >>>
> >>> For kexec we don't expect memory corruption, what are we testing for?
> >>> I can see the use for kdump, but the kdump-kernel is unmapped so the kernel
> >>> can't accidentally write over it.
> >>>
> >>> (we discussed all this last time, but it fizzled-out. If you and the
> >>> ? kexec-tools maintainer think its necessary, fine by me!)
> 
> >> Yes, there had already been discussion and MAINTAINERs have
> >> discouraged none-purgatory implementation.

I don't remember the discussion like this quite well, but anyhow ...

> >>
> >>> I have some comments on making this code easier to maintain..
> >>>
> >> Thanks.
> >>
> >> I have implemented your review comments and have archived the code in
> >>
> >> https://github.com/pratyushanand/kexec-tools.git : purgatory-enable-dcache
> >>
> >> I will be posting the next version only when someone complains about
> >> ARM64 kdump behavior that it is not as fast as x86.
> 
> > On our ARM64-based platform we have very long main kernel-secondary kernel
> > switch time.
> > 
> > This patch set fixes the issue (we are using 4.4 kernel and 2.0.13 kexec-tools
> > version), we can get ~25x speedup, with this patch secondary kernel boots in ~3
> > seconds while on 2.0.13-2.0.16 kexec-tools without this patch switch takes about
> > 75 seconds.
> 
> This is slow because its generating a checksum of the kernel without the benefit
> of the caches. This series generated page tables so that it could enable the MMU
> and caches. But, the purgatory code also needs to be a simple as possible
> because its practically impossible to debug.

Not impossible, but I admit that I occasionally had hard time in debugging.

> The purgatory code does this checksum-ing because its worried the panic() was
> because the kernel cause some memory corruption, and that memory corruption may
> have affected the kdump kernel too.
> 
> This can't happen on arm64 as we unmap kdump's crash region, so not even the
> kernel can accidentally write to it. 98d2e1539b84 ("arm64: kdump: protect crash
> dump kernel memory") has all the details.
> 
> (we also needed to do this to avoid the risk of mismatched memory attributes if
> kdump boots and some CPUs are still stuck in the old kernel)
> 
> 
> > When do you plan merge this patch?
> 
> We ended up with the check-summing code because its the default behaviour of
> kexec-tools on other architectures.
> 
> One alternative is to rip it out for arm64. Untested:

Thanks for the patch. This eventually eliminates "reason d'etre" of
purgatory on arm64 as I does in my kexec_file patch, although it would
require a small re-work.

-Takahiro AKASHI


> --------------------%<--------------------
> diff --git a/purgatory/arch/arm64/Makefile b/purgatory/arch/arm64/Makefile
> index 636abea..f10c148 100644
> --- a/purgatory/arch/arm64/Makefile
> +++ b/purgatory/arch/arm64/Makefile
> @@ -7,7 +7,8 @@ arm64_PURGATORY_EXTRA_CFLAGS = \
>         -Werror-implicit-function-declaration \
>         -Wdeclaration-after-statement \
>         -Werror=implicit-int \
> -       -Werror=strict-prototypes
> +       -Werror=strict-prototypes \
> +       -DNO_SHA_IN_PURGATORY
> 
>  arm64_PURGATORY_SRCS += \
>         purgatory/arch/arm64/entry.S \
> diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
> index 3bbcc09..44e792a 100644
> --- a/purgatory/purgatory.c
> +++ b/purgatory/purgatory.c
> @@ -9,6 +9,8 @@
>  struct sha256_region sha256_regions[SHA256_REGIONS] = {};
>  sha256_digest_t sha256_digest = { };
> 
> +#ifndef NO_SHA_IN_PURGATORY
> +
>  int verify_sha256_digest(void)
>  {
>         struct sha256_region *ptr, *end;
> @@ -39,14 +41,18 @@ int verify_sha256_digest(void)
>         return 0;
>  }
> 
> +#endif /* NO_SHA_IN_PURGATORY */
> +
>  void purgatory(void)
>  {
>         printf("I'm in purgatory\n");
>         setup_arch();
> +#ifndef NO_SHA_IN_PURGATORY
>         if (verify_sha256_digest()) {
>                 for(;;) {
>                         /* loop forever */
>                 }
>         }
> +#endif /* NO_SHA_IN_PURGATORY */
>         post_verification_setup_arch();
>  }
> --------------------%<--------------------
> 
> 
> Thanks,
> 
> James
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
