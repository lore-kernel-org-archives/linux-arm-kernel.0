From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Apr 2014 16:06:40 +0100
Subject: [PATCH] ARM: reinsert ARCH_MULTI_V4 Kconfig option
In-Reply-To: <CACmBeS3kC4dsdOrfANifgu8oQhLauFKcXhEu=iz8xbUxdhMq_A@mail.gmail.com>
References: <1386922149-4561-1-git-send-email-jonas.jensen@gmail.com>
 <20131213095655.GB4360@n2100.arm.linux.org.uk>
 <CACmBeS1d-EX5oPD8f7P-ufmF=MutdTO+LgG23Cb0=biR8yQPCg@mail.gmail.com>
 <20131213113903.GE4360@n2100.arm.linux.org.uk>
 <CACmBeS3kC4dsdOrfANifgu8oQhLauFKcXhEu=iz8xbUxdhMq_A@mail.gmail.com>
Message-ID: <20140409150640.GQ16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 04:54:16PM +0200, Jonas Jensen wrote:
> On 13 December 2013 12:39, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > I see what's causing this: the kuser helpers are using "bx lr" to return
> > which will be undefined on non-Thumb CPUs.  We generally cope fine with
> > non-Thumb CPUs, conditionalising where necessary on HWCAP_THUMB or the
> > T bit in the PSR being set.
> >
> > However, it looks like the kuser helpers got missed.  As a check, please
> > look at arch/arm/kernel/entry-armv.S, find the line with:
> >
> >         .macro  usr_ret, reg
> >
> > and ensure that the mov pc, \reg case always gets used.  Please report
> > back.
> 
> Uwe and Arnd came up with a solution except it doesn't work when I test it.
> 
> The suggested patch is:
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 1879e8d..de15bfd 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -739,6 +739,18 @@ ENDPROC(__switch_to)
> 
>         .macro  usr_ret, reg
>  #ifdef CONFIG_ARM_THUMB
> +       /*
> +        * Having CONFIG_ARM_THUMB isn't a guarantee that the cpu has support
> +        * for Thumb and so the bx instruction. Use a mov if the address to
> +        * jump to is 32 bit aligned. (Note that this code is compiled in ARM
> +        * mode, so this is the right test.)
> +        */
> +#if defined(CONFIG_CPU_32v4)
> +       tst     \reg, #3
> +       moveq   pc, \reg
> +       b       .
> +#endif
> +
>         bx      \reg

What's wrong with:
	tst	\reg, #3
	moveq	pc, \reg
	bx	\reg

rather than ending in an infinite loop?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
