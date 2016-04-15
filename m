From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 15 Apr 2016 11:36:57 +0100
Subject: [PATCH] arm64: fix invalidation of wrong __early_cpu_boot_status
 cacheline
In-Reply-To: <20160415102017.GA8021@leverpostej>
References: <1460715081-16542-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160415102017.GA8021@leverpostej>
Message-ID: <5710C449.3050900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 11:20, Mark Rutland wrote:
> On Fri, Apr 15, 2016 at 12:11:21PM +0200, Ard Biesheuvel wrote:
>> In head.S, the str_l macro, which takes a source register, a symbol name
>> and a temp register, is used to store a status value to the variable
>> __early_cpu_boot_status. Subsequently, the value of the temp register is
>> reused to invalidate any cachelines covering this variable.
>>
>> However, since str_l resolves to
>>
>>        adrp    \tmp, \sym
>>        str     \src, [\tmp, :lo12:\sym]
>>
>> the temp register never actually holds the address of the variable but
>> only of the 4 KB window that covers it, and reusing it leads to the
>> wrong cacheline being invalidated. So instead, take the address
>> explicitly before doing the store, and reuse that value to perform
>> the cache invalidation.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> This deserves a cc stable, since the macro is always invoked for each CPU
>> at boot.
>
> Sounds good, also:
>
> Fixes: bb9052744f4b7ae1 ("arm64: Handle early CPU boot failures")

This first appeared in 4.6-rc1, so I don't think we need to Cc stable.

The initial patch was using adr_l as in this fix.

Catalin, was there a specific reason for that change ? I remember you mentioning
something about it.

Nevertheless,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
