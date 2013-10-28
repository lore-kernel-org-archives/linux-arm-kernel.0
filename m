From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 28 Oct 2013 16:24:37 +0800
Subject: [PATCH v3 1/5] usb: ehci: add freescale imx28 special write
 register method
In-Reply-To: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
References: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20131028082436.GF31499@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 02:02:19PM +0800, Peter Chen wrote:
> According to Freescale imx28 Errata, "ENGR119653 USB: ARM to USB
> register error issue", All USB register write operations must
> use the ARM SWP instruction. So, we implement a special ehci_write
> for imx28.
> 
> Discussion for it at below:
> http://marc.info/?l=linux-usb&m=137996395529294&w=2
> 

Hi Greg, the last two DT patches are not needed at current time.
The first three are OK. Thanks.

Peter

> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/host/ehci.h |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index e8f41c5..535aa8b 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -225,6 +225,7 @@ struct ehci_hcd {			/* one per controller */
>  	unsigned		has_synopsys_hc_bug:1; /* Synopsys HC */
>  	unsigned		frame_index_bug:1; /* MosChip (AKA NetMos) */
>  	unsigned		need_oc_pp_cycle:1; /* MPC834X port power */
> +	unsigned		imx28_write_fix:1; /* For Freescale i.MX28 */
>  
>  	/* required for usb32 quirk */
>  	#define OHCI_CTRL_HCFS          (3 << 6)
> @@ -728,6 +729,13 @@ static inline unsigned int ehci_readl(const struct ehci_hcd *ehci,
>  #endif
>  }
>  
> +#ifdef CONFIG_SOC_IMX28
> +static inline void imx28_ehci_writel(u32 val32, volatile u32 *addr)
> +{
> +	__asm__ ("swp %0, %0, [%1]" : : "r"(val32), "r"(addr));
> +}
> +#endif
> +
>  static inline void ehci_writel(const struct ehci_hcd *ehci,
>  		const unsigned int val, __u32 __iomem *regs)
>  {
> @@ -735,6 +743,11 @@ static inline void ehci_writel(const struct ehci_hcd *ehci,
>  	ehci_big_endian_mmio(ehci) ?
>  		writel_be(val, regs) :
>  		writel(val, regs);
> +#elif defined(CONFIG_SOC_IMX28)
> +	if (ehci->imx28_write_fix)
> +		imx28_ehci_writel(val, regs);
> +	else
> +		writel(val, regs);
>  #else
>  	writel(val, regs);
>  #endif
> -- 
> 1.7.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
