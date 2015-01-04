From: wangnan0@huawei.com (Wang Nan)
Date: Sun, 4 Jan 2015 13:16:02 +0800
Subject: [PATCH v18 10/11] ARM: kprobes: check register usage for probed
 instruction.
In-Reply-To: <54A8CA21.1060009@hitachi.com>
References: <54A07FBE.3010206@hitachi.com>
 <1419826043-27935-1-git-send-email-wangnan0@huawei.com>
 <54A8CA21.1060009@hitachi.com>
Message-ID: <54A8CC92.1080002@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/4 13:05, Masami Hiramatsu wrote:
> Hi Wang,
> 
> (2014/12/29 13:07), Wang Nan wrote:
>> This patch utilizes previous introduced checker to check register usage
>> for probed ARM instruction and saves it in a mask. Futher patch will
>> use such information to avoid simuation or emulation.
>>
>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>> ---
>>  arch/arm/include/asm/probes.h          |  12 ++++
>>  arch/arm/probes/decode.c               |   7 ++
>>  arch/arm/probes/kprobes/actions-arm.c  |   2 +-
>>  arch/arm/probes/kprobes/checkers-arm.c | 124 +++++++++++++++++++++++++++++++++
>>  arch/arm/probes/kprobes/checkers.h     |   1 +
>>  5 files changed, 145 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/probes.h b/arch/arm/include/asm/probes.h
>> index f0a1ee8..ee04067 100644
>> --- a/arch/arm/include/asm/probes.h
>> +++ b/arch/arm/include/asm/probes.h
>> @@ -41,6 +41,18 @@ struct arch_probes_insn {
>>  	probes_insn_singlestep_t	*insn_singlestep;
>>  	probes_insn_fn_t		*insn_fn;
>>  	int stack_space;
>> +
>> +	/* Use 2 bits for a register. One more bit for extension */
> 
> Would you have any concrete idea for the extend bits? If not, we don't need
> it at this point. I think we don't need to care about future binary compatibility :)
> (moreover, if you need another bitflag, you can add another flag)
> 

2 bits can describe the read/write direction of a register. With such information,
futher code is possible to utilize unused register to do some optimization. However,
as you pointed, it is not a very concrete idea.


>> +#define REG_NO_USE	(0)
>> +#define REG_USE		(1)
>> +#define REG_MASK	(3)
>> +#define __register_usage_flag(n, f)	((f) << ((n) * 2))
>> +#define __register_usage_mask(n)	(REG_MASK << ((n) * 2))
>> +#define __clean_register_flag(m, n)	((m) & (~(__register_usage_mask(n))))
>> +#define __set_register_flag(m, n, f)	(__clean_register_flag(m, n) | __register_usage_flag(n, f))
>> +#define set_register_nouse(m, n)	do {(m) = __set_register_flag(m, n, REG_NO_USE);} while(0)
>> +#define set_register_use(m, n)		do {(m) = __set_register_flag(m, n, REG_USE);} while(0)
>> +	int register_usage_mask;
> 
> Is this a mask or flag? It seems a bit flag, if so, it should be "register_usage_flag".
> 
> Thank you,
> 

OK, I'll rename it.

Thanks to your comment.
