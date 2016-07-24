From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:16 -0400
Subject: [PATCH v5 02/15] binfmt_flat: convert printk invocations to their
 modern form
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 fs/binfmt_flat.c | 118 ++++++++++++++++++++++++-------------------------------
 1 file changed, 51 insertions(+), 67 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 892dba62bf..c3ccdefdea 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -15,6 +15,8 @@
  *	JAN/99 -- coded full program relocation (gerg at snapgear.com)
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -40,16 +42,6 @@
 
 /****************************************************************************/
 
-#if 0
-#define DEBUG 1
-#endif
-
-#ifdef DEBUG
-#define	DBG_FLT(a...)	printk(a)
-#else
-#define	DBG_FLT(a...)
-#endif
-
 /*
  * User data (data section and bss) needs to be aligned.
  * We pick 0x20 here because it is the max value elf2flt has always
@@ -102,8 +94,8 @@ static struct linux_binfmt flat_format = {
 
 static int flat_core_dump(struct coredump_params *cprm)
 {
-	printk("Process %s:%d received signr %d and should have core dumped\n",
-			current->comm, current->pid, cprm->siginfo->si_signo);
+	pr_warn("Process %s:%d received signr %d and should have core dumped\n",
+		current->comm, current->pid, cprm->siginfo->si_signo);
 	return 1;
 }
 
@@ -186,17 +178,17 @@ static int decompress_exec(
 	loff_t fpos;
 	int ret, retval;
 
-	DBG_FLT("decompress_exec(offset=%lx,buf=%p,len=%lx)\n", offset, dst, len);
+	pr_debug("decompress_exec(offset=%lx,buf=%p,len=%lx)\n", offset, dst, len);
 
 	memset(&strm, 0, sizeof(strm));
 	strm.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
 	if (strm.workspace == NULL) {
-		DBG_FLT("binfmt_flat: no memory for decompress workspace\n");
+		pr_debug("no memory for decompress workspace\n");
 		return -ENOMEM;
 	}
 	buf = kmalloc(LBUFSIZE, GFP_KERNEL);
 	if (buf == NULL) {
-		DBG_FLT("binfmt_flat: no memory for read buffer\n");
+		pr_debug("no memory for read buffer\n");
 		retval = -ENOMEM;
 		goto out_free;
 	}
@@ -214,25 +206,25 @@ static int decompress_exec(
 
 	/* Check minimum size -- gzip header */
 	if (ret < 10) {
-		DBG_FLT("binfmt_flat: file too small?\n");
+		pr_debug("file too small?\n");
 		goto out_free_buf;
 	}
 
 	/* Check gzip magic number */
 	if ((buf[0] != 037) || ((buf[1] != 0213) && (buf[1] != 0236))) {
-		DBG_FLT("binfmt_flat: unknown compression magic?\n");
+		pr_debug("unknown compression magic?\n");
 		goto out_free_buf;
 	}
 
 	/* Check gzip method */
 	if (buf[2] != 8) {
-		DBG_FLT("binfmt_flat: unknown compression method?\n");
+		pr_debug("unknown compression method?\n");
 		goto out_free_buf;
 	}
 	/* Check gzip flags */
 	if ((buf[3] & ENCRYPTED) || (buf[3] & CONTINUATION) ||
 	    (buf[3] & RESERVED)) {
-		DBG_FLT("binfmt_flat: unknown flags?\n");
+		pr_debug("unknown flags?\n");
 		goto out_free_buf;
 	}
 
