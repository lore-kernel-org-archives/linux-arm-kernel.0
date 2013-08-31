From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Aug 2013 21:06:49 +0100
Subject: Undefined instruction (ldrshtgt?) on mirabox with 3.11-rc7
In-Reply-To: <52221A70.5060707@leahnim.org>
References: <52221A70.5060707@leahnim.org>
Message-ID: <20130831200649.GJ6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 12:31:44PM -0400, Jochen De Smet wrote:
> [54580.136437] CPU: 0 PID: 0 Comm: swapper Not tainted 3.11.0-rc7-stock2 #30
> [54580.143239] task: c03f9540 ti: c03ee000 task.ti: c03ee000
> [54580.148658] PC is at quirk_usb_early_handoff+0x7d0/0x7f4
> [54580.153983] LR is at start_unlink_async+0x20/0x2c
> [54580.158697] pc : [<c020837c>]    lr : [<c020c014>] psr: 00000193
> [54580.158697] sp : c03efd98  ip : ef2735d0  fp : c03efda4
> [54580.170194] r10: 60000193  r9 : 00000006  r8 : c03013ec
> [54580.175427] r7 : 000031ac  r6 : d77d6a38  r5 : 00000001  r4 : 00000ef4
> [54580.181965] r3 : ee817c00  r2 : ef2de8c0  r1 : ee804600  r0 : ef273500
> [54580.188504] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  
>...
> [54580.576967] Code: eaffffcc c03f6040 c0406068 c0394a20 (c03949f0)
> [54580.583077] ---[ end trace 7ff80fa55787f992 ]---
> [54580.587702] Kernel panic - not syncing: Fatal exception in interrupt
>
>
> Didn't have debug symbols enabled (compiling with them now), but both  
> decodecode and gdb seem to track the problem here:
>
> All code
> ========
>    0:   eaffffcc        b       0xffffff38
>    4:   c03f6040        eorsgt  r6, pc, r0, asr #32
>    8:   c0406068        subgt   r6, r0, r8, rrx
>    c:   c0394a20        eorsgt  r4, r9, r0, lsr #20
>   10:*  c03949f0        ldrshtgt        r4, [r9], -r0 <-- trapping  
> instruction

Thanks for disassembling the Code: line, and providing the code below.

> from gdb with a bit more context:
>
>    0xc020836c <+1984>:  b       0xc02082a4 <quirk_usb_early_handoff+1784>
>    0xc0208370 <+1988>:  eorsgt  r6, pc, r0, asr #32
>    0xc0208374 <+1992>:  subgt   r6, r0, r8, rrx
>    0xc0208378 <+1996>:  eorsgt  r4, r9, r0, lsr #20
>    0xc020837c <+2000>:  ldrshtgt        r4, [r9], -r0
>    0xc0208380 <+2004>:  eorsgt  r4, r9, r4, asr #20
>    0xc0208384 <+2008>:  eorsgt  r4, r9, r0, asr #21
>    0xc0208388 <+2012>:  eorsgt  sp, r7, r12, lsl #4
>    0xc020838c <+2016>:  mlasgt  r9, r4, r10, r4
>    0xc0208390 <+2020>:  eorsgt  r4, r9, r8, ror #20
>    0xc0208394 <+2024>:  eorsgt  r4, r9, r4, lsl #22
>    0xc0208398 <+2028>:  eorsgt  r4, r9, r12, lsr r11
>    0xc020839c <+2032>:  ldrsbtgt        r4, [r9], -r8

This doesn't look like valid ARM code (it doesn't make sense).  Instead,
what it looks like is a literal pool placed after the function (which is
something GCC does all the time.)

The question is - how did you end up trying to execute a literal pool.

Well, if we assume that the link register is intact, we would return to:

	start_unlink_async+0x20 (0xc020c014)

so presumably the instruction at the previous address is the one which
called this (I'm assuming no tail-call optimisation.)

Well, just to be confusing, the kernel has three functions called
"start_unlink_async".  One of them is quite a big function, so is unlikely
to be 0x2c bytes in size, so the two candidates are:

static void start_unlink_async(struct ehci_hcd *ehci, struct ehci_qh *qh)
{
        /* If the QH isn't linked then there's nothing we can do. */
        if (qh->qh_state != QH_STATE_LINKED)
                return;

        single_unlink_async(ehci, qh);
        start_iaa_cycle(ehci);
}

static void start_unlink_async(struct fusbh200_hcd *fusbh200, struct fusbh200_qh *qh)
{
        /*
         * If the QH isn't linked then there's nothing we can do
         * unless we were called during a giveback, in which case
         * qh_completions() has to deal with it.
         */
        if (qh->qh_state != QH_STATE_LINKED) {
                if (qh->qh_state == QH_STATE_COMPLETING)
                        qh->needs_rescan = 1;
                return;
        }

        single_unlink_async(fusbh200, qh);
        start_iaa_cycle(fusbh200, false);
}

Neither call quirk_usb_early_handoff().  I'm going to assume that it's
the EHCI one.

The backtrace (and stack) gives us another clue:

> [54580.378225] [<c0208740>] (single_unlink_async+0x0/0x74) from [<c020c014>] (start_unlink_async+0x20/0x2c)
> [54580.387726] [<c020bff4>] (start_unlink_async+0x0/0x2c) from [<c020c0e0>] (unlink_empty_async+0xc0/0xcc)

So the unwinder thinks we entered single_unlink_async().  Given the LR
value, I think that's reasonable (it would be useful to have the complete
disassembly of start_unlink_async() to confirm).

static void single_unlink_async(struct ehci_hcd *ehci, struct ehci_qh *qh)
{
        struct ehci_qh          *prev;

        /* Add to the end of the list of QHs waiting for the next IAAD */
        qh->qh_state = QH_STATE_UNLINK_WAIT;
        list_add_tail(&qh->unlink_node, &ehci->async_unlink);

        /* Unlink it from the schedule */
        prev = ehci->async;
        while (prev->qh_next.qh != qh)
                prev = prev->qh_next.qh;

        prev->hw->hw_next = qh->hw->hw_next;
        prev->qh_next = qh->qh_next;
        if (ehci->qh_scan_next == qh)
                ehci->qh_scan_next = qh->qh_next.qh;
}

Nothing in there does an indirect function call (or any function call).
Again, having the disassembly to that function may be useful.  Also
knowing how much RAM you have in lowmem too, so we know the possible
range of valid kernel addresses.

> The oops is relatively sporadic, perhaps 1-3 times a day.

Is it always the same oops?
