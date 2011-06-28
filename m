From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 28 Jun 2011 16:06:11 +0400
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <20110628103946.GC21898@n2100.arm.linux.org.uk>
References: <20110627125306.GA30646@doriath.ww600.siemens.net>
	<20110627132735.GE16103@n2100.arm.linux.org.uk>
	<4E088DE1.2060809@gmail.com> <4E089AB3.1090801@codesourcery.com>
	<20110628103946.GC21898@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/28/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Mon, Jun 27, 2011 at 10:58:59PM +0800, Yao Qi wrote:
>> On 06/27/2011 10:04 PM, Dmitry Eremin-Solenikov wrote:
>> > Hello,
>> >
>> > On 27.06.2011 17:27, Russell King - ARM Linux wrote:
>> >> We _really_ _do_ want to unwind through this so that we can see the
>> >> parent kernel context information in backtraces - and the fact that
>>
>> I am not sure GDB is able to unwind stacks across processes (from child
>> to parent).
>
> It's not about unwinding across processes.  It's still the same process.
>
> Let me give you a recent example.  This may be using frame pointers rather
> than the unwinder, but serves to illustrate what we - as kernel developers -
> absolutely must have from the kernel:
>
> Internal error: Oops: 17 [#1] PREEMPT
> Modules linked in: uinput g_ether cryptomgr aead arc4 crypto_algapi
> rt2800usb rt2800lib rt2x00usb rt2x00lib mac80211 cfg80211 sg pcmciamtd
> mousedev snd_soc_wm8750 snd_soc_pxa2xx_i2s snd_soc_core ohci_hcd usbcore
> pxa27x_udc physmap snd_pcm_oss snd_pcm snd_timer snd_page_alloc
> snd_mixer_oss snd soundcore rfcomm pxaficp_ir ircomm_tty ircomm irda ipv6
> hidp hid bluetooth rfkill crc16
> CPU: 0    Not tainted  (3.0.0-rc4+ #5)
> PC is at complete+0x28/0x7c
> LR is at complete+0x28/0x7c
> pc : [<c0036b6c>]    lr : [<c0036b6c>]    psr: 80000093
> sp : c3897b68  ip : c3897b68  fp : c3897b84
> r10: c4806000  r9 : c381f3e0  r8 : 0000000a
> r7 : c30f0da8  r6 : 00000000  r5 : 00000000  r4 : a0000013
> r3 : c3896000  r2 : 00000000  r1 : 00000103  r0 : 00000004
> Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0000397f  Table: a080c000  DAC: 00000017
> Process kswapd0 (pid: 270, stack limit = 0xc3896278)
> [<c0036b6c>] (complete+0x28/0x7c) from [<c01e9b0c>] (spi_complete+0x10/0x14)
> [<c01e9b0c>] (spi_complete+0x10/0x14) from [<c01eac2c>]
> (giveback+0x114/0x12c)
> [<c01eac2c>] (giveback+0x114/0x12c) from [<c01eb60c>]
> (pump_transfers+0x13c/0x6f8)
> [<c01eb60c>] (pump_transfers+0x13c/0x6f8) from [<c0044924>]
> (tasklet_action+0x90/0xf0)
> [<c0044924>] (tasklet_action+0x90/0xf0) from [<c0044eb8>]
> (__do_softirq+0x98/0x138)
> [<c0044eb8>] (__do_softirq+0x98/0x138) from [<c00453a0>]
> (irq_exit+0x4c/0xa8)
> [<c00453a0>] (irq_exit+0x4c/0xa8) from [<c002406c>] (asm_do_IRQ+0x6c/0x8c)
> [<c002406c>] (asm_do_IRQ+0x6c/0x8c) from [<c0024b84>] (__irq_svc+0x44/0xcc)
> Exception stack(0xc3897c78 to 0xc3897cc0)
> 7c60:                                                       4022d320
> 4022e000
> 7c80: 08000075 00001000 c32273c0 c03ce1c0 c2b49b78 4022d000 c2b420b4
> 00000001
> 7ca0: 00000000 c3897cfc 00000000 c3897cc0 c00afc54 c002edd8 00000013
> ffffffff
> [<c0024b84>] (__irq_svc+0x44/0xcc) from [<c002edd8>]
> (xscale_flush_user_cache_range+0x18/0x3c)
> [<c002edd8>] (xscale_flush_user_cache_range+0x18/0x3c) from [<c00affd8>]
> (try_to_unmap_file+0x98/0x4ec)
> [<c00affd8>] (try_to_unmap_file+0x98/0x4ec) from [<c00b07ac>]
> (try_to_unmap+0x40/0x60)
> [<c00b07ac>] (try_to_unmap+0x40/0x60) from [<c009b940>]
> (shrink_page_list+0x2a8/0x8cc)
> [<c009b940>] (shrink_page_list+0x2a8/0x8cc) from [<c009c448>]
> (shrink_inactive_list+0x218/0x344)
> [<c009c448>] (shrink_inactive_list+0x218/0x344) from [<c009c8f8>]
> (shrink_zone+0x384/0x4ac)
> [<c009c8f8>] (shrink_zone+0x384/0x4ac) from [<c009ceb0>]
> (kswapd+0x490/0x7d0)
> [<c009ceb0>] (kswapd+0x490/0x7d0) from [<c0059be0>] (kthread+0x90/0x98)
> [<c0059be0>] (kthread+0x90/0x98) from [<c00258d8>]
> (kernel_thread_exit+0x0/0x8)
> Code: e3843080 e121f003 e3a00001 ebfff96a (e5953000)
>
> This shows that we've unwound from 'complete' to '__irq_svc'.  That
> may not be the full story though - the problem may relate to where we
> were when we were interrupted (or indeed took the data or prefetch
> abort).  So the unwinding from __irq_svc right back to kthread is
> just as important.

I did some checks. It seems, the problem isn't related to unwinder. At least
it looks like kernel has all necessary unwinding subops. It looks like the
problem is really related to the lack of necessary .cfi information. At least
when i added .cfi_startproc/.cfi_endproc annotations to entry-armv.S code,
gdb stopped decoding backtrace with the "previous frame identical to this frame"
error. Unfortunately I don't have enough knowledge to add .cfi annotations to
irq handlers.

For the reference I'm providing the patch in the attachment.

Russell, will you agree to merge at least this partial solution, so
that gdb chokes,
but doesn't go to indefinite recursion? If you'd agree, I'll submit it
with proper
headers and sign-off.

-- 
With best wishes
Dmitry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ARM_CFI.patch
Type: text/x-patch
Size: 1980 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110628/61c0ad0d/attachment.bin>
