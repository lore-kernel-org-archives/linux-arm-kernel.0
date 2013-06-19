From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 19 Jun 2013 16:24:49 +1000
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20130619162449.5b0a64cc42e7cb9a744624e9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/Kconfig.debug between commit 828989ad87af ("ARM: keystone: Add
minimal TI Keystone platform support") from the arm-soc tree and commit
34e8a16b944e ("ARM: imx: enable low-level debug support for imx6sl") from
the imx-mxs tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig.debug
index 4649bf5,29f7623..0000000
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@@ -251,20 -251,13 +251,27 @@@ choic
  		  Say Y here if you want kernel low-level debugging support
  		  on i.MX6Q/DL.
  
+ 	config DEBUG_IMX6SL_UART
+ 		bool "i.MX6SL Debug UART"
+ 		depends on SOC_IMX6SL
+ 		help
+ 		  Say Y here if you want kernel low-level debugging support
+ 		  on i.MX6SL.
+ 
 +	config DEBUG_KEYSTONE_UART0
 +		bool "Kernel low-level debugging on KEYSTONE2 using UART0"
 +		depends on ARCH_KEYSTONE
 +		help
 +		  Say Y here if you want the debug print routines to direct
 +		  their output to UART0 serial port on KEYSTONE2 devices.
 +
 +	config DEBUG_KEYSTONE_UART1
 +		bool "Kernel low-level debugging on KEYSTONE2 using UART1"
 +		depends on ARCH_KEYSTONE
 +		help
 +		  Say Y here if you want the debug print routines to direct
 +		  their output to UART1 serial port on KEYSTONE2 devices.
 +
  	config DEBUG_MMP_UART2
  		bool "Kernel low-level debugging message via MMP UART2"
  		depends on ARCH_MMP
@@@ -677,11 -639,9 +685,12 @@@ config DEBUG_LL_INCLUD
  				 DEBUG_IMX35_UART || \
  				 DEBUG_IMX51_UART || \
  				 DEBUG_IMX53_UART ||\
- 				 DEBUG_IMX6Q_UART
+ 				 DEBUG_IMX6Q_UART || \
+ 				 DEBUG_IMX6SL_UART
 -	default "debug/mvebu.S" if DEBUG_MVEBU_UART
 +	default "debug/keystone.S" if DEBUG_KEYSTONE_UART0 || \
 +				      DEBUG_KEYSTONE_UART1
 +	default "debug/mvebu.S" if DEBUG_MVEBU_UART || \
 +				   DEBUG_MVEBU_UART_ALTERNATE
  	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
  	default "debug/nomadik.S" if DEBUG_NOMADIK_UART
  	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/d06cf0c2/attachment.sig>
