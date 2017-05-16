From: s-anna@ti.com (Suman Anna)
Date: Tue, 16 May 2017 17:13:45 -0500
Subject: [PATCH 1/3] ARM: davinci: da8xx: Create DSP device only when assigned
 memory
In-Reply-To: <20170516221347.37990-1-s-anna@ti.com>
References: <20170516221347.37990-1-s-anna@ti.com>
Message-ID: <20170516221347.37990-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DSP device on Davinci platforms does not have an MMU and requires
specific DDR memory to boot. This memory is reserved using the rproc_mem
kernel boot parameter and is assigned to the device on non-DT boots.
The remoteproc core uses the DMA API and so will fall back to assigning
random memory if this memory is not assigned to the device, but the DSP
remote processor boot will not be successful in such cases. So, check
that memory has been reserved and assigned to the device specifically
before even creating the DSP device.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 7cf529ffbe5a..1ccf52e49886 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -814,6 +814,8 @@ static struct platform_device da8xx_dsp = {
 	.resource	= da8xx_rproc_resources,
 };
 
+static bool rproc_mem_inited __initdata;
+
 #if IS_ENABLED(CONFIG_DA8XX_REMOTEPROC)
 
 static phys_addr_t rproc_base __initdata;
@@ -852,6 +854,8 @@ void __init da8xx_rproc_reserve_cma(void)
 	ret = dma_declare_contiguous(&da8xx_dsp.dev, rproc_size, rproc_base, 0);
 	if (ret)
 		pr_err("%s: dma_declare_contiguous failed %d\n", __func__, ret);
+	else
+		rproc_mem_inited = true;
 }
 
 #else
@@ -866,6 +870,12 @@ int __init da8xx_register_rproc(void)
 {
 	int ret;
 
+	if (!rproc_mem_inited) {
+		pr_warn("%s: memory not reserved for DSP, not registering DSP device\n",
+			__func__);
+		return -ENOMEM;
+	}
+
 	ret = platform_device_register(&da8xx_dsp);
 	if (ret)
 		pr_err("%s: can't register DSP device: %d\n", __func__, ret);
-- 
2.12.0
