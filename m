From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 24 Feb 2011 11:50:39 -0800
Subject: [PATCH 4/4] msm: scm: Get cacheline size from CTR
In-Reply-To: <4D66B236.4030003@ru.mvista.com>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-5-git-send-email-sboyd@codeaurora.org>
	<4D66B236.4030003@ru.mvista.com>
Message-ID: <4D66B68F.6010706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2011 11:32 AM, Sergei Shtylyov wrote:
> Stephen Boyd wrote:
>
>> @@ -207,6 +204,14 @@ static int __scm_call(const struct scm_command
>> *cmd)
>>      return ret;
>>  }
>>  
>> +static inline u32 dcache_line_size(void)
>> +{
>> +    u32 ctr;
>> +
>> +    asm volatile("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
>> +    return 4 << ((ctr >> 16) & 0xf);
>> +}
>
>    Won't generic cache_line_size() macro do instead? It's defined as
> L1_CACHE_BYTES.
>

Interesting. It would be the same value (32) but I'm not sure how
multi-platform friendly that will be since L1_CACHE_BYTES is (1 <<
CONFIG_ARM_L1_CACHE_SHIFT). I suppose we can punt supporting platforms
with different cache line sizes in one kernel for another day.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
