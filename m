From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:15 -0400
Subject: [PATCH v5 01/15] binfmt_flat: assorted cleanups
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove excessive casts, do some code grouping, fix most important
checkpatch.pl complaints, etc.

No functional changes.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
---
 fs/binfmt_flat.c | 230 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 109 insertions(+), 121 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index caf9e39bb8..892dba62bf 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -15,7 +15,6 @@
  *	JAN/99 -- coded full program relocation (gerg at snapgear.com)
  */
 
-#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -25,8 +24,6 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/file.h>
-#include <linux/stat.h>
-#include <linux/fcntl.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/slab.h>
@@ -34,10 +31,9 @@
 #include <linux/personality.h>
 #include <linux/init.h>
 #include <linux/flat.h>
-#include <linux/syscalls.h>
+#include <linux/uaccess.h>
 
 #include <asm/byteorder.h>
-#include <asm/uaccess.h>
 #include <asm/unaligned.h>
 #include <asm/cacheflush.h>
 #include <asm/page.h>
@@ -80,7 +76,7 @@ struct lib_info {
 		unsigned long text_len;			/* Length of text segment */
 		unsigned long entry;			/* Start address for this module */
 		unsigned long build_date;		/* When this one was compiled */
-		short loaded;				/* Has this library been loaded? */
+		bool loaded;				/* Has this library been loaded? */
 	} lib_list[MAX_SHARED_LIBS];
 };
 
@@ -107,8 +103,8 @@ static struct linux_binfmt flat_format = {
 static int flat_core_dump(struct coredump_params *cprm)
 {
 	printk("Process %s:%d received signr %d and should have core dumped\n",
-			current->comm, current->pid, (int) cprm->siginfo->si_signo);
-	return(1);
+			current->comm, current->pid, cprm->siginfo->si_signo);
+	return 1;
 }
 
 /****************************************************************************/
