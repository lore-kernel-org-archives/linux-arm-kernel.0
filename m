From: dongbo4@huawei.com (dongbo (E))
Date: Tue, 25 Apr 2017 14:11:29 +0800
Subject: [PATCH] arm64: Preventing READ_IMPLIES_EXEC propagation
In-Reply-To: <1493102296-229934-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1493102296-229934-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <d4205c8c-c8cd-ef35-a6bd-3444a7b3ac48@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Bo <dongbo4@huawei.com>

Once the READ_IMPLIES_EXEC flag is set on arm64, the flag is
propagated to its child processes, even the ELF files are
marked as not requiring executable stack.

Signed-off-by: Dong Bo <dongbo4@huawei.com>
---
 arch/arm64/include/asm/elf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 5d17004..5941e7f 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -142,6 +142,7 @@
 ({									\
 	clear_bit(TIF_32BIT, &current->mm->context.flags);		\
 	clear_thread_flag(TIF_32BIT);					\
+	current->personality &= ~READ_IMPLIES_EXEC;			\
 })
  /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-- 
1.9.1

.
