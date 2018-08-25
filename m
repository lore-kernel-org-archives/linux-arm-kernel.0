From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Sat, 25 Aug 2018 12:54:07 +0530
Subject: [RFC PATCH v2 2/3] pstore: Add register read/write{b,w,l,q}
 tracing support
In-Reply-To: <CAGXu5jL6tGu9U_ANrZSfWREtySqFAJ+CQa3v5YRihZ2oHNMGGw@mail.gmail.com>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
 <65985f8df55b037283746559c1718a54d56e7ec4.1535119711.git.saiprakash.ranjan@codeaurora.org>
 <CAGXu5jL6tGu9U_ANrZSfWREtySqFAJ+CQa3v5YRihZ2oHNMGGw@mail.gmail.com>
Message-ID: <7b212c02-d7ce-4309-155f-22b36963e41c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/24/2018 8:59 PM, Kees Cook wrote:
> On Fri, Aug 24, 2018 at 7:45 AM, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> read/write{b,w,l,q} are typically used for reading from memory
>> mapped registers, which can cause hangs if accessed
>> unclocked. Tracing these events can help in debugging
>> various issues faced during initial development.
>>
>> We log this trace information in persistent ram buffer which
>> can be viewed after reset.
>>
>> We use pstore_rtb_call() to write the RTB log to pstore.
>> RTB buffer size is taken from ramoops dt node with additional
>> property called rtb-size.
>>
>> For reading the trace after mounting pstore, rtb-ramoops entry
>> can be seen in /sys/fs/pstore/ as in below sample output.
>>
>> Sample output of tracing register reads/writes in drivers:
>>
>>   # mount -t pstore pstore /sys/fs/pstore
>>   # tail /sys/fs/pstore/rtb-ramoops-0
>>   [LOGK_READ ] ts:36468476204  data:ffff00000800d0fc  <ffff0000084e9ee0>  gic_check_gicv2+0x58/0x60
>>   [LOGK_WRITE] ts:36468477715  data:ffff00000800d000  <ffff0000084e9fac>  gic_cpu_if_up+0xc4/0x110
>>   [LOGK_READ ] ts:36468478548  data:ffff00000800d000  <ffff0000084e9fd8>  gic_cpu_if_up+0xf0/0x110
>>   [LOGK_WRITE] ts:36468480319  data:ffff00000800d000  <ffff0000084e9fac>  gic_cpu_if_up+0xc4/0x110
>>   [LOGK_READ ] ts:36468481048  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
>>   [LOGK_WRITE] ts:36468482923  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
>>   [LOGK_READ ] ts:36468483184  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
>>   [LOGK_WRITE] ts:36468485215  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
>>   [LOGK_READ ] ts:36468486309  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
>>   [LOGK_WRITE] ts:36468488236  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
>>
>> Output has below 5 fields:
>>
>>   * Log type, Timestamp, Data from caller which is the address of
>>     read/write{b,w,l,q}, Caller ip and Caller name.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> As this is a tracing-like method, could this instead be added to
> ftrace? That would mean it could reuse all the ftrace tools and you'd
> get pstore storage for free.
> 

Ftrace does not trace __raw{read,write}{b,l,w,q}() functions. I am not 
sure why and how it is filtered out because I do not see any notrace 
flag in those functions, maybe that whole directory is filtered out.
So adding this functionality to ftrace would mean removing the notrace 
for these functions i.e., something like using 
__raw{read,write}{b,l,w,q}() as the available filter functions. Also 
pstore ftrace does not filter functions to trace I suppose?

Coming to the reason as to why it would be good to keep this separate 
from ftrace would be:
* Ftrace can get ip and parent ip, but suppose we need extra data (field 
data) as in above sample output we would not be able to get through ftrace.

* Although this patch is for tracing register read/write, we can easily
add more functionality since we have dynamic_rtb api which can be hooked 
to functions and start tracing events(IRQ, Context ID) something similar 
to tracepoints.
Initially thought of having tracepoints for logging register read/write 
but I do not know if we can export tracepoint data to pstore since the 
main usecase is to debug unknown resets and hangs.

* This can be something similar to mmiotrace in x86 and kept seperate 
from function tracer.

Thanks,
Sai Prakash
