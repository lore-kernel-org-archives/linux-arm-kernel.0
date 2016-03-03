From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 3 Mar 2016 16:24:56 -0300
Subject: mtd: pxa3xx_nand: issue with command time out
In-Reply-To: <56D61502.1090007@alliedtelesis.co.nz>
References: <5695CEF0.1080100@alliedtelesis.co.nz>
 <87a8o9ex9r.fsf@belgarion.home>
 <569827BC.10601@alliedtelesis.co.nz>
 <874meddqu5.fsf@belgarion.home> <20160125183022.GA41251@google.com>
 <87fuxl9yil.fsf@belgarion.home>
 <CAAEAJfCNzh9+zRq_Yb=hFyLfP8RFoX+LUsDL4dVwUenVc_gVOA@mail.gmail.com>
 <56D61502.1090007@alliedtelesis.co.nz>
Message-ID: <CAAEAJfAd2qkcJby3AaKOaxL2LZC=PMNfu7dy5yMcZ1eHhOF7oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Richard, Boris and Thomas

On 1 March 2016 at 19:17, Hamish Martin
<Hamish.Martin@alliedtelesis.co.nz> wrote:
> Hi Robert, Ezequiel, and Brian,
>
> I have been working with Michael Wang on this issue and wanted to update
> you on our results as we think there is a wider issue to resolve here.
>
> I believe Ezequiel's analysis of the IRQ sequence is correct. The
> proposed patch from Brian is not needed, not does it resolve our issue.
>
> Further, we have debugged in more detail with kernel tracing and see
> that the problem occurs because nothing calls 'schedule()' in the kernel
> within the timeout period (200ms) to actually allow the IRQ bottom-half
> thread ((pxa3xx_nand_irq_thread()) to run.
>
> With the trace enabled we were able to see long delays between the IRQ
> thread being queued for run as a result of the return with
> IRQ_WAKE_THREAD in pxa3xx_nand_irq(), and a call to schedule() actually
> selecting the thread for execution. This delay was tied to whatever else
> was happening in our system during the boot up when this issue occurs.
> For instance, if a mutex got unlocked this would ultimately lead to a
> call to schedule() and our thread (pxa3xx_nand_irq_thread()) would run.
> If some file system ops happened schedule() would get called. These
> unrelated activities were required so that schedule() got called and the
> scheduler would let the bottom-half execute.
> In our tracing we saw the issue occur whenever the call to schedule()
> didn't occur before the timeout expired. In short, if we got lucky and
> something completely unrelated happened that led to a call to
> 'schedule()', then the issue didn't occur. If we got unlucky and nothing
> called schedule(), the issue was observed.
>
> We have enabled CONFIG_PREEMPT in our system to resolve this. This has
> the effect of leading to a triggering of 'schedule()' at the end of
> processing interrupts. This means that we now see a nice tight execution
> of pxa3xx_nand threaded IRQ such that we see all ops completing with
> less that 20ms delay.
>
> I wanted to highlight this to you because I think it shows that the
> change to a threaded IRQ is probably only safe if we can guarantee
> scheduling of the bottom-half thread within the time out period (200ms).
> I think this is not safe for systems with CONFIG_PREEMPT not configured.
> Or perhaps there is a better way to resolve this. Is this a deficiency
> in the Armada XP code?
>
> What do you think?
>

Thanks a lot for updating us. Richard, Boris and I have
discussed about this on IRC.

We came to the following conclusions:

1. There's no way to guarantee that the thread will be scheduled
soon enough to always do the data transfer in time.

Using CONFIG_PREEMPT could prevent a timeout in many (most?)
cases, but it's not guaranteed to work.

2. The pxa3xx-nand driver is poorly designed, and it shouldn't
do any data transfer in the IRQ (threaded or not) handler.

Instead, this should be done in {read,write}_buf, i.e. in the
context of the calling process that asks data to be read/write.
This is potentially a big rework.

3. Richard proposed to get rid of the timeout
(using wait_for_completion_interruptible instead?).

I'm wondering if that could avoid these kind of issues (false
timeouts), as a less invasive solution, until someone steps
up to rework the driver.

How does it sound?
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
