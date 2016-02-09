From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 9 Feb 2016 10:45:33 +0000
Subject: [PATCH] arm64: allow the module region to be randomized
 independently
In-Reply-To: <CAKv+Gu-vxhJRUMK7sqv1saw+wkQRD5xFydpgTLbKgWhoNj5LmA@mail.gmail.com>
References: <CAGXu5j+1rcScYedzQ5o0aaGZJWPCBGk-gai0D8jY8Huc-VuG7A@mail.gmail.com>
 <1454926332-25929-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160208181305.GW6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-vxhJRUMK7sqv1saw+wkQRD5xFydpgTLbKgWhoNj5LmA@mail.gmail.com>
Message-ID: <20160209104533.GB16122@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 11:03:01AM +0100, Ard Biesheuvel wrote:
> On 8 February 2016 at 19:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Feb 08, 2016 at 11:12:12AM +0100, Ard Biesheuvel wrote:
> >> This adds the option to randomize the module region independently from the
> >> core kernel, and enables it by default. This makes it less likely that the
> >> location of core kernel data structures can be determined by an adversary,
> >> but causes all function calls from modules into the core kernel to be
> >> resolved via entries in the module PLTs.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/Kconfig              | 15 ++++++++
> >>  arch/arm64/include/asm/module.h |  6 ++++
> >>  arch/arm64/kernel/kaslr.c       | 36 +++++++++++++++-----
> >>  arch/arm64/kernel/module.c      |  9 ++---
> >>  4 files changed, 50 insertions(+), 16 deletions(-)
> >
> > With this patch I get an unhandled paging request, coming from
> > kernel/module.c:2982 (the memset). The PC is wrongly attributed but it's
> > in arch/arm64/lib/memset.S:
> >
> 
> This was due to a thinko in kaslr_early_init(). Folding the following
> hunk will fix it (or I can resend the patch if you prefer)
> 
> -------8<----------
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index f8ad30160026..d7eba99ab140 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -82,6 +82,12 @@ u64 __init kaslr_early_init(u64 dt_phys)
>         int size;
> 
>         /*
> +        * Set a reasonable default for module_alloc_base in case
> +        * we end up running with KASLR disabled.
> +        */
> +       module_alloc_base = (u64)_etext - MODULES_VSIZE;
> +
> +       /*
>          * Try to map the FDT early. If this fails, we simply bail,
>          * and proceed with KASLR disabled. We will make another
>          * attempt at mapping the FDT in setup_machine()
> -------8<----------

I'll fold the hunk in and give it a try. Thanks.

-- 
Catalin
