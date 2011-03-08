From: sheetals@codeaurora.org (Sheetal Sahasrabudhe)
Date: Tue, 8 Mar 2011 10:31:46 -0800 (PST)
Subject: [PATCH v2 2/3] [ARM] perfevents: Add support for Scorpion
	performance monitors
In-Reply-To: <1299595957.6872.7.camel@e102144-lin.cambridge.arm.com>
References: <1299534463-25802-1-git-send-email-sheetals@codeaurora.org>
	<1299595957.6872.7.camel@e102144-lin.cambridge.arm.com>
Message-ID: <4653fb879092e41c468c067ebb4fb901.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, March 8, 2011 6:52 am, Will Deacon wrote:
> [...]
>
>> +static DEFINE_PER_CPU(u32, venum_orig_val);
>> +static DEFINE_PER_CPU(u32, fp_orig_val);
>> +
>> +static void scorpion_pre_vlpm(void)
>> +{
>> +       u32 venum_new_val;
>> +       u32 fp_new_val;
>> +       /* CPACR Enable CP10 access*/
>> +       asm volatile("mrc p15, 0, %0, c1, c0, 2" : "=r" (venum_orig_val));
>> +       venum_new_val = venum_orig_val | 0x00100000;
>> +       asm volatile("mcr p15, 0, %0, c1, c0, 2" : : "r" (venum_new_val));
>> +       isb();
>> +       /* Enable FPEXC */
>> +       fp_orig_val = fmrx(FPEXC);
>> +       fp_new_val = fp_orig_val | FPEXC_EN;
>> +       fmxr(FPEXC, fp_new_val);
>> +}
>> +
>
> When I looked at this originally, I thought it would be nice to have
> some functions or macros for poking with the CPACR and planned to submit
> that as a separate patch...
>
> ... well it turns out we already have this! Please can you update this
> bit of code to use the {get,set}_copro_access functions in asm/system.h?
> You can use the CPACC_SVC macro to generate the access mask too instead
> of hardcoding the 0x00100000.

Great! I have made the change and reposted the patch.
Please let me know if it looks good.

Thanks,
Sheetal

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
