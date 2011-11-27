From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 26 Nov 2011 18:58:04 -0700 (MST)
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <4EC6566C.70202@ti.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <4EC6566C.70202@ti.com>
Message-ID: <alpine.DEB.2.00.1111261854340.6289@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t,

a question about this patch.

On Fri, 18 Nov 2011, Cousson, Benoit wrote:

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
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  177 +++++++++++++++++++++++++++-
>  1 files changed, 174 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7695e5d..6cf21ee 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -47,6 +47,7 @@
>  
>  /* Backward references (IPs with Bus Master capability) */
>  static struct omap_hwmod omap44xx_aess_hwmod;
> +static struct omap_hwmod omap44xx_debugss_hwmod;
>  static struct omap_hwmod omap44xx_dma_system_hwmod;
>  static struct omap_hwmod omap44xx_dmm_hwmod;
>  static struct omap_hwmod omap44xx_dsp_hwmod;
> @@ -337,6 +338,14 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
>  };
>  
>  /* l3_main_2 */
> +/* debugss -> l3_main_2 */
> +static struct omap_hwmod_ocp_if omap44xx_debugss__l3_main_2 = {
> +	.master		= &omap44xx_debugss_hwmod,
> +	.slave		= &omap44xx_l3_main_2_hwmod,
> +	.clk		= "dbgclk_mux_ck",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* dma_system -> l3_main_2 */
>  static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
>  	.master		= &omap44xx_dma_system_hwmod,
> @@ -686,7 +695,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
>   *  ctrl_module_pad_core
>   *  ctrl_module_pad_wkup
>   *  ctrl_module_wkup
> - *  debugss
>   *  efuse_ctrl_cust
>   *  efuse_ctrl_std
>   *  elm
> @@ -908,6 +916,168 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
>  };
>  
>  /*
> + * 'debugss' class
> + * debug and emulation sub system
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_debugss_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};

This defines the OCP register offsets for the DEBUGSS, but ...

> +static struct omap_hwmod_class omap44xx_debugss_hwmod_class = {
> +	.name	= "debugss",
> +	.sysc	= &omap44xx_debugss_sysc,
> +};
> +
> +/* debugss */
> +static struct omap_hwmod_irq_info omap44xx_debugss_irqs[] = {
> +	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
> +	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
> +	{ .irq = -1 }
> +};
> +
> +/* debugss master ports */
> +static struct omap_hwmod_ocp_if *omap44xx_debugss_masters[] = {
> +	&omap44xx_debugss__l3_main_2,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_debugss_addrs[] = {
> +	{
> +		.name		= "mipi_stm_add_sp_0",
> +		.pa_start	= 0x54000000,
> +		.pa_end		= 0x540fffff,
> +	},
> +	{
> +		.name		= "mipi_stm_add_sp_1",
> +		.pa_start	= 0x54100000,
> +		.pa_end		= 0x5413ffff,
> +	},
> +	{
> +		.name		= "mpu_c0_debug",
> +		.pa_start	= 0x54140000,
> +		.pa_end		= 0x54141fff,
> +	},
> +	{
> +		.name		= "mpu_c1_debug",
> +		.pa_start	= 0x54142000,
> +		.pa_end		= 0x54143fff,
> +	},
> +	{
> +		.name		= "cti0_mpu",
> +		.pa_start	= 0x54148000,
> +		.pa_end		= 0x54148fff,
> +	},
> +	{
> +		.name		= "cti1_mpu",
> +		.pa_start	= 0x54149000,
> +		.pa_end		= 0x54149fff,
> +	},
> +	{
> +		.name		= "ptm0_mpu",
> +		.pa_start	= 0x5414c000,
> +		.pa_end		= 0x5414cfff,
> +	},
> +	{
> +		.name		= "ptm1_mpu",
> +		.pa_start	= 0x5414d000,
> +		.pa_end		= 0x5414dfff,
> +	},
> +	{
> +		.name		= "tf_mpu",
> +		.pa_start	= 0x54158000,
> +		.pa_end		= 0x54158fff,
> +	},
> +	{
> +		.name		= "dap_pc_mpu",
> +		.pa_start	= 0x54159000,
> +		.pa_end		= 0x54159fff,
> +	},
> +	{
> +		.name		= "apb_bridge_a_ctrl_time_out",
> +		.pa_start	= 0x5415f000,
> +		.pa_end		= 0x5415ffff,
> +	},
> +	{
> +		.name		= "drm",
> +		.pa_start	= 0x54160000,
> +		.pa_end		= 0x54160fff,
> +	},
> +	{
> +		.name		= "mipi_stm",
> +		.pa_start	= 0x54161000,
> +		.pa_end		= 0x54161fff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +	{
> +		.name		= "csetb",
> +		.pa_start	= 0x54162000,
> +		.pa_end		= 0x54162fff,
> +	},
> +	{
> +		.name		= "cstpiu",
> +		.pa_start	= 0x54163000,
> +		.pa_end		= 0x54163fff,
> +	},
> +	{
> +		.name		= "cstf1",
> +		.pa_start	= 0x54164000,
> +		.pa_end		= 0x54164fff,
> +	},
> +	{
> +		.name		= "cstf2",
> +		.pa_start	= 0x54165000,
> +		.pa_end		= 0x54165fff,
> +	},
> +	{
> +		.name		= "l4_cfg_emu_conf_regs",
> +		.pa_start	= 0x54167000,
> +		.pa_end		= 0x54167fff,
> +	},
> +	{
> +		.name		= "l3_instr_emu_conf_regs",
> +		.pa_start	= 0x54180000,
> +		.pa_end		= 0x54180fff,
> +	},
> +	{ }
> +};

... none of the address spaces above have the ADDR_TYPE_RT flag set.
Without this flag set, the hwmod code won't know where to access the OCP 
registers.

>From the basic documentation that I have here, it's not clear to me where 
the SYSCONFIG registers are located?


- Paul
