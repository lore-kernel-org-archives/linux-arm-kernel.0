From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Apr 2016 13:22:13 +0100
Subject: [BUG] arm64/hw_breakpoint: trigger breakpoint exception infinitely
In-Reply-To: <571F2577.2080203@huawei.com>
References: <571F2577.2080203@huawei.com>
Message-ID: <20160426122212.GN27312@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 04:23:19PM +0800, Li Bin wrote:
> This bug can be reproduced by compiling the hw_breakpoint sample
> module that is in the kernel tree, when loading it with parameter
> ksym=nfsdstats, and running nfsstat:
> 
> $ insmod data_breakpoint.ko ksym=nfsdstats
> $ nfsstat
> 
> It will trigger breakpoint exception infinitely:
> 
> nfsdstats value is changed
> ...
> Call trace:
> ...
> Dump stack from sample_hbp_handler
> nfsdstats value is changed
> ...
> Call trace:
> ...
> Dump stack from sample_hbp_handler
> ......
> ......
> 
> This is because that the overflow_handler is set to the callback
> in the module, and in watchpoint_handler, it will not disable the
> breakpoint (and set single step that reenable it), so when exception
> return, it will trigger the breakpoint exception again immediately...

As I explained before, GDB/ptrace *relies* on this behaviour. If you
register an breakpoint overflow handler on arm64, then you need to handle
the step.

Will
