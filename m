From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Wed, 15 Nov 2017 10:19:09 +0000
Subject: [PATCH 05/11] Disable kasan's instrumentation
In-Reply-To: <20171019124714.GZ20805@n2100.armlinux.org.uk>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-6-liuwenliang@huawei.com>
 <20171019124714.GZ20805@n2100.armlinux.org.uk>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0063538@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/17 20:47, Russell King - ARM Linux [mailto:linux at armlinux.org.uk]  wrote:
>On Wed, Oct 11, 2017 at 04:22:21PM +0800, Abbott Liu wrote:
>> From: Andrey Ryabinin <a.ryabinin@samsung.com>
>> 
>>  To avoid some build and runtime errors, compiler's instrumentation must
>>  be disabled for code not linked with kernel image.
>
>How does that explain the change to unwind.c ?

Thanks for your review.
Here is patch code:
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -249,7 +249,8 @@ static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
                if (*vsp >= (unsigned long *)ctrl->sp_high)
                        return -URC_FAILURE;

-       ctrl->vrs[reg] = *(*vsp)++;
+       ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
+       (*vsp)++;
        return URC_OK;
 }

I change here because I don't think unwind_frame need to be check by kasan, and I have ever 
found the following error which rarely appares when remove the change of unwind.c.

Here is the error log:
==================================================================
BUG: KASAN: stack-out-of-bounds in unwind_frame+0x3e0/0x788
Read of size 4 at addr 868a3b20 by task swapper/0/1

CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc2+ #2
Hardware name: ARM-Versatile Express
[<8011479c>] (unwind_backtrace) from [<8010f558>] (show_stack+0x10/0x14)
[<8010f558>] (show_stack) from [<808fdca0>] (dump_stack+0x90/0xa4)
[<808fdca0>] (dump_stack) from [<802b3808>] (print_address_description+0x4c/0x270)
[<802b3808>] (print_address_description) from [<802b3ec4>] (kasan_report+0x218/0x300)
[<802b3ec4>] (kasan_report) from [<801143f4>] (unwind_frame+0x3e0/0x788)
[<801143f4>] (unwind_frame) from [<8010ebc4>] (walk_stackframe+0x2c/0x38)
[<8010ebc4>] (walk_stackframe) from [<8010ee70>] (__save_stack_trace+0x160/0x164)
[<8010ee70>] (__save_stack_trace) from [<802b342c>] (kasan_slab_free+0x84/0x158)
[<802b342c>] (kasan_slab_free) from [<802b05dc>] (kmem_cache_free+0x58/0x1d4)
[<802b05dc>] (kmem_cache_free) from [<801a6420>] (rcu_process_callbacks+0x600/0xe04)
[<801a6420>] (rcu_process_callbacks) from [<801018e8>] (__do_softirq+0x1a0/0x4e0)
[<801018e8>] (__do_softirq) from [<80131560>] (irq_exit+0xec/0x120)
[<80131560>] (irq_exit) from [<8018d2a0>] (__handle_domain_irq+0x78/0xdc)
[<8018d2a0>] (__handle_domain_irq) from [<80101700>] (gic_handle_irq+0x48/0x8c)
[<80101700>] (gic_handle_irq) from [<80110690>] (__irq_svc+0x70/0x94)
Exception stack(0x868a39f0 to 0x868a3a38)
39e0:                                     7fffffff 868a3b88 00000000 00000001
3a00: 868a3b84 7fffffff 868a3b88 6fd1474c 868a3ac0 868a0000 00000002 86898000
3a20: 00000001 868a3a40 8091b4d4 8091edb0 60000013 ffffffff
[<80110690>] (__irq_svc) from [<8091edb0>] (schedule_timeout+0x0/0x3c4)
[<8091edb0>] (schedule_timeout) from [<6fd14770>] (0x6fd14770)

The buggy address belongs to the page:
page:87fcc460 count:0 mapcount:0 mapping:  (null) index:0x0
flags: 0x0()
raw: 00000000 00000000 00000000 ffffffff 00000000 87fcc474 87fcc474 00000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 868a3a00: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
 868a3a80: 00 00 04 f4 f3 f3 f3 f3 00 00 00 00 00 00 00 00
>868a3b00: 00 00 00 00 f1 f1 f1 f1 04 f4 f4 f4 f2 f2 f2 f2
                       ^
 868a3b80: 00 00 00 00 00 04 f4 f4 f3 f3 f3 f3 00 00 00 00
 868a3c00: 00 00 00 00 f1 f1 f1 f1 00 07 f4 f4 f3 f3 f3 f3
==================================================================
Disabling lock debugging due to kernel taint

/* Before poping a register check whether it is feasible or not */
static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
				unsigned long **vsp, unsigned int reg)
{
	if (unlikely(ctrl->check_each_pop))
		if (*vsp >= (unsigned long *)ctrl->sp_high)
			return -URC_FAILURE;

	// unwind_frame+0x3e0/0x788 is here
	ctrl->vrs[reg] = *(*vsp)++;
	return URC_OK;
}
>
>Does this also disable the string macro changes?
>
>In any case, this should certainly precede patch 4, and very probably
>patch 2.

You are right. I will change it in net version.
