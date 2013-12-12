From: marex@denx.de (Marek Vasut)
Date: Thu, 12 Dec 2013 23:01:01 +0100
Subject: [PATCH] pci: designware: fix missing msi irqs
In-Reply-To: <20131212182903.409515738@gmail.com>
References: <20131212182903.409515738@gmail.com>
Message-ID: <201312122301.01658.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 12, 2013 at 07:29:03 PM, Harro Haan wrote:
> The interrupts were cleared after the irq handler was called.
> This means that new interrupts that occur after the handler handled
> the previous irq but before the interrupt is cleared will be missed.
> 
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Richard Zhu <hong-xing.zhu@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Juergen Beisert <jbe@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: linux-pci at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/pci/host/pcie-designware.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c index 1ce0453..762f596 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -167,11 +167,13 @@ void dw_handle_msi_irq(struct pcie_port *pp)
>  			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
>  				irq = irq_find_mapping(pp->irq_domain,
>  						i * 32 + pos);
> +				dw_pcie_wr_own_conf(pp,
> +						PCIE_MSI_INTR0_STATUS + i * 12,
> +						4, 1 << pos);
>  				generic_handle_irq(irq);
>  				pos++;
>  			}
>  		}
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4, val);
>  	}
>  }

On imx6-sabrelite:

Tested-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
