From: tstone@iss.tu-darmstadt.de (Tim Sander)
Date: Wed, 20 Oct 2010 17:57:34 +0200
Subject: [PATCH] ARM: pcm043 micrell ksz8041nl phy support
Message-ID: <201010201757.34531.tstone@iss.tu-darmstadt.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

This patch add the missing support for the phy used on the phytec pcm043 boards. 
Please consider for mainline. Tested on pcm043 hardware.

Best regards
Tim

Signed-off-by: Tim Sander <tim.sander@hbm.com>

---
 drivers/net/fec.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 16a1d58..00d79bb 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -1128,6 +1128,44 @@ static phy_info_t phy_info_dp83848= {
        },
 };
 
+
+/* ------------------------------------------------------------------------- */
+/* support for the micrell ksz8041nl */
+#define MII_KSZ8041NL_ICSR 0x1b
+#define MII_KSZ8041NL_CTL1 0x1e
+static phy_cmd_t const phy_cmd_ksz8041nl_config[] = {
+               { mk_mii_read(MII_REG_CR), mii_parse_cr },
+               { mk_mii_read(MII_REG_ANAR), mii_parse_anar },
+               { mk_mii_end, }
+};
+static phy_cmd_t const phy_cmd_ksz8041nl_startup[] = {
+               { mk_mii_write(MII_KSZ8041NL_ICSR, 0xff00), NULL},
+               { mk_mii_write(MII_KSZ8041NL_CTL1, 0x4000), NULL},
+               { mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
+               { mk_mii_read(MII_REG_SR), mii_parse_sr },
+               { mk_mii_end, }
+};
+static phy_cmd_t const phy_cmd_ksz8041nl_ack_int[] = {
+               /* find out the current status */
+               { mk_mii_read(MII_REG_SR), mii_parse_sr },
+               /* we only need to read ISR to acknowledge */
+               { mk_mii_read(MII_KSZ8041NL_ICSR), NULL },
+               { mk_mii_end, }
+};
+static phy_cmd_t const phy_cmd_ksz8041nl_shutdown[] = { /* disable interrupts */
+               { mk_mii_write(MII_KSZ8041NL_ICSR, 0x0000), NULL},
+               { mk_mii_end, }
+};
+
+static phy_info_t phy_info_ksz8041nl = {
+       0x0022151,
+       "KSZ8041NL",
+       .config = phy_cmd_ksz8041nl_config,
+       .startup = phy_cmd_ksz8041nl_startup,
+       .ack_int = phy_cmd_ksz8041nl_ack_int,
+       .shutdown = phy_cmd_ksz8041nl_shutdown,
+};
+
 /* ------------------------------------------------------------------------- */
 
 static phy_info_t const * const phy_info[] = {
@@ -1137,6 +1175,7 @@ static phy_info_t const * const phy_info[] = {
        &phy_info_am79c874,
        &phy_info_ks8721bl,
        &phy_info_dp83848,
+       &phy_info_ksz8041nl,
        NULL
 };
 
-- 
1.7.0.4
