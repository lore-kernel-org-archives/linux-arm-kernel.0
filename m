From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 10 Nov 2015 11:57:50 +0000
Subject: [PATCH v2 2/7] xen: rename dom0_op to platform_op
In-Reply-To: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
Message-ID: <1447156675-7418-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dom0_op hypercall has been renamed to platform_op since Xen 3.2,
which is ancient, and modern upstream Linux kernels cannot run as dom0
and it anymore anyway.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: konrad.wilk at oracle.com
CC: david.vrabel at citrix.com
CC: boris.ostrovsky at oracle.com
---
 arch/x86/include/asm/xen/hypercall.h |    6 +++---
 arch/x86/xen/apic.c                  |    2 +-
 arch/x86/xen/enlighten.c             |    8 ++++----
 arch/x86/xen/time.c                  |    2 +-
 drivers/xen/acpi.c                   |    2 +-
 drivers/xen/efi.c                    |   30 +++++++++++++++---------------
 drivers/xen/pcpu.c                   |    8 ++++----
 drivers/xen/xen-acpi-cpuhotplug.c    |    2 +-
 drivers/xen/xen-acpi-pad.c           |    4 ++--
 drivers/xen/xen-acpi-processor.c     |    8 ++++----
 drivers/xen/xenfs/xensyms.c          |    4 ++--
 include/xen/interface/xen.h          |    2 +-
 12 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 4c20dd3..3bcdcc8 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -310,10 +310,10 @@ HYPERVISOR_mca(struct xen_mc *mc_op)
 }
 
 static inline int
-HYPERVISOR_dom0_op(struct xen_platform_op *platform_op)
+HYPERVISOR_platform_op(struct xen_platform_op *op)
 {
-	platform_op->interface_version = XENPF_INTERFACE_VERSION;
-	return _hypercall1(int, dom0_op, platform_op);
+	op->interface_version = XENPF_INTERFACE_VERSION;
+	return _hypercall1(int, platform_op, op);
 }
 
 static inline int
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index acda713..abf4901 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -64,7 +64,7 @@ static u32 xen_apic_read(u32 reg)
 	if (reg != APIC_ID)
 		return 0;
 
-	ret = HYPERVISOR_dom0_op(&op);
+	ret = HYPERVISOR_platform_op(&op);
 	if (ret)
 		return 0;
 
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 5774800..f963c40 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -415,7 +415,7 @@ static bool __init xen_check_mwait(void)
 
 	set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
 
