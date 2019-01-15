Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:12:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9571420656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TYHYmT9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9571420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0IyDnJwqIbiatt6Y6Y48zvb8sNRFX6u2+3rjdDQ5h2o=; b=TYHYmT9rCNycI5
	4L/ABywplk6Y2fdxPckBh/ZQbKKHRA8X/AvU5VLQT7XI/HgxcxfrF0t0KD3OgG2HFsApD7IzZBcYP
	ZCjNHkAaSrOn2FbN34mI05IhXll1aBaR9gVju+GVdGwTlONprNIuXZkKe8rd1+rZlKtrWKOAXoUL8
	FL+jNLIdR7A4hRiMzSwnIkvTYbeikHURs5IOqLy+EYk0HmiTQUhKaO3Ag2Re8yQEY8KWLJYOrQH8R
	Ya9+dTzga5cBqL56JDu61+Byk8etytKP4qmsF5CAfiw+yhTzxlE87RlISdRkxGq9I5l3jVt7KNxa8
	gGD9vCPSE7ad2IMUuRvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjTC6-0001iy-M1; Tue, 15 Jan 2019 18:12:10 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjTC3-0001iX-JB
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 18:12:09 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 99CD98022;
 Tue, 15 Jan 2019 18:12:11 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH] ARM: OMAP5+: Fix inverted nirq pin interrupts with
 irq_set_type
