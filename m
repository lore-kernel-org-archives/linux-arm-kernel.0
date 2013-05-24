From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 May 2013 01:45:05 -0400
Subject: [PATCH 2/8] drivers/bus: arm-cci: function to enable CCI ports from
 early boot code
In-Reply-To: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
References: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1369374311-21260-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides cci_enable_port_for_self().  This is the counterpart to
cci_disable_port_by_cpu(self).

This is meant to be called from the MCPM machine specific power_up_setup
callback code when the appropriate affinity level needs to be initialized.
The code therefore has to be position independent as the MMU is still off
and it cannot rely on any stack space.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/bus/arm-cci.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index ea81fa4a28..c6ae6e7193 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -43,6 +43,7 @@ enum cci_ace_port_type {
 
 struct cci_ace_port {
 	void __iomem *base;
+	unsigned long phys;
 	enum cci_ace_port_type type;
 	struct device_node *dn;
 };
@@ -51,11 +52,13 @@ static struct cci_ace_port *ports;
 static unsigned int nb_cci_ports;
 
 static void __iomem *cci_ctrl_base;
+static unsigned long cci_ctrl_phys;
 
 struct cpu_port {
 	u64 mpidr;
 	u32 port;
 };
+
 /*
  * Use the port MSB as valid flag, shift can be made dynamic
  * by computing number of bits required for port indexes.
@@ -230,6 +233,98 @@ int notrace cci_disable_port_by_cpu(u64 mpidr)
 EXPORT_SYMBOL_GPL(cci_disable_port_by_cpu);
 
 /**
+ * cci_enable_port_for_self() - function to enable a CCI port for calling CPU
+ *
+ * Enabling a CCI port for the calling CPU implies enabling the CCI
+ * port controlling that CPU cluster. Code enabling CPU CCI ports
+ * must make sure that the CPU running the code is the first active
+ * CPU in the cluster and all other CPUs are quiescent in a low power
+ * state  or waiting for this CPU to complete the CCI initialization.
+ *
+ * Because this is called when the MMU is still off and with no stack,
+ * the code must be position independent and ideally rely on callee
+ * clobbered registers only.  To achieve this we must code this function
+ * entirely in assembler.
+ *
+ * Return:
+ *	0 on success
+ *	-ENODEV on port look-up failure
+ */
+asmlinkage int __naked cci_enable_port_for_self(void)
+{
+	asm volatile ("\n"
+
+"	mrc	p15, 0, r0, c0, c0, 5	@ get MPIDR value \n"
+"	and	r0, r0, #"__stringify(MPIDR_HWID_BITMASK)" \n"
+"	adr	r1, 5f \n"
+"	ldr	r2, [r1] \n"
+"	add	r1, r1, r2		@ &cpu_port \n"
+"	add	ip, r1, %[sizeof_cpu_port] \n"
+
+	/* Loop over the cpu_port array looking for a matching MPIDR */
+"1:	ldr	r2, [r1, %[offsetof_cpu_port_mpidr_lsb]] \n"
+"	cmp	r2, r0 			@ compare MPIDR \n"
+"	bne	2f \n"
+
+	/* Found a match, now test port validity */
+"	ldr	r3, [r1, %[offsetof_cpu_port_port]] \n"
+"	tst	r3, #"__stringify(PORT_VALID)" \n"
+"	bne	3f \n"
+
+	/* no match, loop with the next cpu_port entry */
+"2:	add	r1, r1, %[sizeof_struct_cpu_port] \n"
+"	cmp	r1, ip			@ done? \n"
+"	blo	1b \n"
+"	mov	r0, #"__stringify(-ENODEV)" \n"
+"	bx	lr \n"
+
+	/* Use matched port index to look up the corresponding ports entry */
+"3:	bic	r3, r3, #"__stringify(PORT_VALID)" \n"
+"	adr	r0, 6f \n"
+"	ldmia	r0, {r1, r2} \n"
+"	sub	r1, r1, r0 		@ virt - phys \n"
+"	ldr	r0, [r0, r2] 		@ *(&ports) \n"
+"	mov	r2, %[sizeof_struct_ace_port] \n"
+"	mla	r0, r2, r3, r0		@ &ports[index] \n"
+"	sub	r0, r0, r1		@ virt_to_phys() \n"
+
+	/* Enable the CCI port */
+"	ldr	r0, [r0, %[offsetof_port_phys]] \n"
+"	mov	r3, #"__stringify(CCI_ENABLE_REQ)" \n"
+"	str	r3, [r0, #"__stringify(CCI_PORT_CTRL)"] \n"
+
+	/* poll the status reg for completion */
+"	adr	r1, 7f \n"
+"	ldr	r0, [r1] \n"
+"	ldr	r0, [r0, r1]		@ cci_ctrl_base \n"
+"4:	ldr	r1, [r0, #"__stringify(CCI_CTRL_STATUS)"] \n"
+"	tst	r1, #1 \n"
+"	bne	4b \n"
+
+"	mov	r0, #0 \n"
+"	bx	lr \n"
+
+"	.align \n"
+"5:	.word	cpu_port - . \n"
+"6:	.word	. \n"
+"	.word	ports - 6b \n"
+"7:	.word	cci_ctrl_phys - . \n"
+	: :
+	[sizeof_cpu_port] "i" (sizeof(cpu_port)),
+#ifndef __ARMEB__
+	[offsetof_cpu_port_mpidr_lsb] "i" (offsetof(struct cpu_port, mpidr)),
+#else
+	[offsetof_cpu_port_mpidr_lsb] "i" (offsetof(struct cpu_port, mpidr)+4),
+#endif
+	[offsetof_cpu_port_port] "i" (offsetof(struct cpu_port, port)),
+	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
+	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
+	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
+
+	unreachable();
+}
+
+/**
  * __cci_control_port_by_device() - function to control a CCI port by device
  *				    reference
  *
@@ -306,6 +401,7 @@ static int __init cci_probe(void)
 	struct cci_nb_ports const *cci_config;
 	int ret, i, nb_ace = 0, nb_ace_lite = 0;
 	struct device_node *np, *cp;
+	struct resource res;
 	const char *match_str;
 	bool is_ace;
 
@@ -323,9 +419,12 @@ static int __init cci_probe(void)
 	if (!ports)
 		return -ENOMEM;
 
-	cci_ctrl_base = of_iomap(np, 0);
-
-	if (!cci_ctrl_base) {
+	ret = of_address_to_resource(np, 0, &res);
+	if (!ret) {
+		cci_ctrl_base = ioremap(res.start, resource_size(&res));
+		cci_ctrl_phys =	res.start;
+	}
+	if (ret || !cci_ctrl_base) {
 		WARN(1, "unable to ioremap CCI ctrl\n");
 		ret = -ENXIO;
 		goto memalloc_err;
@@ -353,9 +452,12 @@ static int __init cci_probe(void)
 			continue;
 		}
 
-		ports[i].base = of_iomap(cp, 0);
-
-		if (!ports[i].base) {
+		ret = of_address_to_resource(cp, 0, &res);
+		if (!ret) {
+			ports[i].base = ioremap(res.start, resource_size(&res));
+			ports[i].phys = res.start;
+		}	
+		if (ret || !ports[i].base) {
 			WARN(1, "unable to ioremap CCI port %d\n", i);
 			continue;
 		}
@@ -382,6 +484,7 @@ static int __init cci_probe(void)
 	 * cluster power-up/power-down. Make sure it reaches main memory.
 	 */
 	sync_cache_w(&cci_ctrl_base);
+	sync_cache_w(&cci_ctrl_phys);
 	sync_cache_w(&ports);
 	sync_cache_w(&cpu_port);
 	__sync_cache_range_w(ports, sizeof(*ports) * nb_cci_ports);
-- 
1.8.1.2
