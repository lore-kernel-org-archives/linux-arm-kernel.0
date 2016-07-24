From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:21 -0400
Subject: [PATCH v5 07/15] binfmt_flat: use proper user space accessors with
 relocs processing code
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-8-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Relocs are fixed up in place in user space memory.  The appropriate
accessors are required for this code to work with an active MMU.

The architecture specific handlers flat_get_addr_from_rp() and
flat_put_addr_at_rp() for ARM and M68K are adjusted with separate
patches. SuperH and Xtensa are left out as they doesn't implement
__get_user_unaligned() and __put_user_unaligned() yet. The other
architectures that use BFLT don't have any MMU.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
---
 fs/binfmt_flat.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 5dc7968a42..9deafb282d 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -419,7 +419,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	unsigned long textpos, datapos, realdatastart;
 	unsigned long text_len, data_len, bss_len, stack_len, full_data, flags;
 	unsigned long len, memp, memp_size, extra, rlim;
-	unsigned long *reloc, *rp;
+	unsigned long __user *reloc, *rp;
 	struct inode *inode;
 	int i, rev, relocs;
 	loff_t fpos;
@@ -591,7 +591,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			goto err;
 		}
 
-		reloc = (unsigned long *)
+		reloc = (unsigned long __user *)
 			(datapos + (ntohl(hdr->reloc_start) - text_len));
 		memp = realdatastart;
 		memp_size = len;
@@ -616,7 +616,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 				MAX_SHARED_LIBS * sizeof(unsigned long),
 				FLAT_DATA_ALIGN);
 
-		reloc = (unsigned long *)
+		reloc = (unsigned long __user *)
 			(datapos + (ntohl(hdr->reloc_start) - text_len));
 		memp = textpos;
 		memp_size = len;
@@ -708,15 +708,20 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * image.
 	 */
 	if (flags & FLAT_FLAG_GOTPIC) {
-		for (rp = (unsigned long *)datapos; *rp != 0xffffffff; rp++) {
-			unsigned long addr;
-			if (*rp) {
-				addr = calc_reloc(*rp, libinfo, id, 0);
+		for (rp = (unsigned long __user *)datapos; ; rp++) {
+			unsigned long addr, rp_val;
+			if (get_user(rp_val, rp))
+				return -EFAULT;
+			if (rp_val == 0xffffffff)
+				break;
+			if (rp_val) {
+				addr = calc_reloc(rp_val, libinfo, id, 0);
 				if (addr == RELOC_FAILED) {
 					ret = -ENOEXEC;
 					goto err;
 				}
-				*rp = addr;
+				if (put_user(addr, rp))
+					return -EFAULT;
 			}
 		}
 	}
@@ -733,7 +738,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * __start to address 4 so that is okay).
 	 */
 	if (rev > OLD_FLAT_VERSION) {
-		unsigned long persistent = 0;
+		unsigned long __maybe_unused persistent = 0;
 		for (i = 0; i < relocs; i++) {
 			unsigned long addr, relval;
 
@@ -742,12 +747,14 @@ static int load_flat_file(struct linux_binprm *bprm,
 			 * relocated (of course, the address has to be
 			 * relocated first).
 			 */
-			relval = ntohl(reloc[i]);
+			if (get_user(relval, reloc + i))
+				return -EFAULT;
+			relval = ntohl(relval);
 			if (flat_set_persistent(relval, &persistent))
 				continue;
 			addr = flat_get_relocate_addr(relval);
-			rp = (unsigned long *) calc_reloc(addr, libinfo, id, 1);
-			if (rp == (unsigned long *)RELOC_FAILED) {
+			rp = (unsigned long __user *)calc_reloc(addr, libinfo, id, 1);
+			if (rp == (unsigned long __user *)RELOC_FAILED) {
 				ret = -ENOEXEC;
 				goto err;
 			}
-- 
2.7.4
