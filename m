From: Hamish.Martin@alliedtelesis.co.nz (Hamish Martin)
Date: Tue, 1 Mar 2016 22:17:38 +0000
Subject: mtd: pxa3xx_nand: issue with command time out
In-Reply-To: <CAAEAJfCNzh9+zRq_Yb=hFyLfP8RFoX+LUsDL4dVwUenVc_gVOA@mail.gmail.com>
References: <5695CEF0.1080100@alliedtelesis.co.nz>
 <87a8o9ex9r.fsf@belgarion.home> <569827BC.10601@alliedtelesis.co.nz>
 <874meddqu5.fsf@belgarion.home> <20160125183022.GA41251@google.com>
 <87fuxl9yil.fsf@belgarion.home>
 <CAAEAJfCNzh9+zRq_Yb=hFyLfP8RFoX+LUsDL4dVwUenVc_gVOA@mail.gmail.com>
Message-ID: <56D61502.1090007@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert, Ezequiel, and Brian,

I have been working with Michael Wang on this issue and wanted to update 
you on our results as we think there is a wider issue to resolve here.

I believe Ezequiel's analysis of the IRQ sequence is correct. The 
proposed patch from Brian is not needed, not does it resolve our issue.

Further, we have debugged in more detail with kernel tracing and see 
that the problem occurs because nothing calls 'schedule()' in the kernel 
within the timeout period (200ms) to actually allow the IRQ bottom-half 
thread ((pxa3xx_nand_irq_thread()) to run.

With the trace enabled we were able to see long delays between the IRQ 
thread being queued for run as a result of the return with 
IRQ_WAKE_THREAD in pxa3xx_nand_irq(), and a call to schedule() actually 
selecting the thread for execution. This delay was tied to whatever else 
was happening in our system during the boot up when this issue occurs. 
For instance, if a mutex got unlocked this would ultimately lead to a 
call to schedule() and our thread (pxa3xx_nand_irq_thread()) would run. 
If some file system ops happened schedule() would get called. These 
unrelated activities were required so that schedule() got called and the 
scheduler would let the bottom-half execute.
In our tracing we saw the issue occur whenever the call to schedule() 
didn't occur before the timeout expired. In short, if we got lucky and 
something completely unrelated happened that led to a call to 
'schedule()', then the issue didn't occur. If we got unlucky and nothing 
called schedule(), the issue was observed.

We have enabled CONFIG_PREEMPT in our system to resolve this. This has 
the effect of leading to a triggering of 'schedule()' at the end of 
processing interrupts. This means that we now see a nice tight execution 
of pxa3xx_nand threaded IRQ such that we see all ops completing with 
less that 20ms delay.

I wanted to highlight this to you because I think it shows that the 
change to a threaded IRQ is probably only safe if we can guarantee 
scheduling of the bottom-half thread within the time out period (200ms). 
I think this is not safe for systems with CONFIG_PREEMPT not configured. 
Or perhaps there is a better way to resolve this. Is this a deficiency 
in the Armada XP code?

What do you think?

Thanks,
Hamish Martin


On 01/27/2016 02:03 AM, Ezequiel Garcia wrote:
> On 25 January 2016 at 17:48, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Brian Norris <computersforpeace@gmail.com> writes:
>>
>>> Hi Robert,
>>>
>>> On Sun, Jan 17, 2016 at 12:53:06AM +0100, Robert Jarzmik wrote:
>>> commit 24542257a3b987025d4b998ec2d15e556c98ad3f
>>> Author: Robert Jarzmik <robert.jarzmik@free.fr>
>>> Date:   Fri Feb 20 19:36:43 2015 +0100
>>>
>>>      mtd: pxa3xx-nand: handle PIO in threaded interrupt
>>>
>>>
>>> And now I'm wondering: when does the completion get triggered? i.e.:
>>>
>>>        complete(&info->cmd_complete);
>>> It seems to me like you've short-circuited some of the IRQ handling
>>> code, so that the threaded handler is buggy. AIUI, if the completion
>>> event ever happens, it's actually happening *before* the full (threaded)
>>> handler is actually finished, since it occurs in pxa3xx_nand_irq(),
>>> before pxa3xx_nand_irq_thread() ever runs. Now, I'm not sure if that
>>> causes a real problem in practice, since you used IRQF_ONESHOT, but I
>>> would think that's also suspect.
>> I think you're very right, this "goto NORMAL_IRQ_EXIT" creates a
>> short-cirtcuit. That makes me think that I should :
>>   - add
>> static void pxa3xx_nand_data_finished(struct pxa3xx_nand_info *info)
>> {
>>          unsigned int done;
>>
>>          cmd_done =nfo->cs ? NDSR_CS1_CMDD : NDSR_CS0_CMDD;
>>          nand_writel(info, NDSR, cmd_done);
>>          complete(&inf0->cmd_complete);
>> }
>>
>>   - in pxa3xx_nand_irq_thread(), I should add at the end:
>>          pxa3xx_nand_data_finished(info);
>>
>>   - in pxa3xx_nand_data_dma_irq(), I should add at the end:
>>          pxa3xx_nand_data_finished(info);
>>
>> Ezequiel, would you have a look at that code snippet and tell me if I'm missing
>> something in the driver's structure ?
>>
> Although it seems Brian is right, I'm not so sure about it. As far as
> I can recall, the IRQ sequence is (please correct me if I'm wrong!):
>
> 1. Write command request (WRCMDREQ), the IRQ handler writes the command.
> 2. Read/write data request (RDDREQ | WRDREQ). The IRQ handler fires
> the threaded handler, which does data transfer.
> 3. Command done IRQ (CMDD), the IRQ handler completes the completion.
>
> I don't think data request and command done can be found
> simultaneously, so I don't think this is a real issue. Ideas?
>
> Regarding the fixed proposed up there, it seems wrong: the completion
> should be completed only after a command done IRQ is found, and not as
> the result of data transfer being finished.
