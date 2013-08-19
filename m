From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 19 Aug 2013 12:51:05 -0500
Subject: [PATCHv3 5/9] ARM: OMAP2+: AM33XX: Add assembly code for PM
 operations
In-Reply-To: <5212159F.10302@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-6-git-send-email-d-gerlach@ti.com> <5212159F.10302@ti.com>
Message-ID: <52125B09.20004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 07:54 AM, Gururaja Hebbar wrote:
> Hi,
>
> On 8/6/2013 11:19 PM, Dave Gerlach wrote:
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> In preparation for suspend-resume support for AM33XX, add
>> the assembly file with the code which is copied to internal
>> memory (OCMC RAM) during bootup and runs from there.
>>
>> As part of the low power entry (DeepSleep0 mode in AM33XX TRM),
>> the code running from OCMC RAM does the following
>> 1. Stores the EMIF configuration
>> 2. Puts external memory in self-refresh
>> 3. Disables EMIF clock
>> 4. Executes WFI after writing to MPU_CLKCTRL register.
>>
>
> ...snip...
> ...snip...
>
>
>> +	ldr	r1, [r0, #EMIF_DDR_PHY_CTRL_1]
>> +	str	r1, emif_rd_lat_val
>> +
>> +	/* Put SDRAM in self-refresh */
>> +	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
>> +	orr	r1, r1, #0xa0
>> +	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
>> +	str	r1, [r0, #4]
>
> This seems to be a bug which I had pointed out to VB earlier.
>
> r0 ---> base of emif module
>
> r0 + 4 ---> EMIF4_0_SDRAM_STATUS   ===> which is read only register
>
>
> Above 2 lines should be as below
>
> +	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
> +	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
>
>
> It works even with the bug because the Shadow register is updated and
> that some how seems to take precedence.
>
>
> Thanks & regards
> Gururaja
>

Thanks for pointing this out, I have fixed it for next version.

Regards,
Dave

>
>> +
>> +	ldr	r1, dram_sync_word	@ a dummy access to DDR as per spec
>> +	ldr	r2, [r1, #0]
>
