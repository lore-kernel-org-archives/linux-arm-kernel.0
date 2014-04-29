From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Apr 2014 22:00:53 +0200
Subject: [PATCH] Xen: hibernation is x86-only at the moment
Message-ID: <5165529.jneGVBC5b5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 603fb42a66499ab "ARM: 8011/1: ARM hibernation / suspend-to-disk",
currently in linux-next, the ARM architecture gains support for
hibernation (suspend-to-disk). Xen supports this in principle, but only
has an architecture specific hypercall defined on x86, which leads
to a build error when both hibernation and Xen support are enabled:

drivers/xen/manage.c:105:2: error: implicit declaration of function 'HYPERVISOR_suspend' [-Werror=implicit-function-declaration]
  si->cancelled = HYPERVISOR_suspend(si->arg);

It is probably a good idea to define this hypercall on ARM as well
and provide an implementation in the host, but until that is done,
this patch helps disable the broken code in the Xen guest by making
it depend on CONFIG_X86.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 32f9236..beba1be 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -60,7 +60,7 @@ void xen_resume_notifier_unregister(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(xen_resume_notifier_unregister);
 
-#ifdef CONFIG_HIBERNATE_CALLBACKS
+#if defined(CONFIG_HIBERNATE_CALLBACKS) && defined(CONFIG_X86)
 static void xen_hvm_post_suspend(int cancelled)
 {
 	xen_arch_hvm_post_suspend(cancelled);
@@ -242,7 +242,7 @@ static void shutdown_handler(struct xenbus_watch *watch,
 		{ "poweroff",	do_poweroff },
 		{ "halt",	do_poweroff },
 		{ "reboot",	do_reboot   },
-#ifdef CONFIG_HIBERNATE_CALLBACKS
+#if defined(CONFIG_HIBERNATE_CALLBACKS) && defined(CONFIG_X86)
 		{ "suspend",	do_suspend  },
 #endif
 		{NULL, NULL},
