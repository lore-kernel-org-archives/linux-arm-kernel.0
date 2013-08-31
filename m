From: jochen.armkernel@leahnim.org (Jochen De Smet)
Date: Sat, 31 Aug 2013 19:00:29 -0400
Subject: Undefined instruction (ldrshtgt?) on mirabox with 3.11-rc7
In-Reply-To: <20130831200649.GJ6617@n2100.arm.linux.org.uk>
References: <52221A70.5060707@leahnim.org>
 <20130831200649.GJ6617@n2100.arm.linux.org.uk>
Message-ID: <5222758D.2050306@leahnim.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/31/2013 16:06, Russell King - ARM Linux wrote:
> On Sat, Aug 31, 2013 at 12:31:44PM -0400, Jochen De Smet wrote:
>     0xc0208378 <+1996>:  eorsgt  r4, r9, r0, lsr #20
>     0xc020837c <+2000>:  ldrshtgt        r4, [r9], -r0
>     0xc0208380 <+2004>:  eorsgt  r4, r9, r4, asr #20
>     0xc0208384 <+2008>:  eorsgt  r4, r9, r0, asr #21
>     0xc0208388 <+2012>:  eorsgt  sp, r7, r12, lsl #4
>     0xc020838c <+2016>:  mlasgt  r9, r4, r10, r4
>     0xc0208390 <+2020>:  eorsgt  r4, r9, r8, ror #20
>     0xc0208394 <+2024>:  eorsgt  r4, r9, r4, lsl #22
>     0xc0208398 <+2028>:  eorsgt  r4, r9, r12, lsr r11
>     0xc020839c <+2032>:  ldrsbtgt        r4, [r9], -r8
> This doesn't look like valid ARM code (it doesn't make sense).  Instead,
> what it looks like is a literal pool placed after the function (which is
> something GCC does all the time.)
>
> The question is - how did you end up trying to execute a literal pool.
>
> Well, if we assume that the link register is intact, we would return to:
>
> 	start_unlink_async+0x20 (0xc020c014)
>
> so presumably the instruction at the previous address is the one which
> called this (I'm assuming no tail-call optimisation.)
>
> Well, just to be confusing, the kernel has three functions called
> "start_unlink_async".  One of them is quite a big function, so is unlikely
> to be 0x2c bytes in size, so the two candidates are:
>
> static void start_unlink_async(struct ehci_hcd *ehci, struct ehci_qh *qh)
> {
>          /* If the QH isn't linked then there's nothing we can do. */
>          if (qh->qh_state != QH_STATE_LINKED)
>                  return;
>
>          single_unlink_async(ehci, qh);
>          start_iaa_cycle(ehci);
> }
>
> static void start_unlink_async(struct fusbh200_hcd *fusbh200, struct fusbh200_qh *qh)
> {
>          /*
>           * If the QH isn't linked then there's nothing we can do
>           * unless we were called during a giveback, in which case
>           * qh_completions() has to deal with it.
>           */
>          if (qh->qh_state != QH_STATE_LINKED) {
>                  if (qh->qh_state == QH_STATE_COMPLETING)
>                          qh->needs_rescan = 1;
>                  return;
>          }
>
>          single_unlink_async(fusbh200, qh);
>          start_iaa_cycle(fusbh200, false);
> }
>
> Neither call quirk_usb_early_handoff().  I'm going to assume that it's
> the EHCI one.
Curiously enough, I don't see either one (ehci-q.c or fusbh200-hcd.c) in 
the kernel "make" output.
Ah, ehci-q gets directly included by ehci-hcd.c, which I do see. Don't 
see anything similar for fusbh200
or oxu210hp-hcd.c, so I'm pretty sure the EHCI one is the only one I'm 
compiling and your guess is
right.
> The backtrace (and stack) gives us another clue:
>
>> [54580.378225] [<c0208740>] (single_unlink_async+0x0/0x74) from [<c020c014>] (start_unlink_async+0x20/0x2c)
>> [54580.387726] [<c020bff4>] (start_unlink_async+0x0/0x2c) from [<c020c0e0>] (unlink_empty_async+0xc0/0xcc)
> So the unwinder thinks we entered single_unlink_async().  Given the LR
> value, I think that's reasonable (it would be useful to have the complete
> disassembly of start_unlink_async() to confirm).
(gdb) disassemble /r start_unlink_async
Dump of assembler code for function start_unlink_async:
    0xc020bff4 <+0>:     0d c0 a0 e1     mov     r12, sp
    0xc020bff8 <+4>:     18 d8 2d e9     push    {r3, r4, r11, r12, lr, pc}
    0xc020bffc <+8>:     04 b0 4c e2     sub     r11, r12, #4
    0xc020c000 <+12>:    2c 30 d1 e5     ldrb    r3, [r1, #44]   ; 0x2c
    0xc020c004 <+16>:    00 40 a0 e1     mov     r4, r0
    0xc020c008 <+20>:    01 00 53 e3     cmp     r3, #1
    0xc020c00c <+24>:    18 a8 9d 18     ldmne   sp, {r3, r4, r11, sp, pc}
    0xc020c010 <+28>:    ca f1 ff eb     bl      0xc0208740 
<single_unlink_async>
    0xc020c014 <+32>:    04 00 a0 e1     mov     r0, r4
    0xc020c018 <+36>:    40 ff ff eb     bl      0xc020bd20 
<start_iaa_cycle>
    0xc020c01c <+40>:    18 a8 9d e8     ldm     sp, {r3, r4, r11, sp, pc}
End of assembler dump.

disassemble /m  doesn't seem to work for this; is that normal?   On the 
bright side
the address does match what's in the stacktrace, so it should be the 
right function.
>
> static void single_unlink_async(struct ehci_hcd *ehci, struct ehci_qh *qh)
> {
>          struct ehci_qh          *prev;
>
>          /* Add to the end of the list of QHs waiting for the next IAAD */
>          qh->qh_state = QH_STATE_UNLINK_WAIT;
>          list_add_tail(&qh->unlink_node, &ehci->async_unlink);
>
>          /* Unlink it from the schedule */
>          prev = ehci->async;
>          while (prev->qh_next.qh != qh)
>                  prev = prev->qh_next.qh;
>
>          prev->hw->hw_next = qh->hw->hw_next;
>          prev->qh_next = qh->qh_next;
>          if (ehci->qh_scan_next == qh)
>                  ehci->qh_scan_next = qh->qh_next.qh;
> }
>
> Nothing in there does an indirect function call (or any function call).
> Again, having the disassembly to that function may be useful.  Also
(gdb) disassemble single_unlink_async
Dump of assembler code for function single_unlink_async:
    0xc0208740 <+0>:     mov     r12, sp
    0xc0208744 <+4>:     push    {r11, r12, lr, pc}
    0xc0208748 <+8>:     sub     r11, r12, #4
    0xc020874c <+12>:    mov     r3, #4
    0xc0208750 <+16>:    strb    r3, [r1, #44]   ; 0x2c
    0xc0208754 <+20>:    ldr     r3, [r0, #212]  ; 0xd4
    0xc0208758 <+24>:    add     r2, r1, #32
    0xc020875c <+28>:    add     r12, r0, #208   ; 0xd0
    0xc0208760 <+32>:    str     r2, [r0, #212]  ; 0xd4
    0xc0208764 <+36>:    str     r12, [r1, #32]
    0xc0208768 <+40>:    str     r3, [r1, #36]   ; 0x24
    0xc020876c <+44>:    str     r2, [r3]
    0xc0208770 <+48>:    ldr     r2, [r0, #200]  ; 0xc8
    0xc0208774 <+52>:    b       0xc020877c <single_unlink_async+60>
    0xc0208778 <+56>:    mov     r2, r3
    0xc020877c <+60>:    ldr     r3, [r2, #8]
    0xc0208780 <+64>:    cmp     r3, r1
    0xc0208784 <+68>:    bne     0xc0208778 <single_unlink_async+56>
    0xc0208788 <+72>:    ldr     r12, [r1]
    0xc020878c <+76>:    ldr     r3, [r2]
    0xc0208790 <+80>:    ldr     r12, [r12]
    0xc0208794 <+84>:    str     r12, [r3]
    0xc0208798 <+88>:    ldr     r3, [r1, #8]
    0xc020879c <+92>:    str     r3, [r2, #8]
    0xc02087a0 <+96>:    ldr     r3, [r0, #196]  ; 0xc4
    0xc02087a4 <+100>:   cmp     r3, r1
    0xc02087a8 <+104>:   ldreq   r3, [r1, #8]
    0xc02087ac <+108>:   streq   r3, [r0, #196]  ; 0xc4
    0xc02087b0 <+112>:   ldm     sp, {r11, sp, pc}
End of assembler dump.

> knowing how much RAM you have in lowmem too, so we know the possible
> range of valid kernel addresses.
Sorry, not sure how to get this.  Dumping some of the things that come 
to mind:

$ free
              total       used       free     shared    buffers cached
Mem:       1035324     999140      36184          0       5392 828716
-/+ buffers/cache:     165032     870292
Swap:       499996       1212     498784

]$ cat /proc/meminfo
MemTotal:        1035324 kB
MemFree:           36096 kB
Buffers:            5392 kB
Cached:           828716 kB
SwapCached:           28 kB
Active:           227984 kB
Inactive:         661920 kB
Active(anon):      32972 kB
Inactive(anon):    70092 kB
Active(file):     195012 kB
Inactive(file):   591828 kB
Unevictable:        3688 kB
Mlocked:            3688 kB
HighTotal:        270336 kB
HighFree:           1416 kB
LowTotal:         764988 kB
LowFree:           34680 kB
SwapTotal:        499996 kB
SwapFree:         498784 kB
Dirty:               236 kB
Writeback:             0 kB
AnonPages:         59472 kB
Mapped:            59180 kB
Shmem:             44932 kB
Slab:              55144 kB
SReclaimable:      40732 kB
SUnreclaim:        14412 kB
KernelStack:        1160 kB
PageTables:         2756 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     1017656 kB
Committed_AS:     359744 kB
VmallocTotal:     245760 kB
VmallocUsed:        3764 kB
VmallocChunk:     233092 kB

>
>> The oops is relatively sporadic, perhaps 1-3 times a day.
> Is it always the same oops?
I'm afraid I didn't save a full copy of the previous ones, but as far as 
I remember
yes it's the same backtrace every time.

J.
