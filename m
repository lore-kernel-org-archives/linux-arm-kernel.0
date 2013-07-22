From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 22 Jul 2013 09:21:28 +0800
Subject: [PATCH v12 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <201307220315.28821.marex@denx.de>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <201307121518.31501.marex@denx.de>
 <20130716094320.GA29679@nchen-desktop>
 <201307220315.28821.marex@denx.de>
Message-ID: <20130722012127.GA25817@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 03:15:28AM +0200, Marek Vasut wrote:
> Hi Peter,
> 
> > On Fri, Jul 12, 2013 at 03:18:31PM +0200, Marek Vasut wrote:
> > > Hi Peter,
> > > 
> > > > On Fri, Jul 12, 2013 at 06:04:43AM +0200, Marek Vasut wrote:
> > > > > Hi Peter,
> > > > > 
> > > > > > On Thu, Jul 11, 2013 at 07:57:19PM +0200, Marek Vasut wrote:
> > > > > > > Hi Peter,
> > > > > > > 
> > > > > > > > This patchset adds tested otg id switch function and
> > > > > > > > vbus connect and disconnect detection for chipidea driver.
> > > > > > > > And fix kinds of bugs found at chipidea drivers after enabling
> > > > > > > > id and vbus detection.
> > > > > > > > 
> > > > > > > > This patch is fully tested at imx6 sabresd platform.
> > > > > > > > My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
> > > > > > > > 
> > > > > > > > Changes for v12:
> > > > > > > > - Rebased greg's usb-next tree (3.10.0-rc7+)
> > > > > > > > - Split more small patches for single function and fix.
> > > > > > > 
> > > > > > > I tested the patchset. Here are the results:
> > > > > > > 
> > > > > > > - VBUS switching
> > > > > > > 
> > > > > > > I'm no longer getting any ID interrupts at all when I apply the
> > > > > > > patch below. The board stays in HOST mode all the time. If I
> > > > > > > configure it as peripheral, it works as peripheral. Note with
> > > > > > > [1], I was able to switch from Peripheral->Host , not the other
> > > > > > > way around.
> > > > > > 
> > > > > > Thanks for your testing. But first, can you have me check
> > > > > > if your ID wakeup is enabled?
> > > > > 
> > > > > ID wakeup? How do I check?
> > > > 
> > > > See otgsc at controller register, the ID wakeup enable is bit 24.
> > > 
> > > Yes, ID interrupt (IDIE) is set.
> > > 
> > > I noticed this backtrace in the kernel bootlog, but this only happens if
> > > the dr_mode="otg" , it comes from the host-mode irq handler :
> > > 
> > > [    2.757563] irq 238: nobody cared (try booting with the "irqpoll"
> > > option) [    2.764398] CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.0-
> > > next-20130711-00013-g011c4b3-dirty #703
> > > [    2.773445] [<80013878>] (unwind_backtrace+0x0/0xe8) from [<80011644>]
> > > (show_stack+0x10/0x14)
> > > [    2.782027] [<80011644>] (show_stack+0x10/0x14) from [<800659f4>]
> > > (__report_bad_irq.isra.6+0x20/0xe0)
> > > [    2.791286] [<800659f4>] (__report_bad_irq.isra.6+0x20/0xe0) from
> > > [<80065c98>] (note_interrupt+0x16c/0x230)
> > > [    2.801063] [<80065c98>] (note_interrupt+0x16c/0x230) from
> > > [<80064000>] (handle_irq_event_percpu+0x10c/0x1a4)
> > > [    2.811010] [<80064000>] (handle_irq_event_percpu+0x10c/0x1a4) from
> > > [<800640e8>] (handle_irq_event+0x50/0x78)
> > > [    2.820958] [<800640e8>] (handle_irq_event+0x50/0x78) from
> > > [<8006652c>] (handle_level_irq+0x88/0x10c)
> > > [    2.830210] [<8006652c>] (handle_level_irq+0x88/0x10c) from
> > > [<800638d0>] (generic_handle_irq+0x28/0x3c)
> > > [    2.839637] [<800638d0>] (generic_handle_irq+0x28/0x3c) from
> > > [<8000f84c>] (handle_IRQ+0x30/0x84)
> > > [    2.848461] [<8000f84c>] (handle_IRQ+0x30/0x84) from [<80012160>]
> > > (__irq_svc+0x40/0x6c)
> > > [    2.856510] [<80012160>] (__irq_svc+0x40/0x6c) from [<80022a44>]
> > > (__do_softirq+0x90/0x1d8)
> > > [    2.864812] [<80022a44>] (__do_softirq+0x90/0x1d8) from [<80022edc>]
> > > (irq_exit+0x98/0xd4)
> > > [    2.873025] [<80022edc>] (irq_exit+0x98/0xd4) from [<8000f850>]
> > > (handle_IRQ+0x34/0x84)
> > > [    2.880980] [<8000f850>] (handle_IRQ+0x34/0x84) from [<80012160>]
> > > (__irq_svc+0x40/0x6c)
> > > [    2.889020] [<80012160>] (__irq_svc+0x40/0x6c) from [<8001d724>]
> > > (vprintk_emit+0x1bc/0x524)
> > > [    2.897411] [<8001d724>] (vprintk_emit+0x1bc/0x524) from [<804da5a4>]
> > > (printk+0x30/0x40)
> > > [    2.905551] [<804da5a4>] (printk+0x30/0x40) from [<80630138>]
> > > (mousedev_init+0x4c/0x60)
> > > [    2.913617] [<80630138>] (mousedev_init+0x4c/0x60) from [<806178fc>]
> > > (do_one_initcall+0x94/0x14c)
> > > [    2.922537] [<806178fc>] (do_one_initcall+0x94/0x14c) from
> > > [<80617b20>] (kernel_init_freeable+0x16c/0x22c)
> > > [    2.932230] [<80617b20>] (kernel_init_freeable+0x16c/0x22c) from
> > > [<804d8cbc>] (kernel_init+0x8/0x150)
> > > [    2.941486] [<804d8cbc>] (kernel_init+0x8/0x150) from [<8000ea70>]
> > > (ret_from_fork+0x14/0x24)
> > > [    2.949932] handlers:
> > > [    2.952227] [<8033fc58>] ci_irq
> > > [    2.955388] Disabling IRQ #238
> > 
> > Marek, I have a test at imx28evk (Freescale imx28evk) for this patchset,
> > it works well for dual-role switch after adding below dts change.
> > There is a kernel dump when works at udc mode(due to enable
> > CONFIG_LOCKUP_DETECTOR), at the first connect, but it does not affect
> > function, it should be a common chipidea problem, I will check later.
> 
> Sorry for the long delay. I finally got further with this, at least now I can 
> switch Periph->Host again, but if I do so the other way around (unplug host 
> adapter and plug computer cable) and dump the controller registers, I still see 
> the controller in "host" (according to USBMODE register) mode. The controller 
> stays in HOST mode even if I force it to gadget mode by writing "gadget" into 
> debugfs "role" entry. I will keep poking.
> 
> In the meantime, I guess if it works on the EVK, it might be a hardware error so 
> I better stop stalling you. I'll drop you an email if I find what this problem 
> is.
> 

No, the problem is you did not config the USB OTG ID pin.
Do the same thing I have done at imx28evk, you probably will work
if the ID pin is the same at your board.

If it works, please give a tested-by :).

-- 

Best Regards,
Peter Chen
