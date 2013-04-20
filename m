From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:36:22 +0200
Subject: [PATCH v3] ARM: pci: create pci_common_init_dev()
In-Reply-To: <20130419140633.GS14496@n2100.arm.linux.org.uk>
References: <1365788748-7908-1-git-send-email-linus.walleij@linaro.org>
 <20130413102929.GB30758@avionic-0098.mockup.avionic-design.de>
 <20130419140633.GS14496@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdabcCLku2tzMogVo2G-i3BjemHN3HkgcD2+mt3tSEf9Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 4:06 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Apr 13, 2013 at 12:29:29PM +0200, Thierry Reding wrote:
>> On Fri, Apr 12, 2013 at 07:45:48PM +0200, Linus Walleij wrote:
>> [...]
>> > +static inline void pci_common_init(struct hw_pci *hw) {
>>
>> I think that the CodingStyle rule for putting the opening brace on a
>> line by itself also applies to inline functions.
>>
>> Aside from that nit:
>>
>> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
>
> Strangely the patch never came through the mailing list.  Where can it
> be found?  Obviously this is core ARM code which is being touched so
> it should've been copied to me.

Yes the mail header looks like this:

Received: from mail.df.lth.se (mail.df.lth.se. [194.47.250.12])
        by mx.google.com with ESMTPS id w10si3088342lbw.255.2013.04.12.10.44.04
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 10:44:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of triad at df.lth.se designates
194.47.250.12 as permitted sender) client-ip=194.47.250.12;
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of triad at df.lth.se designates
194.47.250.12 as permitted sender) smtp.mail=triad at df.lth.se
Received: from mer.df.lth.se (mer.df.lth.se [194.47.250.37])
(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
(No client certificate requested)
by mail.df.lth.se (Postfix) with ESMTPS id AA5C765D3A;
Fri, 12 Apr 2013 19:44:02 +0200 (CEST)
Received: from mer.df.lth.se (triad at localhost.localdomain [127.0.0.1])
by mer.df.lth.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r3CHi24v007862;
Fri, 12 Apr 2013 19:44:02 +0200
Received: (from triad at localhost)
by mer.df.lth.se (8.14.3/8.14.3/Submit) id r3CHhuSs007858;
Fri, 12 Apr 2013 19:43:56 +0200
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel at lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <mike@compulab.co.il>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Andrew Murray <andrew.murray@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmitt <benh@kernel.crashing.org>
Subject: [PATCH v2] ARM: pci: create pci_common_init_dev()
Date: Fri, 12 Apr 2013 19:43:48 +0200
Message-Id: <1365788628-7831-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 1.7.2.5

So I suspect it might be that this listserver does not accept that I am sending
@linaro.org mails from a non-linaro.org mailserver (mail.df.lth.se).

I guess I'll try to figure out how to send mails out of that domains mail server
instead.

Here is the patch, inlined (it'll probably me mangled by gmails editor..)
>From cabfcde34c85e8f6b73a86f20e43f76b0a040484 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 11 Apr 2013 23:32:28 +0200
Subject: [PATCH] ARM: pci: create pci_common_init_dev()

When working with device tree support for PCI on ARM you run
into a problem when mapping IRQs from the device tree irqmaps:
doing this the code in drivers/of/of_pci_irq.c will try to
find the OF node on the root bridge and this fails, because
bus->dev.of_node is NULL, and that in turn boils down to
the fact that pci_set_bus_of_node() has called
pcibios_get_phb_of_node() from drivers/pci/of.c to obtain
the OF node of the bridge or its parent and none is set
and thus NULL is returned.

Fix this by adding an additional parent argument API for
registering PCI bridges on the ARM architecture called
pci_common_init_dev(), and pass along this parent to
pci_scan_root_bus() called from pcibios_init_hw() in
bios32.c and voila: the IRQ mappings start working:
the OF node can be retrieved from the parent.

Create the old pci_common_init() as a wrapper around
the new call.

Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmitt <benh@kernel.crashing.org>
Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Put opening bracket on its own line.
- Use the proper rmk+kernel address for Russells CC.
---
 arch/arm/include/asm/mach/pci.h | 12 +++++++++++-
 arch/arm/kernel/bios32.c        |  9 +++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 5cf2e97..28ac12f 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -16,6 +16,7 @@
 struct pci_sys_data;
 struct pci_ops;
 struct pci_bus;
+struct device;

 struct hw_pci {
 #ifdef CONFIG_PCI_DOMAINS
@@ -57,7 +58,16 @@ struct pci_sys_data {
 /*
  * Call this with your hw_pci struct to initialise the PCI system.
  */
-void pci_common_init(struct hw_pci *);
+void pci_common_init_dev(struct device *, struct hw_pci *);
+
+/*
+ * Compatibility wrapper for older platforms that do not care about
+ * passing the parent device.
+ */
+static inline void pci_common_init(struct hw_pci *hw)
+{
+    pci_common_init_dev(NULL, hw);
+}

 /*
  * Setup early fixed I/O mapping.
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index a1f73b5..a99bde1 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -445,7 +445,8 @@ static int pcibios_init_resources(int busnr,
struct pci_sys_data *sys)
     return 0;
 }

-static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
+static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
+                struct list_head *head)
 {
     struct pci_sys_data *sys = NULL;
     int ret;
@@ -479,7 +480,7 @@ static void pcibios_init_hw(struct hw_pci *hw,
struct list_head *head)
             if (hw->scan)
                 sys->bus = hw->scan(nr, sys);
             else
-                sys->bus = pci_scan_root_bus(NULL, sys->busnr,
+                sys->bus = pci_scan_root_bus(parent, sys->busnr,
                         hw->ops, sys, &sys->resources);

             if (!sys->bus)
@@ -496,7 +497,7 @@ static void pcibios_init_hw(struct hw_pci *hw,
struct list_head *head)
     }
 }

-void pci_common_init(struct hw_pci *hw)
+void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 {
     struct pci_sys_data *sys;
     LIST_HEAD(head);
@@ -504,7 +505,7 @@ void pci_common_init(struct hw_pci *hw)
     pci_add_flags(PCI_REASSIGN_ALL_RSRC);
     if (hw->preinit)
         hw->preinit();
-    pcibios_init_hw(hw, &head);
+    pcibios_init_hw(parent, hw, &head);
     if (hw->postinit)
         hw->postinit();

--
1.8.1.4



Yours,
Linus Walleij
