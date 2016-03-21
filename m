From: panand@redhat.com (Pratyush Anand)
Date: Mon, 21 Mar 2016 16:35:53 +0530
Subject: [PATCH 2/2] arm64: Fix watchpoint recursion when single-step is
 wrongly triggered in irq
In-Reply-To: <56EFCF27.3090903@huawei.com>
References: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
 <1458549470-124791-2-git-send-email-hekuang@huawei.com>
 <20160321102423.GB15150@dhcppc6.redhat.com>
 <56EFCF27.3090903@huawei.com>
Message-ID: <20160321110553.GC15150@dhcppc6.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/2016:06:38:31 PM, Wangnan (F) wrote:
> 
> 
> On 2016/3/21 18:24, Pratyush Anand wrote:
> >On 21/03/2016:08:37:50 AM, He Kuang wrote:
> >>On arm64, watchpoint handler enables single-step to bypass the next
> >>instruction for not recursive enter. If an irq is triggered right
> >>after the watchpoint, a single-step will be wrongly triggered in irq
> >>handler, which causes the watchpoint address not stepped over and
> >>system hang.
> >Does patch [1] resolves this issue as well? I hope it should. Patch[1] has still
> >not been sent for review. Your test result will be helpful.
> >
> >~Pratyush
> >
> >[1] https://github.com/pratyushanand/linux/commit/7623c8099ac22eaa00e7e0f52430f7a4bd154652
> 
> Could you please provide a test program for your case so we can test
> it on our devices? I guess setting breakpoint on a "copy_from_user()"
> accessing an invalid address can trigger this problem?

My test case was to test kprobing of copy_from_user. I used kprobe64-v11.

I reverted "patch v11 3/9" and used following script  for __copy_to_user(),
which instruments kprobe at every instruction of a given function. I can easily
see "Unexpected kernel single-step exception at EL1".
-------------------------------------------------------------
#kprobe_at_function_all_inst.sh  
-------------------------------------------------------------
#! /bin/sh
#$1: function name
echo 0 > /sys/kernel/debug/tracing/events/kprobes/enable
echo >  /sys/kernel/debug/tracing/trace
echo > /sys/kernel/debug/tracing/kprobe_events
func=$(cat /proc/kallsyms | grep -A 1 -w $1 | cut -d ' ' -f 1)
func_start=$((0x$(echo $func | cut -d ' ' -f 1)))
func_end=$((0x$(echo $func | cut -d ' ' -f 2)))
offset=0
while [ $(($func_start + $offset)) -lt $func_end ]
  do
          printf -v cmd "p:probe_%x $1+0x%x" $offset $offset
          echo $cmd >> /sys/kernel/debug/tracing/kprobe_events
          offset=$((offset + 4))
  done
echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
-------------------------------------------------------------

# ./kprobe_at_function_all_inst.sh __copy_to_user

Now, if I apply the patch which I referred in [1], I can no longer see any
"Unexpected kernel single-step exception at EL1" with above test script.

If I understood correctly, then the problem you described in your patch is that
an irq (el1_irq) is raised when watchpoint was being handled by kernel(specially
before kernel could call reinstall_suspended_bps() to disable single stepping).
Since, I disable single stepping for all the el1 exception mode, if
kernel_enable_single_step() had been called but kernel_disable_single_step() had
n't been called. So, your test case could be another good test for my
patch.

~Pratyush
