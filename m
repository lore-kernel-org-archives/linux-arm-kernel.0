From: panand@redhat.com (Pratyush Anand)
Date: Mon, 4 Apr 2016 10:47:14 +0530
Subject: [PATCH 2/2] arm64: Fix watchpoint recursion when single-step is
 wrongly triggered in irq
In-Reply-To: <56FD1BD1.7070101@huawei.com>
References: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
 <1458549470-124791-2-git-send-email-hekuang@huawei.com>
 <20160321102423.GB15150@dhcppc6.redhat.com>
 <56FD1BD1.7070101@huawei.com>
Message-ID: <20160404051714.GH28435@dhcppc0.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Li,

On 31/03/2016:08:45:05 PM, Li Bin wrote:
> Hi Pratyush,
> 
> on 2016/3/21 18:24, Pratyush Anand wrote:
> > On 21/03/2016:08:37:50 AM, He Kuang wrote:
> >> On arm64, watchpoint handler enables single-step to bypass the next
> >> instruction for not recursive enter. If an irq is triggered right
> >> after the watchpoint, a single-step will be wrongly triggered in irq
> >> handler, which causes the watchpoint address not stepped over and
> >> system hang.
> > 
> > Does patch [1] resolves this issue as well? I hope it should. Patch[1] has still
> > not been sent for review. Your test result will be helpful.
> > 
> > ~Pratyush
> > 
> > [1] https://github.com/pratyushanand/linux/commit/7623c8099ac22eaa00e7e0f52430f7a4bd154652
> 
> This patch did not consider that, when excetpion return, the singlestep flag
> should be restored, otherwise the right singlestep will not triggered.
> Right?

Yes, you are right, and there are other problems as well. Will Deacon pointed
out [1] that kernel debugging is per-cpu rather than per-task. So, I did thought
of a per-cpu implementation by introducing a new element "flags" in struct
pt_regs. But even with that I see issues. For example:
- While executing single step instruction, we get a data abort
- In the kernel_entry of data abort we disable single stepping based on "flags"
  bit field
- While handling data abort we receive anther interrupt, so we are again in
  kernel_entry (for el1_irq). Single stepping will be disabled again (although
  it does not matter).

Now the issue is that, what condition should be verified in kernel_exit for
enabling single step again? In the above scenario, kernel_exit for el1_irq
should not enable single stepping, but how to prevent that elegantly?

[1] http://www.spinics.net/lists/arm-kernel/msg491844.html
