From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 22 Jan 2014 20:12:52 +0530
Subject: [PATCH v7 5/6] misc: debug: remove compilation warnings
In-Reply-To: <1390401773-12100-1-git-send-email-vijay.kilari@gmail.com>
References: <1390401773-12100-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1390401773-12100-6-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Resolve following compiler warnings
warning: format '%lx' expects argument of type 'long unsigned int',
but argument 2 has type 'u64' [-Wformat]

tested for warnings on arm32 & arm64

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
---
 drivers/misc/kgdbts.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 36f5d52..78e10b2 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -350,8 +350,8 @@ static int check_single_step(char *put_str, char *arg)
 	kgdb_hex2mem(&put_str[1], (char *)kgdbts_gdb_regs,
 		 NUMREGBYTES);
 	gdb_regs_to_pt_regs(kgdbts_gdb_regs, &kgdbts_regs);
-	v2printk("Singlestep stopped at IP: %lx\n",
-		   instruction_pointer(&kgdbts_regs));
+	v2printk("Singlestep stopped at IP: %llx\n",
+		   (unsigned long long)instruction_pointer(&kgdbts_regs));
 
 	if (sstep_thread_id != cont_thread_id) {
 		/*
@@ -376,8 +376,8 @@ static int check_single_step(char *put_str, char *arg)
 continue_test:
 	matched_id = 0;
 	if (instruction_pointer(&kgdbts_regs) == addr) {
-		eprintk("kgdbts: SingleStep failed at %lx\n",
-			   instruction_pointer(&kgdbts_regs));
+		eprintk("kgdbts: SingleStep failed at %llx\n",
+			(unsigned long long)instruction_pointer(&kgdbts_regs));
 		return 1;
 	}
 
@@ -491,8 +491,8 @@ static int emul_sstep_put(char *put_str, char *arg)
 		kgdb_hex2mem(&put_str[1], (char *)kgdbts_gdb_regs,
 			 NUMREGBYTES);
 		gdb_regs_to_pt_regs(kgdbts_gdb_regs, &kgdbts_regs);
-		v2printk("Stopped at IP: %lx\n",
-			 instruction_pointer(&kgdbts_regs));
+		v2printk("Stopped at IP: %llx\n",
+			 (unsigned long long)instruction_pointer(&kgdbts_regs));
 		/* Want to stop at IP + break instruction size by default */
 		sstep_addr = cont_addr + BREAK_INSTR_SIZE;
 		break;
-- 
1.7.9.5
