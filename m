From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 25 Feb 2015 19:11:18 +0800
Subject: [RFC PATCH v3 00/26] Early kprobe: enable kprobes at very early
 booting stage.
In-Reply-To: <54E6B139.20909@hitachi.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
 <54E6B139.20909@hitachi.com>
Message-ID: <54EDADD6.5070404@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/20 11:59, Masami Hiramatsu wrote:
> Hi,
> 
> Sorry for replying late.
> 
> (2015/02/13 14:39), Wang Nan wrote:
>> I fell very sorry for people who reviewed my v2 patch series yesterday
>> at https://lkml.org/lkml/2015/2/12/234 because I didn't provide enough
>> information in commit log. This v3 patch series add those missing
>> commit messages. There are also 2 small fix based on v2:
>>
>>  1. Fixes ftrace_sort_mcount_area. Original patch doesn't work for module.
>>  2. Wraps setting of kprobes_initialized in stop_machine() context.
> 
> From the viewpoint of the maintenance, it seems over-engineered and
> not general implementation. Please reconsider just initializing breakpoint
> handler in earlier stage. Since those exceptions may happen anywhere,
> those trap handlers setup very early stage. E.g. on x86, setup_arch()
> setup early_trap_init() at beginning. So we just need to initialize
> kprobes earlier.

I tried as your suggestion. For x86, int3 handler doesn't work correctly until
trap_init(). I don't have enough time to look into this problem today (and I don't
familiar with x86 architecture). Could you please have a look on it?

Thank you.

> I think this is almost enough for debugging, and very general because
> we don't need optprobe for porting to other arch.
> 
> And for ftrace-based kprobe, we can just put breakpoint on mcount call at
> beginning. ftrace will need to check and keep it when replacing mcount-call
> with nop. Afterward, we can cleanly update those kprobes with ftrace-based
> kprobe.
> 
> So, please start with smaller changes.
> 
> Thank you,
> 
