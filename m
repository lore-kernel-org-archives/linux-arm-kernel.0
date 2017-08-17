From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Aug 2017 03:23:47 -0400
Subject: [PATCH v2 8/8] binfmt_elf_fdpic: fix crash on MMU system with dynamic
 binaries
In-Reply-To: <20170817072347.19990-1-nicolas.pitre@linaro.org>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
Message-ID: <20170817072347.19990-9-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In elf_fdpic_map_file() there is a test to ensure the dynamic section in
user space is properly terminated. However it does so by dereferencing
a user address directly. Add proper user space accessor.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 fs/binfmt_elf_fdpic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 692e2a1fd2..6a56dea138 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -835,6 +835,9 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 			if (phdr->p_vaddr >= seg->p_vaddr &&
 			    phdr->p_vaddr + phdr->p_memsz <=
 			    seg->p_vaddr + seg->p_memsz) {
+				Elf32_Dyn __user *dyn;
+				Elf32_Sword d_tag;
+
 				params->dynamic_addr =
 					(phdr->p_vaddr - seg->p_vaddr) +
 					seg->addr;
@@ -847,8 +850,9 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 					goto dynamic_error;
 
 				tmp = phdr->p_memsz / sizeof(Elf32_Dyn);
-				if (((Elf32_Dyn *)
-				     params->dynamic_addr)[tmp - 1].d_tag != 0)
+				dyn = (Elf32_Dyn __user *)params->dynamic_addr;
+				__get_user(d_tag, &dyn[tmp - 1].d_tag);
+				if (d_tag != 0)
 					goto dynamic_error;
 				break;
 			}
-- 
2.9.5
