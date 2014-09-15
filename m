From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 15 Sep 2014 23:31:18 +0200
Subject: [PATCH v4 6/7] ARM: EXYNOS: Add support for non-secure L2X0 resume
In-Reply-To: <20140915090353.GD12379@n2100.arm.linux.org.uk>
References: <1409062680-15906-1-git-send-email-t.figa@samsung.com>
 <1409062680-15906-7-git-send-email-t.figa@samsung.com>
 <20140915090353.GD12379@n2100.arm.linux.org.uk>
Message-ID: <54175AA6.3050702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.09.2014 11:03, Russell King - ARM Linux wrote:
>> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
>> index 554b350..71bcfbd 100644
>> --- a/arch/arm/mach-exynos/firmware.c
>> +++ b/arch/arm/mach-exynos/firmware.c
>> @@ -102,7 +102,9 @@ static int exynos_suspend(void)
>>  	writel(EXYNOS_SLEEP_MAGIC, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
>>  	writel(virt_to_phys(exynos_cpu_resume_ns),
>>  		sysram_ns_base_addr + EXYNOS_BOOT_ADDR);
>> -
>> +#ifdef CONFIG_CACHE_L2X0
>> +	l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
>> +#endif
> 
> NAK.  Please look at how arch/arm/mm/l2c-l2x0-resume.S gets the address
> of this structure in assembly code.  The name of this variable is crap
> in any case.  It's not the registers, it's the saved registers.  So even
> more reason to kill this abomination, which incidentally, I've already
> killed off once before in the exynos code.
> 

Right. The way l2c-l2x0-resume.S does this is much better. Somehow I
overlooked it when implementing this.

Best regards,
Tomasz
