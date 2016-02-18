From: james.morse@arm.com (James Morse)
Date: Thu, 18 Feb 2016 11:57:37 +0000
Subject: [PATCH v5 11/15] arm64: head.S: Change the register el2_setup()
 returns its result in x0
In-Reply-To: <20160218114127.GA12626@red-moon>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-12-git-send-email-james.morse@arm.com>
 <20160218114127.GA12626@red-moon>
Message-ID: <56C5B1B1.20205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 18/02/16 11:41, Lorenzo Pieralisi wrote:
> On Tue, Feb 16, 2016 at 03:49:23PM +0000, James Morse wrote:
>> Today el2_setup() returns its result in w20. This means we can't call it
>> like any normal function. Change this to w0.
>>
>> All three callers of el2_setup() call set_cpu_boot_mode_flag() immediately
>> afterwards, and don't rely on x0 in later code. Boot cpu code calls
>> preserve_boot_args() before el2_setup(), so we don't clobber the DT pointer.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>>  arch/arm64/include/asm/processor.h |  2 ++
>>  arch/arm64/kernel/head.S           | 18 +++++++++---------
>>  2 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>> index 4acb7ca94fcd..07ac4351538e 100644
>> --- a/arch/arm64/include/asm/processor.h
>> +++ b/arch/arm64/include/asm/processor.h
>> @@ -188,4 +188,6 @@ static inline void spin_lock_prefetch(const void *x)
>>  
>>  void cpu_enable_pan(void *__unused);
>>  
>> +int el2_setup(void);
> 
> Do we really need to have this declaration (and this patch) ? We never
> treat (and call) el2_setup as a C function anyway, as long as the registers
> used to pass in values (and return value) are documented I do not think we
> have an issue anyway, am I missing something here ?

Without this patch swsusp_el2_setup_helper() in patch 14 needs to know that
el2_setup will clobber w20, and save that value somewhere that it knows won't
get clobbered. It didn't seem right to bake all this knowledge into another
function.

Its not quite perfect, as el2_setup() has "msr el2_lr, lr; eret", any caller
needs to know this.

I added the declaration because this now gets called from hibernate-asm.S, but
this doesn't seem to be normal for asm functions. I will remove it from any
future version.


Thanks,

James
