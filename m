From: yang.shi@linaro.org (Shi, Yang)
Date: Wed, 27 Apr 2016 09:50:33 -0700
Subject: [BUG] set_pte_at: racy dirty state clearing warning
In-Reply-To: <20160421084946.GA23774@e104818-lin.cambridge.arm.com>
References: <57180A53.3000207@linaro.org>
 <20160421084946.GA23774@e104818-lin.cambridge.arm.com>
Message-ID: <50501020-db93-cb6c-c2d9-b59efc05c30d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/2016 1:49 AM, Catalin Marinas wrote:
> On Wed, Apr 20, 2016 at 04:01:39PM -0700, Shi, Yang wrote:
>> When I enable memory comact via
>>
>> # echo 1 > /proc/sys/vm/compact_memory
>>
>> I got the below WARNING:
>>
>> set_pte_at: racy dirty state clearing: 0x0068000099371bd3 ->
>> 0x0068000099371fd3
>> ------------[ cut here ]------------
>> WARNING: CPU: 5 PID: 294 at ./arch/arm64/include/asm/pgtable.h:227
>> ptep_set_access_flags+0x138/0x1b8
>> Modules linked in:
>
> Do you have this patch applied:
>
> http://article.gmane.org/gmane.linux.ports.arm.kernel/492239
>
> It's also queued into -next as commit 66dbd6e61a52.

No, but I just applied it, it works.

Thanks,
Yang

>
>> My kernel has ARM64_HW_AFDBM enabled, but LS2085 is not ARMv8.1.
>>
>> The code shows it just check if ARM64_HW_AFDBM is enabled or not, but
>> doesn't check if the CPU really has such capability.
>>
>> So, it might be better to have the capability checked runtime?
>
> The warnings are there to spot any incorrect uses of the pte accessors
> even before you run on AF/DBM-capable hardware.
>
