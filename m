From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 11 Jun 2010 18:51:35 +0300
Subject: [PATCH v4 00/14] omap: mailbox: bunch of cleanups
Message-ID: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Contreras <--global>

Hi,

These are hopefully non-functional changes. Just shuffling code around, and
removing unecessary stuff.

This v4 includes minor changes suggested by Felipe Balbi, Hiroshi, and Russell.

Comments from Felipe Balbi, Tony Lindgren, Hiroshi DOYU, and Russell King.

Felipe Contreras (14):
  omap: mailbox: trivial whitespace cleanups
  omap: mailbox: trivial cleanups
  omap: mailbox: reorganize structures
  omap: mailbox: 2420 should be detected at run-time
  omap: mailbox: use correct config for omap1
  omap: mailbox: update omap1 probing
  omap: mailbox: don't export unecessary symbols
  omap: mailbox: remove unecessary fields
  omap: mailbox: add IRQ names
  omap: mailbox: reorganize registering
  omap: mailbox: simplify omap_mbox_register()
  omap: mailbox: only compile for configured archs
  omap: mailbox: standarize on 'omap-mailbox'
  omap: mailbox: reorganize headers

 arch/arm/mach-omap1/devices.c             |   11 +-
 arch/arm/mach-omap1/mailbox.c             |   55 ++++------
 arch/arm/mach-omap2/devices.c             |    6 +-
 arch/arm/mach-omap2/mailbox.c             |  179 +++++++++++++----------------
 arch/arm/plat-omap/include/plat/mailbox.h |   16 +--
 arch/arm/plat-omap/mailbox.c              |  136 +++++++++-------------
 6 files changed, 170 insertions(+), 233 deletions(-)

Here's the interdiff with v3:

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index fdd6cc9..1a85a42 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -143,17 +143,16 @@ struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
 
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
-       struct resource *res;
+       struct resource *mem;
        int ret;
        int i;
        struct omap_mbox **list;
 
-       res = pdev->resource;
-
        list = omap1_mboxes;
        list[0]->irq = platform_get_irq_byname(pdev, "dsp");
 
-       mbox_base = ioremap(res[0].start, resource_size(&res[0]));
+       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       mbox_base = ioremap(mem->start, resource_size(mem));
        if (!mbox_base)
                return -ENOMEM;
 
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index d46e439..42dbfa4 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -388,13 +388,12 @@ struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
-       struct resource *res;
+       struct resource *mem;
        int ret;
        struct omap_mbox **list;
 
-       res = pdev->resource;
-
-       if (false);
+       if (false)
+               ;
 #if defined(CONFIG_ARCH_OMAP3430)
        else if (cpu_is_omap3430()) {
                list = omap3_mboxes;
@@ -423,7 +422,8 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
                return -ENODEV;
        }
 
-       mbox_base = ioremap(res[0].start, resource_size(&res[0]));
+       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       mbox_base = ioremap(mem->start, resource_size(mem));
        if (!mbox_base)
                return -ENOMEM;
 
