From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 16:26:56 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mailbox tree
Message-ID: <20130621162656.bb94e0fa8b6813781b804a73@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mailbox/Kconfig between commit a1824eaab70f ("mailbox: OMAP:
introduce mailbox framework") from the mailbox tree and commit
c869c75c16b3 ("mailbox/omap: move the OMAP mailbox framework to drivers")
from the arm-soc tree.

I fixed it up (I suspect not properly - see below) and can carry the fix
as necessary (no action is required).

It looks like we have two different versions of these changes in
linux-next now, so please clean it all up.  i.e. can I just drop the
mailbox tree now?
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/mailbox/Kconfig
index 438ea21,c8b5c13..0000000
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@@ -16,45 -16,38 +16,63 @@@ config PL320_MBO
  	  Management Engine, primarily for cpufreq. Say Y here if you want
  	  to use the PL320 IPCM support.
  
- config OMAP1_MBOX
-        tristate "OMAP1 Mailbox framework support"
-        depends on ARCH_OMAP1
-        help
-          Mailbox implementation for OMAP chips with hardware for
-          interprocessor communication involving DSP in OMAP1. Say Y here
-          if you want to use OMAP1 Mailbox framework support.
- 
- config OMAP2PLUS_MBOX
-        tristate "OMAP2+ Mailbox framework support"
-        depends on ARCH_OMAP2PLUS
-        help
-          Mailbox implementation for OMAP family chips with hardware for
-          interprocessor communication involving DSP, IVA1.0 and IVA2 in
-          OMAP2/3; or IPU, IVA HD and DSP in OMAP4. Say Y here if you want
-          to use OMAP2+ Mailbox framework support.
- 
 +config DBX500_MBOX
 +	tristate "DBx500 Mailbox driver support"
 +	depends on ARCH_U8500
 +	help
 +	  Say Y here if you want to use DBx500 Mailbox driver support for
 +	  power coprocessor access on Ux500 and Ux540 families
 +
 +config MBOX_KFIFO_SIZE
 +       int "Mailbox kfifo default buffer size (bytes)"
 +       default 256
 +       help
 +         Specify the default size of mailbox's kfifo buffers (bytes).
 +         This can also be changed at runtime (via the mbox_kfifo_size
 +         module parameter).
 +
 +config MBOX_DATA_SIZE
 +	int "Mailbox associated data max size (bytes)"
 +	default 64 if DBX500_MBOX
 +	default 4
 +	help
 +	  Specify the default size of mailbox's associated data buffer
 +	  (bytes)
 +          This can also be changed at runtime (via the mbox_kfifo_size
 +          module parameter).
++
+ config OMAP_MBOX
+ 	tristate
+ 	help
+ 	  This option is selected by any OMAP architecture specific mailbox
+ 	  driver such as CONFIG_OMAP1_MBOX or CONFIG_OMAP2PLUS_MBOX. This
+ 	  enables the common OMAP mailbox framework code.
+ 
+ config OMAP1_MBOX
+ 	tristate "OMAP1 Mailbox framework support"
+ 	depends on ARCH_OMAP1
+ 	select OMAP_MBOX
+ 	help
+ 	  Mailbox implementation for OMAP chips with hardware for
+ 	  interprocessor communication involving DSP in OMAP1. Say Y here
+ 	  if you want to use OMAP1 Mailbox framework support.
+ 
+ config OMAP2PLUS_MBOX
+ 	tristate "OMAP2+ Mailbox framework support"
+ 	depends on ARCH_OMAP2PLUS
+ 	select OMAP_MBOX
+ 	help
+ 	  Mailbox implementation for OMAP family chips with hardware for
+ 	  interprocessor communication involving DSP, IVA1.0 and IVA2 in
+ 	  OMAP2/3; or IPU, IVA HD and DSP in OMAP4/5. Say Y here if you
+ 	  want to use OMAP2+ Mailbox framework support.
+ 
+ config OMAP_MBOX_KFIFO_SIZE
+ 	int "Mailbox kfifo default buffer size (bytes)"
+ 	depends on OMAP2PLUS_MBOX || OMAP1_MBOX
+ 	default 256
+ 	help
+ 	  Specify the default size of mailbox's kfifo buffers (bytes).
+ 	  This can also be changed at runtime (via the mbox_kfifo_size
+ 	  module parameter).
  endif
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/54feb6c1/attachment-0001.sig>
