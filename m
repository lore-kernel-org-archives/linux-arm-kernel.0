From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 11 Dec 2015 12:09:03 +0000
Subject: [PATCH] scripts: recordmcount: break hardlinks
In-Reply-To: <20151202090517.432556a4@gandalf.local.home>
References: <20151202090517.432556a4@gandalf.local.home>
Message-ID: <E1a7MVT-0000et-62@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

recordmcount edits the file in-place, which can cause problems when
using ccache in hardlink mode.  Arrange for recordmcount to break a
hardlinked object.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Steven, sorry it took a while to get this out...

 scripts/recordmcount.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 698768bdc581..91705ef30402 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -211,6 +211,20 @@ static void *mmap_file(char const *fname)
 		addr = umalloc(sb.st_size);
 		uread(fd_map, addr, sb.st_size);
 	}
+	if (sb.st_nlink != 1) {
+		/* file is hard-linked, break the hard link */
+		close(fd_map);
+		if (unlink(fname) < 0) {
+			perror(fname);
+			fail_file();
+		}
+		fd_map = open(fname, O_RDWR | O_CREAT, sb.st_mode);
+		if (fd_map < 0) {
+			perror(fname);
+			fail_file();
+		}
+		uwrite(fd_map, addr, sb.st_size);
+	}
 	return addr;
 }
 
-- 
2.1.0
