From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 17 Jun 2016 18:14:22 +0200
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1465906063.20796.20.camel@mtksdaap41>
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
 <1465906063.20796.20.camel@mtksdaap41>
Message-ID: <576421DE.7080203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/06/16 14:07, Horng-Shyang Liao wrote:
> Hi Matthias,
>
> On Tue, 2016-06-14 at 12:17 +0200, Matthias Brugger wrote:
>>
>> On 14/06/16 09:44, Horng-Shyang Liao wrote:
>>> Hi Matthias,
>>>
>>> On Wed, 2016-06-08 at 17:35 +0200, Matthias Brugger wrote:
>>>>
>>>> On 08/06/16 14:25, Horng-Shyang Liao wrote:
>>>>> Hi Matthias,
>>>>>
>>>>> On Wed, 2016-06-08 at 12:45 +0200, Matthias Brugger wrote:
>>>>>>
>>>>>> On 08/06/16 07:40, Horng-Shyang Liao wrote:
>>>>>>> Hi Matthias,
>>>>>>>
>>>>>>> On Tue, 2016-06-07 at 18:59 +0200, Matthias Brugger wrote:
>>>>>>>>
>>>>>>>> On 03/06/16 15:11, Matthias Brugger wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +            smp_mb(); /* modify jump before enable thread */
>>>>>>>>>>>>>>>>>> +        }
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +        cmdq_thread_writel(thread, task->pa_base +
>>>>>>>>>>>>>>>>>> task->command_size,
>>>>>>>>>>>>>>>>>> +                   CMDQ_THR_END_ADDR);
>>>>>>>>>>>>>>>>>> +        cmdq_thread_resume(thread);
>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>> +    list_move_tail(&task->list_entry, &thread->task_busy_list);
>>>>>>>>>>>>>>>>>> +    spin_unlock_irqrestore(&cmdq->exec_lock, flags);
>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +static void cmdq_handle_error_done(struct cmdq *cmdq,
>>>>>>>>>>>>>>>>>> +                   struct cmdq_thread *thread, u32 irq_flag)
>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>> +    struct cmdq_task *task, *tmp, *curr_task = NULL;
>>>>>>>>>>>>>>>>>> +    u32 curr_pa;
>>>>>>>>>>>>>>>>>> +    struct cmdq_cb_data cmdq_cb_data;
>>>>>>>>>>>>>>>>>> +    bool err;
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +    if (irq_flag & CMDQ_THR_IRQ_ERROR)
>>>>>>>>>>>>>>>>>> +        err = true;
>>>>>>>>>>>>>>>>>> +    else if (irq_flag & CMDQ_THR_IRQ_DONE)
>>>>>>>>>>>>>>>>>> +        err = false;
>>>>>>>>>>>>>>>>>> +    else
>>>>>>>>>>>>>>>>>> +        return;
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +    curr_pa = cmdq_thread_readl(thread, CMDQ_THR_CURR_ADDR);
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +    list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
>>>>>>>>>>>>>>>>>> +                 list_entry) {
>>>>>>>>>>>>>>>>>> +        if (curr_pa >= task->pa_base &&
>>>>>>>>>>>>>>>>>> +            curr_pa < (task->pa_base + task->command_size))
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> What are you checking here? It seems as if you make some implcit
>>>>>>>>>>>>>>>>> assumptions about pa_base and the order of execution of
>>>>>>>>>>>>>>>>> commands in the
>>>>>>>>>>>>>>>>> thread. Is it save to do so? Does dma_alloc_coherent give any
>>>>>>>>>>>>>>>>> guarantees
>>>>>>>>>>>>>>>>> about dma_handle?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> 1. Check what is the current running task in this GCE thread.
>>>>>>>>>>>>>>>> 2. Yes.
>>>>>>>>>>>>>>>> 3. Yes, CMDQ doesn't use iommu, so physical address is continuous.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Yes, physical addresses might be continous, but AFAIK there is no
>>>>>>>>>>>>>>> guarantee that the dma_handle address is steadily growing, when
>>>>>>>>>>>>>>> calling
>>>>>>>>>>>>>>> dma_alloc_coherent. And if I understand the code correctly, you
>>>>>>>>>>>>>>> use this
>>>>>>>>>>>>>>> assumption to decide if the task picked from task_busy_list is
>>>>>>>>>>>>>>> currently
>>>>>>>>>>>>>>> executing. So I think this mecanism is not working.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I don't use dma_handle address, and just use physical addresses.
>>>>>>>>>>>>>>        From CPU's point of view, tasks are linked by the busy list.
>>>>>>>>>>>>>>        From GCE's point of view, tasks are linked by the JUMP command.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> In which cases does the HW thread raise an interrupt.
>>>>>>>>>>>>>>> In case of error. When does CMDQ_THR_IRQ_DONE get raised?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> GCE will raise interrupt if any task is done or error.
>>>>>>>>>>>>>> However, GCE is fast, so CPU may get multiple done tasks
>>>>>>>>>>>>>> when it is running ISR.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> In case of error, that GCE thread will pause and raise interrupt.
>>>>>>>>>>>>>> So, CPU may get multiple done tasks and one error task.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> I think we should reimplement the ISR mechanism. Can't we just read
>>>>>>>>>>>>> CURR_IRQ_STATUS and THR_IRQ_STATUS in the handler and leave
>>>>>>>>>>>>> cmdq_handle_error_done to the thread_fn? You will need to pass
>>>>>>>>>>>>> information from the handler to thread_fn, but that shouldn't be an
>>>>>>>>>>>>> issue. AFAIK interrupts are disabled in the handler, so we should stay
>>>>>>>>>>>>> there as short as possible. Traversing task_busy_list is expensive, so
>>>>>>>>>>>>> we need to do it in a thread context.
>>>>>>>>>>>>
>>>>>>>>>>>> Actually, our initial implementation is similar to your suggestion,
>>>>>>>>>>>> but display needs CMDQ to return callback function very precisely,
>>>>>>>>>>>> else display will drop frame.
>>>>>>>>>>>> For display, CMDQ interrupt will be raised every 16 ~ 17 ms,
>>>>>>>>>>>> and CMDQ needs to call callback function in ISR.
>>>>>>>>>>>> If we defer callback to workqueue, the time interval may be larger than
>>>>>>>>>>>> 32 ms.sometimes.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I think the problem is, that you implemented the workqueue as a ordered
>>>>>>>>>>> workqueue, so there is no parallel processing. I'm still not sure why
>>>>>>>>>>> you need the workqueue to be ordered. Can you please explain.
>>>>>>>>>>
>>>>>>>>>> The order should be kept.
>>>>>>>>>> Let me use mouse cursor as an example.
>>>>>>>>>> If task 1 means move mouse cursor to point A, task 2 means point B,
>>>>>>>>>> and task 3 means point C, our expected result is A -> B -> C.
>>>>>>>>>> If the order is not kept, the result could become A -> C -> B.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Got it, thanks for the clarification.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I think a way to get rid of the workqueue is to use a timer, which gets
>>>>>>>> programmed to the time a timeout in the first task in the busy list
>>>>>>>> would happen. Everytime we update the busy list (e.g. because of task
>>>>>>>> got finished by the thread), we update the timer. When the timer
>>>>>>>> triggers, which hopefully won't happen too often, we return timeout on
>>>>>>>> the busy list elements, until the time is lower then the actual time.
>>>>>>>>
>>>>>>>> At least with this we can reduce the data structures in this driver and
>>>>>>>> make it more lightweight.
>>>>>>>
>>>>>>>     From my understanding, your proposed method can handle timeout case.
>>>>>>>
>>>>>>> However, the workqueue is also in charge of releasing tasks.
>>>>>>> Do you take releasing tasks into consideration by using the proposed
>>>>>>> timer method?
>>>>>>> Furthermore, I think the code will become more complex if we also use
>>>>>>> timer to implement releasing tasks.
>>>>>>>
>>>>>>
>>>>>> Can't we call
>>>>>>             clk_disable_unprepare(cmdq->clock);
>>>>>>             cmdq_task_release(task);
>>>>>> after invoking the callback?
>>>>>
>>>>> Do you mean just call these two functions in ISR?
>>>>> My major concern is dma_free_coherent() and kfree() in
>>>>> cmdq_task_release(task).
>>>>
>>>> Why do we need the dma calls at all? Can't we just calculate the
>>>> physical address using __pa(x)?
>>>
>>> I prefer to use dma_map_single/dma_unmap_single.
>>>
>>
>> Can you please elaborate why you need this. We don't do dma, so we
>> should not use dma memory for this.
>
> We need a buffer to share between CPU and GCE, so we do need DMA.
> CPU is in charge of writing GCE commands into this buffer.
> GCE is in charge of reading and running GCE commands from this buffer.
> When we chain CMDQ tasks, we also need to modify GCE JUMP command.
> Therefore, I prefer to use dma_alloc_coherent and dma_free_coherent.
>
> However, if we want to use timer to handle timeout, we need to release
> memory in ISR.
> In this case, using kmalloc/kfree + dma_map_single/dma_unmap_single
> instead of dma_alloc_coherent/dma_free_coherent is an alternative
> solution, but taking care the synchronization between cache and memory
> is the expected overhead.
>
>>>>> Therefore, your suggestion is to use GFP_ATOMIC for both
>>>>> dma_alloc_coherent() and kzalloc(). Right?
>>>>
>>>> I don't think we need GFP_ATOMIC, the critical path will just free the
>>>> memory.
>>>
>>> I tested these two functions, and kfree was safe.
>>> However, dma_free_coherent raised BUG.
>>> BUG: failure at
>>> /mnt/host/source/src/third_party/kernel/v3.18/mm/vmalloc.c:1514/vunmap()!
>>
>> Just a general hint. Please try to evaluate on a recent kernel. It looks
>> like as if you tried this on a v3.18 based one.
>
> This driver should be backward compatible to v3.18 for a MTK project.
>

That is something the Linux community can't use as argument for design 
decisions. If the backporting get's cumbersome, I propose to tell your 
boss, giving him the hint, that if the driver would have been in 
mainline earlier, this would all be easier ;)
No, seriously, that's why it makes a lot of sense for companies like 
Mediatek to have their driver mainlined. A switch to a new kernel 
version comes for free for all the mainlined drivers. Knowing the source 
code of the Mediatek kernel, I suppose doing a kernel version switch 
takes a good bunch of time and nerves. :)

Best regards,
Matthias
