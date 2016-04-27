From: huawei.libin@huawei.com (Li Bin)
Date: Wed, 27 Apr 2016 10:35:33 +0800
Subject: [BUG] arm64/hw_breakpoint: trigger breakpoint exception infinitely
In-Reply-To: <20160426122212.GN27312@arm.com>
References: <571F2577.2080203@huawei.com> <20160426122212.GN27312@arm.com>
Message-ID: <57202575.20102@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



on 2016/4/26 20:22, Will Deacon wrote:
> On Tue, Apr 26, 2016 at 04:23:19PM +0800, Li Bin wrote:
>> This bug can be reproduced by compiling the hw_breakpoint sample
>> module that is in the kernel tree, when loading it with parameter
>> ksym=nfsdstats, and running nfsstat:
>>
>> $ insmod data_breakpoint.ko ksym=nfsdstats
>> $ nfsstat
>>
>> It will trigger breakpoint exception infinitely:
>>
>> nfsdstats value is changed
>> ...
>> Call trace:
>> ...
>> Dump stack from sample_hbp_handler
>> nfsdstats value is changed
>> ...
>> Call trace:
>> ...
>> Dump stack from sample_hbp_handler
>> ......
>> ......
>>
>> This is because that the overflow_handler is set to the callback
>> in the module, and in watchpoint_handler, it will not disable the
>> breakpoint (and set single step that reenable it), so when exception
>> return, it will trigger the breakpoint exception again immediately...
> 
> As I explained before, GDB/ptrace *relies* on this behaviour. If you
> register an breakpoint overflow handler on arm64, then you need to handle
> the step.

So it is a bug of samples/hw_breakpoint/data_breakpoint.c for arm64.
Should we fix it (may need to change the kernel code), or disable it
for arm64?

Thanks,
Li Bin

> 
> Will
> 
> .
> 
