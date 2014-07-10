From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 10 Jul 2014 14:33:27 +0200
Subject: dove (marvell A510) crash on boot with config_preempt
In-Reply-To: <20140708151705.GE13433@titan.lakedaemon.net>
References: <20140706080845.723e9787@armhf>
 <20140708151705.GE13433@titan.lakedaemon.net>
Message-ID: <53BE8817.10703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2014 05:17 PM, Jason Cooper wrote:
> On Sun, Jul 06, 2014 at 08:08:45AM +0200, Jean-Francois Moine wrote:
>> Since the official 3.15.0 release, the kernel crashes at boot time
>> when compiled with the option CONFIG_PREEMPT.
>>
>> Reverting the commit 431a84b1a4f7d1a0085d5b91330c5053cc8e8b12
>>
>>     ARM: 8034/1: Disable preemption in iwmmxt_task_enable()
>>
>> removes the problem.
>>
>> Linux version 3.16.0-rc3-00062-gd92a333-dirty (jef at armhf) (gcc version 4.8.3 (Debian 4.8.3-4) ) #5 PREEMPT Thu Jul 3 19:46:39 CEST 2014
[...]
>> PJ4 iWMMXt v2 coprocessor enabled.
[...]
>> Unable to handle kernel paging request at virtual address fffffffe
>> pgd = bb25c000
>> [fffffffe] *pgd=3bfde821, *pte=00000000, *ppte=00000000
>> Internal error: Oops: 80000007 [#1] PREEMPT ARM
>> Modules linked in:
>> CPU: 0 PID: 62 Comm: startpar Not tainted 3.16.0-rc3-00062-gd92a333-dirty #5
>> task: bb230b80 ti: bb256000 task.ti: bb256000
>> PC is at 0xfffffffe
>> LR is at iwmmxt_task_copy+0x44/0x4c
>> pc : [<fffffffe>]    lr : [<800130ac>]    psr: 40000033
>> sp : bb257de8  ip : 00000013  fp : bb257ea4
>> r10: bb256000  r9 : fffffdfe  r8 : 76e898e6
>> r7 : bb257ec8  r6 : bb256000  r5 : 7ea12760  r4 : 000000a0
>> r3 : ffffffff  r2 : 00000003  r1 : bb257df8  r0 : 00000000
>> Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment user
>> Control: 10c5387d  Table: 3b25c019  DAC: 00000015
>> Process startpar (pid: 62, stack limit = 0xbb256248)

Ok, I have been able to debug this despite my limited knowledge of
iWMMXt and ARM asm. While the patch below fixes the issue, I have
no clue if it is the right approach or if there should be a different
solution. I'd like to leave that to either Russell or Catalin to decide.

If anything in below explanation is wrong, please correct me
immediately!

Above mentioned commit basically added {inc,dec}_preempt_count macros
to iwmmxt_task_enable to run it with preemption disabled:

  ENTRY(iwmmxt_task_enable)
+       inc_preempt_count r10, r3
[...]
concan_save:
[...]
concan_dump:
[...]
concan_load:
[...]
+3:
+#ifdef CONFIG_PREEMPT_COUNT
+       get_thread_info r10
+#endif
+4:     dec_preempt_count r10, r3
         mov     pc, lr

Unfortunately, other procedures in iwmmxt.S, e.g. iwmmxt_task_copy,
also branch to above concan_{save,dump,load} labels without disabling
preemption first:

ENTRY(iwmmxt_task_copy)
[...]
1:	@ this task owns Concan regs -- grab a copy from there
	mov	r0, #0			@ nothing to load
	mov	r2, #3			@ save all regs
	mov	r3, lr			@ preserve return address
	bl	concan_dump
	msr	cpsr_c, ip		@ restore interrupt mode
	mov	pc, r3

This causes two issues that finally lead to observed behavior:
(a) introduced {inc,dec}_preempt_count use r3 as temporary register,
     while iwmmxt_task_copy uses it to store its return address
(b) branching to concan_foo labels decrements preempt_count without
     incrementing it first

The patch below addresses (a) by using r4 as temporary register for
{inc,dec}_preempt_count macro and (b) by moving concan_foo into
separate code sections and call them from iwmmxt_task_enable like
the other procedures do.

Sebastian

-------------- next part --------------
A non-text attachment was scrubbed...
Name: iwmmxt.S.diff
Type: text/x-patch
Size: 1061 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/e7869915/attachment.bin>
