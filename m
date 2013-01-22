From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jan 2013 17:42:57 +0000
Subject: [PATCH 3/6] arm: kconfig: don't select TWD with local timer for
 Armada 370/XP
In-Reply-To: <20130122171817.GM23505@n2100.arm.linux.org.uk>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <201301221557.02976.arnd@arndb.de>
 <20130122171817.GM23505@n2100.arm.linux.org.uk>
Message-ID: <201301221742.57490.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Russell King - ARM Linux wrote:
> > 
> > > >       default y
> > > I am not a kconfig expert, but won't this line set HAVE_ARM_TWD to 'y' whatever
> > > the result of the previous line?
> > 
> > Yes, that was a mistake on my side.
> 
> Sigh.  No.  Wrong.
> 
> config HAVE_ARM_TWD
>         depends on LOCAL_TIMERS
>         default ARCH_MULTIPLATFORM || (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT && !ARMADA_370_XP_TIMER)
>         default y
> 
> This takes the value of the first enabled default.  The first enabled
> default is the first default (it's unconditional).  So, the default y
> will never be used.

Right. I actually know how it works, but didn't think through it this
time. The 'default y' was a mistake on my side and should not have
been in there. I was also missing a 'bool' statement in there, which
makes the whole thing a syntax error.

> Given the above, it's far from clear what the actual behaviour being
> asked for is - it looks totally and utterly screwed to me - and the
> wrong thing to be doing.
> 
> If the desire is to have it enabled if ARCH_MULTIPLATFORM is set, then
> it's easy, and requires just a single line addition:
> 
>  config LOCAL_TIMERS
>         bool "Use local timer interrupts"
>         depends on SMP
>         default y
>         select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
> +       select HAVE_ARM_TWD if ARCH_MULTIPLATFORM

Right. The effect would be the same as what I intended to write:

config LOCAL_TIMERS
        bool "Use local timer interrupts"
        depends on SMP
        default y

config HAVE_ARM_TWD
	def_bool ARCH_MULTIPLATFORM || (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
        depends on LOCAL_TIMERS

but your patch is simpler.

	Arnd
