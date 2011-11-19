From: ming.lei@canonical.com (Ming Lei)
Date: Sat, 19 Nov 2011 22:37:08 +0800
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <4EC6566C.70202@ti.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <4EC6566C.70202@ti.com>
Message-ID: <CACVXFVN+8RXsheCwoneCz3AZcmhjfoOy+aG=PQVbuUMdpKaG5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Fri, Nov 18, 2011 at 8:58 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Ming Lei,
>
> Sorry, for the delay, it took me some time to gather the exhaustive data for that block.

The work is really great.

> On 11/10/2011 10:02 AM, Paul Walmsley wrote:
>> Hello Ming Lei,
>>
>> just a few quick comments for now -
>>
>> On Wed, 9 Nov 2011, Ming Lei wrote:
>>
>>> On Tue, Nov 8, 2011 at 11:26 PM, Paul Walmsley<paul@pwsan.com> ?wrote:
>>>
>>>>> +static struct omap_hwmod_irq_info omap44xx_emu_irqs[] = {
>>>>> + ? ? { .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
>>>>> + ? ? { .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
>>>>> + ? ? { .irq = -1 }
>>>>> +};
>>>>
>>>> Are you sure these are part of the emulation IP? ?We already have those
>>>
>>> I am not sure, I just figure out one way to make omap4 pmu work. Since there
>>> are few descriptions in TRM about it, it is a hacking based on [1], :-)
>>>
>>>> IRQs in the MPU hwmod, see omap44xx_mpu_irqs[] in the same file.
>>>
>>> I just see it, but looks like the "mpu" hwmod isn't populated as omap_device,
>>> so the CTI irqs aren't requested now.
>>
>> Okay. ?Maybe you can probably add some code in mach-omap2/devices.c to
>> build an omap_device for this for right now? ?I am not 100% sure whether
>> those cti0/1 interrupts should be associated with the MPU or with the
>> DEBUGSS but Beno?t might be able to answer this.
>>
>>> Also, current arm perf code don't handle three IRQs(one pl310 irq and
>>> two CTI irq) inside one device correctly.
>>
>> To fix this, that ARM perf code should either be using
>> platform_get_irq_byname(), or the hwmod hardware data will need to be
>> rearranged to meet the arbitrary ordering requirement. ?I'd suggest
>> pinging Will on this issue to see what he wants to do.
>>
>>> So any suggestion about CTI IRQs connecting to which hwmod, so that they can
>>> be found by pmu driver?
>>>
>>>>> +/*emu hwmod*/
>>>>> +static struct omap_hwmod omap44xx_emu_hwmod = {
>>>>> + ? ? .name ? ? ? ? ? = "emu",
>>>>> + ? ? .class ? ? ? ? ?=&omap44xx_emu_hwmod_class,
>>>>> + ? ? .clkdm_name ? ? = "emu_sys_clkdm",
>>>>> + ? ? .prcm = {
>>>>> + ? ? ? ? ? ? .omap4 = {
>>>>> + ? ? ? ? ? ? ? ? ? ? .clkctrl_offs = OMAP4_CM_EMU_CLKSTCTRL_OFFSET,
>>>>
>>>> This doesn't look right either: EMU is a clockdomain, not an IP block.
>>>
>>> I defined the 'emu' hwmod to control the clock state transition of the EMU
>>> clock domain by writing to CLKTRCTRL.CM_EMU_CLKSTCTRL with standard
>>> hwmod interface(_enable / _idle). Is there any other neat way to do it?
>>
>> So the clockdomain is already defined in
>> mach-omap2/clockdomains44xx_data.c and there's code to control it - see
>> for example clkdm_enable_idle(). ?But this code should not be called
>> directly by any device driver code or driver integration code. ?The thing
>> to do here is to ask Beno?t to release the hwmod data for the DEBUGSS
>> hwmod, then someone will need to write an MFD driver for that which
>> exposes the PMU address space to the PMU platform driver.
>
> Following that discussion, here is the patch to expose debugss hwmod.
>
> I have moved the CTIs irq from MPU to debugss and exposed all the internals IP that are part of the OMAP debug subsystem.
>
> Since the DEBUGSS cannot be accessed at boot time if the l3_main_3 and the l3_instr interconnects are not enable, you will have some warnings.
>

Currently these two modules are enabled in my patch 5/7 and 6/7, and the
pmu omap device is built from the three IPs: debugss, l3_main_3 and
the l3_instr,
so that these two modules can be enabled in omap_device_enable().

I don't know how to enable the two IPs in other ways, also I am not
sure if the way
is suitable, but it does work, could you help to review the two patches?

> [ ? ?0.416992] omap_hwmod: debugss: softreset failed (waited 10000 usec)
> [ ? ?0.426727] omap_hwmod: debugss: _wait_target_disable failed
>
> Just let me know if you have any issue with that patch.

In fact, now it is very easy to enable pmu on omap with your patch,
I have made omap4 pmu work already using debugss:

     - replace the patch 3/7 with your debugss patch(replace 'emu'
with 'debugss')
     - modify the patch  5/7 to create pmu omap device from 'debugss'
instead of 'emu'

thanks,
--
Ming Lei

>
> Please note that will will need the fix "ARM: OMAP: hwmod: Fix the addr space, irq, dma count APIs" to avoid hwmod core messing up with the resources.
>
> I've just posted a pull request for Tony to get it for -rc3.
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/140458
>
> I pushed these two patches on a branch based on mainline for your convenience.
>
> git://gitorious.org/omap-pm/linux.git wip-emu/debuss_hwmod
>
> Regards,
> Benoit
>
> ---
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Fri, 18 Nov 2011 11:42:12 +0100
> Subject: [PATCH] ARM: OMAP4: hwmod data: Add support for the debug modules
>
> The OMAP4 DEBUG subsystem contains all the IPs used for emulation,
> included the ones from the CortexA9 MPU.
> Expose the individual modules base address.
>
> Re-map the CTIs IRQs from MPU to DEBUGSS.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> ---
> ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c | ?177 +++++++++++++++++++++++++++-
> ?1 files changed, 174 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7695e5d..6cf21ee 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -47,6 +47,7 @@
>
> ?/* Backward references (IPs with Bus Master capability) */
> ?static struct omap_hwmod omap44xx_aess_hwmod;
> +static struct omap_hwmod omap44xx_debugss_hwmod;
> ?static struct omap_hwmod omap44xx_dma_system_hwmod;
> ?static struct omap_hwmod omap44xx_dmm_hwmod;
> ?static struct omap_hwmod omap44xx_dsp_hwmod;
> @@ -337,6 +338,14 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
> ?};
>
> ?/* l3_main_2 */
> +/* debugss -> l3_main_2 */
> +static struct omap_hwmod_ocp_if omap44xx_debugss__l3_main_2 = {
> + ? ? ? .master ? ? ? ? = &omap44xx_debugss_hwmod,
> + ? ? ? .slave ? ? ? ? ?= &omap44xx_l3_main_2_hwmod,
> + ? ? ? .clk ? ? ? ? ? ?= "dbgclk_mux_ck",
> + ? ? ? .user ? ? ? ? ? = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> ?/* dma_system -> l3_main_2 */
> ?static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
> ? ? ? ?.master ? ? ? ? = &omap44xx_dma_system_hwmod,
> @@ -686,7 +695,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
> ?* ?ctrl_module_pad_core
> ?* ?ctrl_module_pad_wkup
> ?* ?ctrl_module_wkup
> - * ?debugss
> ?* ?efuse_ctrl_cust
> ?* ?efuse_ctrl_std
> ?* ?elm
> @@ -908,6 +916,168 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
> ?};
>
> ?/*
> + * 'debugss' class
> + * debug and emulation sub system
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_debugss_sysc = {
> + ? ? ? .rev_offs ? ? ? = 0x0000,
> + ? ? ? .sysc_offs ? ? ?= 0x0010,
> + ? ? ? .syss_offs ? ? ?= 0x0014,
> + ? ? ? .sysc_flags ? ? = (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> + ? ? ? .sysc_fields ? ?= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_debugss_hwmod_class = {
> + ? ? ? .name ? = "debugss",
> + ? ? ? .sysc ? = &omap44xx_debugss_sysc,
> +};
> +
> +/* debugss */
> +static struct omap_hwmod_irq_info omap44xx_debugss_irqs[] = {
> + ? ? ? { .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
> + ? ? ? { .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
> + ? ? ? { .irq = -1 }
> +};
> +
> +/* debugss master ports */
> +static struct omap_hwmod_ocp_if *omap44xx_debugss_masters[] = {
> + ? ? ? &omap44xx_debugss__l3_main_2,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_debugss_addrs[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "mipi_stm_add_sp_0",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54000000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x540fffff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "mipi_stm_add_sp_1",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54100000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x5413ffff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "mpu_c0_debug",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54140000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54141fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "mpu_c1_debug",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54142000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54143fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "cti0_mpu",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54148000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54148fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "cti1_mpu",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54149000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54149fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "ptm0_mpu",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x5414c000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x5414cfff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "ptm1_mpu",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x5414d000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x5414dfff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "tf_mpu",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54158000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54158fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "dap_pc_mpu",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54159000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54159fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "apb_bridge_a_ctrl_time_out",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x5415f000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x5415ffff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "drm",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54160000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54160fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "mipi_stm",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54161000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54161fff,
> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= ADDR_TYPE_RT
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "csetb",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54162000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54162fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "cstpiu",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54163000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54163fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "cstf1",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54164000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54164fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "cstf2",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54165000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54165fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "l4_cfg_emu_conf_regs",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54167000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54167fff,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "l3_instr_emu_conf_regs",
> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x54180000,
> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x54180fff,
> + ? ? ? },
> + ? ? ? { }
> +};
> +
> +/* l3_instr -> debugss */
> +static struct omap_hwmod_ocp_if omap44xx_l3_instr__debugss = {
> + ? ? ? .master ? ? ? ? = &omap44xx_l3_instr_hwmod,
> + ? ? ? .slave ? ? ? ? ?= &omap44xx_debugss_hwmod,
> + ? ? ? .clk ? ? ? ? ? ?= "l3_div_ck",
> + ? ? ? .addr ? ? ? ? ? = omap44xx_debugss_addrs,
> + ? ? ? .user ? ? ? ? ? = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* debugss slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_debugss_slaves[] = {
> + ? ? ? &omap44xx_l3_instr__debugss,
> +};
> +
> +static struct omap_hwmod omap44xx_debugss_hwmod = {
> + ? ? ? .name ? ? ? ? ? = "debugss",
> + ? ? ? .class ? ? ? ? ?= &omap44xx_debugss_hwmod_class,
> + ? ? ? .clkdm_name ? ? = "emu_sys_clkdm",
> + ? ? ? .mpu_irqs ? ? ? = omap44xx_debugss_irqs,
> + ? ? ? .main_clk ? ? ? = "trace_clk_div_ck",
> + ? ? ? .prcm = {
> + ? ? ? ? ? ? ? .omap4 = {
> + ? ? ? ? ? ? ? ? ? ? ? .clkctrl_offs = OMAP4_CM_EMU_DEBUGSS_CLKCTRL_OFFSET,
> + ? ? ? ? ? ? ? ? ? ? ? .context_offs = OMAP4_RM_EMU_DEBUGSS_CONTEXT_OFFSET,
> + ? ? ? ? ? ? ? },
> + ? ? ? },
> + ? ? ? .slaves ? ? ? ? = omap44xx_debugss_slaves,
> + ? ? ? .slaves_cnt ? ? = ARRAY_SIZE(omap44xx_debugss_slaves),
> + ? ? ? .masters ? ? ? ?= omap44xx_debugss_masters,
> + ? ? ? .masters_cnt ? ?= ARRAY_SIZE(omap44xx_debugss_masters),
> +};
> +
> +/*
> ?* 'dma' class
> ?* dma controller for data exchange between memory to memory (i.e. internal or
> ?* external memory) and gp peripherals to memory or memory to gp peripherals
> @@ -3902,8 +4072,6 @@ static struct omap_hwmod_class omap44xx_mpu_hwmod_class = {
> ?/* mpu */
> ?static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] = {
> ? ? ? ?{ .name = "pl310", .irq = 0 + OMAP44XX_IRQ_GIC_START },
> - ? ? ? { .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
> - ? ? ? { .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
> ? ? ? ?{ .irq = -1 }
> ?};
>
> @@ -5308,6 +5476,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
> ? ? ? ?/* counter class */
> ?/* ? ? &omap44xx_counter_32k_hwmod, */
>
> + ? ? ? /* debugss class */
> + ? ? ? &omap44xx_debugss_hwmod,
> +
> ? ? ? ?/* dma class */
> ? ? ? ?&omap44xx_dma_system_hwmod,
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
