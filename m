From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 10 Sep 2015 15:45:25 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access
 and dirty pte bits
In-Reply-To: <20150910100753.GE12294@localhost>
References: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
 <55F06A87.3000204@citrix.com> <20150910100753.GE12294@localhost>
Message-ID: <55F19785.4090106@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/09/15 11:07, Catalin Marinas wrote:
> On Wed, Sep 09, 2015 at 06:21:11PM +0100, Julien Grall wrote:
>> I've tried to boot the latest linus/master (a794b4f) which include this
>> patch as DOM0 on xgene. This is failing late in the boot with
>> a BUG (see trace below).
>>
>> The bisector pointed me to this patch. When I disable
>> CONFIG_ARM64_HW_AFDBM, I'm able to boot the kernel and use it
>> without any issue.
>>
>> Although, I'm not sure to understand how this patch could
>> possibly break the filesystem subsystem.
> 
> I don't understand either. It seems that the kernel raises a BUG on
> !PagePrivate but this patch never touches the page structure, only ptes.
> 
> I recall to have tested it on XGene but I can try it again (bare metal).
> Is the bare metal error for you the same?

Same on bare-metal. I'm using Debian Jessie for the userspace and boot
using U-boot:

U-Boot 2013.04-mustang_sw_1.15.12 (May 20 2015 - 10:03:33)

CPU0: APM ARM 64-bit Potenza Rev A3 2400MHz PCP 2400MHz
     32 KB ICACHE, 32 KB DCACHE
     SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
Boot from SPI-NOR
Slimpro FW:
        Ver: 2.1
Board: Mustang - AppliedMicro APM883208-xNA24SPT Reference Board
I2C:   ready
DRAM:  ECC 16 GiB @ 1600MHz
SF: Detected N25Q256 with page size 256 Bytes, total 32 MiB

> 
>> Do you have any insight for debugging this problem?
> [...]
>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>>> index 39139a3aa16d..a8be513dff6f 100644
>>> --- a/arch/arm64/mm/proc.S
>>> +++ b/arch/arm64/mm/proc.S
>>> @@ -196,6 +196,19 @@ ENTRY(__cpu_setup)
>>>  	 */
>>>  	mrs	x9, ID_AA64MMFR0_EL1
>>>  	bfi	x10, x9, #32, #3
>>> +#ifdef CONFIG_ARM64_HW_AFDBM
>>> +	/*
>>> +	 * Hardware update of the Access and Dirty bits.
>>> +	 */
>>> +	mrs	x9, ID_AA64MMFR1_EL1
>>> +	and	x9, x9, #0xf
>>> +	cbz	x9, 2f
>>> +	cmp	x9, #2
>>> +	b.lt	1f
>>> +	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
>>> +1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
>>> +2:
>>> +#endif	/* CONFIG_ARM64_HW_AFDBM */
>>>  	msr	tcr_el1, x10
>>>  	ret					// return to head.S
>>>  ENDPROC(__cpu_setup)
> 
> Just in case some ID registers are wrong, can you do an "#if 0" above
> instead of CONFIG_ARM64_HW_AFDBM?

It doesn't change anything for me. I've also tried the solution
suggested by Will (see changes below) and I still hit the BUG_ON in the
fs driver.

The only way to get a usable userspace is disabling CONFIG_ARM64_HW_AFDBM.

diff --git a/arch/arm64/include/asm/pgtable.h
b/arch/arm64/include/asm/pgtable.h
index 6900b2d9..975735c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -513,7 +513,8 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t
newprot)
        return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
 }

-#ifdef CONFIG_ARM64_HW_AFDBM
+//#ifdef CONFIG_ARM64_HW_AFDBM
+#if 0
 /*
  * Atomic pte/pmd modifications.
  */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index e4ee7bd..05e026f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -192,7 +192,8 @@ ENTRY(__cpu_setup)
         */
        mrs     x9, ID_AA64MMFR0_EL1
        bfi     x10, x9, #32, #3
-#ifdef CONFIG_ARM64_HW_AFDBM
+/* #ifdef CONFIG_ARM64_HW_AFDBM */
+#if 0
        /*
         * Hardware update of the Access and Dirty bits.
         */

Regards,

-- 
Julien Grall
