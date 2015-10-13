From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 13 Oct 2015 12:25:55 +0200
Subject: [BUG] broken mixer after second resume from mem
Message-ID: <561CDC33.7050103@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

have been hunting down a bug on exynos5250-snow which caused both HDMI
and LVDS output to be broken after the second resume (with suspend to
mem, but not to idle).

What I have found is that when powering down the DISP1 power domain
while suspending for the second time, the contents of the SRC_TOP3
register change from 0x1110550 to 0x1110500. IIUIC, this means that
ACLK_200_DISP1 is reparented to XXTI.

When the CPU comes up again, that register contains 0x1110550 again, but
it's set to 0x1110500 by the code that restores clk registers when resuming:

First suspend:

exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - before
exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - after
exynos5250_clk_suspend: SRC_TOP3 1110550
exynos5250_clk_resume: SRC_TOP3 1110550 - before
exynos5250_clk_resume: SRC_TOP3 1110550 - after
exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - before
exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - after


Second suspend:

exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - before
exynos_pd_power: SRC_TOP3 1110500 disp1-power-domain at 100440A0 - after
exynos5250_clk_suspend: SRC_TOP3 1110500
exynos5250_clk_resume: SRC_TOP3 1110550 - before
exynos5250_clk_resume: SRC_TOP3 1110500 - after
exynos_pd_power: SRC_TOP3 1110500 disp1-power-domain at 100440A0 - before
exynos_pd_power: SRC_TOP3 1110500 disp1-power-domain at 100440A0 - after


I have no idea of why it happens on the second suspend, and also don't
know why it doesn't happen when suspending to idle.

Any ideas?

Thanks,

Tomeu
