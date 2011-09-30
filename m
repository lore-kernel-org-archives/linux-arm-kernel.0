From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Sep 2011 10:48:47 +0100
Subject: [PATCH] genirq: percpu: allow interrupt type to be set at enable t=
Message-ID: <mailman.160.1317380864.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ime

As request_percpu_irq() doesn't allow for a percpu interrupt
to have its type configured (it is generally impossible to
configure it on all CPUs at once), add a 'type' argument to
enable_percpu_irq().

This allows some low-level, board specific init code to
be switched to a generic API.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/interrupt.h |    2 +-
 kernel/irq/manage.c       |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1cdfd09..664544f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -223,7 +223,7 @@ extern void disable_irq_nosync(unsigned int irq);
 extern void disable_irq(unsigned int irq);
 extern void disable_percpu_irq(unsigned int irq);
 extern void enable_irq(unsigned int irq);
-extern void enable_percpu_irq(unsigned int irq);
+extern void enable_percpu_irq(unsigned int irq, unsigned int type);
=20
 /* The following three functions are for the core kernel use only. */
 #ifdef CONFIG_GENERIC_HARDIRQS
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7b4b156..e647ce1 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1419,7 +1419,7 @@ int request_any_context_irq(unsigned int irq, irq_han=
dler_t handler,
 }
 EXPORT_SYMBOL_GPL(request_any_context_irq);
=20
-void enable_percpu_irq(unsigned int irq)
+void enable_percpu_irq(unsigned int irq, unsigned int type)
 {
 =09unsigned int cpu =3D smp_processor_id();
 =09unsigned long flags;
@@ -1428,7 +1428,20 @@ void enable_percpu_irq(unsigned int irq)
 =09if (!desc)
 =09=09return;
=20
+=09type &=3D IRQ_TYPE_SENSE_MASK;
+=09if (type !=3D IRQ_TYPE_NONE) {
+=09=09int ret;
+
+=09=09ret =3D __irq_set_trigger(desc, irq, type);
+
+=09=09if (ret) {
+=09=09=09WARN(1, "failed to set type for IRQ%d\n");
+=09=09=09goto out;
+=09=09}
+=09}
+
 =09irq_percpu_enable(desc, cpu);
+out:
 =09irq_put_desc_unlock(desc, flags);
 }
=20
--=20
1.7.0.4

--------------040908090006060506080309--
