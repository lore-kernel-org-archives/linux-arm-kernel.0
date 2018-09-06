From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Thu, 6 Sep 2018 23:36:11 +0530
Subject: [RFC PATCH v2 3/3] dynamic_debug: Add support for dynamic
 register trace
In-Reply-To: <20180906100523.GE3592@arm.com>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
 <9015a7a4aafa9935be769c07918743df63d6f648.1535119711.git.saiprakash.ranjan@codeaurora.org>
 <20180906100523.GE3592@arm.com>
Message-ID: <0b96bfa0-f577-f72f-7c88-ac2e7ac3a189@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/6/2018 3:35 PM, Will Deacon wrote:
> On Fri, Aug 24, 2018 at 08:15:27PM +0530, Sai Prakash Ranjan wrote:
>> Introduce dynamic debug filtering mechanism to register
>> tracing as dynamic_rtb() which will reduce a lot of
>> overhead otherwise of tracing all the register reads/writes
>> in all files.
>>
>> Now we can just specify the file name or any wildcard pattern
>> as any other dynamic debug facility in bootargs and dynamic rtb
>> will just trace them and the output can be seen in pstore.
>>
>> TODO: Now we use same 'p' flag but will add a separate flag for register trace
>> later.
>>
>> Also add asm-generic/io-instrumented.h file for instrumentation of IO
>> operations such as read/write{b,w,l,q} as per Will's suggestion to not touch
>> arch code and let core generate instrumentation.
>> This can be extended to arm as well later for tracing.
>>
>> Example for tracing all register reads/writes in drivers/soc/qcom/* below:
>>
>>    # dyndbg="file drivers/soc/qcom/* +p" in bootargs
>>    # reboot -f
>>    # mount -t pstore pstore /sys/fs/pstore
>>    # cat /sys/fs/pstore/rtb-ramoops-0
>>      [LOGK_WRITE] ts:1373030419  data:ffff00000d5065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
>>      [LOGK_WRITE] ts:1373360576  data:ffff00000d506608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/io.h           | 26 +++++++++-------------
>>   include/asm-generic/io-instrumented.h | 32 +++++++++++++++++++++++++++
>>   include/linux/dynamic_debug.h         | 13 +++++++++++
>>   kernel/trace/Kconfig                  |  1 +
>>   4 files changed, 56 insertions(+), 16 deletions(-)
>>   create mode 100644 include/asm-generic/io-instrumented.h
>>
>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>> index 35b2e50f17fb..aafd4b0be9f0 100644
>> --- a/arch/arm64/include/asm/io.h
>> +++ b/arch/arm64/include/asm/io.h
> 
> The arm64 bits look fine to me, but please can you split them into a
> separate patch?
> 

Thanks for the review. Sure, I will split them into separate patch in 
next post. I have got the tracepoints working now as Steven suggested, 
will upload them soon.

>> diff --git a/include/asm-generic/io-instrumented.h b/include/asm-generic/io-instrumented.h
>> new file mode 100644
>> index 000000000000..ce273742b98c
>> --- /dev/null
>> +++ b/include/asm-generic/io-instrumented.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _ASM_GENERIC_IO_INSTRUMENTED_H
>> +#define _ASM_GENERIC_IO_INSTRUMENTED_H
>> +
>> +#include <linux/dynamic_debug.h>
>> +
>> +#define __raw_write(v, a, _t) ({			\
>> +	volatile void __iomem *_a = (a);		\
> 
> Does this actually need to be volatile?
> 

To avoid 100's of compilation warnings like below. Also wanted the 
parameters of functions like "iowrite32" to be passed to 
arch_raw_{read,write}() as is.

./include/asm-generic/io.h: In function ?iowrite32?:
./include/asm-generic/io-instrumented.h:8:21: warning: initialization 
discards ?volatile? qualifier from pointer target type 
[-Wdiscarded-qualifiers]
   void __iomem *_a = (a);    \
                      ^
./include/asm-generic/io-instrumented.h:15:28: note: in expansion of 
macro ?__raw_write?
  #define __raw_writel(v, a) __raw_write((v), a, l)
                             ^~~~~~~~~~~
./arch/arm64/include/asm/io.h:118:36: note: in expansion of macro 
?__raw_writel?
  #define writel_relaxed(v,c) ((void)__raw_writel((__force 
u32)cpu_to_le32(v),(c)))
                                     ^~~~~~~~~~~~
./arch/arm64/include/asm/io.h:133:36: note: in expansion of macro 
?writel_relaxed?
  #define writel(v,c)  ({ __iowmb(); writel_relaxed((v),(c)); })
                                     ^~~~~~~~~~~~~~
./include/asm-generic/io.h:745:2: note: in expansion of macro ?writel?
   writel(value, addr);
   ^~~~~~

>> +	dynamic_rtb("LOGK_WRITE", (void __force *)(_a));\
>> +	arch_raw_write##_t((v), _a);			\
>> +	})
>> +
>> +#define __raw_writeb(v, a)	__raw_write((v), a, b)
>> +#define __raw_writew(v, a)	__raw_write((v), a, w)
>> +#define __raw_writel(v, a)	__raw_write((v), a, l)
>> +#define __raw_writeq(v, a)	__raw_write((v), a, q)
>> +
>> +#define __raw_read(a, _l, _t)    ({					\
>> +	_t __a;								\
>> +	const volatile void __iomem *_a = (const volatile void __iomem *)(a);\
> 
> Again, can't this just be void __iomem * ?
> 

Same as above.

>> +	dynamic_rtb("LOGK_READ", (void __force *)(_a));			\
>> +	__a = arch_raw_read##_l(_a);					\
>> +	__a;								\
>> +	})
>> +
>> +#define __raw_readb(a)	__raw_read((a), b, u8)
>> +#define __raw_readw(a)	__raw_read((a), w, u16)
>> +#define __raw_readl(a)	__raw_read((a), l, u32)
>> +#define __raw_readq(a)	__raw_read((a), q, u64)
> 
> I find the way you've defined the __raw_{read,write} macros quite confusing.
> They both have an _t parameter, but it's totally unrelated between the two!
> 
Sorry for the confusion, I will fix it and have _l for both 
_raw_{read,write}.

Thanks,
Sai Prakash
