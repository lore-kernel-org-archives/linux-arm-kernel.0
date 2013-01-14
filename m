From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 14 Jan 2013 12:09:02 -0500
Subject: [PATCH v5 02/14] ARM: Section based HYP idmap
In-Reply-To: <20130114161337.GE23505@n2100.arm.linux.org.uk>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183848.46302.77369.stgit@ubuntu>
 <20130114161337.GE23505@n2100.arm.linux.org.uk>
Message-ID: <CANM98qJUkLgvoX-4t84M=ApUry68hyL7mWgrJsUvOSTkCPGrmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 11:13 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 08, 2013 at 01:38:48PM -0500, Christoffer Dall wrote:
>> +     pr_info("Setting up static %sidentity map for 0x%llx - 0x%llx\n",
>> +             prot ? "HYP " : "",
>> +             (long long)addr, (long long)end);
>
> There's no point using 0x%llx and casting to 64-bit longs if the arguments
> are always going to be 32-bit.

true, that's silly. This should improve the code, suggested by Will:

commit 1baa03f3d70f082e4522fd32db09e4f5542ff48d
Author: Christoffer Dall <c.dall@virtualopensystems.com>
Date:   Mon Jan 14 12:06:26 2013 -0500

    ARM: idmap: cleanup pr_info

    It's cleaner to simply print the info messages in the callers and
    there's no reason to convert 32-bit values to 64-bit values.

    Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index d9213a5..b9ae344 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -71,9 +71,6 @@ static void identity_mapping_add(pgd_t *pgd, const
char *text_start,
 	addr = virt_to_phys(text_start);
 	end = virt_to_phys(text_end);

-	pr_info("Setting up static %sidentity map for 0x%llx - 0x%llx\n",
-		prot ? "HYP " : "",
-		(long long)addr, (long long)end);
 	prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;

 	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
@@ -97,6 +94,8 @@ static int __init init_static_idmap_hyp(void)
 	if (!hyp_pgd)
 		return -ENOMEM;

+	pr_info("Setting up static HYP identity map for 0x%p - 0x%p\n",
+		__hyp_idmap_text_start, __hyp_idmap_text_end);
 	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
 			     __hyp_idmap_text_end, PMD_SECT_AP1);

@@ -119,6 +118,8 @@ static int __init init_static_idmap(void)
 	if (!idmap_pgd)
 		return -ENOMEM;

+	pr_info("Setting up static identity map for 0x%p - 0x%p\n",
+		__idmap_text_start, __idmap_text_end);
 	identity_mapping_add(idmap_pgd, __idmap_text_start,
 			     __idmap_text_end, 0);

--

-Christoffer
