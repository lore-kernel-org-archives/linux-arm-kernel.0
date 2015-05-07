From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  7 May 2015 20:19:23 +0200
Subject: [PATCH RFC 0/2] stmmac: stand alone platform drivers
Message-ID: <1431022765-30715-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I ran into some issue using a separate platform driver[1] for lpc1850-dwmac.

My dts files looks like this.
mac: ethernet at 40010000 {
	compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
	...
}

On boot the generic driver in stmmac_platform.c would grab the
device, matching on one of generic compat strings and thus blocking
the lpc1850-dwmac driver.

By changing the build order in the Makefile (see patch 1) I managed
to get it working, but I am not sure that is a good solution(?).

Another fix would be to remove the generic compat strings from the
match table in stmmac_platform but there are some dts-files that
only have these compat strings.
See abilis_tb10x.dtsi and exynos5440.dtsi.

I could also remove the generic compat strings from my dts file but
I am not sure that is good solution either. If more glue is
converted this would then be need in those dts files also.


Any advice on how to handle this situation?


[1] http://marc.info/?l=linux-arm-kernel&m=143076781409270&w=2

Joachim Eastwood (2):
  stmac: support standalone platform drivers
  stmac: add dwmac glue for NXP 18xx/43xx family

 drivers/net/ethernet/stmicro/stmmac/Makefile       | 11 ++-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    | 98 ++++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 14 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |  4 +
 4 files changed, 120 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c

-- 
1.8.0
