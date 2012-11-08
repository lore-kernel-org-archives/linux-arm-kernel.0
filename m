From: balbi@ti.com (Felipe Balbi)
Date: Thu, 8 Nov 2012 21:28:34 +0200
Subject: [PATCH] ARM: OMAP4: TWL: mux sys_drm_msecure as output for PMIC
In-Reply-To: <1352401730-4269-1-git-send-email-khilman@deeprootsystems.com>
References: <1352401730-4269-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20121108192834.GA2962@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 08, 2012 at 11:08:50AM -0800, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
> 
> On OMAP4 boards using the TWL6030 PMIC, the sys_drm_msecure is
> connected to the MSECURE input of the TWL6030 PMIC.  This signal
> controls the secure-mode operation of the PMIC.  If its not mux'd
> correctly, some functionality of the PMIC will not be accessible since
> the PMIC will be in secure mode.
> 
> For example, if the TWL RTC is in secure mode, most of its registers
> are read-only, meaning (re)programming the RTC (e.g. for wakeup from
> suspend) will fail.
> 
> To fix, ensure the signal is properly mux'd as output when TWL is
> intialized.
> 
> This fix is required when using recent versions of u-boot (>= v2012.04.01)
> since u-boot is no longer setting the default mux for this pin.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Based on v3.7-rc4.  Targetted as a fix for v3.7.
> 
> A correponding DT fix for this is needed as well, but that will be part of 
> a bigger series to get PM working with DT boot and needs to include other
> pins like sys_nirq1.
> 
>  arch/arm/mach-omap2/twl-common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index 635e109..96cae8b 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -73,6 +73,7 @@ void __init omap4_pmic_init(const char *pmic_type,
>  {
>  	/* PMIC part*/
>  	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
> +	omap_mux_init_signal("fref_clk0_out.sys_drm_msecure", OMAP_PIN_OUTPUT);
>  	omap_pmic_init(1, 400, pmic_type, 7 + OMAP44XX_IRQ_GIC_START, pmic_data);
>  
>  	/* Register additional devices on i2c1 bus if needed */

not entirely related to $SUBJECT but this essentially means we're
dropping the security feature whenever Linux runs.

Shouldn't we try to change that pin at register write boundaries so we
keep the secure feature enabled until we know we're going to write to
the HW ?

Maybe it could even be done later through pinctrl, perhaps ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121108/e5d88f69/attachment.sig>