Date: Tue, 15 Jan 2019 10:11:55 -0800
Message-Id: <20190115181155.31155-1-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_101207_672459_9345FEC7 
X-CRM114-Status: GOOD (  19.35  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, Nishanth Menon <nm@ti.com>,
 Richard Woodruff <r-woodruff2@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Belisko Marek <marek.belisko@gmail.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo <t-kristo@ti.com>,
 Jon Hunter <jonathanh@nvidia.com>,
 "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, Keerthy <j-keerthy@ti.com>,
 Thierry Reding <treding@nvidia.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of
IRQ_TYPE_NONE") started warning about incorrect dts usage for irqs.
ARM GIC only supports active-high interrupts for SPI (Shared Peripheral
Interrupts), and the Palmas PMIC by default is active-low.

Palmas PMIC allows changing the interrupt polarity using register
PALMAS_POLARITY_CTRL_INT_POLARITY, but configuring sys_nirq1 with
a pull-down and setting PALMAS_POLARITY_CTRL_INT_POLARITY made the
Palmas RTC interrupts stop working. This can be easily tested with
kernel tools rtctest.c.

Turns out the SoC inverts the sys_nirq pins for GIC as they do not go
through a peripheral device but go directly to the MPUSS wakeupgen.
I've verified this by muxing the interrupt line temporarily to gpio_wk16
instead of sys_nirq1. with a gpio, the interrupt works fine both
active-low and active-high with the SoC internal pull configured and
palmas polarity configured. But as sys_nirq1, the interrupt only works
when configured ACTIVE_LOW for palmas, and ACTIVE_HIGH for GIC.

Note that there was a similar issue earlier with tegra114 and palmas
interrupt polarity that got fixed by commit df545d1cd01a ("mfd: palmas:
Provide irq flags through DT/platform data"). However, the difference
between omap5 and tegra114 is that tegra inverts the palmas interrupt
twice, once when entering tegra PMC, and again when exiting tegra PMC
to GIC.

Let's fix the issue by adding a custom wakeupgen_irq_set_type() for
wakeupgen and invert any interrupts with wrong polarity. Let's also
warn about any non-sysnirq pins using wrong polarity. Note that we
also need to update the dts for the level as IRQ_TYPE_NONE never
has irq_set_type() called, and let's add some comments and use proper
pin nameing to avoid more confusion later on.

Cc: Belisko Marek <marek.belisko@gmail.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Thierry Reding <treding@nvidia.com>
Reported-by: Belisko Marek <marek.belisko@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Marek, care to test this with any kernel between v4.17..v4.20?

Current v5.0-rc1 seems to have some regmap_irq regression that needs
separate fixes, I'll send a separate email about that.

---
 arch/arm/boot/dts/omap5-board-common.dtsi |  9 ++++--
 arch/arm/boot/dts/omap5-cm-t54.dts        | 12 +++++++-
 arch/arm/mach-omap2/omap-wakeupgen.c      | 36 ++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -317,7 +317,8 @@
 
 	palmas_sys_nirq_pins: pinmux_palmas_sys_nirq_pins {
 		pinctrl-single,pins = <
-			OMAP5_IOPAD(0x068, PIN_INPUT_PULLUP | MUX_MODE0) /* sys_nirq1 */
+			/* sys_nirq1 is pulled down as the SoC is inverting it for GIC */
+			OMAP5_IOPAD(0x068, PIN_INPUT_PULLUP | MUX_MODE0)
 		>;
 	};
 
@@ -385,7 +386,8 @@
 
 	palmas: palmas@48 {
 		compatible = "ti,palmas";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
+		/* sys_nirq/ext_sys_irq pins get inverted at mpuss wakeupgen */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x48>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
@@ -651,7 +653,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&twl6040_pins>;
 
-		interrupts = <GIC_SPI 119 IRQ_TYPE_NONE>; /* IRQ_SYS_2N cascaded to gic */
+		/* sys_nirq/ext_sys_irq pins get inverted at mpuss wakeupgen */
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_LOW>;
 
 		/* audpwron gpio defined in the board specific dts */
 
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -181,6 +181,13 @@
 			OMAP5_IOPAD(0x0042, PIN_INPUT_PULLDOWN | MUX_MODE6)  /* llib_wakereqin.gpio1_wk15 */
 		>;
 	};
+
+	palmas_sys_nirq_pins: pinmux_palmas_sys_nirq_pins {
+		pinctrl-single,pins = <
+			/* sys_nirq1 is pulled down as the SoC is inverting it for GIC */
+			OMAP5_IOPAD(0x068, PIN_INPUT_PULLUP | MUX_MODE0)
+		>;
+	};
 };
 
 &omap5_pmx_core {
@@ -414,8 +421,11 @@
 
 	palmas: palmas@48 {
 		compatible = "ti,palmas";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
 		reg = <0x48>;
+		pinctrl-0 = <&palmas_sys_nirq_pins>;
+		pinctrl-names = "default";
+		/* sys_nirq/ext_sys_irq pins get inverted at mpuss wakeupgen */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,system-power-controller;
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -50,6 +50,9 @@
 #define OMAP4_NR_BANKS		4
 #define OMAP4_NR_IRQS		128
 
+#define SYS_NIRQ1_EXT_SYS_IRQ_1	7
+#define SYS_NIRQ2_EXT_SYS_IRQ_2	119
+
 static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
 static DEFINE_RAW_SPINLOCK(wakeupgen_lock);
@@ -153,6 +156,37 @@ static void wakeupgen_unmask(struct irq_data *d)
 	irq_chip_unmask_parent(d);
 }
 
+/*
+ * The sys_nirq pins bypass peripheral modules and are wired directly
+ * to MPUSS wakeupgen. They get automatically inverted for GIC.
+ */
+static int wakeupgen_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	bool inverted = false;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		type &= ~IRQ_TYPE_LEVEL_MASK;
+		type |= IRQ_TYPE_LEVEL_HIGH;
+		inverted = true;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type &= ~IRQ_TYPE_EDGE_BOTH;
+		type |= IRQ_TYPE_EDGE_RISING;
+		inverted = true;
+		break;
+	default:
+		break;
+	}
+
+	if (inverted && d->hwirq != SYS_NIRQ1_EXT_SYS_IRQ_1 &&
+	    d->hwirq != SYS_NIRQ2_EXT_SYS_IRQ_2)
+		pr_warn("wakeupgen: irq%li polarity inverted in dts\n",
+			d->hwirq);
+
+	return irq_chip_set_type_parent(d, type);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static DEFINE_PER_CPU(u32 [MAX_NR_REG_BANKS], irqmasks);
 
@@ -446,7 +480,7 @@ static struct irq_chip wakeupgen_chip = {
 	.irq_mask		= wakeupgen_mask,
 	.irq_unmask		= wakeupgen_unmask,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_type		= wakeupgen_irq_set_type,
 	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
-- 
2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
