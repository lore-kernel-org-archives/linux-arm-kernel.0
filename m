From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Jul 2014 12:08:43 +0200
Subject: [GIT PULL 2/2] 2nd Samsung S5PV210 DT support for v3.17
In-Reply-To: <53D196FC.40004@samsung.com>
References: <53D196FC.40004@samsung.com>
Message-ID: <5065930.BoSud11E6H@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 July 2014 08:30:04 Kukjin Kim wrote:
> 
> The following changes since commit a7a30232df01db886473324050d79c3122937c78:
> 
>    Merge branch 'v3.17-next/cleanup-samsung' into v3.17-next/dt-s5pv210 
> (2014-07-19 04:24:18 +0900)
> 
> are available in the git repository at:
> 
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/s5pv210-dt
> 

Pulled both branches into next/soc, thanks!

Any reason why you based it on top of -rc6? It's only a minor annoyance,
so I had no reason for not pulling it, but it does make our lives slightly
easier if we don't have to update the baseline -rc.

On a related note, I have two patch sets that I meant to send out earlier.
One moves mach-s5pv210/* into mach-exynos, the other one enables
multiplatform support for s3c64xx. The s3c64xx still has some remaining
issues (debug_ll and adc), so it will have to wait for 3.18 I guess.

If you like, I can still send you the merge of s5pv210 with exynos
to take a look.

Tomasz: one bug I just found yesterday:

        config DEBUG_S3C_UART0
                depends on PLAT_SAMSUNG
                select DEBUG_EXYNOS_UART if ARCH_EXYNOS
                select DEBUG_S3C24XX_UART if ARCH_S3C24XX
                select DEBUG_S5PV210_UART if ARCH_S5PV210

This won't work if you try to enable DEBUG_LL for S5PV210
in a kernel that also includes EXYNOS support. I think it
would be good to fix this for 3.17 in some way, and in the long
run merge all the different implementations into debug/samsung.S 
to avoid this problem altogether.

	Arnd
