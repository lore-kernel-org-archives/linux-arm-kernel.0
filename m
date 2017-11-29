From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 29 Nov 2017 12:51:45 +0100
Subject: [PATCH] net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on
 64-bit
In-Reply-To: <1511949669-30379-1-git-send-email-geert+renesas@glider.be>
References: <1511949669-30379-1-git-send-email-geert+renesas@glider.be>
Message-ID: <c69c2f1f-0f22-2baf-41a5-d30e2f6d96a0@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.11.2017 11:01, Geert Uytterhoeven wrote:
> On 64-bit (e.g. powerpc64/allmodconfig):
> 
>     drivers/net/ethernet/xilinx/ll_temac_main.c: In function 'temac_start_xmit_done':
>     drivers/net/ethernet/xilinx/ll_temac_main.c:633:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> 	dev_kfree_skb_irq((struct sk_buff *)cur_p->app4);
> 			  ^
> 
> cdmac_bd.app4 is u32, so it is too small to hold a kernel pointer.
> 
> Note that several other fields in struct cdmac_bd are also too small to
> hold physical addresses on 64-bit platforms.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/ethernet/xilinx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
> index 6d68c8a8f4f2ac7f..da4ec575ccf9ba4a 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -34,6 +34,7 @@ config XILINX_AXI_EMAC
>  config XILINX_LL_TEMAC
>  	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
>  	depends on (PPC || MICROBLAZE)
> +	depends on !64BIT || BROKEN
>  	select PHYLIB
>  	---help---
>  	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
> 

Yes. This IP is available only on big endian 32bit systems.

Thanks,
Michal