@@ -240,7 +232,7 @@ static int decompress_exec(
 	if (buf[3] & EXTRA_FIELD) {
 		ret += 2 + buf[10] + (buf[11] << 8);
 		if (unlikely(ret >= LBUFSIZE)) {
-			DBG_FLT("binfmt_flat: buffer overflow (EXTRA)?\n");
+			pr_debug("buffer overflow (EXTRA)?\n");
 			goto out_free_buf;
 		}
 	}
@@ -248,7 +240,7 @@ static int decompress_exec(
 		while (ret < LBUFSIZE && buf[ret++] != 0)
 			;
 		if (unlikely(ret == LBUFSIZE)) {
-			DBG_FLT("binfmt_flat: buffer overflow (ORIG_NAME)?\n");
+			pr_debug("buffer overflow (ORIG_NAME)?\n");
 			goto out_free_buf;
 		}
 	}
@@ -256,7 +248,7 @@ static int decompress_exec(
 		while (ret < LBUFSIZE && buf[ret++] != 0)
 			;
 		if (unlikely(ret == LBUFSIZE)) {
-			DBG_FLT("binfmt_flat: buffer overflow (COMMENT)?\n");
+			pr_debug("buffer overflow (COMMENT)?\n");
 			goto out_free_buf;
 		}
 	}
@@ -269,7 +261,7 @@ static int decompress_exec(
 	strm.total_out = 0;
 
 	if (zlib_inflateInit2(&strm, -MAX_WBITS) != Z_OK) {
-		DBG_FLT("binfmt_flat: zlib init failed?\n");
+		pr_debug("zlib init failed?\n");
 		goto out_free_buf;
 	}
 
@@ -286,7 +278,7 @@ static int decompress_exec(
 	}
 
 	if (ret < 0) {
-		DBG_FLT("binfmt_flat: decompression failed (%d), %s\n",
+		pr_debug("decompression failed (%d), %s\n",
 			ret, strm.msg);
 		goto out_zlib;
 	}
@@ -323,24 +315,23 @@ calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
 		r &= 0x00ffffff;	/* Trim ID off here */
 	}
 	if (id >= MAX_SHARED_LIBS) {
-		printk("BINFMT_FLAT: reference 0x%lx to shared library %d",
-				r, id);
+		pr_err("reference 0x%lx to shared library %d", r, id);
 		goto failed;
 	}
 	if (curid != id) {
 		if (internalp) {
-			printk("BINFMT_FLAT: reloc address 0x%lx not in same module "
-					"(%d != %d)", r, curid, id);
+			pr_err("reloc address 0x%lx not in same module "
+			       "(%d != %d)", r, curid, id);
 			goto failed;
 		} else if (!p->lib_list[id].loaded &&
 			   load_flat_shared_library(id, p) < 0) {
-			printk("BINFMT_FLAT: failed to load library %d", id);
+			pr_err("failed to load library %d", id);
 			goto failed;
 		}
 		/* Check versioning information (i.e. time stamps) */
 		if (p->lib_list[id].build_date && p->lib_list[curid].build_date &&
 				p->lib_list[curid].build_date < p->lib_list[id].build_date) {
-			printk("BINFMT_FLAT: library %d is younger than %d", id, curid);
+			pr_err("library %d is younger than %d", id, curid);
 			goto failed;
 		}
 	}
@@ -354,7 +345,7 @@ calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
 	text_len = p->lib_list[id].text_len;
 
 	if (!flat_reloc_valid(r, start_brk - start_data + text_len)) {
-		printk("BINFMT_FLAT: reloc outside program 0x%lx (0 - 0x%lx/0x%lx)",
+		pr_err("reloc outside program 0x%lx (0 - 0x%lx/0x%lx)",
 		       r, start_brk-start_data+text_len, text_len);
 		goto failed;
 	}
@@ -368,7 +359,7 @@ calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
 	return addr;
 
 failed:
-	printk(", killing %s!\n", current->comm);
+	pr_cont(", killing %s!\n", current->comm);
 	send_sig(SIGSEGV, current, 0);
 
 	return RELOC_FAILED;
@@ -378,9 +369,7 @@ failed:
 
 static void old_reloc(unsigned long rl)
 {
-#ifdef DEBUG
 	static const char *segment[] = { "TEXT", "DATA", "BSS", "*UNKNOWN*" };
-#endif
 	flat_v2_reloc_t	r;
 	unsigned long *ptr;
 
@@ -391,11 +380,9 @@ static void old_reloc(unsigned long rl)
 	ptr = (unsigned long *) (current->mm->start_data + r.reloc.offset);
 #endif
 
-#ifdef DEBUG
-	printk("Relocation of variable at DATASEG+%x "
-		"(address %p, currently %lx) into segment %s\n",
-		r.reloc.offset, ptr, *ptr, segment[r.reloc.type]);
-#endif
+	pr_debug("Relocation of variable at DATASEG+%x "
+		 "(address %p, currently %lx) into segment %s\n",
+		 r.reloc.offset, ptr, *ptr, segment[r.reloc.type]);
 
 	switch (r.reloc.type) {
 	case OLD_FLAT_RELOC_TYPE_TEXT:
@@ -408,13 +395,11 @@ static void old_reloc(unsigned long rl)
 		*ptr += current->mm->end_data;
 		break;
 	default:
-		printk("BINFMT_FLAT: Unknown relocation type=%x\n", r.reloc.type);
+		pr_err("Unknown relocation type=%x\n", r.reloc.type);
 		break;
 	}
 
-#ifdef DEBUG
-	printk("Relocation became %lx\n", *ptr);
-#endif
+	pr_debug("Relocation became %lx\n", *ptr);
 }
 
 /****************************************************************************/
@@ -463,20 +448,19 @@ static int load_flat_file(struct linux_binprm *bprm,
 	}
 
 	if (flags & FLAT_FLAG_KTRACE)
-		printk("BINFMT_FLAT: Loading file: %s\n", bprm->filename);
+		pr_info("Loading file: %s\n", bprm->filename);
 
 	if (rev != FLAT_VERSION && rev != OLD_FLAT_VERSION) {
-		printk("BINFMT_FLAT: bad flat file version 0x%x (supported "
-			"0x%lx and 0x%lx)\n",
-			rev, FLAT_VERSION, OLD_FLAT_VERSION);
+		pr_err("bad flat file version 0x%x (supported 0x%lx and 0x%lx)\n",
+		       rev, FLAT_VERSION, OLD_FLAT_VERSION);
 		ret = -ENOEXEC;
 		goto err;
 	}
 
 	/* Don't allow old format executables to use shared libraries */
 	if (rev == OLD_FLAT_VERSION && id != 0) {
-		printk("BINFMT_FLAT: shared libraries are not available before rev 0x%lx\n",
-				FLAT_VERSION);
+		pr_err("shared libraries are not available before rev 0x%lx\n",
+		       FLAT_VERSION);
 		ret = -ENOEXEC;
 		goto err;
 	}
@@ -490,7 +474,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 
 #ifndef CONFIG_BINFMT_ZFLAT
 	if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
-		printk("Support for ZFLAT executables is not enabled.\n");
+		pr_err("Support for ZFLAT executables is not enabled.\n");
 		ret = -ENOEXEC;
 		goto err;
 	}
@@ -536,7 +520,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		 * this should give us a ROM ptr,  but if it doesn't we don't
 		 * really care
 		 */
-		DBG_FLT("BINFMT_FLAT: ROM mapping of file (we hope)\n");
+		pr_debug("ROM mapping of file (we hope)\n");
 
 		textpos = vm_mmap(bprm->file, 0, text_len, PROT_READ|PROT_EXEC,
 				  MAP_PRIVATE|MAP_EXECUTABLE, 0);
@@ -544,7 +528,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			ret = textpos;
 			if (!textpos)
 				ret = -ENOMEM;
-			printk("Unable to mmap process text, errno %d\n", ret);
+			pr_err("Unable to mmap process text, errno %d\n", ret);
 			goto err;
 		}
 
@@ -557,7 +541,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			ret = realdatastart;
 			if (!realdatastart)
 				ret = -ENOMEM;
-			printk("Unable to allocate RAM for process data, "
+			pr_err("Unable to allocate RAM for process data, "
 			       "errno %d\n", ret);
 			vm_munmap(textpos, text_len);
 			goto err;
@@ -566,8 +550,8 @@ static int load_flat_file(struct linux_binprm *bprm,
 				MAX_SHARED_LIBS * sizeof(unsigned long),
 				FLAT_DATA_ALIGN);
 
-		DBG_FLT("BINFMT_FLAT: Allocated data+bss+stack (%ld bytes): %lx\n",
-			data_len + bss_len + stack_len, datapos);
+		pr_debug("Allocated data+bss+stack (%ld bytes): %lx\n",
+			 data_len + bss_len + stack_len, datapos);
 
 		fpos = ntohl(hdr->data_start);
 #ifdef CONFIG_BINFMT_ZFLAT
@@ -582,7 +566,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		}
 		if (IS_ERR_VALUE(result)) {
 			ret = result;
-			printk("Unable to read data+bss, errno %d\n", ret);
+			pr_err("Unable to read data+bss, errno %d\n", ret);
 			vm_munmap(textpos, text_len);
 			vm_munmap(realdatastart, len);
 			goto err;
@@ -603,7 +587,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			ret = textpos;
 			if (!textpos)
 				ret = -ENOMEM;
-			printk("Unable to allocate RAM for process text/data, "
+			pr_err("Unable to allocate RAM for process text/data, "
 			       "errno %d\n", ret);
 			goto err;
 		}
@@ -645,7 +629,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		}
 		if (IS_ERR_VALUE(result)) {
 			ret = result;
-			printk("Unable to read code+data+bss, errno %d\n", ret);
+			pr_err("Unable to read code+data+bss, errno %d\n", ret);
 			vm_munmap(textpos, text_len + data_len + extra +
 				MAX_SHARED_LIBS * sizeof(unsigned long));
 			goto err;
@@ -675,12 +659,12 @@ static int load_flat_file(struct linux_binprm *bprm,
 	}
 
 	if (flags & FLAT_FLAG_KTRACE) {
-		printk("Mapping is %lx, Entry point is %x, data_start is %x\n",
-		       textpos, 0x00ffffff&ntohl(hdr->entry), ntohl(hdr->data_start));
-		printk("%s %s: TEXT=%lx-%lx DATA=%lx-%lx BSS=%lx-%lx\n",
-		       id ? "Lib" : "Load", bprm->filename,
-		       start_code, end_code, datapos, datapos + data_len,
-		       datapos + data_len, (datapos + data_len + bss_len + 3) & ~3);
+		pr_info("Mapping is %lx, Entry point is %x, data_start is %x\n",
+			textpos, 0x00ffffff&ntohl(hdr->entry), ntohl(hdr->data_start));
+		pr_info("%s %s: TEXT=%lx-%lx DATA=%lx-%lx BSS=%lx-%lx\n",
+			id ? "Lib" : "Load", bprm->filename,
+			start_code, end_code, datapos, datapos + data_len,
+			datapos + data_len, (datapos + data_len + bss_len + 3) & ~3);
 	}
 
 	/* Store the current module values into the global library structure */
@@ -890,7 +874,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 	set_binfmt(&flat_format);
 
 	p = ((current->mm->context.end_brk + stack_len + 3) & ~3) - 4;
-	DBG_FLT("p=%lx\n", p);
+	pr_debug("p=%lx\n", p);
 
 	/* copy the arg pages onto the stack, this could be more efficient :-) */
 	for (i = TOP_OF_ARGS - 1; i >= bprm->p; i--)
@@ -922,8 +906,8 @@ static int load_flat_binary(struct linux_binprm *bprm)
 	FLAT_PLAT_INIT(regs);
 #endif
 
-	DBG_FLT("start_thread(regs=0x%p, entry=0x%lx, start_stack=0x%lx)\n",
-		regs, start_addr, current->mm->start_stack);
+	pr_debug("start_thread(regs=0x%p, entry=0x%lx, start_stack=0x%lx)\n",
+		 regs, start_addr, current->mm->start_stack);
 	start_thread(regs, start_addr, current->mm->start_stack);
 
 	return 0;
-- 
2.7.4
