From: marex@denx.de (Marek Vasut)
Date: Sat, 19 Oct 2013 03:33:52 +0200
Subject: [PATCH] PCI: imx6: fix imprecise abort handler
In-Reply-To: <1382056042-7299-1-git-send-email-tharvey@gateworks.com>
References: <1382056042-7299-1-git-send-email-tharvey@gateworks.com>
Message-ID: <201310190333.52772.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Tim Harvey,

> An imprecise abort is triggered when a port behind a switch is accessed
> and no device is present.  At enumeration, imprecise aborts are not enabled
> thus this ends up getting deferred until the kernel has completed init.  At
> that point we must not adjust PC - the handler must do nothing, but a
> handler must exist.
> 
> This fixes random crashes that occur right after freeing init.
> This is against linux-pci/host-imx6.
> 
> Acked-by: Marek Vasut <marex@denx.de>
> Tested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Expanding CC a bit, let's have more eyes on this.

> ---
>  drivers/pci/host/pci-imx6.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 966bac6..90fce05 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -200,12 +200,6 @@ static int pcie_phy_write(void __iomem *dbi_base, int
> addr, int data) static int imx6q_pcie_abort_handler(unsigned long addr,
>  		unsigned int fsr, struct pt_regs *regs)
>  {
> -	/*
> -	 * If it was an imprecise abort, then we need to correct the
> -	 * return address to be _after_ the instruction.
> -	 */
> -	if (fsr & (1 << 10))
> -		regs->ARM_pc += 4;
>  	return 0;
>  }

Best regards,
Marek Vasut
