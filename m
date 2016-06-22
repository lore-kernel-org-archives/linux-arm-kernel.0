From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 22 Jun 2016 11:58:19 +0200
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1466574193.27740.6.camel@mtksdaap41>
References: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
 <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
 <574C5CBF.7060002@gmail.com> <1464683762.14604.59.camel@mtksdaap41>
 <574DEE40.9010008@gmail.com> <1464775020.11122.40.camel@mtksdaap41>
 <574FF264.7050209@gmail.com> <1464934356.15175.31.camel@mtksdaap41>
 <57516774.5080008@gmail.com> <1464956037.16029.8.camel@mtksdaap41>
 <575181E5.6090603@gmail.com> <5756FD73.3050607@gmail.com>
 <1465364427.9963.13.camel@mtksdaap41> <5757F762.4020908@gmail.com>
 <1465388727.21326.8.camel@mtksdaap41> <57583B45.2080504@gmail.com>
 <1465890268.7191.13.camel@mtksdaap41> <575FD9BA.8040708@gmail.com>
 <1465906063.20796.20.camel@mtksdaap41> <1466152107.11184.14.camel@mtksdaap41>
 <57641E01.3070205@gmail.com> <1466488358.8045.19.camel@mtksdaap41>
 <5769440D.5030505@gmail.com> <1466574193.27740.6.camel@mtksdaap41>
