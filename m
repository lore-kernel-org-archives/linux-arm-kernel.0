From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Thu, 24 Jan 2013 12:10:02 -0500
Subject: [PATCH v6 02/15] ARM: Section based HYP idmap
In-Reply-To: <20130124170520.GG18233@arm.com>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175734.29147.19552.stgit@ubuntu>
 <20130124143224.GC18233@arm.com>
 <CANM98qJfxsXtQwjpMw5m8FEM2awtkCg-hZXa_Qrk7=jb3pqFAQ@mail.gmail.com>
 <20130124170520.GG18233@arm.com>
Message-ID: <CANM98qK9AjMv8f42OTosoM-__cWXBrFBbPv140Gn=aJetPF0ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 12:05 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Jan 24, 2013 at 04:36:09PM +0000, Christoffer Dall wrote:
>> On Thu, Jan 24, 2013 at 9:32 AM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Wed, Jan 16, 2013 at 05:57:34PM +0000, Christoffer Dall wrote:
>> >> --- a/arch/arm/mm/idmap.c
>> >> +++ b/arch/arm/mm/idmap.c
>> >> @@ -1,4 +1,6 @@
>> >> +#include <linux/module.h>
>> >
>> > Minor thing - do you need to include linux/module.h here?
>> >
>>
>> there was once a time when kvm/arm could be compiled as a module; my
>> best guess is that it's a leftover from that.
>>
>> >> +     identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
>> >> +                          __hyp_idmap_text_end, PMD_SECT_AP1);
>> >
>> > It would be more consistent if you define PMD_SECT_HYP or something like
>> > that. I think you have a L_PTE_HYP bit as well.
>> >
>> Is this along the lines of what you had in mind?
>>
>> diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h
>> b/arch/arm/include/asm/pgtable-3level-hwdef.h
>> index 18f5cef..432fa12 100644
>> --- a/arch/arm/include/asm/pgtable-3level-hwdef.h
>> +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
>> @@ -50,6 +50,7 @@
>>  #define PMD_SECT_AP_READ     (_AT(pmdval_t, 0))
>>  #define PMD_SECT_AP1         (_AT(pmdval_t, 1) << 6)
>>  #define PMD_SECT_TEX(x)              (_AT(pmdval_t, 0))
>> +#define PMD_SECT_HYP         PMD_SECT_AP1
>>
>>  /*
>>   * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
>> diff --git a/arch/arm/include/asm/pgtable-3level.h
>> b/arch/arm/include/asm/pgtable-3level.h
>> index 6ef8afd..a7e6532 100644
>> --- a/arch/arm/include/asm/pgtable-3level.h
>> +++ b/arch/arm/include/asm/pgtable-3level.h
>> @@ -116,6 +116,7 @@
>>  /*
>>   * Hyp-mode PL2 PTE definitions for LPAE.
>>   */
>> +#define PMD_HYP                      PMD_SECT_AP1
>
> Yes, but only one definition in is probably enough (PMD_SECT_HYP?).
>
yeah, that one was not supposed to be included in my git add command, whoops:

diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h
b/arch/arm/include/asm/pgtable-3level-hwdef.h
index 18f5cef..432fa12 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -50,6 +50,7 @@
 #define PMD_SECT_AP_READ	(_AT(pmdval_t, 0))
 #define PMD_SECT_AP1		(_AT(pmdval_t, 1) << 6)
 #define PMD_SECT_TEX(x)		(_AT(pmdval_t, 0))
+#define PMD_SECT_HYP		PMD_SECT_AP1

 /*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 2dffc01..bf1ee20 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -1,4 +1,3 @@
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>

@@ -97,7 +96,7 @@ static int __init init_static_idmap_hyp(void)
 	pr_info("Setting up static HYP identity map for 0x%p - 0x%p\n",
 		__hyp_idmap_text_start, __hyp_idmap_text_end);
 	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
-			     __hyp_idmap_text_end, PMD_SECT_AP1);
+			     __hyp_idmap_text_end, PMD_SECT_HYP);

 	return 0;
 }
--


Thanks, I'll queue these and send them after the other patch series
has been merged.

-Christoffer
