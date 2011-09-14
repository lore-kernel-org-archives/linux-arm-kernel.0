From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Sep 2011 11:09:31 +0100
Subject: [ltt-dev] LTTng 2.0 on ARM
In-Reply-To: <CAH+eYFDrCav6sVzmapfN3YL8omYKc2NHorHuHMXh49dBbzw1Xg@mail.gmail.com>
References: <4E68559A.8080204@linaro.org>
	<BLU0-SMTP86E263003FB9999131E2A196000@phx.gbl>
	<4E6E4250.2000309@linaro.org>
	<BLU0-SMTP6FB53F86865C7F0175B0D96020@phx.gbl>
	<4E6F3B93.5050603@linaro.org>
	<BLU0-SMTP720ADD6D0D065018E5C97196050@phx.gbl>
	<CAH+eYFDrCav6sVzmapfN3YL8omYKc2NHorHuHMXh49dBbzw1Xg@mail.gmail.com>
Message-ID: <20110914100931.GB2104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 11:14:47PM +0530, Rabin Vincent wrote:
> On Tue, Sep 13, 2011 at 21:20, Mathieu Desnoyers
> <compudj@krystal.dyndns.org> wrote:
> > * Avik Sil (avik.sil at linaro.org) wrote:
> >> On Tuesday 13 September 2011 12:35 AM, Mathieu Desnoyers wrote:
> >> > * Avik Sil (avik.sil at linaro.org) wrote:
> >> >> [ 1139.173522] vmalloc_sync_all_sym: c00a1d14
> >> >> [ 1139.180877] Internal error: Oops - undefined instruction: 0 [#1]
> >> >> PREEMPT SMP
> >> >> [ 1139.191284] Modules linked in: lttng_ftrace(+)
> >> >> [ 1139.198974] CPU: 1 ? ?Not tainted ?(3.0.0-1004-linaro-omap #6)
> >> >> [ 1139.208099] PC is at vmalloc_sync_all+0x0/0x8
> >> >> [ 1139.215667] LR is at init_module+0x1c/0x28 [lttng_ftrace]
> >> >> [ 1139.224304] pc : [<c00a1d14>] ? ?lr : [<bf800211>] ? ?psr: 60000113
> >> >> [ 1139.224304] sp : ebb11f50 ?ip : 00000000 ?fp : 00000000
> >> >> [ 1139.242401] r10: 00000000 ?r9 : 00000000 ?r8 : c06a2f00
> >> >> [ 1139.250793] r7 : bf8001f5 ?r6 : 00000000 ?r5 : 00182008 ?r4 : c00a1d14
> >> >> [ 1139.260559] r3 : 271aed1f ?r2 : ebb11f44 ?r1 : bf8003a6 ?r0 : 00000034
> >> >> [ 1139.270233] Flags: nZCv ?IRQs on ?FIQs on ?Mode SVC_32 ?ISA ARM
> [...]
> >> Disassembly of section .text:
> >>
> >> c00a1d14 <vmalloc_sync_all>:
> >> c00a1d14: ? ? b500 ? ? ? ? ? ?push ? ?{lr}
> >> c00a1d16: ? ? f76a fa9d ? ? ? bl ? ? ?c000c254 <__gnu_mcount_nc>
> >> c00a1d1a: ? ? 4770 ? ? ? ? ? ?bx ? ? ?lr
> >>
> [...]
> >> >
> >> > We have to keep in mind that this could also be a ftrace function tracer
> >> > bug, in which case the surrounding of 0xc00a1d14 from the vmlinux image
> >> > will not match the instructions in memory. Can you dump the hex content
> >> > around 0xc00a1d14 just before the vmalloc_sync_all gets called and
> >> > compare with the disassembly ?
> >>
> >> The hex content dump shows:
> >>
> >> [ ?150.810119] c00a1d14: b500 f85d eb04 4770
> >>
> >> So it seems your guess is right, the content of vmlinux image
> >> surrounding 0xc00a1d14 is not matching the instruction in memory. By
> >> grepping objdump I found that instruction 'f85d eb04' translates to
> >> "ldr.w ? ? ? ?lr, [sp], #4".
> >
> > I'm adding the ARM function tracer developers in CC. Maybe they can
> > enlighten us.
> 
> ftrace has indeed overwritten the instructions here, but it's done it
> correctly.  The problem here is that you're trying to execute a Thumb-2
> function in ARM mode.  This is unrelated to ftrace, I've reproduced it
> here with a Thumb-2 kernel without ftrace enabled with just this code:
> 
> static int __init late(void)
> {
> 	void (*v)(void);
> 
> 	v = (void *) kallsyms_lookup_name("vmalloc_sync_all");
> 	printk("%s addr %p\n", __func__, v);
> 	
> 	v();
> 
> 	return 0;
> }
> late_initcall(late);
> 
> which leads to this:
> 
>   late addr c010ed7c
>   Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
>   CPU: 0    Not tainted  (3.1.0-rc2+ #339)
>   PC is at late+0x4/0x28
>   LR is at late+0x17/0x28
>   pc : [<c010ed80>]    lr : [<c010ed93>]    psr: 40000013
>   sp : c782dfb0  ip : 00000000  fp : 00000000
>   r10: 00000000  r9 : 00000000  r8 : 00000000
>   r7 : 00000033  r6 : 00000000  r5 : c010ed7d  r4 : c010ed7c
>   r3 : c010ed7c  r2 : c782dfa4  r1 : c00f0963  r0 : 00000025
>   Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>   Control: 50c53c7d  Table: 0000406a  DAC: 00000015
>   Process swapper (pid: 1, stack limit = 0xc782c2f0)
>   Stack: (0xc782dfb0 to 0xc782e000)
>   dfa0:                                     c011ab7c c010b66b 00000000 00000000
>   dfc0: 0000007f c01295ac c000ca81 c011ab7c c011ab94 c000ca81 00000033 00000000
>   dfe0: 00000000 c010b765 00000000 00000000 c010b701 c000ca81 00000000 00000000
>   [<c010ed80>] (late+0x4/0x28) from [<c010b66b>] (do_one_initcall+0x63/0xf8)
>   [<c010b66b>] (do_one_initcall+0x63/0xf8) from [<c010b765>]
> (kernel_init+0x65/0xd8)
>   [<c010b765>] (kernel_init+0x65/0xd8) from [<c000ca81>]
> (kernel_thread_exit+0x1/0x6)
>   Code: c0125e20 c01307ac 47702000 4806b510 (f81ef727)
> 
> The problem is that the addresses returned by kallsyms_lookup_name()
> does not have the zero bit, which is what is expected for Thumb
> functions because the BLX instruction which is used to call them uses
> this bit to determines which mode to switch into.  Since it's cleared,
> you switch to ARM mode and attempt to execute Thumb-2 code, with obvious
> results.
> 
> A cursory look at the parties involved shows that nm doesn't show the
> zero bit (even though it's set in the vmlinux symbol table), and
> scripts/kallsyms builds the table by parsing nm's output.

It's not quite as simple as saying "the output of nm is wrong" though...

When getting the address of a function, there are actually two
separate answers:

 a) the pointer which can be used to call the function

 b) the address of the start of the function body

On many arches these they are identical, but on some they are different.
On ARM, they are identical for ARM code but different for Thumb code
(because the Thumb bit must be set in case (a) but not in case (b))

It may be worth looking at what is done in the kernel for ia64 and ppc64.
I believe that (a) and (b) are quite different for these because
functions are called through descriptors.  Don't quote me on that though:
I'm mostly ignorant about these arches.

For the Thumb-2 kernel case, we can probably hack around this: there
are various places in the kernel where we just force-set the Thumb bit
in addresses without really knowing what the target code is.  We get
away with this because the kernel is (very nearly) 100% Thumb code
for a Thumb-2 kernel.

However, if the kernel already has a correct approach for solving this
problem, we should probably be using it.

Cheers
---Dave
