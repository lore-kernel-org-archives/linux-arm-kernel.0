From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 25 Jan 2013 16:49:55 +0100
Subject: [PATCHv1 for soc 4/5] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <1359075633-13502-5-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-5-git-send-email-dinguyen@altera.com>
Message-ID: <20130125154955.GD10055@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> mach-socfpga is another platform that needs to use
> v7_invalidate_l1 to bringup additional cores. There was a comment that
> the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S

If there are three copies of code, with fourth one needed for next
platform, moving it into common code makes sense.

But... The code was not identical before the merge. Are you sure that
the differences do not hurt? At the very least, it should be mentioned
in the changelog.

Thanks,
								Pavel

> diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
> index 7e49deb..921fc15 100644
> --- a/arch/arm/mach-imx/headsmp.S
> +++ b/arch/arm/mach-imx/headsmp.S
> @@ -17,53 +17,6 @@
> -ENTRY(v7_invalidate_l1)
> -	mov	r0, #0
> -	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
> -	mcr	p15, 2, r0, c0, c0, 0
> -	mrc	p15, 1, r0, c0, c0, 0
...
> diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> index 4a317fa..fb082c4 100644
> --- a/arch/arm/mach-tegra/headsmp.S
> +++ b/arch/arm/mach-tegra/headsmp.S
> @@ -18,49 +18,6 @@
> -ENTRY(v7_invalidate_l1)
> -        mov     r0, #0
> -        mcr     p15, 2, r0, c0, c0, 0
> -        mrc     p15, 1, r0, c0, c0, 0

[Note missing mcr p15, 0, .. line.]


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
