From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 8 Jul 2014 16:50:53 -0700
Subject: timers & suspend
In-Reply-To: <f270ad9c-9906-445d-9e9a-4d3618787455@BY2FFO11FD039.protection.gbl>
References: <f270ad9c-9906-445d-9e9a-4d3618787455@BY2FFO11FD039.protection.gbl>
Message-ID: <2489e9cb-51c2-4901-9ab5-c952877d8a9d@BL2FFO11FD057.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let me extend the audience a bit.

On Mon, 2014-06-30 at 11:39AM -0700, S?ren Brinkmann wrote:
> Hi,
> 
> I'm currently working on suspend for Zynq and try to track down some
> spurious wakes. It looks like the spurious wakes are caused by timers,
> hence I was wondering whether there are any special requirements for
> timer drivers when it comes to suspend support or if I just missed
> something.
> 
> Zynq sets the 'IRQCHIP_MASK_ON_SUSPEND' flag, which should mask all
> interrupts but the wake source. Reading through kernel/irq/pm.c
> indicates, that timer interrupts get some special treatment though.
> Therefore I implemented some suspend/resume callbacks for the
> cadence_ttc which disable and clear the timer's interrupts when going
> into suspend. That seems to mitigate the issue quite a bit, but I still
> saw spurious wakes - just a lot less often.
> Digging a little deeper revealed, the spurious wakes are caused by the
> ARM's smp_twd timer now. Given that that driver is probably used by a few
> more ARM platforms, I get the feeling that I'm missing something.
> 
> It's probably worth mentioning that the suspend state in Zynq does not
> power off the CPU cores. It just asserts the resets on secondary cores
> and the primary one waits in wfi.

I think I found the issue. When going into suspend, all device
interrupts get disabled, but timers are kept running until very late.
Then in kernel/power/suspend.c:
 - arch_suspend_disable_irqs() disables interrupts (locally)
 - syscore_suspend is called, which disables timers through
   tick_suspend()

I think what happens is: The interrupts get disabled locally, but the
timers are still running and generating interrupts.
Such an interrupt happens and stays pending since interrupts are already
disabled and no longer handled.
Then, since Zynq does not power off but only goes into wfi, it
immediately resumes due to a pending timer IRQ.

Especially with the TTC this can happen quite often since it is only
16 bit wide. But I also see spurious wakes caused by the twd.

Does that sound like a possible scenario?

	S?ren
