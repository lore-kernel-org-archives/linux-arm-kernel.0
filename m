From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Thu, 26 Aug 2010 15:02:31 +0300
Subject: [PATCH v2 5/6] crash/kdump: add ARM support
In-Reply-To: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <57cbc6faa8e5e4922267bf716a734ed510988986.1282822832.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARM support for kdump files (ELF files readable from
/proc/vmcore). It also provides a function which tries to determine correct
phys_base based on the program headers in the ELF file.

Signed-off-by: Jan Karlsson <jan.karlsson@sonyericsson.com>
Signed-off-by: Thomas F?nge <thomas.fange@sonyericsson.com>
Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 defs.h    |    3 ++
 netdump.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/defs.h b/defs.h
index 3d34b8e..c8bae00 100755
--- a/defs.h
+++ b/defs.h
@@ -4353,6 +4353,9 @@ int xen_minor_version(void);
 int get_netdump_arch(void);
 void *get_regs_from_elf_notes(struct task_context *);
 void map_cpus_to_prstatus(void);
+#ifdef ARM
+int kdump_phys_base(ulong *);
+#endif
 
 /*
  *  diskdump.c
diff --git a/netdump.c b/netdump.c
index 3a5db13..3bf6e3b 100644
--- a/netdump.c
+++ b/netdump.c
@@ -32,6 +32,7 @@ static void dump_Elf64_Ehdr(Elf64_Ehdr *);
 static void dump_Elf64_Phdr(Elf64_Phdr *, int);
 static size_t dump_Elf64_Nhdr(Elf64_Off offset, int);
 static void get_netdump_regs_ppc64(struct bt_info *, ulong *, ulong *);
+static void get_netdump_regs_arm(struct bt_info *, ulong *, ulong *);
 static physaddr_t xen_kdump_p2m(physaddr_t);
 static void check_dumpfile_size(char *);
 
@@ -170,6 +171,12 @@ is_netdump(char *file, ulong source_query)
 				goto bailout;
 			break;
 
+		case EM_ARM:
+			if (machine_type_mismatch(file, "ARM", NULL,
+			    source_query))
+				goto bailout;
+			break;
+
 		default:
 			if (machine_type_mismatch(file, "(unknown)", NULL,
 			    source_query))
@@ -2094,6 +2101,10 @@ get_netdump_regs(struct bt_info *bt, ulong *eip, ulong *esp)
 	case EM_S390:
 		machdep->get_stack_frame(bt, eip, esp);
 		break;
+
+	case EM_ARM:
+		return get_netdump_regs_arm(bt, eip, esp);
+		break;
 	default:
 		error(FATAL, 
 		   "support for ELF machine type %d not available\n",
@@ -2393,6 +2404,40 @@ get_netdump_regs_ppc64(struct bt_info *bt, ulong *eip, ulong *esp)
 	machdep->get_stack_frame(bt, eip, esp);
 }
 
+static void
+get_netdump_regs_arm(struct bt_info *bt, ulong *eip, ulong *esp)
+{
+	Elf64_Nhdr *note;
+	size_t len;
+
+	if ((bt->task == tt->panic_task) ||
+		(is_task_active(bt->task) && nd->num_prstatus_notes > 1)) {
+		/*
+		 * Registers are saved during the dump process for the
+		 * panic task. Whereas in kdump, regs are captured for all
+		 * CPUs if they responded to an IPI.
+		 */
+                if (nd->num_prstatus_notes > 1) {
+			if (!nd->nt_prstatus_percpu[bt->tc->processor])
+				error(FATAL,
+				      "cannot determine NT_PRSTATUS ELF note "
+				      "for %s task: %lx\n",
+				       (bt->task == tt->panic_task) ?
+				       "panic" : "active", bt->task);
+                        note = (Elf64_Nhdr *)
+                                nd->nt_prstatus_percpu[bt->tc->processor];
+		} else
+			note = (Elf64_Nhdr *)nd->nt_prstatus;
+
+		len = sizeof(Elf64_Nhdr);
+		len = roundup(len + note->n_namesz, 4);
+		bt->machdep = (void *)((char *)note + len +
+			MEMBER_OFFSET("elf_prstatus", "pr_reg"));
+	}
+
+	machdep->get_stack_frame(bt, eip, esp);
+}
+
 int 
 is_partial_netdump(void)
 {
@@ -2644,6 +2689,7 @@ xen_minor_version(void)
 static void *get_ppc64_regs_from_elf_notes(struct task_context *);
 static void *get_x86_regs_from_elf_notes(struct task_context *);
 static void *get_x86_64_regs_from_elf_notes(struct task_context *);
+static void *get_arm_regs_from_elf_notes(struct task_context *);
 
 int get_netdump_arch(void)
 {
@@ -2670,6 +2716,8 @@ get_regs_from_elf_notes(struct task_context *tc)
 		return get_ppc64_regs_from_elf_notes(tc);
 	case EM_X86_64:
 		return get_x86_64_regs_from_elf_notes(tc);
+	case EM_ARM:
+		return get_arm_regs_from_elf_notes(tc);
 	default:
 		error(FATAL,
 		    "support for ELF machine type %d not available\n",
@@ -2786,3 +2834,70 @@ get_ppc64_regs_from_elf_notes(struct task_context *tc)
 	
 	return pt_regs;
 }
+
+#ifdef ARM
+/*
+ * In case of ARM we need to determine correct PHYS_OFFSET from the kdump file.
+ * This is done by taking lowest physical address (LMA) from given load
+ * segments. Normally this is the right one.
+ *
+ * Alternative would be to store phys_base in VMCOREINFO but current kernel
+ * kdump doesn't do that yet.
+ */
+int kdump_phys_base(ulong *phys_base)
+{
+	struct pt_load_segment *pls;
+	ulong paddr = ULONG_MAX;
+	int i;
+
+	for (i = 0; i < nd->num_pt_load_segments; i++) {
+		pls = &nd->pt_load_segments[i];
+		if (pls->phys_start < paddr)
+			paddr = pls->phys_start;
+	}
+
+	if (paddr != ULONG_MAX) {
+		*phys_base = paddr;
+		return TRUE;
+	}
+	return FALSE;
+}
+#endif /* ARM */
+
+static void *
+get_arm_regs_from_elf_notes(struct task_context *tc)
+{
+	Elf32_Nhdr *note_32;
+	Elf64_Nhdr *note_64;
+	void *note;
+	size_t len;
+	void *pt_regs;
+
+	len = 0;
+	pt_regs = NULL;
+
+	if ((tc->task == tt->panic_task) ||
+	    (is_task_active(tc->task) && (nd->num_prstatus_notes > 1))) {
+		if (nd->num_prstatus_notes > 1)
+			note = (void *)
+				nd->nt_prstatus_percpu[tc->processor];
+		else
+			note = (void *)nd->nt_prstatus;
+		if (nd->elf32) {
+			note_32 = (Elf32_Nhdr *)note;
+			len = sizeof(Elf32_Nhdr);
+			len = roundup(len + note_32->n_namesz, 4);
+		} else if (nd->elf64) {
+			note_64 = (Elf64_Nhdr *)note;
+			len = sizeof(Elf64_Nhdr);
+			len = roundup(len + note_64->n_namesz, 4);
+		}
+
+		pt_regs = (void *)((char *)note + len +
+			MEMBER_OFFSET("elf_prstatus", "pr_reg"));
+	} else
+		error(FATAL,
+		    "cannot determine arm register set for task \"%s\"\n",
+			tc->comm);
+	return pt_regs;
+}
-- 
1.5.6.5
