From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Sat, 20 Feb 2010 16:32:10 +0100
Subject: [PATCH 2/3] MXC: add pcmcia support
In-Reply-To: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
References: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
Message-ID: <20100220153210.19692.39370.stgit@srv002.fuzzey.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 arch/arm/mach-mx2/clock_imx21.c |    1 +
 arch/arm/mach-mx2/clock_imx27.c |    1 +
 arch/arm/mach-mx2/devices.c     |   21 +++++++++++++++++++++
 arch/arm/mach-mx2/devices.h     |    2 ++
 arch/arm/mach-mx3/clock.c       |    1 +
 5 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/clock_imx21.c b/arch/arm/mach-mx2/clock_imx21.c
index 9f24748..16e5ce6 100644
--- a/arch/arm/mach-mx2/clock_imx21.c
+++ b/arch/arm/mach-mx2/clock_imx21.c
@@ -960,6 +960,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
 	_REGISTER_CLOCK(NULL, "owire", owire_clk)
 	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
+	_REGISTER_CLOCK("mxc-pcmcia", NULL, hclk_clk)
 };
 
 /*
diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
index 514688e..07e234c 100644
--- a/arch/arm/mach-mx2/clock_imx27.c
+++ b/arch/arm/mach-mx2/clock_imx27.c
@@ -674,6 +674,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk)
 	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
 	_REGISTER_CLOCK(NULL, "scc", scc_clk)
+	_REGISTER_CLOCK("mxc-pcmcia", NULL, ahb_clk)
 };
 
 /* Adjust the clock path for TO2 and later */
diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index 3d398ce..fa0646a 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -642,3 +642,24 @@ int __init mxc_register_gpios(void)
 {
 	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
 }
+
+static struct resource mxc_resource_pcmcia[] = {
+	{
+		.start  = PCMCIA_CTL_BASE_ADDR,
+		.end    = PCMCIA_CTL_BASE_ADDR + 0x67,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = MXC_INT_PCMCIA,
+		.end    = MXC_INT_PCMCIA,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device mxc_device_pcmcia = {
+	.name           = "mxc-pcmcia",
+	.id             = -1,
+	.resource       = mxc_resource_pcmcia,
+	.num_resources  = ARRAY_SIZE(mxc_resource_pcmcia),
+};
+
diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index 97306aa..c1027bc 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -28,3 +28,5 @@ extern struct platform_device mxc_spi_device1;
 extern struct platform_device mxc_spi_device2;
 extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
+extern struct platform_device mxc_device_pcmcia;
+
diff --git a/arch/arm/mach-mx3/clock.c b/arch/arm/mach-mx3/clock.c
index 7ec71d0..7158210 100644
--- a/arch/arm/mach-mx3/clock.c
+++ b/arch/arm/mach-mx3/clock.c
@@ -573,6 +573,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "mpeg4", mpeg4_clk)
 	_REGISTER_CLOCK(NULL, "mbx", mbx_clk)
 	_REGISTER_CLOCK("mxc_rtc", NULL, ckil_clk)
+	_REGISTER_CLOCK("mxc-pcmcia", NULL, ahb_clk)
 };
 
 int __init mx31_clocks_init(unsigned long fref)