-	if ((HYPERVISOR_dom0_op(&op) == 0) &&
+	if ((HYPERVISOR_platform_op(&op) == 0) &&
 	    (buf[2] & (ACPI_PDC_C_C1_FFH | ACPI_PDC_C_C2C3_FFH))) {
 		cpuid_leaf5_ecx_val = cx;
 		cpuid_leaf5_edx_val = dx;
@@ -1374,7 +1374,7 @@ static void __init xen_boot_params_init_edd(void)
 		info->params.length = sizeof(info->params);
 		set_xen_guest_handle(op.u.firmware_info.u.disk_info.edd_params,
 				     &info->params);
-		ret = HYPERVISOR_dom0_op(&op);
+		ret = HYPERVISOR_platform_op(&op);
 		if (ret)
 			break;
 
@@ -1392,7 +1392,7 @@ static void __init xen_boot_params_init_edd(void)
 	op.u.firmware_info.type = XEN_FW_DISK_MBR_SIGNATURE;
 	for (nr = 0; nr < EDD_MBR_SIG_MAX; nr++) {
 		op.u.firmware_info.index = nr;
-		ret = HYPERVISOR_dom0_op(&op);
+		ret = HYPERVISOR_platform_op(&op);
 		if (ret)
 			break;
 		mbr_signature[nr] = op.u.firmware_info.u.disk_mbr_signature.mbr_signature;
@@ -1698,7 +1698,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 		xen_start_info->console.domU.mfn = 0;
 		xen_start_info->console.domU.evtchn = 0;
 
-		if (HYPERVISOR_dom0_op(&op) == 0)
+		if (HYPERVISOR_platform_op(&op) == 0)
 			boot_params.kbd_status = op.u.firmware_info.u.kbd_shift_flags;
 
 		/* Make sure ACS will be enabled */
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 041d4cd..663c2ea 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -139,7 +139,7 @@ static int xen_pvclock_gtod_notify(struct notifier_block *nb,
 	op.u.settime.nsecs = now.tv_nsec;
 	op.u.settime.system_time = xen_clocksource_read();
 
-	(void)HYPERVISOR_dom0_op(&op);
+	(void)HYPERVISOR_platform_op(&op);
 
 	/*
 	 * Move the next drift compensation time 11 minutes
diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
index 90307c0..6893c79 100644
--- a/drivers/xen/acpi.c
+++ b/drivers/xen/acpi.c
@@ -58,7 +58,7 @@ static int xen_acpi_notify_hypervisor_state(u8 sleep_state,
 		 bits, val_a, val_b))
 		return -1;
 
-	HYPERVISOR_dom0_op(&op);
+	HYPERVISOR_platform_op(&op);
 	return 1;
 }
 
diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
index f745db2..be7e56a 100644
--- a/drivers/xen/efi.c
+++ b/drivers/xen/efi.c
@@ -42,7 +42,7 @@ static efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
 	struct xen_platform_op op = INIT_EFI_OP(get_time);
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	if (tm) {
@@ -67,7 +67,7 @@ static efi_status_t xen_efi_set_time(efi_time_t *tm)
 	BUILD_BUG_ON(sizeof(*tm) != sizeof(efi_data(op).u.set_time));
 	memcpy(&efi_data(op).u.set_time, tm, sizeof(*tm));
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	return efi_data(op).status;
@@ -79,7 +79,7 @@ static efi_status_t xen_efi_get_wakeup_time(efi_bool_t *enabled,
 {
 	struct xen_platform_op op = INIT_EFI_OP(get_wakeup_time);
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	if (tm) {
@@ -108,7 +108,7 @@ static efi_status_t xen_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 	else
 		efi_data(op).misc |= XEN_EFI_SET_WAKEUP_TIME_ENABLE_ONLY;
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	return efi_data(op).status;
@@ -129,7 +129,7 @@ static efi_status_t xen_efi_get_variable(efi_char16_t *name,
 	efi_data(op).u.get_variable.size = *data_size;
 	set_xen_guest_handle(efi_data(op).u.get_variable.data, data);
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	*data_size = efi_data(op).u.get_variable.size;
@@ -152,7 +152,7 @@ static efi_status_t xen_efi_get_next_variable(unsigned long *name_size,
 	memcpy(&efi_data(op).u.get_next_variable_name.vendor_guid, vendor,
 	       sizeof(*vendor));
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	*name_size = efi_data(op).u.get_next_variable_name.size;
@@ -178,7 +178,7 @@ static efi_status_t xen_efi_set_variable(efi_char16_t *name,
 	efi_data(op).u.set_variable.size = data_size;
 	set_xen_guest_handle(efi_data(op).u.set_variable.data, data);
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	return efi_data(op).status;
@@ -196,7 +196,7 @@ static efi_status_t xen_efi_query_variable_info(u32 attr,
 
 	efi_data(op).u.query_variable_info.attr = attr;
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	*storage_space = efi_data(op).u.query_variable_info.max_store_size;
@@ -210,7 +210,7 @@ static efi_status_t xen_efi_get_next_high_mono_count(u32 *count)
 {
 	struct xen_platform_op op = INIT_EFI_OP(get_next_high_monotonic_count);
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	*count = efi_data(op).misc;
@@ -232,7 +232,7 @@ static efi_status_t xen_efi_update_capsule(efi_capsule_header_t **capsules,
 	efi_data(op).u.update_capsule.capsule_count = count;
 	efi_data(op).u.update_capsule.sg_list = sg_list;
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	return efi_data(op).status;
@@ -252,7 +252,7 @@ static efi_status_t xen_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 					capsules);
 	efi_data(op).u.query_capsule_capabilities.capsule_count = count;
 
-	if (HYPERVISOR_dom0_op(&op) < 0)
+	if (HYPERVISOR_platform_op(&op) < 0)
 		return EFI_UNSUPPORTED;
 
 	*max_size = efi_data(op).u.query_capsule_capabilities.max_capsule_size;
@@ -331,7 +331,7 @@ efi_system_table_t __init *xen_efi_probe(void)
 	};
 	union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
 
-	if (!xen_initial_domain() || HYPERVISOR_dom0_op(&op) < 0)
+	if (!xen_initial_domain() || HYPERVISOR_platform_op(&op) < 0)
 		return NULL;
 
 	/* Here we know that Xen runs on EFI platform. */
@@ -347,7 +347,7 @@ efi_system_table_t __init *xen_efi_probe(void)
 	info->vendor.bufsz = sizeof(vendor);
 	set_xen_guest_handle(info->vendor.name, vendor);
 
-	if (HYPERVISOR_dom0_op(&op) == 0) {
+	if (HYPERVISOR_platform_op(&op) == 0) {
 		efi_systab_xen.fw_vendor = __pa_symbol(vendor);
 		efi_systab_xen.fw_revision = info->vendor.revision;
 	} else
@@ -357,14 +357,14 @@ efi_system_table_t __init *xen_efi_probe(void)
 	op.u.firmware_info.type = XEN_FW_EFI_INFO;
 	op.u.firmware_info.index = XEN_FW_EFI_VERSION;
 
-	if (HYPERVISOR_dom0_op(&op) == 0)
+	if (HYPERVISOR_platform_op(&op) == 0)
 		efi_systab_xen.hdr.revision = info->version;
 
 	op.cmd = XENPF_firmware_info;
 	op.u.firmware_info.type = XEN_FW_EFI_INFO;
 	op.u.firmware_info.index = XEN_FW_EFI_RT_VERSION;
 
-	if (HYPERVISOR_dom0_op(&op) == 0)
+	if (HYPERVISOR_platform_op(&op) == 0)
 		efi.runtime_version = info->version;
 
 	return &efi_systab_xen;
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index 49e88f2..cdc6daa 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -78,7 +78,7 @@ static int xen_pcpu_down(uint32_t cpu_id)
 		.u.cpu_ol.cpuid		= cpu_id,
 	};
 
-	return HYPERVISOR_dom0_op(&op);
+	return HYPERVISOR_platform_op(&op);
 }
 
 static int xen_pcpu_up(uint32_t cpu_id)
@@ -89,7 +89,7 @@ static int xen_pcpu_up(uint32_t cpu_id)
 		.u.cpu_ol.cpuid		= cpu_id,
 	};
 
-	return HYPERVISOR_dom0_op(&op);
+	return HYPERVISOR_platform_op(&op);
 }
 
 static ssize_t show_online(struct device *dev,
@@ -277,7 +277,7 @@ static int sync_pcpu(uint32_t cpu, uint32_t *max_cpu)
 		.u.pcpu_info.xen_cpuid = cpu,
 	};
 
-	ret = HYPERVISOR_dom0_op(&op);
+	ret = HYPERVISOR_platform_op(&op);
 	if (ret)
 		return ret;
 
@@ -364,7 +364,7 @@ int xen_pcpu_id(uint32_t acpi_id)
 	op.cmd = XENPF_get_cpuinfo;
 	while (cpu_id <= max_id) {
 		op.u.pcpu_info.xen_cpuid = cpu_id;
-		if (HYPERVISOR_dom0_op(&op)) {
+		if (HYPERVISOR_platform_op(&op)) {
 			cpu_id++;
 			continue;
 		}
diff --git a/drivers/xen/xen-acpi-cpuhotplug.c b/drivers/xen/xen-acpi-cpuhotplug.c
index f4a3694..fdc9e67 100644
--- a/drivers/xen/xen-acpi-cpuhotplug.c
+++ b/drivers/xen/xen-acpi-cpuhotplug.c
@@ -206,7 +206,7 @@ static int xen_hotadd_cpu(struct acpi_processor *pr)
 	op.u.cpu_add.acpi_id = pr->acpi_id;
 	op.u.cpu_add.pxm = pxm;
 
-	cpu_id = HYPERVISOR_dom0_op(&op);
+	cpu_id = HYPERVISOR_platform_op(&op);
 	if (cpu_id < 0)
 		pr_err(PREFIX "Failed to hotadd CPU for acpi_id %d\n",
 				pr->acpi_id);
diff --git a/drivers/xen/xen-acpi-pad.c b/drivers/xen/xen-acpi-pad.c
index f83b754..23d1808 100644
--- a/drivers/xen/xen-acpi-pad.c
+++ b/drivers/xen/xen-acpi-pad.c
@@ -36,7 +36,7 @@ static int xen_acpi_pad_idle_cpus(unsigned int idle_nums)
 	op.u.core_parking.type = XEN_CORE_PARKING_SET;
 	op.u.core_parking.idle_nums = idle_nums;
 
-	return HYPERVISOR_dom0_op(&op);
+	return HYPERVISOR_platform_op(&op);
 }
 
 static int xen_acpi_pad_idle_cpus_num(void)
@@ -46,7 +46,7 @@ static int xen_acpi_pad_idle_cpus_num(void)
 	op.cmd = XENPF_core_parking;
 	op.u.core_parking.type = XEN_CORE_PARKING_GET;
 
-	return HYPERVISOR_dom0_op(&op)
+	return HYPERVISOR_platform_op(&op)
 	       ?: op.u.core_parking.idle_nums;
 }
 
diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index 70fa438..076970a 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -116,7 +116,7 @@ static int push_cxx_to_hypervisor(struct acpi_processor *_pr)
 	set_xen_guest_handle(op.u.set_pminfo.power.states, dst_cx_states);
 
 	if (!no_hypercall)
-		ret = HYPERVISOR_dom0_op(&op);
+		ret = HYPERVISOR_platform_op(&op);
 
 	if (!ret) {
 		pr_debug("ACPI CPU%u - C-states uploaded.\n", _pr->acpi_id);
@@ -244,7 +244,7 @@ static int push_pxx_to_hypervisor(struct acpi_processor *_pr)
 	}
 
 	if (!no_hypercall)
-		ret = HYPERVISOR_dom0_op(&op);
+		ret = HYPERVISOR_platform_op(&op);
 
 	if (!ret) {
 		struct acpi_processor_performance *perf;
@@ -302,7 +302,7 @@ static unsigned int __init get_max_acpi_id(void)
 	info = &op.u.pcpu_info;
 	info->xen_cpuid = 0;
 
-	ret = HYPERVISOR_dom0_op(&op);
+	ret = HYPERVISOR_platform_op(&op);
 	if (ret)
 		return NR_CPUS;
 
@@ -310,7 +310,7 @@ static unsigned int __init get_max_acpi_id(void)
 	last_cpu = op.u.pcpu_info.max_present;
 	for (i = 0; i <= last_cpu; i++) {
 		info->xen_cpuid = i;
-		ret = HYPERVISOR_dom0_op(&op);
+		ret = HYPERVISOR_platform_op(&op);
 		if (ret)
 			continue;
 		max_acpi_id = max(info->acpi_id, max_acpi_id);
diff --git a/drivers/xen/xenfs/xensyms.c b/drivers/xen/xenfs/xensyms.c
index f8b1285..a03f261 100644
--- a/drivers/xen/xenfs/xensyms.c
+++ b/drivers/xen/xenfs/xensyms.c
@@ -31,7 +31,7 @@ static int xensyms_next_sym(struct xensyms *xs)
 
 	symnum = symdata->symnum;
 
-	ret = HYPERVISOR_dom0_op(&xs->op);
+	ret = HYPERVISOR_platform_op(&xs->op);
 	if (ret < 0)
 		return ret;
 
@@ -50,7 +50,7 @@ static int xensyms_next_sym(struct xensyms *xs)
 		set_xen_guest_handle(symdata->name, xs->name);
 		symdata->symnum--; /* Rewind */
 
-		ret = HYPERVISOR_dom0_op(&xs->op);
+		ret = HYPERVISOR_platform_op(&xs->op);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index 167071c..d133112 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -48,7 +48,7 @@
 #define __HYPERVISOR_set_callbacks         4
 #define __HYPERVISOR_fpu_taskswitch        5
 #define __HYPERVISOR_sched_op_compat       6
-#define __HYPERVISOR_dom0_op               7
+#define __HYPERVISOR_platform_op           7
 #define __HYPERVISOR_set_debugreg          8
 #define __HYPERVISOR_get_debugreg          9
 #define __HYPERVISOR_update_descriptor    10
-- 
1.7.10.4
