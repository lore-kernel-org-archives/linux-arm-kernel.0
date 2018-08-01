From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 1 Aug 2018 16:57:21 +0900
Subject: [PATCH v12 16/16] arm64: kexec_file: add kaslr support
In-Reply-To: <405b6708-4518-d81e-3938-39032c2b487e@arm.com>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-17-takahiro.akashi@linaro.org>
 <50b31f17-fc85-aa72-06f5-d3b62060a91f@arm.com>
 <20180727083104.GI11258@linaro.org>
 <405b6708-4518-d81e-3938-39032c2b487e@arm.com>
Message-ID: <20180801075720.GM11258@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

All the changes mentioned below were applied to my coming v13.

On Fri, Jul 27, 2018 at 10:22:31AM +0100, James Morse wrote:
> Hi Akashi,
> 
> 
> On 07/27/2018 09:31 AM, AKASHI Takahiro wrote:
> >On Thu, Jul 26, 2018 at 02:40:49PM +0100, James Morse wrote:
> >>On 24/07/18 07:57, AKASHI Takahiro wrote:
> >>>Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> >>>address randomization, at secondary kernel boot.
> >>Hmm, there are three things that get moved by CONFIG_RANDOMIZE_BASE. The kernel
> >>physical placement when booted via the EFIstub, the kernel-text VAs and the
> >>location of memory in the linear-map region. Adding the kaslr-seed only does the
> >>last two.
> >Yes, but I think that I and Mark has agreed that "kaslr" meant
> >"virtual" randomisation, not including "physical" randomisation.
> Okay, I'll update my terminology!
> 
> 
> >>This means the physical placement of the new kernel is predictable from
> >>/proc/iomem ... but this also tells you the physical placement of the current
> >>kernel, so I don't think this is a problem.
> >>
> >>
> >>>We always do this as it will have no harm on kaslr-incapable kernel.
> >>>We don't have any "switch" to turn off this feature directly, but still
> >>>can suppress it by passing "nokaslr" as a kernel boot argument.
> >>
> >>>diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >>>index 7356da5a53d5..47a4fbd0dc34 100644
> >>>--- a/arch/arm64/kernel/machine_kexec_file.c
> >>>+++ b/arch/arm64/kernel/machine_kexec_file.c
> >>>@@ -158,6 +160,12 @@ static int setup_dtb(struct kimage *image,
> >>Don't you need to reserve some space in the area you vmalloc()d for the DT?
> >No, I don't think so.
> >All the data to be loaded are temporarily saved in kexec buffers,
> >which will eventually be copied to target locations in machine_kexec
> >(arm64_relocate_new_kernel, which, unlike its name, will handle
> >not only kernel but also other data as well).
> 
> I think we're speaking at cross purposes. Don't you need:
> 
> | buf_size += fdt_prop_len("kaslr?seed", sizeof(u64));
> 
> 
> You can't assume the existing DTB had a kaslr-seed property, and the
> difference may take us over a PAGE_SIZE boundary.

I see, I will add that.

> 
> >
> >>
> >>>+	/* add kaslr-seed */
> >>>+	get_random_bytes(&value, sizeof(value));
> >>What happens if the crng isn't ready?
> >>
> >>It looks like this will print a warning that these random-bytes aren't really up
> >>to standard, but the new kernel doesn't know this happened.
> >>
> >>crng_ready() isn't exposed, all we could do now is
> >>wait_for_random_bytes(), but that may wait forever because we do this
> >>unconditionally.
> >>
> >>I'd prefer to leave this feature until we can check crng_ready(), and skip
> >>adding a dodgy-seed if its not-ready. This avoids polluting the next-kernel's
> >>entropy pool.
> >OK. I would try to follow the same way as Bhupesh's userspace patch
> >does for kaslr-seed:
> >http://lists.infradead.org/pipermail/kexec/2018-April/020564.html
> 
> (I really don't understand this 'copying code from user-space' that happens
> with kexec_file_load)
> 
> 
> >   if (not found kaslr-seed in 1st kernel's dtb)
> >      don't care; go ahead
> 
> Don' t bother. As you say in the commit-message its harmless if the new
> kernel doesn't support it.
> Always having this would let you use kexec_file_load as a bootloader that
> can get the crng to
> provide decent entropy even if the platform bootloader can't.

OK, but anyway previous "kaslr-seed" will be dropped first.

> 
> >   else
> >      if (current kaslr-seed != 0)
> >         error
> 
> Don't bother. If this happens its a bug in another part of the kernel that
> doesn't affect this one. We aren't second-guessing the file-system when we
> read the kernel-fd, lets keep this simple.

OK

> >      if (crng_ready()) ; FIXME, it's a local macro
> >         get_random_bytes(non-blocking)
> >         set new kaslr-seed
> >      else
> >         error
> error? Something like pr_warn_once().

It was changed to pr_notice() since there is nothing wrong.

Thanks,
-Takahiro AKASHI

> I thought the kaslr-seed was added to the entropy pool, but now I look again
> I see its a separate EFI table. So the new kernel will add the same entropy
> ... that doesn't sound clever. (I can't see where its zero'd or
> re-initialised)
> 
> 
> 
> Thanks,
> 
> James
