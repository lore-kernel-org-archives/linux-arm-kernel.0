From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Jul 2014 00:58:32 +0200
Subject: [PATCH 02/16] ARM: mvebu: Add a common function for the boot
 address work around
In-Reply-To: <20140701163428.23408c9d@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-3-git-send-email-gregory.clement@free-electrons.com>
 <20140701163428.23408c9d@free-electrons.com>
Message-ID: <53B48E98.2080407@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,


>> +	/*
>> +	 * The last word of the code copied in SRAM must contain the
>> +	 * physical base address of the PMSU register
>> +	 */
>> +	*(unsigned long *)(sram_virt_base + code_len - 4) = resume_addr_reg;
> 
> Contrary to what I said, use __raw_writel() and not writel() here, to
> keep the native endianness of the system when writing the value:

Ok


[...]
> --- a/arch/arm/mach-mvebu/pmsu_ll.S
> +++ b/arch/arm/mach-mvebu/pmsu_ll.S
> @@ -43,11 +43,14 @@ ENDPROC(armada_38x_cpu_resume)
>  /* The following code will be executed from SRAM */
>  ENTRY(mvebu_boot_wa_start)
>  mvebu_boot_wa_start:
> -/* use physical address of the boot address register register */
> +ARM_BE8(setend be )                    @ go BE8 if entered LE
>         adr     r0, 1f
> -       ldr     r0, [r0]
> -       ldr     r0, [r0]
> -       mov     pc, r0
> +       ldr     r0, [r0]                @ load the address of the
> +                                       @ resume register
> +       ldr     r0, [r0]                @ load the value in the
> +                                       @ resume register
> +ARM_BE8(rev    r0, r0)                 @ the value is stored LE
> +       mov     pc, r0                  @ jump to this value
> 
> Note that the first ldr r0, [r0] does not need a rev r0, r0 because the
> value is stored in the native endianness of the system thanks to the
> __raw_writel() mentioned before. However, the second ldr r0, [r0] reads
> the value in the Resume Address register, which is written in
> little-endian by the writel() call in mvebu_pmsu_set_cpu_boot_addr().
> 
> Could you include this in your next iteration of the patches?

Yes sure, and thanks again for having tested it in BE

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
