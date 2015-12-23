From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 23 Dec 2015 09:27:28 -0700
Subject: [PATCH V7 04/24] coresight: moving PM runtime operations to core
 framework
In-Reply-To: <20151219171342.GA2437@debian>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <1450472361-426-5-git-send-email-mathieu.poirier@linaro.org>
 <20151219171342.GA2437@debian>
Message-ID: <CANLsYkzgMq1caiE+wA2RRBpe4Bg14Fy7Eu8CnRkrhYmNg7j1Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 December 2015 at 10:13, Rabin Vincent <rabin@rab.in> wrote:
> On Fri, Dec 18, 2015 at 01:59:00PM -0700, Mathieu Poirier wrote:
>> @@ -415,9 +418,13 @@ struct list_head *coresight_build_path(struct coresight_device *csdev)
>>   */
>>  void coresight_release_path(struct list_head *path)
>>  {
>> +     struct coresight_device *csdev;
>>       struct coresight_node *nd, *next;
>>
>>       list_for_each_entry_safe(nd, next, path, link) {
>> +             csdev = nd->csdev;
>> +
>> +             pm_runtime_put_sync(csdev->dev.parent);
>>               list_del(&nd->link);
>>               kfree(nd);
>>       }
>
> This leads to the following splat:
>
>  BUG: sleeping function called from invalid context at /home/rabin/dev/linux/drivers/base/power/runtime.c:892
>  in_atomic(): 1, irqs_disabled(): 128, pid: 763, name: perf
>  2 locks held by perf/763:
>   #0:  (&mm->mmap_sem){++++++}, at: [<c012e42c>] vm_munmap+0x2c/0x50
>   #1:  (&event->mmap_mutex){+.+.+.}, at: [<c008248c>] atomic_dec_and_mutex_lock+0x58/0x98
>  irq event stamp: 63152
>  hardirqs last  enabled at (63151): [<c04f7edc>] _raw_spin_unlock_irqrestore+0x30/0x5c
>  hardirqs last disabled at (63152): [<c04f88e8>] __irq_svc+0x48/0x78
>  softirqs last  enabled at (61242): [<c003a914>] __do_softirq+0x408/0x4fc
>  softirqs last disabled at (61223): [<c003ad50>] irq_exit+0xcc/0x130
>  CPU: 1 PID: 763 Comm: perf Not tainted 4.4.0-rc5-00224-ge461459-dirty #152
>  Hardware name: Generic OMAP4 (Flattened Device Tree)
>  [<c00184dc>] (unwind_backtrace) from [<c0014c74>] (show_stack+0x10/0x14)
>  [<c0014c74>] (show_stack) from [<c025c834>] (dump_stack+0x90/0xb8)
>  [<c025c834>] (dump_stack) from [<c02f026c>] (__pm_runtime_idle+0xa4/0xa8)
>  [<c02f026c>] (__pm_runtime_idle) from [<c03e1a08>] (coresight_release_path+0x38/0x7c)
>  [<c03e1a08>] (coresight_release_path) from [<c03e210c>] (free_event_data+0x84/0x9c)
>  [<c03e210c>] (free_event_data) from [<c00f8be8>] (rb_irq_work+0x4c/0xcc)
>  [<c00f8be8>] (rb_irq_work) from [<c00e8860>] (irq_work_run_list+0x7c/0xb4)
>  [<c00e8860>] (irq_work_run_list) from [<c00e88b8>] (irq_work_run+0x20/0x34)
>  [<c00e88b8>] (irq_work_run) from [<c0016dcc>] (handle_IPI+0x1cc/0x334)
>  [<c0016dcc>] (handle_IPI) from [<c0009538>] (gic_handle_irq+0x84/0x88)
>  [<c0009538>] (gic_handle_irq) from [<c04f88f8>] (__irq_svc+0x58/0x78)
>  Exception stack(0xed865e98 to 0xed865ee0)
>  5e80:                                                       00000001 00000110
>  5ea0: 00000000 ee2f1080 20000113 c0784808 edbe4e1c b6ae5000 edb882f0 ed9b1e04
>  5ec0: edb88298 c075648c 00000002 ed865ee8 c008724c c04f7ee0 20000113 ffffffff
>  [<c04f88f8>] (__irq_svc) from [<c04f7ee0>] (_raw_spin_unlock_irqrestore+0x34/0x5c)
>  [<c04f7ee0>] (_raw_spin_unlock_irqrestore) from [<c00e8978>] (irq_work_queue+0xac/0xb4)
>  [<c00e8978>] (irq_work_queue) from [<c00f5020>] (perf_mmap_close+0x370/0x3c8)
>  [<c00f5020>] (perf_mmap_close) from [<c012c560>] (remove_vma+0x40/0x6c)
>  [<c012c560>] (remove_vma) from [<c012e2b4>] (do_munmap+0x210/0x35c)
>  [<c012e2b4>] (do_munmap) from [<c012e43c>] (vm_munmap+0x3c/0x50)
>  [<c012e43c>] (vm_munmap) from [<c0010320>] (ret_fast_syscall+0x0/0x1c)
>
> It should presumably be using pm_runtime_put() instead.

That's a first - what platform did you test on?  If I send you fixes
will you be able to help me with the verification?

Thanks,
Mathieu
