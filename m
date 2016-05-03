From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:21:39 +0100
Subject: [PATCH kexec-tools 07/32] kexec: fix warnings caused by selecting
 64-bit file IO on 32-bit platforms
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXSV-0004hZ-CH@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warnings caused by selecting 64-bit file IO on 32-bit platforms.

kexec/kexec.c:710:2: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'off_t' [-Wformat]
kexec/zlib.c:63:4: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'off_t' [-Wformat]
kexec/kexec-uImage.c:85:3: warning: format '%ld' expects argument of type 'long
int', but argument 2 has type 'off_t' [-Wformat]

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/kexec-uImage.c | 3 ++-
 kexec/kexec.c        | 4 ++--
 kexec/zlib.c         | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 9df601b..5e24629 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -82,7 +82,8 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 	if (be32_to_cpu(header.ih_size) > len - sizeof(header)) {
 		printf("uImage header claims that image has %d bytes\n",
 				be32_to_cpu(header.ih_size));
-		printf("we read only %ld bytes.\n", len - sizeof(header));
+		printf("we read only %lld bytes.\n",
+		       (long long)len - sizeof(header));
 		return -1;
 	}
 #ifdef HAVE_LIBZ
diff --git a/kexec/kexec.c b/kexec/kexec.c
index f0bd527..500e5a9 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -707,8 +707,8 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	/* slurp in the input kernel */
 	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
 
-	dbgprintf("kernel: %p kernel_size: 0x%lx\n",
-		  kernel_buf, kernel_size);
+	dbgprintf("kernel: %p kernel_size: %#llx\n",
+		  kernel_buf, (unsigned long long)kernel_size);
 
 	if (get_memory_ranges(&info.memory_range, &info.memory_ranges,
 		info.kexec_flags) < 0 || info.memory_ranges == 0) {
diff --git a/kexec/zlib.c b/kexec/zlib.c
index 7170ac3..95b6080 100644
--- a/kexec/zlib.c
+++ b/kexec/zlib.c
@@ -60,8 +60,8 @@ char *zlib_decompress_file(const char *filename, off_t *r_size)
 			if ((errno == EINTR) || (errno == EAGAIN))
 				continue;
 			_gzerror(fp, &errnum, &msg);
-			dbgprintf("Read on %s of %ld bytes failed: %s\n",
-					filename, (allocated - size) + 0UL, msg);
+			dbgprintf("Read on %s of %d bytes failed: %s\n",
+				  filename, (int)(allocated - size), msg);
 			size = 0;
 			goto fail;
 		}
-- 
1.9.1
