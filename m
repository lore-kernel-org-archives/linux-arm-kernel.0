From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:33:09 +0000
Subject: [PATCH 06/17] ARM: sa11x0: neponset: provide function to manipulate
 NCR_0
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOsf-0001Bt-Pv@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than having direct register accesses to NCR_0 scattered amongst
the code, provide a function instead.  This contains the necessary
race protection for this platform, ensuring that updates to this
register are safe.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/neponset.h |    4 ++++
 arch/arm/mach-sa1100/neponset.c              |    9 +++++++++
 drivers/net/ethernet/smsc/smc91x.c           |    2 +-
 drivers/pcmcia/sa1100_neponset.c             |    7 +------
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/neponset.h b/arch/arm/mach-sa1100/include/mach/neponset.h
index ffe2bc4..6032216 100644
--- a/arch/arm/mach-sa1100/include/mach/neponset.h
+++ b/arch/arm/mach-sa1100/include/mach/neponset.h
@@ -71,4 +71,8 @@
 #define NCR_A0VPP		(1<<5)
 #define NCR_A1VPP		(1<<6)
 
+void neponset_ncr_frob(unsigned int, unsigned int);
+#define neponset_ncr_set(v)	neponset_ncr_frob(0, v)
+#define neponset_ncr_clear(v)	neponset_ncr_frob(v, 0)
+
 #endif
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 6a14d37..10be07e 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -20,6 +20,15 @@
 #include <asm/hardware/sa1111.h>
 #include <asm/sizes.h>
 
+void neponset_ncr_frob(unsigned int mask, unsigned int val)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	NCR_0 = (NCR_0 & ~mask) | val;
+	local_irq_restore(flags);
+}
+
 /*
  * Install handler for Neponset IRQ.  Note that we have to loop here
  * since the ETHERNET and USAR IRQs are level based, and we need to
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 64ad3ed..0dba050 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2281,7 +2281,7 @@ static int __devinit smc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_release_io;
 #if defined(CONFIG_SA1100_ASSABET)
-	NCR_0 |= NCR_ENET_OSC_EN;
+	neponset_ncr_set(NCR_ENET_OSC_EN);
 #endif
 	platform_set_drvdata(pdev, ndev);
 	ret = smc_enable_device(pdev);
diff --git a/drivers/pcmcia/sa1100_neponset.c b/drivers/pcmcia/sa1100_neponset.c
index c95639b..4300a7f 100644
--- a/drivers/pcmcia/sa1100_neponset.c
+++ b/drivers/pcmcia/sa1100_neponset.c
@@ -94,12 +94,7 @@ neponset_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_sta
 
 	ret = sa1111_pcmcia_configure_socket(skt, state);
 	if (ret == 0) {
-		unsigned long flags;
-
-		local_irq_save(flags);
-		NCR_0 = (NCR_0 & ~ncr_mask) | ncr_set;
-
-		local_irq_restore(flags);
+		neponset_ncr_frob(ncr_mask, ncr_set);
 		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
 	}
 
-- 
1.7.4.4
