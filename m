From: T.Mehnert@eckelmann.de (Mehnert, Torsten)
Date: Mon, 1 Aug 2011 08:02:07 +0000
Subject: [PATCH] i.MX25 GPT clock fix: ensure correct the clock source
Message-ID: <3F263ABB4EDE344D974E1983B56807734FFAB7A9@EX-DAG02.eckelmann.group>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request for comment and commit.


From: T. Mehnert <t.mehnert@eckelmann.de>
Date: Mon, 4 Jul 2011 15:53:30 +0200
Subject: [PATCH] i.MX25 GPT clock fix: ensure correct the clock source

This patch ensures, that Linux will take the correct clock source (AHB_DIV)
for gpt in the ARM i.MX25 implementation. The currect code depends on the reset
defaults of the CCM_MCR register. So on some boards it could happen that the
UPLL is used for clock source, which results in faulty time behavior in Linux.
In this case all delays or sleeps will will be faktor 1.8 too long.

Signed-off-by: Torsten Mehnert <t.mehnert@eckelmann.de>
---
 arch/arm/mach-imx/clock-imx25.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index a65838f..bf1ecda 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -328,6 +328,10 @@ int __init mx25_clocks_init(void)
        __raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7) | (1 << 0),
                        CRM_BASE + 0x64);

+       /* Clock source for gpt is ahb_div */
+       __raw_writel(__raw_readl(CRM_BASE+0x64) & ~(1 << 5),
+                       CRM_BASE + 0x64);
+
        mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);

        return 0;
--
1.7.0.4

best regards,
        Torsten

Torsten Mehnert
K?lte- und Geb?udeleittechnik (KGL)

ECKELMANN AG
Berliner Stra?e 161
D - 65205 Wiesbaden

Phone:  +49 (0) 611 / 7103 - 370
Fax:    +49 (0) 611 / 7103 - 133

e-Mail: mailto:t.mehnert@eckelmann.de
Web:    http://www.eckelmann.de

ECKELMANN AG
Vorstand: Dr.-Ing. Gerd Eckelmann (Vorsitzender), Dr.-Ing. Peter Cordes, Dr.-Ing. Frank-Thomas Mellert
Vorsitzender des Aufsichtsrats: Hubertus G. Krossa
Sitz der Gesellschaft: Wiesbaden
Amtsgericht Wiesbaden, HRB 12636
