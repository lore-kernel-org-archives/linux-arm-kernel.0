From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 27 Jan 2010 15:00:48 +0200
Subject: [PATCH 2/3] mx25: add support for the DryIce rtc
In-Reply-To: <cover.1264596212.git.baruch@tkos.co.il>
References: <cover.1264596212.git.baruch@tkos.co.il>
Message-ID: <0898eb20ddb0b155be1600280fe456706119db1f.1264596212.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/clock.c            |    2 ++
 arch/arm/mach-mx25/devices.c          |   19 +++++++++++++++++++
 arch/arm/mach-mx25/devices.h          |    1 +
 arch/arm/plat-mxc/include/mach/mx25.h |    2 ++
 4 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 6acc88b..744b52a 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -182,6 +182,7 @@ DEFINE_CLOCK(kpp_clk,	 0, CCM_CGCR1, 28, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(tsc_clk,	 0, CCM_CGCR2, 13, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
 DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
+DEFINE_CLOCK(dryice_clk, 0, CCM_CGCR1,  8, get_rate_ipg, NULL, NULL);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
@@ -214,6 +215,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c_clk)
 	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
+	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
 };
 
 int __init mx25_clocks_init(void)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index dd40697..b0b75fc 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -458,3 +458,22 @@ struct platform_device mxc_nand_device = {
 	.num_resources	= ARRAY_SIZE(mxc_nand_resources),
 	.resource	= mxc_nand_resources,
 };
+
+static struct resource mx25_rtc_resources[] = {
+	{
+		.start	= MX25_DRYICE_BASE_ADDR,
+		.end	= MX25_DRYICE_BASE_ADDR + 0x40,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= MX25_INT_DRYICE,
+		.flags	= IORESOURCE_IRQ
+	},
+};
+
+struct platform_device mx25_rtc_device = {
+	.name	= "imxdi_rtc",
+	.id	= 0,
+	.num_resources	= ARRAY_SIZE(mx25_rtc_resources),
+	.resource	= mx25_rtc_resources,
+};
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index 8f55300..37e6a08 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -19,3 +19,4 @@ extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_i2c_device2;
 extern struct platform_device mx25_fec_device;
 extern struct platform_device mxc_nand_device;
+extern struct platform_device mx25_rtc_device;
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 58e0bd3..215c4d8 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -43,7 +43,9 @@
 
 #define MX25_FEC_BASE_ADDR		0x50038000
 #define MX25_NFC_BASE_ADDR		0xbb000000
+#define MX25_DRYICE_BASE_ADDR		0x53ffc000
 
+#define MX25_INT_DRYICE	25
 #define MX25_INT_FEC	57
 #define MX25_INT_NANDFC	33
 
-- 
1.6.5