@@ -120,11 +116,11 @@ static int flat_core_dump(struct coredump_params *cprm)
 
 static unsigned long create_flat_tables(
 	unsigned long pp,
-	struct linux_binprm * bprm)
+	struct linux_binprm *bprm)
 {
-	unsigned long *argv,*envp;
-	unsigned long * sp;
-	char * p = (char*)pp;
+	unsigned long *argv, *envp;
+	unsigned long *sp;
+	char *p = (char *)pp;
 	int argc = bprm->argc;
 	int envc = bprm->envc;
 	char uninitialized_var(dummy);
@@ -142,7 +138,7 @@ static unsigned long create_flat_tables(
 
 	put_user(argc, sp);
 	current->mm->arg_start = (unsigned long) p;
-	while (argc-->0) {
+	while (argc-- > 0) {
 		put_user((unsigned long) p, argv++);
 		do {
 			get_user(dummy, p); p++;
@@ -150,7 +146,7 @@ static unsigned long create_flat_tables(
 	}
 	put_user((unsigned long) NULL, argv);
 	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
-	while (envc-->0) {
+	while (envc-- > 0) {
 		put_user((unsigned long)p, envp); envp++;
 		do {
 			get_user(dummy, p); p++;
@@ -190,7 +186,7 @@ static int decompress_exec(
 	loff_t fpos;
 	int ret, retval;
 
-	DBG_FLT("decompress_exec(offset=%x,buf=%x,len=%x)\n",(int)offset, (int)dst, (int)len);
+	DBG_FLT("decompress_exec(offset=%lx,buf=%p,len=%lx)\n", offset, dst, len);
 
 	memset(&strm, 0, sizeof(strm));
 	strm.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
@@ -243,7 +239,7 @@ static int decompress_exec(
 	ret = 10;
 	if (buf[3] & EXTRA_FIELD) {
 		ret += 2 + buf[10] + (buf[11] << 8);
-		if (unlikely(LBUFSIZE <= ret)) {
+		if (unlikely(ret >= LBUFSIZE)) {
 			DBG_FLT("binfmt_flat: buffer overflow (EXTRA)?\n");
 			goto out_free_buf;
 		}
@@ -251,7 +247,7 @@ static int decompress_exec(
 	if (buf[3] & ORIG_NAME) {
 		while (ret < LBUFSIZE && buf[ret++] != 0)
 			;
-		if (unlikely(LBUFSIZE == ret)) {
+		if (unlikely(ret == LBUFSIZE)) {
 			DBG_FLT("binfmt_flat: buffer overflow (ORIG_NAME)?\n");
 			goto out_free_buf;
 		}
@@ -259,7 +255,7 @@ static int decompress_exec(
 	if (buf[3] & COMMENT) {
 		while (ret < LBUFSIZE && buf[ret++] != 0)
 			;
-		if (unlikely(LBUFSIZE == ret)) {
+		if (unlikely(ret == LBUFSIZE)) {
 			DBG_FLT("binfmt_flat: buffer overflow (COMMENT)?\n");
 			goto out_free_buf;
 		}
@@ -327,17 +323,17 @@ calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
 		r &= 0x00ffffff;	/* Trim ID off here */
 	}
 	if (id >= MAX_SHARED_LIBS) {
-		printk("BINFMT_FLAT: reference 0x%x to shared library %d",
-				(unsigned) r, id);
+		printk("BINFMT_FLAT: reference 0x%lx to shared library %d",
+				r, id);
 		goto failed;
 	}
 	if (curid != id) {
 		if (internalp) {
-			printk("BINFMT_FLAT: reloc address 0x%x not in same module "
-					"(%d != %d)", (unsigned) r, curid, id);
+			printk("BINFMT_FLAT: reloc address 0x%lx not in same module "
+					"(%d != %d)", r, curid, id);
 			goto failed;
-		} else if ( ! p->lib_list[id].loaded &&
-				load_flat_shared_library(id, p) < 0) {
+		} else if (!p->lib_list[id].loaded &&
+			   load_flat_shared_library(id, p) < 0) {
 			printk("BINFMT_FLAT: failed to load library %d", id);
 			goto failed;
 		}
@@ -358,8 +354,8 @@ calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
 	text_len = p->lib_list[id].text_len;
 
 	if (!flat_reloc_valid(r, start_brk - start_data + text_len)) {
-		printk("BINFMT_FLAT: reloc outside program 0x%x (0 - 0x%x/0x%x)",
-		       (int) r,(int)(start_brk-start_data+text_len),(int)text_len);
+		printk("BINFMT_FLAT: reloc outside program 0x%lx (0 - 0x%lx/0x%lx)",
+		       r, start_brk-start_data+text_len, text_len);
 		goto failed;
 	}
 
@@ -369,7 +365,7 @@ calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
 		addr = r - text_len + start_data;
 
 	/* Range checked already above so doing the range tests is redundant...*/
-	return(addr);
+	return addr;
 
 failed:
 	printk(", killing %s!\n", current->comm);
@@ -383,11 +379,11 @@ failed:
 static void old_reloc(unsigned long rl)
 {
 #ifdef DEBUG
-	char *segment[] = { "TEXT", "DATA", "BSS", "*UNKNOWN*" };
+	static const char *segment[] = { "TEXT", "DATA", "BSS", "*UNKNOWN*" };
 #endif
 	flat_v2_reloc_t	r;
 	unsigned long *ptr;
-	
+
 	r.value = rl;
 #if defined(CONFIG_COLDFIRE)
 	ptr = (unsigned long *) (current->mm->start_code + r.reloc.offset);
@@ -397,10 +393,10 @@ static void old_reloc(unsigned long rl)
 
 #ifdef DEBUG
 	printk("Relocation of variable at DATASEG+%x "
-		"(address %p, currently %x) into segment %s\n",
-		r.reloc.offset, ptr, (int)*ptr, segment[r.reloc.type]);
+		"(address %p, currently %lx) into segment %s\n",
+		r.reloc.offset, ptr, *ptr, segment[r.reloc.type]);
 #endif
-	
+
 	switch (r.reloc.type) {
 	case OLD_FLAT_RELOC_TYPE_TEXT:
 		*ptr += current->mm->start_code;
@@ -417,27 +413,25 @@ static void old_reloc(unsigned long rl)
 	}
 
 #ifdef DEBUG
-	printk("Relocation became %x\n", (int)*ptr);
+	printk("Relocation became %lx\n", *ptr);
 #endif
-}		
+}
 
 /****************************************************************************/
 
-static int load_flat_file(struct linux_binprm * bprm,
+static int load_flat_file(struct linux_binprm *bprm,
 		struct lib_info *libinfo, int id, unsigned long *extra_stack)
 {
-	struct flat_hdr * hdr;
-	unsigned long textpos = 0, datapos = 0, result;
-	unsigned long realdatastart = 0;
-	unsigned long text_len, data_len, bss_len, stack_len, flags;
-	unsigned long full_data;
-	unsigned long len, memp = 0;
-	unsigned long memp_size, extra, rlim;
-	unsigned long *reloc = 0, *rp;
+	struct flat_hdr *hdr;
+	unsigned long textpos, datapos, realdatastart;
+	unsigned long text_len, data_len, bss_len, stack_len, full_data, flags;
+	unsigned long len, memp, memp_size, extra, rlim;
+	unsigned long *reloc, *rp;
 	struct inode *inode;
-	int i, rev, relocs = 0;
+	int i, rev, relocs;
 	loff_t fpos;
 	unsigned long start_code, end_code;
+	ssize_t result;
 	int ret;
 
 	hdr = ((struct flat_hdr *) bprm->buf);		/* exec-header */
@@ -478,11 +472,11 @@ static int load_flat_file(struct linux_binprm * bprm,
 		ret = -ENOEXEC;
 		goto err;
 	}
-	
+
 	/* Don't allow old format executables to use shared libraries */
 	if (rev == OLD_FLAT_VERSION && id != 0) {
-		printk("BINFMT_FLAT: shared libraries are not available before rev 0x%x\n",
-				(int) FLAT_VERSION);
+		printk("BINFMT_FLAT: shared libraries are not available before rev 0x%lx\n",
+				FLAT_VERSION);
 		ret = -ENOEXEC;
 		goto err;
 	}
@@ -517,11 +511,9 @@ static int load_flat_file(struct linux_binprm * bprm,
 
 	/* Flush all traces of the currently running executable */
 	if (id == 0) {
-		result = flush_old_exec(bprm);
-		if (result) {
-			ret = result;
+		ret = flush_old_exec(bprm);
+		if (ret)
 			goto err;
-		}
 
 		/* OK, This is the point of no return */
 		set_personality(PER_LINUX_32BIT);
@@ -549,38 +541,38 @@ static int load_flat_file(struct linux_binprm * bprm,
 		textpos = vm_mmap(bprm->file, 0, text_len, PROT_READ|PROT_EXEC,
 				  MAP_PRIVATE|MAP_EXECUTABLE, 0);
 		if (!textpos || IS_ERR_VALUE(textpos)) {
-			if (!textpos)
-				textpos = (unsigned long) -ENOMEM;
-			printk("Unable to mmap process text, errno %d\n", (int)-textpos);
 			ret = textpos;
+			if (!textpos)
+				ret = -ENOMEM;
+			printk("Unable to mmap process text, errno %d\n", ret);
 			goto err;
 		}
 
 		len = data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);
 		len = PAGE_ALIGN(len);
-		realdatastart = vm_mmap(0, 0, len,
+		realdatastart = vm_mmap(NULL, 0, len,
 			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
 
 		if (realdatastart == 0 || IS_ERR_VALUE(realdatastart)) {
+			ret = realdatastart;
 			if (!realdatastart)
-				realdatastart = (unsigned long) -ENOMEM;
-			printk("Unable to allocate RAM for process data, errno %d\n",
-					(int)-realdatastart);
+				ret = -ENOMEM;
+			printk("Unable to allocate RAM for process data, "
+			       "errno %d\n", ret);
 			vm_munmap(textpos, text_len);
-			ret = realdatastart;
 			goto err;
 		}
 		datapos = ALIGN(realdatastart +
 				MAX_SHARED_LIBS * sizeof(unsigned long),
 				FLAT_DATA_ALIGN);
 
-		DBG_FLT("BINFMT_FLAT: Allocated data+bss+stack (%d bytes): %x\n",
-				(int)(data_len + bss_len + stack_len), (int)datapos);
+		DBG_FLT("BINFMT_FLAT: Allocated data+bss+stack (%ld bytes): %lx\n",
+			data_len + bss_len + stack_len, datapos);
 
 		fpos = ntohl(hdr->data_start);
 #ifdef CONFIG_BINFMT_ZFLAT
 		if (flags & FLAT_FLAG_GZDATA) {
-			result = decompress_exec(bprm, fpos, (char *) datapos, 
+			result = decompress_exec(bprm, fpos, (char *)datapos,
 						 full_data, 0);
 		} else
 #endif
@@ -589,29 +581,30 @@ static int load_flat_file(struct linux_binprm * bprm,
 					full_data);
 		}
 		if (IS_ERR_VALUE(result)) {
-			printk("Unable to read data+bss, errno %d\n", (int)-result);
+			ret = result;
+			printk("Unable to read data+bss, errno %d\n", ret);
 			vm_munmap(textpos, text_len);
 			vm_munmap(realdatastart, len);
-			ret = result;
 			goto err;
 		}
 
-		reloc = (unsigned long *) (datapos+(ntohl(hdr->reloc_start)-text_len));
+		reloc = (unsigned long *)
+			(datapos + (ntohl(hdr->reloc_start) - text_len));
 		memp = realdatastart;
 		memp_size = len;
 	} else {
 
 		len = text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);
 		len = PAGE_ALIGN(len);
-		textpos = vm_mmap(0, 0, len,
+		textpos = vm_mmap(NULL, 0, len,
 			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
 
 		if (!textpos || IS_ERR_VALUE(textpos)) {
-			if (!textpos)
-				textpos = (unsigned long) -ENOMEM;
-			printk("Unable to allocate RAM for process text/data, errno %d\n",
-					(int)-textpos);
 			ret = textpos;
+			if (!textpos)
+				ret = -ENOMEM;
+			printk("Unable to allocate RAM for process text/data, "
+			       "errno %d\n", ret);
 			goto err;
 		}
 
@@ -629,10 +622,10 @@ static int load_flat_file(struct linux_binprm * bprm,
 		 * load it all in and treat it like a RAM load from now on
 		 */
 		if (flags & FLAT_FLAG_GZIP) {
-			result = decompress_exec(bprm, sizeof (struct flat_hdr),
-					 (((char *) textpos) + sizeof (struct flat_hdr)),
+			result = decompress_exec(bprm, sizeof(struct flat_hdr),
+					 (((char *)textpos) + sizeof(struct flat_hdr)),
 					 (text_len + full_data
-						  - sizeof (struct flat_hdr)),
+						  - sizeof(struct flat_hdr)),
 					 0);
 			memmove((void *) datapos, (void *) realdatastart,
 					full_data);
@@ -641,8 +634,7 @@ static int load_flat_file(struct linux_binprm * bprm,
 			if (!IS_ERR_VALUE(result))
 				result = decompress_exec(bprm, text_len, (char *) datapos,
 						 full_data, 0);
-		}
-		else
+		} else
 #endif
 		{
 			result = read_code(bprm->file, textpos, 0, text_len);
@@ -652,21 +644,19 @@ static int load_flat_file(struct linux_binprm * bprm,
 						   full_data);
 		}
 		if (IS_ERR_VALUE(result)) {
-			printk("Unable to read code+data+bss, errno %d\n",(int)-result);
+			ret = result;
+			printk("Unable to read code+data+bss, errno %d\n", ret);
 			vm_munmap(textpos, text_len + data_len + extra +
 				MAX_SHARED_LIBS * sizeof(unsigned long));
-			ret = result;
 			goto err;
 		}
 	}
 
-	if (flags & FLAT_FLAG_KTRACE)
-		printk("Mapping is %x, Entry point is %x, data_start is %x\n",
-			(int)textpos, 0x00ffffff&ntohl(hdr->entry), ntohl(hdr->data_start));
+	start_code = textpos + sizeof(struct flat_hdr);
+	end_code = textpos + text_len;
+	text_len -= sizeof(struct flat_hdr); /* the real code len */
 
 	/* The main program needs a little extra setup in the task structure */
-	start_code = textpos + sizeof (struct flat_hdr);
-	end_code = textpos + text_len;
 	if (id == 0) {
 		current->mm->start_code = start_code;
 		current->mm->end_code = end_code;
@@ -684,16 +674,14 @@ static int load_flat_file(struct linux_binprm * bprm,
 		current->mm->context.end_brk = memp + memp_size - stack_len;
 	}
 
-	if (flags & FLAT_FLAG_KTRACE)
-		printk("%s %s: TEXT=%x-%x DATA=%x-%x BSS=%x-%x\n",
-			id ? "Lib" : "Load", bprm->filename,
-			(int) start_code, (int) end_code,
-			(int) datapos,
-			(int) (datapos + data_len),
-			(int) (datapos + data_len),
-			(int) (((datapos + data_len + bss_len) + 3) & ~3));
-
-	text_len -= sizeof(struct flat_hdr); /* the real code len */
+	if (flags & FLAT_FLAG_KTRACE) {
+		printk("Mapping is %lx, Entry point is %x, data_start is %x\n",
+		       textpos, 0x00ffffff&ntohl(hdr->entry), ntohl(hdr->data_start));
+		printk("%s %s: TEXT=%lx-%lx DATA=%lx-%lx BSS=%lx-%lx\n",
+		       id ? "Lib" : "Load", bprm->filename,
+		       start_code, end_code, datapos, datapos + data_len,
+		       datapos + data_len, (datapos + data_len + bss_len + 3) & ~3);
+	}
 
 	/* Store the current module values into the global library structure */
 	libinfo->lib_list[id].start_code = start_code;
@@ -703,7 +691,7 @@ static int load_flat_file(struct linux_binprm * bprm,
 	libinfo->lib_list[id].loaded = 1;
 	libinfo->lib_list[id].entry = (0x00ffffff & ntohl(hdr->entry)) + textpos;
 	libinfo->lib_list[id].build_date = ntohl(hdr->build_date);
-	
+
 	/*
 	 * We just load the allocations into some temporary memory to
 	 * help simplify all this mumbo jumbo
@@ -743,14 +731,16 @@ static int load_flat_file(struct linux_binprm * bprm,
 	 */
 	if (rev > OLD_FLAT_VERSION) {
 		unsigned long persistent = 0;
-		for (i=0; i < relocs; i++) {
+		for (i = 0; i < relocs; i++) {
 			unsigned long addr, relval;
 
-			/* Get the address of the pointer to be
-			   relocated (of course, the address has to be
-			   relocated first).  */
+			/*
+			 * Get the address of the pointer to be
+			 * relocated (of course, the address has to be
+			 * relocated first).
+			 */
 			relval = ntohl(reloc[i]);
-			if (flat_set_persistent (relval, &persistent))
+			if (flat_set_persistent(relval, &persistent))
 				continue;
 			addr = flat_get_relocate_addr(relval);
 			rp = (unsigned long *) calc_reloc(addr, libinfo, id, 1);
@@ -780,14 +770,14 @@ static int load_flat_file(struct linux_binprm * bprm,
 			}
 		}
 	} else {
-		for (i=0; i < relocs; i++)
+		for (i = 0; i < relocs; i++)
 			old_reloc(ntohl(reloc[i]));
 	}
-	
+
 	flush_icache_range(start_code, end_code);
 
 	/* zero the BSS,  BRK and stack areas */
-	memset((void*)(datapos + data_len), 0, bss_len + 
+	memset((void *)(datapos + data_len), 0, bss_len +
 			(memp + memp_size - stack_len -		/* end brk */
 			libinfo->lib_list[id].start_brk) +	/* start brk */
 			stack_len);
@@ -846,7 +836,7 @@ out:
 	allow_write_access(bprm.file);
 	fput(bprm.file);
 
-	return(res);
+	return res;
 }
 
 #endif /* CONFIG_BINFMT_SHARED_FLAT */
@@ -857,7 +847,7 @@ out:
  * libraries.  There is no binary dependent code anywhere else.
  */
 
-static int load_flat_binary(struct linux_binprm * bprm)
+static int load_flat_binary(struct linux_binprm *bprm)
 {
 	struct lib_info libinfo;
 	struct pt_regs *regs = current_pt_regs();
@@ -869,6 +859,7 @@ static int load_flat_binary(struct linux_binprm * bprm)
 	int i, j;
 
 	memset(&libinfo, 0, sizeof(libinfo));
+
 	/*
 	 * We have to add the size of our arguments to our stack size
 	 * otherwise it's too easy for users to create stack overflows
@@ -881,33 +872,33 @@ static int load_flat_binary(struct linux_binprm * bprm)
 	stack_len += (bprm->argc + 1) * sizeof(char *); /* the argv array */
 	stack_len += (bprm->envc + 1) * sizeof(char *); /* the envp array */
 	stack_len += FLAT_STACK_ALIGN - 1;  /* reserve for upcoming alignment */
-	
+
 	res = load_flat_file(bprm, &libinfo, 0, &stack_len);
 	if (res < 0)
 		return res;
-	
+
 	/* Update data segment pointers for all libraries */
-	for (i=0; i<MAX_SHARED_LIBS; i++)
+	for (i = 0; i < MAX_SHARED_LIBS; i++)
 		if (libinfo.lib_list[i].loaded)
-			for (j=0; j<MAX_SHARED_LIBS; j++)
+			for (j = 0; j < MAX_SHARED_LIBS; j++)
 				(-(j+1))[(unsigned long *)(libinfo.lib_list[i].start_data)] =
-					(libinfo.lib_list[j].loaded)?
-						libinfo.lib_list[j].start_data:UNLOADED_LIB;
+					(libinfo.lib_list[j].loaded) ?
+						libinfo.lib_list[j].start_data : UNLOADED_LIB;
 
 	install_exec_creds(bprm);
 
 	set_binfmt(&flat_format);
 
 	p = ((current->mm->context.end_brk + stack_len + 3) & ~3) - 4;
-	DBG_FLT("p=%x\n", (int)p);
+	DBG_FLT("p=%lx\n", p);
 
 	/* copy the arg pages onto the stack, this could be more efficient :-) */
 	for (i = TOP_OF_ARGS - 1; i >= bprm->p; i--)
-		* (char *) --p =
+		*(char *) --p =
 			((char *) page_address(bprm->page[i/PAGE_SIZE]))[i % PAGE_SIZE];
 
 	sp = (unsigned long *) create_flat_tables(p, bprm);
-	
+
 	/* Fake some return addresses to ensure the call chain will
 	 * initialise library in order for us.  We are required to call
 	 * lib 1 first, then 2, ... and finally the main program (id 0).
@@ -915,7 +906,7 @@ static int load_flat_binary(struct linux_binprm * bprm)
 	start_addr = libinfo.lib_list[0].entry;
 
 #ifdef CONFIG_BINFMT_SHARED_FLAT
-	for (i = MAX_SHARED_LIBS-1; i>0; i--) {
+	for (i = MAX_SHARED_LIBS-1; i > 0; i--) {
 		if (libinfo.lib_list[i].loaded) {
 			/* Push previos first to call address */
 			--sp;	put_user(start_addr, sp);
@@ -923,16 +914,16 @@ static int load_flat_binary(struct linux_binprm * bprm)
 		}
 	}
 #endif
-	
+
 	/* Stash our initial stack pointer into the mm structure */
-	current->mm->start_stack = (unsigned long )sp;
+	current->mm->start_stack = (unsigned long)sp;
 
 #ifdef FLAT_PLAT_INIT
 	FLAT_PLAT_INIT(regs);
 #endif
-	DBG_FLT("start_thread(regs=0x%x, entry=0x%x, start_stack=0x%x)\n",
-		(int)regs, (int)start_addr, (int)current->mm->start_stack);
-	
+
+	DBG_FLT("start_thread(regs=0x%p, entry=0x%lx, start_stack=0x%lx)\n",
+		regs, start_addr, current->mm->start_stack);
 	start_thread(regs, start_addr, current->mm->start_stack);
 
 	return 0;
@@ -945,9 +936,6 @@ static int __init init_flat_binfmt(void)
 	register_binfmt(&flat_format);
 	return 0;
 }
-
-/****************************************************************************/
-
 core_initcall(init_flat_binfmt);
 
 /****************************************************************************/
-- 
2.7.4
