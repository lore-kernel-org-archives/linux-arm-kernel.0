From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 30 Oct 2015 18:26:56 +0000
Subject: [PATCH 3/7] powerpc: use read_file() in kernel and initrd loading
In-Reply-To: <1446229620-28088-1-git-send-email-andre.przywara@arm.com>
References: <1446229620-28088-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1446229620-28088-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the unsafe read-loops in the powerpc kernel image loading
function with our new and safe read_file() wrapper.
This should fix random fails in kernel image loading, especially
from pipes and sockets.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 powerpc/kvm.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/powerpc/kvm.c b/powerpc/kvm.c
index 13bba30..2b0bddd 100644
--- a/powerpc/kvm.c
+++ b/powerpc/kvm.c
@@ -162,19 +162,22 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 {
 	void *p;
 	void *k_start;
-	void *i_start;
-	int nr;
+	ssize_t filesize;
 
 	if (lseek(fd_kernel, 0, SEEK_SET) < 0)
 		die_perror("lseek");
 
 	p = k_start = guest_flat_to_host(kvm, KERNEL_LOAD_ADDR);
 
-	while ((nr = read(fd_kernel, p, 65536)) > 0)
-		p += nr;
-
-	pr_info("Loaded kernel to 0x%x (%ld bytes)", KERNEL_LOAD_ADDR, (long)(p-k_start));
+	filesize = read_file(fd_kernel, p, INITRD_LOAD_ADDR - KERNEL_LOAD_ADDR);
+	if (filesize < 0) {
+		if (errno == ENOMEM)
+			die("Kernel overlaps initrd!");
 
+		die_perror("kernel read");
+	}
+	pr_info("Loaded kernel to 0x%x (%ld bytes)", KERNEL_LOAD_ADDR,
+		filesize);
 	if (fd_initrd != -1) {
 		if (lseek(fd_initrd, 0, SEEK_SET) < 0)
 			die_perror("lseek");
@@ -183,19 +186,20 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 			die("Kernel overlaps initrd!");
 
 		/* Round up kernel size to 8byte alignment, and load initrd right after. */
-		i_start = p = guest_flat_to_host(kvm, INITRD_LOAD_ADDR);
-
-		while (((nr = read(fd_initrd, p, 65536)) > 0) &&
-		       p < (kvm->ram_start + kvm->ram_size))
-			p += nr;
-
-		if (p >= (kvm->ram_start + kvm->ram_size))
-			die("initrd too big to contain in guest RAM.\n");
+		p = guest_flat_to_host(kvm, INITRD_LOAD_ADDR);
+
+		filesize = read_file(fd_initrd, p,
+			       (kvm->ram_start + kvm->ram_size) - p);
+		if (filesize < 0) {
+			if (errno == ENOMEM)
+				die("initrd too big to contain in guest RAM.\n");
+			die_perror("initrd read");
+		}
 
 		pr_info("Loaded initrd to 0x%x (%ld bytes)",
-			INITRD_LOAD_ADDR, (long)(p-i_start));
+			INITRD_LOAD_ADDR, filesize);
 		kvm->arch.initrd_gra = INITRD_LOAD_ADDR;
-		kvm->arch.initrd_size = p-i_start;
+		kvm->arch.initrd_size = filesize;
 	} else {
 		kvm->arch.initrd_size = 0;
 	}
-- 
2.5.1
