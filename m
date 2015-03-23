From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 23 Mar 2015 11:33:18 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm-perf tree
Message-ID: <20150323113318.0319c248@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/bus/Kconfig between commit c9966c98697a ("arm-cci: Split the
code for PMU vs driver support") from the arm-perf tree and commit
13fbf3c8d0f7 ("drivers: bus: Sort Kconfig entries alphabetically") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/bus/Kconfig
index 79e297b1f221,7e9c2674af81..000000000000
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@@ -4,6 -4,21 +4,38 @@@
  
  menu "Bus devices"
  
 -config ARM_CCI
 -	bool "ARM CCI driver support"
++config ARM_CCI400_PORT_CTRL
++	bool
+ 	depends on ARM && OF && CPU_V7
++	select ARM_CCI400_COMMON
+ 	help
 -	  Driver supporting the CCI cache coherent interconnect for ARM
 -	  platforms.
++	  Low level power management driver for CCI400 cache coherent
++	  interconnect for ARM platforms.
++
++config ARM_CCI400_PMU
++	bool "ARM CCI400 PMU support"
++	default y
++	depends on ARM || ARM64
++	depends on HW_PERF_EVENTS
++	select ARM_CCI400_COMMON
++	help
++	  Support for PMU events monitoring on the ARM CCI cache coherent
++	  interconnect.
++
++	  If unsure, say Y
++
++config ARM_CCI400_COMMON
++	bool
++	select ARM_CCI
+ 
+ config ARM_CCN
+ 	bool "ARM CCN driver support"
+ 	depends on ARM || ARM64
+ 	depends on PERF_EVENTS
+ 	help
+ 	  PMU (perf) driver supporting the ARM CCN (Cache Coherent Network)
+ 	  interconnect.
+ 
  config BRCMSTB_GISB_ARB
  	bool "Broadcom STB GISB bus arbiter"
  	depends on ARM || MIPS
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150323/85b3cad9/attachment.sig>
