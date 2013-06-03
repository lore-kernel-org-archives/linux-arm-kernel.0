From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Mon, 03 Jun 2013 20:39:50 +0530
Subject: [PATCH v4 0/6] Add generic set_rate clk_ops for PLL35xx and PLL36xx
 for samsung SoCs
Message-ID: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does the following:

 1) Unifies the clk strutures used for PLL35xx & PLL36xx and usues clk->base
    instead of clk->con0, to factor out possible common code.

 2) Defines a common rate_table which will contain recommended p, m, s and k
    values for supported rates that needs to be changed for changing
    corresponding PLL's rate

 3) Adds set_rate() and round_rate() clk_ops for PLL35xx and PLL36xx

changes since v3:
	- Used __clk_lookup() instead of adding alias for mout_vpllsrc
	- Added check for changing only M value in samsung_pll36xx_set_rate()
	- Modified samsung_pll35xx_mp_change() & samsung_pll35xx_set_rate()
	to improve readabilty.
	- Made the input rate_table as __init_data which is to be provided while
	registering PLL and made a copy of that table while registering, so
	that if multiple tables are their, they can be freed after getting the
	P, M, S, K setting values from required one.

changes since v2:
	- Added new patch to reorder the MUX registration for mout_vpllsrc MUX
	before the PLL registrations. And to add the alias for the mout_vpllsrc MUX.
        - Added a check to confirm parent rate while registrating the PLL
	rate tables.

changes since v1:
	- removed sorting and bsearch
	- modified the definition of struct "samsung_pll_rate_table"
	- added generic round_rate()
	- rectified the ops assignment for "rate table passed as NULL"
	  during PLL registration

Is rebased on branch kgene's "for-next"
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next

Vikas Sajjan (3):
  clk: samsung: Add set_rate() clk_ops for PLL36xx
  clk: samsung: Reorder MUX registration for mout_vpllsrc
  clk: samsung: Add EPLL and VPLL freq table for exynos5250 SoC

Yadwinder Singh Brar (3):
  clk: samsung: Use clk->base instead of directly using clk->con0 for
    PLL3xxx
  clk: samsung: Add support to register rate_table for PLL3xxx
  clk: samsung: Add set_rate() clk_ops for PLL35xx

 drivers/clk/samsung/clk-exynos4.c    |   10 +-
 drivers/clk/samsung/clk-exynos5250.c |   73 +++++++++--
 drivers/clk/samsung/clk-pll.c        |  255 ++++++++++++++++++++++++++++++----
 drivers/clk/samsung/clk-pll.h        |   35 +++++-
 drivers/clk/samsung/clk.h            |    2 +
 5 files changed, 332 insertions(+), 43 deletions(-)
