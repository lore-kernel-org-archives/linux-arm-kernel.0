From: lizefan@huawei.com (Li Zefan)
Date: Sat, 2 Feb 2013 17:19:25 +0800
Subject: backport patches to 2.6.34 to remove
 __ARCH_WANT_INTERRUPTS_ON_CTXSW?
In-Reply-To: <51077966.1060703@huawei.com>
References: <51077966.1060703@huawei.com>
Message-ID: <510CDA1D.90703@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013/1/29 15:25, Li Zefan wrote:
> Hi Catalin,
> 
> We got system crashes, and then we managed to trigger the bug within minutes,
> and we found this in upstream, which also backported to 2.6.34 stable:
> 
> commit cb297a3e433dbdcf7ad81e0564e7b804c941ff0d
> Author: Chanho Min <chanho0207@gmail.com>
> Date:   Thu Jan 5 20:00:19 2012 +0900
> 
>     sched/rt: Fix task stack corruption under __ARCH_WANT_INTERRUPTS_ON_CTXSW
> 
> The bug described in this commit resembles to ours. Unfortunately After applying
> the fix, we still get crash in hours. We tried to bind each real-time task to a
> single cpu to make sure no cpu migration will happen, and it ran without any
> problem for ~20 hours.
> 
> We're still investigating this issue. One thing I'm doing is backporting patches
> that removes __ARCH_WANT_INTERRUPTS_ON_CTXSW. With those patches, I can boot
> the kernel, but it hung up when the system automatically start nfs and later
> soft-lockup was reported. Things are fine if I disable nfs startup and start it
> manually.
> 
> So did I miss something when backporting, or is it infeasible to backport them
> to 2.6.34? We're using ARMv7. I've attached the patches I backported.

For anyone who might be interested in this bug, and for those who might encouter
the bug in the future and find this thread, here's the story continued.

It turns out I some how missed this one:

commit d427958a46af24f75d0017c45eadd172273bbf33
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Thu May 26 11:22:44 2011 +0100

    ARM: 6942/1: mm: make TTBR1 always point to swapper_pg_dir on ARMv6/7

With those 4 patches backported, we've run two machines for 55 hours and
45 hours, and everything's fine.

problem solved.
