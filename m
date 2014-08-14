From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 Aug 2014 18:08:25 +0100
Subject: [PATCH] arm64: align randomized TEXT_OFFSET on 4 kB boundary
In-Reply-To: <CAKv+Gu8yne5zdtgsVcsc+D=C--qQcMoOuanPuHeWg+BiKO8xfA@mail.gmail.com>
References: <1407952383-1214-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140814102307.GB24018@leverpostej>
 <CAKv+Gu8yne5zdtgsVcsc+D=C--qQcMoOuanPuHeWg+BiKO8xfA@mail.gmail.com>
Message-ID: <20140814170825.GG9039@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 11:31:35AM +0100, Ard Biesheuvel wrote:
> On 14 August 2014 12:23, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Aug 13, 2014 at 06:53:03PM +0100, Ard Biesheuvel wrote:
> >> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> >> index b6ca95aee348..ae055a18b04a 100644
> >> --- a/arch/arm64/kernel/head.S
> >> +++ b/arch/arm64/kernel/head.S
> >> @@ -38,11 +38,11 @@
> >>
> >>  #define KERNEL_RAM_VADDR     (PAGE_OFFSET + TEXT_OFFSET)
> >>
> >> -#if (TEXT_OFFSET & 0xf) != 0
> >> -#error TEXT_OFFSET must be at least 16B aligned
> >> -#elif (PAGE_OFFSET & 0xfffff) != 0
> >> +#if (TEXT_OFFSET & 0xfff) != 0
> >> +#error TEXT_OFFSET must be at least 4kB aligned
> >
> > Minor nit, but can we have "KB" here to match "MB"?
> 
> Ack
> 
> >> +#elif (PAGE_OFFSET & 0x1fffff) != 0
> >>  #error PAGE_OFFSET must be at least 2MB aligned
> >> -#elif TEXT_OFFSET > 0xfffff
> >> +#elif TEXT_OFFSET > 0x1fffff
> >>  #error TEXT_OFFSET must be less than 2MB
> >>  #endif
> >
> > I thought I'd left wording in Kconfig.debug, but that doesn't seem to be
> > the case. This looks sane to me, so:
> >
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> >
> > Catalin, can you pick this up? Without it UEFI boot can be broken by
> > ARM64_RANDOMIZE_TEXT_OFFSET.
> 
> I assume the above change does not require a v2.

I can fix it up. Thanks.

-- 
Catalin
