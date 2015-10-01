From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Thu,  1 Oct 2015 19:17:28 -0300
Subject: [PATCH 6/7] [media] c8sectpfe: fix namespace on memcpy/memset
In-Reply-To: <cover.1443737682.git.mchehab@osg.samsung.com>
References: <cover.1443737682.git.mchehab@osg.samsung.com>
Message-ID: <5347f97c651906887446a8811946e54b5a972fe4.1443737683.git.mchehab@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Solves those sparse warnings:

drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:1087:9: warning: incorrect type in argument 1 (different address spaces)
drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:1087:9:    expected void *<noident>
drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:1087:9:    got void [noderef] <asn:2>*<noident>
drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:1090:9: warning: incorrect type in argument 1 (different address spaces)
drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:1090:9:    expected void *<noident>
drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:1090:9:    got void [noderef] <asn:2>*

Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 486aef50d99b..e358b9163a68 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -1084,10 +1084,10 @@ static void load_dmem_segment(struct c8sectpfei *fei, Elf32_Phdr *phdr,
 		seg_num, phdr->p_paddr, phdr->p_filesz,
 		dst, phdr->p_memsz);
 
-	memcpy((void __iomem *)dst, (void *)fw->data + phdr->p_offset,
+	memcpy((void __force *)dst, (void *)fw->data + phdr->p_offset,
 		phdr->p_filesz);
 
-	memset((void __iomem *)dst + phdr->p_filesz, 0,
+	memset((void __force *)dst + phdr->p_filesz, 0,
 		phdr->p_memsz - phdr->p_filesz);
 }
 
-- 
2.4.3
