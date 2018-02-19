From: john.garry@huawei.com (John Garry)
Date: Mon, 19 Feb 2018 11:12:32 +0000
Subject: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
In-Reply-To: <20180219110238.GA30394@arm.com>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
 <36bd758c-dd49-edef-cc1a-20f5b43f5011@huawei.com>
 <20180219110238.GA30394@arm.com>
Message-ID: <c868d4aa-99f8-6e14-9b26-a4f0ad768f71@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/2018 11:02, Will Deacon wrote:
> Hi John,
>
> On Mon, Feb 19, 2018 at 10:19:35AM +0000, John Garry wrote:
>> On 19/02/2018 06:39, Bhupesh Sharma wrote:
>>> Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
>>> Silence Sparse warnings), compilation of arm64 architecture is broken
>>> with the following error messages:
>>>
>>>  AR      arch/arm64/kernel/built-in.o
>>>  arch/arm64/kernel/head.S: Assembler messages:
>>>  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>>>  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>>>  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>>>  arch/arm64/kernel/head.S:677: Error: junk at end of line, first
>>>  unrecognized character is `L'
>>>  arch/arm64/kernel/head.S:677: Error: unexpected characters following
>>>  instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
>>>  arch/arm64/kernel/head.S:677: Error: unexpected characters following
>>>  instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
>>>
>>> This patch fixes the same by using the UL() macro correctly for
>>> assigning the MPIDR_HWID_BITMASK macro value.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>>> ---
>>> arch/arm64/include/asm/cputype.h | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
>>> index eda8c5f629fc..350c76a1d15b 100644
>>> --- a/arch/arm64/include/asm/cputype.h
>>> +++ b/arch/arm64/include/asm/cputype.h
>>> @@ -20,7 +20,7 @@
>>>
>>> #define MPIDR_UP_BITMASK	(0x1 << 30)
>>> #define MPIDR_MT_BITMASK	(0x1 << 24)
>>> -#define MPIDR_HWID_BITMASK	0xff00ffffffUL
>>> +#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)
>>
>> Works for me.
>>
>> FYI, I am using (old) gcc-linaro-4.8-2015.06-x86_64_aarch64.
>
> Just to confirm: are you saying that this patch fixes the build for you,
> or that mainline builds for you and the patch is not needed?
>

Ah, what I said was ambigious.

I am saying that linux-next (20180219) is broken for me for the same 
reason and this patch fixes it.

I didn't spot the kernelci message Arnd mentioned, so I just wanted to 
mention the toolchain I used.

Cheers,
John

> Cheers,
>
> Will
>
> .
>
