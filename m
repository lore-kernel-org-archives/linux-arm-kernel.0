From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 1 Nov 2017 20:54:44 +0800
Subject: [PATCH v1 1/3] arm64: add a macro for SError synchronization
In-Reply-To: <6dc82768-8564-a54e-041b-3b9965fa038b@arm.com>
References: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
 <1509563697-6359-2-git-send-email-gengdongjiu@huawei.com>
 <6dc82768-8564-a54e-041b-3b9965fa038b@arm.com>
Message-ID: <d7b8b779-9e00-8e8f-b44e-48e3d7e37058@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 2017/11/1 19:24, Robin Murphy wrote:
>> +	esb
>> +alternative_else_nop_endif
>> +1:
>> +	.endm
> Having a branch in here is pretty horrible, and furthermore using label
> number 1 has a pretty high chance of subtly breaking code where this
> macro is inserted.
> 
> Can we not somehow nest or combine the alternative conditions here?

I found it will report error if combine the alternative conditions here.

For example:

+	.macro	error_synchronize
+alternative_if ARM64_HAS_IESB
+alternative_if ARM64_HAS_RAS_EXTN
+	esb
+alternative_else_nop_endif
+alternative_else_nop_endif
+	.endm

And even using b.eq/cbz instruction in the alternative instruction in arch/arm64/kernel/entry.S,
it will report Error.

For example below

alternative_if ARM64_HAS_PAN
	xxxxxxxxxxxxxxxxxxxx
        b.eq    xxxxx
alternative_else_nop_endif

I do not dig it deeply, do you know the reason about it or good suggestion about that?
Thanks a lot in advance.


> 
> Robin.
> 
>>  #endif	/* __ASM_ASSEMBLER_H */
