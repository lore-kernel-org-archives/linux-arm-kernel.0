From: dyoung@redhat.com (Dave Young)
Date: Fri, 31 Oct 2014 15:52:09 +0800
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <cover.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
Message-ID: <20141031075209.GH3290@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff

I tested your patches. The macihne is using spin-table cpu enable method
so I tried maxcpus=1 as you suggested.

There's below issues for me, thoughts?

1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
to use.

2. adding "acpi=off" to 1st kernel boot cmdline, kexec load fails with error
like below:
machine_apply_elf_rel: ERROR Unknown type: 261

I did below hack then kexec load works fine, but `kexec -e` still does not work
there's nothing more than "Disableing non-boot CPUS ...\n Bye!":

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 9db1c07..2df24f0 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -790,6 +790,10 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 # define R_AARCH64_ABS64 257
 #endif
 
+#if !defined(R_AARCH64_PREL32)
+#define R_AARCH64_PREL32		261
+#endif
+
 #if !defined(R_AARCH64_LD_PREL_LO19)
 # define R_AARCH64_LD_PREL_LO19 273
 #endif
@@ -806,6 +810,7 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 # define R_AARCH64_CALL26 283
 #endif
 
+	uint64_t *location1 = (uint64_t *)ptr;
 	uint32_t *location = (uint32_t *)ptr;
 	uint32_t data = *location;
 	const char *type = NULL;
@@ -813,7 +818,11 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 	switch(r_type) {
 	case R_AARCH64_ABS64:
 		type = "ABS64";
-		*location += value;
+		*location1 += value;
+		break;
+	case R_AARCH64_PREL32:
+		type = "PREL32";
+		*location += value - address;
 		break;
 	case R_AARCH64_LD_PREL_LO19:
 		type = "LD_PREL_LO19";
@@ -839,7 +848,7 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 		break;
 	}
 
-	dbgprintf("%s: %s %x->%x\n", __func__, type, data, *location);
+	dbgprintf("%s: %s %x->%lx\n", __func__, type, data, (r_type == R_AARCH64_ABS64)? *location1: *location);
 }
 
 void arch_reuse_initrd(void)

Thanks
Dave