Message-ID: <8aec0411-a85a-f669-b73e-578471493858@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/22/2016 07:43 AM, Horng-Shyang Liao wrote:
> On Tue, 2016-06-21 at 15:41 +0200, Matthias Brugger wrote:
>>
>> On 21/06/16 07:52, Horng-Shyang Liao wrote:
>>> On Fri, 2016-06-17 at 17:57 +0200, Matthias Brugger wrote:
>>>>
>>>> On 17/06/16 10:28, Horng-Shyang Liao wrote:
>>>>> Hi Matthias,
>>>>>
>>>>> On Tue, 2016-06-14 at 20:07 +0800, Horng-Shyang Liao wrote:
>>>>>> Hi Matthias,
>>>>>>
>>>>>> On Tue, 2016-06-14 at 12:17 +0200, Matthias Brugger wrote:
>>>>>>>
>>>>>>> On 14/06/16 09:44, Horng-Shyang Liao wrote:
>>>>>>>> Hi Matthias,
>>>>>>>>
>>>>>>>> On Wed, 2016-06-08 at 17:35 +0200, Matthias Brugger wrote:
>>>>>>>>>
>>>>>>>>> On 08/06/16 14:25, Horng-Shyang Liao wrote:
>>>>>>>>>> Hi Matthias,
>>>>>>>>>>
>>>>>>>>>> On Wed, 2016-06-08 at 12:45 +0200, Matthias Brugger wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 08/06/16 07:40, Horng-Shyang Liao wrote:
>>>>>>>>>>>> Hi Matthias,
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, 2016-06-07 at 18:59 +0200, Matthias Brugger wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 03/06/16 15:11, Matthias Brugger wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>> [...]
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +            smp_mb(); /* modify jump before enable thread */
>>>>>>>>>>>>>>>>>>>>>>> +        }
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +        cmdq_thread_writel(thread, task->pa_base +
>>>>>>>>>>>>>>>>>>>>>>> task->command_size,
>>>>>>>>>>>>>>>>>>>>>>> +                   CMDQ_THR_END_ADDR);
>>>>>>>>>>>>>>>>>>>>>>> +        cmdq_thread_resume(thread);
>>>>>>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>>>>>>> +    list_move_tail(&task->list_entry, &thread->task_busy_list);
>>>>>>>>>>>>>>>>>>>>>>> +    spin_unlock_irqrestore(&cmdq->exec_lock, flags);
>>>>>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +static void cmdq_handle_error_done(struct cmdq *cmdq,
>>>>>>>>>>>>>>>>>>>>>>> +                   struct cmdq_thread *thread, u32 irq_flag)
>>>>>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>>>>>> +    struct cmdq_task *task, *tmp, *curr_task = NULL;
>>>>>>>>>>>>>>>>>>>>>>> +    u32 curr_pa;
>>>>>>>>>>>>>>>>>>>>>>> +    struct cmdq_cb_data cmdq_cb_data;
>>>>>>>>>>>>>>>>>>>>>>> +    bool err;
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +    if (irq_flag & CMDQ_THR_IRQ_ERROR)
>>>>>>>>>>>>>>>>>>>>>>> +        err = true;
>>>>>>>>>>>>>>>>>>>>>>> +    else if (irq_flag & CMDQ_THR_IRQ_DONE)
>>>>>>>>>>>>>>>>>>>>>>> +        err = false;
>>>>>>>>>>>>>>>>>>>>>>> +    else
>>>>>>>>>>>>>>>>>>>>>>> +        return;
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +    curr_pa = cmdq_thread_readl(thread, CMDQ_THR_CURR_ADDR);
>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>> +    list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
>>>>>>>>>>>>>>>>>>>>>>> +                 list_entry) {
>>>>>>>>>>>>>>>>>>>>>>> +        if (curr_pa >= task->pa_base &&
>>>>>>>>>>>>>>>>>>>>>>> +            curr_pa < (task->pa_base + task->command_size))
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> What are you checking here? It seems as if you make some implcit
>>>>>>>>>>>>>>>>>>>>>> assumptions about pa_base and the order of execution of
>>>>>>>>>>>>>>>>>>>>>> commands in the
>>>>>>>>>>>>>>>>>>>>>> thread. Is it save to do so? Does dma_alloc_coherent give any
>>>>>>>>>>>>>>>>>>>>>> guarantees
>>>>>>>>>>>>>>>>>>>>>> about dma_handle?
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> 1. Check what is the current running task in this GCE thread.
>>>>>>>>>>>>>>>>>>>>> 2. Yes.
>>>>>>>>>>>>>>>>>>>>> 3. Yes, CMDQ doesn't use iommu, so physical address is continuous.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Yes, physical addresses might be continous, but AFAIK there is no
>>>>>>>>>>>>>>>>>>>> guarantee that the dma_handle address is steadily growing, when
>>>>>>>>>>>>>>>>>>>> calling
>>>>>>>>>>>>>>>>>>>> dma_alloc_coherent. And if I understand the code correctly, you
>>>>>>>>>>>>>>>>>>>> use this
>>>>>>>>>>>>>>>>>>>> assumption to decide if the task picked from task_busy_list is
>>>>>>>>>>>>>>>>>>>> currently
>>>>>>>>>>>>>>>>>>>> executing. So I think this mecanism is not working.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> I don't use dma_handle address, and just use physical addresses.
>>>>>>>>>>>>>>>>>>>         From CPU's point of view, tasks are linked by the busy list.
>>>>>>>>>>>>>>>>>>>         From GCE's point of view, tasks are linked by the JUMP command.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> In which cases does the HW thread raise an interrupt.
>>>>>>>>>>>>>>>>>>>> In case of error. When does CMDQ_THR_IRQ_DONE get raised?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> GCE will raise interrupt if any task is done or error.
>>>>>>>>>>>>>>>>>>> However, GCE is fast, so CPU may get multiple done tasks
>>>>>>>>>>>>>>>>>>> when it is running ISR.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> In case of error, that GCE thread will pause and raise interrupt.
>>>>>>>>>>>>>>>>>>> So, CPU may get multiple done tasks and one error task.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I think we should reimplement the ISR mechanism. Can't we just read
>>>>>>>>>>>>>>>>>> CURR_IRQ_STATUS and THR_IRQ_STATUS in the handler and leave
>>>>>>>>>>>>>>>>>> cmdq_handle_error_done to the thread_fn? You will need to pass
>>>>>>>>>>>>>>>>>> information from the handler to thread_fn, but that shouldn't be an
>>>>>>>>>>>>>>>>>> issue. AFAIK interrupts are disabled in the handler, so we should stay
>>>>>>>>>>>>>>>>>> there as short as possible. Traversing task_busy_list is expensive, so
>>>>>>>>>>>>>>>>>> we need to do it in a thread context.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Actually, our initial implementation is similar to your suggestion,
>>>>>>>>>>>>>>>>> but display needs CMDQ to return callback function very precisely,
>>>>>>>>>>>>>>>>> else display will drop frame.
>>>>>>>>>>>>>>>>> For display, CMDQ interrupt will be raised every 16 ~ 17 ms,
>>>>>>>>>>>>>>>>> and CMDQ needs to call callback function in ISR.
>>>>>>>>>>>>>>>>> If we defer callback to workqueue, the time interval may be larger than
>>>>>>>>>>>>>>>>> 32 ms.sometimes.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I think the problem is, that you implemented the workqueue as a ordered
>>>>>>>>>>>>>>>> workqueue, so there is no parallel processing. I'm still not sure why
>>>>>>>>>>>>>>>> you need the workqueue to be ordered. Can you please explain.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The order should be kept.
>>>>>>>>>>>>>>> Let me use mouse cursor as an example.
>>>>>>>>>>>>>>> If task 1 means move mouse cursor to point A, task 2 means point B,
>>>>>>>>>>>>>>> and task 3 means point C, our expected result is A -> B -> C.
>>>>>>>>>>>>>>> If the order is not kept, the result could become A -> C -> B.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Got it, thanks for the clarification.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> I think a way to get rid of the workqueue is to use a timer, which gets
>>>>>>>>>>>>> programmed to the time a timeout in the first task in the busy list
>>>>>>>>>>>>> would happen. Everytime we update the busy list (e.g. because of task
>>>>>>>>>>>>> got finished by the thread), we update the timer. When the timer
>>>>>>>>>>>>> triggers, which hopefully won't happen too often, we return timeout on
>>>>>>>>>>>>> the busy list elements, until the time is lower then the actual time.
>>>>>>>>>>>>>
>>>>>>>>>>>>> At least with this we can reduce the data structures in this driver and
>>>>>>>>>>>>> make it more lightweight.
>>>>>>>>>>>>
>>>>>>>>>>>>      From my understanding, your proposed method can handle timeout case.
>>>>>>>>>>>>
>>>>>>>>>>>> However, the workqueue is also in charge of releasing tasks.
>>>>>>>>>>>> Do you take releasing tasks into consideration by using the proposed
>>>>>>>>>>>> timer method?
>>>>>>>>>>>> Furthermore, I think the code will become more complex if we also use
>>>>>>>>>>>> timer to implement releasing tasks.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Can't we call
>>>>>>>>>>>              clk_disable_unprepare(cmdq->clock);
>>>>>>>>>>>              cmdq_task_release(task);
>>>>>>>>>>> after invoking the callback?
>>>>>
>>>>> After I put clk_disable_unprepare(cmdq->clock) into ISR, I encounter
>>>>> another BUG.
>>>>>
>>>>> (Quote some Linux 4.7 source code.)
>>>>>
>>>>>    605 void clk_unprepare(struct clk *clk)
>>>>>    606 {
>>>>>    607         if (IS_ERR_OR_NULL(clk))
>>>>>    608                 return;
>>>>>    609
>>>>>    610         clk_prepare_lock();                      // <-- Here
>>>>>    611         clk_core_unprepare(clk->core);
>>>>>    612         clk_prepare_unlock();
>>>>>    613 }
>>>>>    614 EXPORT_SYMBOL_GPL(clk_unprepare);
>>>>>
>>>>>     91 static void clk_prepare_lock(void)
>>>>>     92 {
>>>>>     93         if (!mutex_trylock(&prepare_lock)) {     // <-- Here
>>>>>     94                 if (prepare_owner == current) {
>>>>>     95                         prepare_refcnt++;
>>>>>     96                         return;
>>>>>     97                 }
>>>>>     98                 mutex_lock(&prepare_lock);
>>>>>     99         }
>>>>>    100         WARN_ON_ONCE(prepare_owner != NULL);
>>>>>    101         WARN_ON_ONCE(prepare_refcnt != 0);
>>>>>    102         prepare_owner = current;
>>>>>    103         prepare_refcnt = 1;
>>>>>    104 }
>>>>>
>>>>> So, 'unprepare' can sleep and cannot be put into ISR.
>>>>> I also try to put it into a timer, but the error is the same
>>>>> since timer callback is executed by softirq.
>>>>>
>>>>> We need clk_disable_unprepare() since it can save power consumption
>>>>> in idle.
>>>>
>>>> We can call clk_prepare in probe and then use clk_enable/clk_disable,
>>>> which don't sleep.
>>>>
>>>> Regards,
>>>> Matthias
>>>
>>> Hi Matthias,
>>>
>>> Because clock gate and MUX are controlled by clk_enable/clk_disable,
>>> and PLL is controlled by clk_prepare/clk_unprepare,
>>> I still need to call clk_unprepare.
>>>
>>> After I remove releasing buffer, releasing task, and timeout task from
>>> work, the work can be detached from task.
>>>
>>> Therefore, I can use the following flow to reduce the number of works.
>>>
>>> if task_busy_list from empty to non-empty
>>> 	clk_prepare_enable
>>> if task_busy_list from non-empty to empty
>>> 	in ISR, add work for clk_disable_unprepare
>>>
>>> What do you think of this solution?
>>
>> Can't we just call clk_prepare in probe and clk_unprepare in remove? I
>> think this could be a good starting point, and if we see, that we need
>> to save more energy in the future, we can think of some other mechanism.
>> What do you think?
>>
>> Regards,
>> Matthias
>
> Hi Matthias,
>
> As far as I know, we should call clk_unprepare to save more energy.
>
> May I call clk_prepare in probe/resume and clk_unprepare in
> remove/suspend in this patch, and then prepare another patch to call
> clk_unprepare in idle to save more energy?
>

Sure. This was just a suggestion to a first working version of the 
driver to which we can add step-by-step new functionality.

Regards,
Matthias

> Thanks,
> HS
>
>>>
>>> Thanks,
>>> HS
>>>
>>>>> Therefore, I plan to
>>>>> (1) move releasing buffer and task into ISR,
>>>>> (2) move timeout into timer, and
>>>>> (3) keep workqueue for clk_disable_unprepare().
>>>>>
>>>>> What do you think?
>>>>>
>>>>> Thanks,
>>>>> HS
>>>>>
>>>>>>>>>>
>>>>>>>>>> Do you mean just call these two functions in ISR?
>>>>>>>>>> My major concern is dma_free_coherent() and kfree() in
>>>>>>>>>> cmdq_task_release(task).
>>>>>>>>>
>>>>>>>>> Why do we need the dma calls at all? Can't we just calculate the
>>>>>>>>> physical address using __pa(x)?
>>>>>>>>
>>>>>>>> I prefer to use dma_map_single/dma_unmap_single.
>>>>>>>>
>>>>>>>
>>>>>>> Can you please elaborate why you need this. We don't do dma, so we
>>>>>>> should not use dma memory for this.
>>>>>>
>>>>>> We need a buffer to share between CPU and GCE, so we do need DMA.
>>>>>> CPU is in charge of writing GCE commands into this buffer.
>>>>>> GCE is in charge of reading and running GCE commands from this buffer.
>>>>>> When we chain CMDQ tasks, we also need to modify GCE JUMP command.
>>>>>> Therefore, I prefer to use dma_alloc_coherent and dma_free_coherent.
>>>>>>
>>>>>> However, if we want to use timer to handle timeout, we need to release
>>>>>> memory in ISR.
>>>>>> In this case, using kmalloc/kfree + dma_map_single/dma_unmap_single
>>>>>> instead of dma_alloc_coherent/dma_free_coherent is an alternative
>>>>>> solution, but taking care the synchronization between cache and memory
>>>>>> is the expected overhead.
>>>>>>
>>>>>>>>>> Therefore, your suggestion is to use GFP_ATOMIC for both
>>>>>>>>>> dma_alloc_coherent() and kzalloc(). Right?
>>>>>>>>>
>>>>>>>>> I don't think we need GFP_ATOMIC, the critical path will just free the
>>>>>>>>> memory.
>>>>>>>>
>>>>>>>> I tested these two functions, and kfree was safe.
>>>>>>>> However, dma_free_coherent raised BUG.
>>>>>>>> BUG: failure at
>>>>>>>> /mnt/host/source/src/third_party/kernel/v3.18/mm/vmalloc.c:1514/vunmap()!
>>>>>>>
>>>>>>> Just a general hint. Please try to evaluate on a recent kernel. It looks
>>>>>>> like as if you tried this on a v3.18 based one.
>>>>>>
>>>>>> This driver should be backward compatible to v3.18 for a MTK project.
>>>>>>
>>>>>>> Best regards,
>>>>>>> Matthias
>>>>>>
>>>>>> Thanks,
>>>>>> HS
>>>>>>
>>>>>>>> 1512 void vunmap(const void *addr)
>>>>>>>> 1513 {
>>>>>>>> 1514         BUG_ON(in_interrupt());		// <-- here
>>>>>>>> 1515         might_sleep();
>>>>>>>> 1516         if (addr)
>>>>>>>> 1517                 __vunmap(addr, 0);
>>>>>>>> 1518 }
>>>>>>>> 1519 EXPORT_SYMBOL(vunmap);
>>>>>>>>
>>>>>>>> Therefore, I plan to use kmalloc + dma_map_single instead of
>>>>>>>> dma_alloc_coherent, and dma_unmap_single + kfree instead of
>>>>>>>> dma_free_coherent.
>>>>>>>>
>>>>>>>> What do you think about the function replacement?
>>>>>>>>
>>>>>>>>>> If so, I can try to implement timeout by timer, and discuss with you
>>>>>>>>>> if I have further questions.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Sounds good :)
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Matthias
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> HS
>>>>>>>>
>>>>>>>>>>> Regrading the clock, wouldn't it be easier to handle the clock
>>>>>>>>>>> enable/disable depending on the state of task_busy_list? I suppose we
>>>>>>>>>>> can't as we would need to check the task_busy_list of all threads, right?
>>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>> Matthias
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> HS
>>>
>>>
>
>
