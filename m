From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 May 2014 10:17:41 +1000
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20140526101741.102768b2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/Kconfig.debug between commit 7098cff2a3f4 ("ARM: debug: qcom:
make UART address selection configuration option") from the arm-soc
tree and commit 1899de289497 ("ARM: S3C24XX: use generic
DEBUG_UART_PHY/_VIRT in debug macro") from the samsung tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig.debug
index 6ff3dc661fdd,4678870f8ee8..000000000000
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@@ -966,10 -1007,10 +1003,11 @@@ config DEBUG_LL_INCLUD
  				 DEBUG_IMX51_UART || \
  				 DEBUG_IMX53_UART ||\
  				 DEBUG_IMX6Q_UART || \
 -				 DEBUG_IMX6SL_UART
 -	default "debug/msm.S" if DEBUG_MSM_UART
 +				 DEBUG_IMX6SL_UART || \
 +				 DEBUG_IMX6SX_UART
 +	default "debug/msm.S" if DEBUG_MSM_UART || DEBUG_QCOM_UARTDM
  	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
+ 	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART
  	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
  	default "debug/sti.S" if DEBUG_STI_UART
  	default "debug/tegra.S" if DEBUG_TEGRA_UART
@@@ -1057,8 -1102,7 +1101,8 @@@ config DEBUG_UART_PHY
  	default 0xfffff700 if ARCH_IOP33X
  	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
  		DEBUG_LL_UART_EFM32 || \
- 		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
 -		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_S3C24XX_UART
++		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_S3C24XX_UART \
 +		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM
  
  config DEBUG_UART_VIRT
  	hex "Virtual base address of debug UART"
@@@ -1118,8 -1166,7 +1168,8 @@@
  	default 0xff003000 if DEBUG_U300_UART
  	default DEBUG_UART_PHYS if !MMU
  	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
- 		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
 -		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_S3C24XX_UART
++		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_S3C24XX_UART \
 +		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM
  
  config DEBUG_UART_8250_SHIFT
  	int "Register offset shift for the 8250 debug UART"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140526/70d34985/attachment.sig>
