From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 11 Sep 2015 16:43:47 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access
 and dirty pte bits
In-Reply-To: <20150910153812.GG22439@arm.com>
References: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
 <55F06A87.3000204@citrix.com> <20150910100753.GE12294@localhost>
 <55F19785.4090106@citrix.com> <20150910153812.GG22439@arm.com>
Message-ID: <55F2F6B3.2080108@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 10/09/15 16:38, Will Deacon wrote:
> Weird. That doesn't leave a lot of code. Two other things you could try
> are:
> 
>   (1) Put PTE_WRITE back to bit 57

This change doesn't help.

>   (2) Remove the pte_hw_dirty check/set in pte_modify

This one too, if I only drop the check pte_hw_dirty in pte_modify.

But if I disable completely pte_hw_dirty (i.e always return 0 [1]),
I'm able to use without any issue the userspace.

Which means that the problem seems to come from the defition of pte_dirty:

#define pte_dirty(pte)         (pte_sw_dirty(pte) || pte_hw_dirty(pte))

Regards,

[1]
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6900b2d9..804ec87 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -145,7 +145,8 @@ extern struct page *empty_zero_page;
 #define pte_write(pte)         (!!(pte_val(pte) & PTE_WRITE))
 #define pte_exec(pte)          (!(pte_val(pte) & PTE_UXN))
 
-#ifdef CONFIG_ARM64_HW_AFDBM
+//#ifdef CONFIG_ARM64_HW_AFDBM
+#if 0
 #define pte_hw_dirty(pte)      (!(pte_val(pte) & PTE_RDONLY))
 #else
 #define pte_hw_dirty(pte)      (0)


-- 
Julien Grall
