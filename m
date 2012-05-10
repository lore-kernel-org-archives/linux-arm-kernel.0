From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 10 May 2012 13:55:01 -0500
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120510084422.GB27276@mudshark.cambridge.arm.com>
References: <87ipg76hfm.fsf@ti.com> <4FA8284C.7080803@ti.com>
 <87k40nzi3i.fsf@ti.com> <4FA8FCFF.40105@ti.com> <4FA9588E.9020906@ti.com>
 <87sjfal65t.fsf@ti.com> <4FAA4DB9.8060504@ti.com> <4FAAB1A3.9040806@ti.com>
 <4FAAC549.6010206@ti.com> <4FAAE564.6040708@ti.com>
 <20120510084422.GB27276@mudshark.cambridge.arm.com>
Message-ID: <4FAC0F05.3060803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 05/10/2012 03:44 AM, Will Deacon wrote:
> On Wed, May 09, 2012 at 10:45:08PM +0100, Jon Hunter wrote:
>> Hi All,
> 
> Hi Jon,
> 
>> I have posted my latest series here [1] based upon that from Will [2]
>> which attempts to fix the EMU CD based upon the inputs from this thread.
>> It is working on my omap4460 panda. Hopefully Ming and/or Will can also
>> test. I know that Ming is out this week but said he can test next week.
> 
> Many thanks to you (+Kevin, Benoit, Paul and co) for persevering with this.
> If I can get my hands on a Panda, I'll see if I can test something this
> week. Any particular tests you want me to run to exercise the interaction
> with PM?

May be Kevin and Paul have some suggestions, but I am not sure what PM modes are currently supported for OMAP4 in the linux-omap master branch.

For my testing I have just been reading the PM_EMU_PWRSTST register which shows the power state of the EMU power domain. It should read 3 when the power domain is ON and 0 when it is off. I did something like the following (dumping all EMU clock and power domain registers).

Cheers
Jon

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b02aa81..41cb2fa 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -437,8 +437,25 @@ static struct omap_device_pm_latency omap_pmu_latency[] = {
 static struct cti omap4_cti[2];
 static struct platform_device *pmu_dev;
 
+static inline void dump_emu(char *s, int d)
+{
+       pr_info("%s-%d: CM_EMU_CLKSTCTRL = 0x%x\n", s, d,
+               __raw_readl(OMAP2_L4_IO_ADDRESS(0x4A307A00)));
+       pr_info("%s-%d: CM_EMU_DYNAMICDEP = 0x%x\n", s, d,
+               __raw_readl(OMAP2_L4_IO_ADDRESS(0x4A307A08)));
+       pr_info("%s-%d: CM_EMU_DEBUGSS_CLKCTRL = 0x%x\n", s, d,
+               __raw_readl(OMAP2_L4_IO_ADDRESS(0x4A307A20)));
+       pr_info("%s-%d: PM_EMU_PWRSTCTRL = 0x%x\n", s, d,
+               __raw_readl(OMAP2_L4_IO_ADDRESS(0x4A307900)));
+       pr_info("%s-%d: PM_EMU_PWRSTST = 0x%x\n", s, d,
+               __raw_readl(OMAP2_L4_IO_ADDRESS(0x4A307904)));
+       pr_info("%s-%d: RM_EMU_DEBUGSS_CONTEXT = 0x%x\n", s, d,
+               __raw_readl(OMAP2_L4_IO_ADDRESS(0x4A307924)));
+
+}
 static void omap4_enable_cti(int irq)
 {
+       dump_emu((char *)__func__, __LINE__);
        pm_runtime_get_sync(&pmu_dev->dev);
        if (irq == OMAP44XX_IRQ_CTI0) {
                /* configure CTI0 for pmu irq routing */
@@ -451,15 +468,18 @@ static void omap4_enable_cti(int irq)
                cti_map_trigger(&omap4_cti[1], 1, 6, 2);
                cti_enable(&omap4_cti[1]);
        }
+       dump_emu((char *)__func__, __LINE__);
 }
 
 static void omap4_disable_cti(int irq)
 {
+       dump_emu((char *)__func__, __LINE__);
        if (irq == OMAP44XX_IRQ_CTI0)
                cti_disable(&omap4_cti[0]);
        else if (irq == OMAP44XX_IRQ_CTI1)
                cti_disable(&omap4_cti[1]);
        pm_runtime_put(&pmu_dev->dev);
+       dump_emu((char *)__func__, __LINE__);
 }
