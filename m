From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 23 Jan 2015 15:42:40 -0600
Subject: [PATCH] PCI: xilinx: fix harmless format string warning
In-Reply-To: <1759235.dcJCuiggea@wuerfel>
References: <1759235.dcJCuiggea@wuerfel>
Message-ID: <20150123214240.GL29776@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 03:20:05PM +0100, Arnd Bergmann wrote:
> The xilinx pcie driver prints a register value whose type is
> propagated to the type returned by the GENMASK() macro.
> Unfortunately, that type has recently changed as the result
> of a bug fix, so now we get a warning about the type:
> 
> drivers/pci/host/pcie-xilinx.c: In function 'xilinx_pcie_clear_err_interrupts':
> drivers/pci/host/pcie-xilinx.c:154:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
> 
> This changes the code so we always print the number as an
> 'unsigned long' type to avoid the warning. The original code
> was fine on 32-bit architectures but not on 64-bit. Now it
> works as expected on both.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 00b4d9a1412 ("bitops: Fix shift overflow in GENMASK macros")

Applied with Maxime's ack to pci/host-xilinx for v3.20, thanks!

> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index ef3ebaf9a738..ce1c61d85b2c 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -148,10 +148,10 @@ static inline bool xilinx_pcie_link_is_up(struct xilinx_pcie_port *port)
>   */
>  static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *port)
>  {
> -	u32 val = pcie_read(port, XILINX_PCIE_REG_RPEFR);
> +	unsigned long val = pcie_read(port, XILINX_PCIE_REG_RPEFR);
>  
>  	if (val & XILINX_PCIE_RPEFR_ERR_VALID) {
> -		dev_dbg(port->dev, "Requester ID %d\n",
> +		dev_dbg(port->dev, "Requester ID %lu\n",
>  			val & XILINX_PCIE_RPEFR_REQ_ID);
>  		pcie_write(port, XILINX_PCIE_RPEFR_ALL_MASK,
>  			   XILINX_PCIE_REG_RPEFR);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
