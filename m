From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Jun 2017 21:54:14 -0400
Subject: [PATCH 2/2] dmaengine: dmatest: add support for memset test
In-Reply-To: <CAHp75Vdw2orpkx4C+O6CLHBWOUDrS8rWPuuDV0DzOCqu8kWkGQ@mail.gmail.com>
References: <1498610786-6090-1-git-send-email-okaya@codeaurora.org>
 <1498610786-6090-2-git-send-email-okaya@codeaurora.org>
 <CAHp75Vdw2orpkx4C+O6CLHBWOUDrS8rWPuuDV0DzOCqu8kWkGQ@mail.gmail.com>
Message-ID: <1e6151c9-693b-335a-2e4f-bcf201e77b6d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,


On 6/28/2017 4:58 AM, Andy Shevchenko wrote:
> On Wed, Jun 28, 2017 at 3:46 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>
>> echo dma0chan0 > /sys/module/dmatest/parameters/channel
>> echo 2 >  /sys/module/dmatest/parameters/dmatest
>> echo 2000 >  /sys/module/dmatest/parameters/timeout
>> echo 10 >  /sys/module/dmatest/parameters/iterations
>> echo 1 >  /sys/module/dmatest/parameters/run
> 
> Good someone is developing tests!
> My comments below.

Yeah, no problem. 

> 
>>  static void dmatest_init_srcs(u8 **bufs, unsigned int start, unsigned int len,
>> +               unsigned int buf_size, bool is_memset)
>>  {
>>         unsigned int i;
>>         u8 *buf;
>>
>>         for (; (buf = *bufs); bufs++) {
>> +               for (i = 0; i < start; i++) {
> 
>> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
>> +
>> +                       buf[i] = PATTERN_SRC | (~val & PATTERN_COUNT_MASK);
> 
>> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
>> +
>>                         buf[i] = PATTERN_SRC | PATTERN_COPY
>> +                               | (~val & PATTERN_COUNT_MASK);
> 
>> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
>> +
>> +                       buf[i] = PATTERN_SRC | (~val & PATTERN_COUNT_MASK);
> 
> Looks like a candidate now for a helper function
> 
> static inline u8 gen_src_value(u8 index, bool is_memset)
> {
>     u8 val = is_memset ? PATTERN_MEMSET_IDX : i;
>     return PATTERN_SRC | (~val & PATTERN_COUNT_MASK);
> }
> 
> buf[i] = gen_src_value(i, is_memset);
> buf[i] = gen_src_value(i, is_memset) | PATTERN_COPY;
> buf[i] = gen_src_value(i, is_memset);

will change as you recommended.

> 
>> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
>> +
>> +                       buf[i] = PATTERN_DST | (~val & PATTERN_COUNT_MASK);
> 
>> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
>> +
>>                         buf[i] = PATTERN_DST | PATTERN_OVERWRITE
>> +                               | (~val & PATTERN_COUNT_MASK);
> 
>> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
>> +
>> +                       buf[i] = PATTERN_DST | (~val & PATTERN_COUNT_MASK);
> 
> Ditto for DST.

done.

> 
>> +               unsigned int counter, bool is_srcbuf, bool is_memset)
> 
> This is a signal to replace it with
> 
> unsigned int flags
> 
> #define DMATEST_FL_SRCBUF BIT(0)
> #define DMATEST_FL_MEMSET BIT(1)
> 
> or alike.
> 
> I'm not insisting, just consider an opportunity.

OK. I'm not touching it for the moment. Maybe, we can have another patch later
to get rid of flags.

> 
>> +               bool is_srcbuf, bool is_memset)
> 
> Ditto.
> 
>>                 start = ktime_get();
>> +
>>                 pr_debug("%s: verifying source buffer...\n", current->comm);
> 
> The change doesn't belong to the patch.
> 
>> +
>>                 error_count += dmatest_verify(thread->dsts, dst_off + len,
> 
> Ditto.
> 

Posted V2 with the change now.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
