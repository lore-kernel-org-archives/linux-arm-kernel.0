From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Aug 2014 22:11:31 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <1965890.bT7bZyQJt8@amdc1032>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
 <1965890.bT7bZyQJt8@amdc1032>
Message-ID: <3598124.ze8sbSR9ui@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 August 2014 20:05:49 Bartlomiej Zolnierkiewicz wrote:
> I've been looking lately into making it possible to easily go
> from multi_v7_defconfig config to a single platform one (in my
> case Exynos one) and removing the need to keep the latter (i.e.
> exynos_defconfig) in the kernel tree in the long-term.
> 
> Because of this I've noticed that some config options for platform
> specific hardware that are selected in multi_v7_defconfig don't
> have proper dependencies.  This results in more complex than
> necessary single platform configs (obtained from a multiplatform
> config) and unnecessarily bigger resulting kernel images.
> 
> Your patch also adds/uncovers some such config options.
> 
> Lets first look at sizes of resulting vmlinux images for single
> platform Exynos config before and after your patch:
> 
>   $ size vmlinux.*
>      text    data     bss     dec     hex filename
>   7817317  517188  278992 8613497  836e79 vmlinux.before
>   7978325  527012  279056 8784393  860a09 vmlinux.after
> 
>   (=> the patch results in 170kB bigger vmlinux size)
> 

Interesting work. We don't currently have a policy for this,
so we should first talk about whether the behavior that you
want is desirable. The alternative would be that everybody
who wants to build a platform-specific kernel out of
multi_v7_defconfig has to go through the extra work of not
only disabling the platforms but also the individual drivers
for the other platforms.

This is a bit tricky for drivers that may be shared between
a few platforms in multi_v7_defconfig but are meaningless
on the others. We could solve that by having more complex
dependencies for each of those drivers, but that is where
maintaining those gets really messy.

A related problem that I think is more significant is that
some platforms 'select' a particular driver and when you
disable the platform, that driver is suddenly removed from the
defconfig for all other platforms as well. This has bitten
us a few times in the past, and I'd really like to fix those
cases first.

	Arnd
