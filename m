From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:21:13 +0100
Subject: [PATCH kexec-tools 02/32] kdump: fix multiple program header entries
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXS5-0004h5-Cb@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

generate_new_headers() forgot to increment the program header pointer
after adding each program header from the kexec template. Fix it to
increment it correctly.

Without this, the program headers contain only the last entry, which
means we will be missing most of the kernel image in the dump.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kdump/kdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kdump/kdump.c b/kdump/kdump.c
index 3247a54..99a1789 100644
--- a/kdump/kdump.c
+++ b/kdump/kdump.c
@@ -192,6 +192,7 @@ static void *generate_new_headers(
 		}
 		memcpy(nphdr, &phdr[i], sizeof(*nphdr));
 		nphdr->p_offset = offset;
+		nphdr++;
 		offset += phdr[i].p_filesz;
 	}
 	
-- 
1.9.1
