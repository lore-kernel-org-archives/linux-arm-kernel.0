From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 17:58:52 +0100
Subject: [PATCH kexec-tools v2 02/32] kdump: fix multiple program header
 entries
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xrY-0003rb-Na@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

generate_new_headers() forgot to increment the program header pointer
after adding each program header from the kexec template. Fix it to
increment it correctly.

Without this, the program headers contain only the last entry, which
means we will be missing most of the kernel image in the dump.

Reviewed-by: Pratyush Anand <panand@redhat.com>
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
