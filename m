From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 20 Jun 2016 17:22:41 +0800
Subject: [RFC PATCH 2/4] trace: Introduce an output interface from ftrace
 to STM
In-Reply-To: <87inxlqpqe.fsf@ashishki-desk.ger.corp.intel.com>
References: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
 <1464779939-24986-3-git-send-email-zhang.chunyan@linaro.org>
 <87inxlqpqe.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CAG2=9p95EWUTh-SPs38RDAyn3YJ=ADSLba2EM-5TvDt1_tBaGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 6:04 PM, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Chunyan Zhang <zhang.chunyan@linaro.org> writes:
>
>> This patch is introducing a new function to print Ftrace messages
>> to STM buffer when the traces happen.  In order to reduce the
>> effect on timing overhead as much as possible, only the current
>> function and its parent ip address will be recorded into STM in
>> this patch.  This idea was first introduced by Philippe Langlais
>> at ST-Microelectronics a long time ago[1].
>
> So why is this useful? The value of trace points is in their payload.

>From what I understand, we have no way to log as much information as
Ftrace has done if we want to control the overhead of writing STM in a
limited/acceptable range.  Exporting information to STM is much more
time-consuming than writing ring buffer, the thought was simply that
export as much useful information as possible while taking a limited
bytes.

Thanks,
Chunyan

>
>> +#define STM_FTRACE_CHAN 0
>
> This is why we have the stm master/channel allocation policy, which
> should already assign a channel to your stm_source device when it is
> linked to an stm device.
>
> Also, why is this a separate compilation unit from the stm_ftrace.o?
>
>> +
>> +void ftrace_stm_func(unsigned long ip, unsigned long parent_ip)
>> +{
>> +     unsigned long ip_array[2] = {ip, parent_ip};
>> +
>> +     stm_ftrace_write((char *)ip_array, sizeof(unsigned long) * 2,
>> +                      STM_FTRACE_CHAN);
>> +}
>> +EXPORT_SYMBOL_GPL(ftrace_stm_func);
>> diff --git a/kernel/trace/trace_output_stm.h b/kernel/trace/trace_output_stm.h
>> new file mode 100644
>> index 0000000..fc3f989
>> --- /dev/null
>> +++ b/kernel/trace/trace_output_stm.h
>> @@ -0,0 +1,14 @@
>> +#ifndef __TRACE_OUTPUT_STM_H
>> +#define __TRACE_OUTPUT_STM_H
>> +
>> +#include <linux/module.h>
>> +
>> +#ifdef CONFIG_STM_FTRACE
>> +extern void stm_ftrace_write(const char *buf, unsigned int len,
>> +                          unsigned int chan);
>> +extern void ftrace_stm_func(unsigned long ip, unsigned long parent_ip);
>> +#else
>> +static inline void ftrace_stm_func(unsigned long ip, unsigned long parent_ip) {}
>> +#endif
>> +
>> +#endif /* __TRACE_OUTPUT_STM_H */
>> --
>> 1.9.1
