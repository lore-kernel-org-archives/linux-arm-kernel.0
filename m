From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 1 Nov 2017 13:31:03 +0000
Subject: [PATCH v1 1/3] arm64: add a macro for SError synchronization
In-Reply-To: <d7b8b779-9e00-8e8f-b44e-48e3d7e37058@huawei.com>
References: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
 <1509563697-6359-2-git-send-email-gengdongjiu@huawei.com>
 <6dc82768-8564-a54e-041b-3b9965fa038b@arm.com>
 <d7b8b779-9e00-8e8f-b44e-48e3d7e37058@huawei.com>
Message-ID: <32039c76-8e9b-77e5-dfe6-3f519821a08d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/17 12:54, gengdongjiu wrote:
> Hi Robin,
> 
> On 2017/11/1 19:24, Robin Murphy wrote:
>>> +	esb
>>> +alternative_else_nop_endif
>>> +1:
>>> +	.endm
>> Having a branch in here is pretty horrible, and furthermore using label
>> number 1 has a pretty high chance of subtly breaking code where this
>> macro is inserted.
>>
>> Can we not somehow nest or combine the alternative conditions here?
> 
> I found it will report error if combine the alternative conditions here.
> 
> For example:
> 
> +	.macro	error_synchronize
> +alternative_if ARM64_HAS_IESB
> +alternative_if ARM64_HAS_RAS_EXTN
> +	esb
> +alternative_else_nop_endif
> +alternative_else_nop_endif
> +	.endm
> 
> And even using b.eq/cbz instruction in the alternative instruction in arch/arm64/kernel/entry.S,
> it will report Error.
> 
> For example below
> 
> alternative_if ARM64_HAS_PAN
> 	xxxxxxxxxxxxxxxxxxxx
>         b.eq    xxxxx
> alternative_else_nop_endif
> 
> I do not dig it deeply, do you know the reason about it or good suggestion about that?
> Thanks a lot in advance.

Actually, on second look ARM64_HAS_RAS_EXTN doesn't even matter - ESB is
a hint, so if the CPU doesn't have RAS it should behave as a NOP anyway.

On which note, since I don't see one here - are any of those other
patches defining an "esb" assembly macro similar to the inline asm case?
If not then this isn't going to build with older toolchains - perhaps we
should just use the raw hint syntax directly.

Robin.
