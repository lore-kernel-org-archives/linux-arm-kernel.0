From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Mar 2016 17:59:40 +0100
Subject: Bad mode in undefined instruction handler detected
In-Reply-To: <CAF_dkJBa3Y1EZGduZyjWqV3p5s7zf+Y4ppdeKW8anhd5nkjOPg@mail.gmail.com>
References: <CAF_dkJBa3Y1EZGduZyjWqV3p5s7zf+Y4ppdeKW8anhd5nkjOPg@mail.gmail.com>
Message-ID: <20160329165940.GA19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 10:55:07AM -0400, Patrick Doyle wrote:
> Hello folks...
> I am looking for a clue as to how I might debug the following kernel oops:

I'm not sure even I can help on this one, it looks extremely weird.

> Bad mode in undefined instruction handler detected
> Internal error: Oops - bad mode: 0 [#1] ARM
> Modules linked in: usb_f_eem g_ether u_ether libcomposite atmel_usba_udc
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.1.0-linux4sam_5.1 #4
> Hardware name: Atmel SAMA5
> task: c11440b8 ti: c1140000 task.ti: c1140000
> PC is at _einittext+0x3f9456e8/0xfffdb400
> LR is at 0xc0c565c8
> pc : [<ffff0024>]    lr : [<c0c565c8>]    psr: 600e0192
> sp : c1141f30  ip : 00000019  fp : c11420d0
> r10: c1147548  r9 : 00000132  r8 : b0a5c253
> r7 : 00000132  r6 : b0a5bacb  r5 : 00000000  r4 : c1162d10
> r3 : 00000132  r2 : b0a5c253  r1 : fffffff9  r0 : c1141f78
> Flags: nZCv  IRQs off  FIQs on  Mode IRQ_32  ISA ARM  Segment kernel

So what this is saying is that we entered the undefined instruction
handler due to the instruction at PC=0xffff0024 with PSR=0x600e0192,
where the PSR value indicates that we were in 32-bit IRQ mode.

Entering the undefined instruction handler from PC=0xffff0024 is
intentional, since we fill the vectors page with a code which is
guaranteed to cause an undefined instruction exception (0xe7fddef1).

The problem is two fold:

(a) how did we end up executing code at 0xffff0024?
(b) how did we execute this code while in IRQ mode?

> Control: 10c53c7d  Table: 24804059  DAC: 00000015
> Process swapper (pid: 0, stack limit = 0xc1140208)
> Stack: (0xc1141f30 to 0xc1142000)
> 1f20:                                     c1141f78 fffffff9 b0a5c253 00000132
> 1f40: c1162d10 00000000 b0a5bacb 00000132 b0a5c253 00000132 c1147548 c11420d0
> 1f60: 00000019 c1141f30 c0c565c8 ffff0024 600e0192 ffffffff

These stacked values are the register state printed out above, so we can
ignore these (this gets printed because we're unable to properly save
the SVC stack pointer, which is why these exceptions are fatal.)

> 1f60:                                                       b0a5c253 00000132
> 1f80: 00000001 c1140000 c11420c8 c1162d10 c11631c4 00000001 c1162d08 c1147548
> 1fa0: c11420d0 c003c9f0 00000000 c116d57b 00000000 c1142000 00000000 c0686c34
> 1fc0: ffffffff ffffffff c0686680 00000000 00000000 c06ad280 c116db14 c1142078
> 1fe0: c06ad27c c114518c 20004059 410fc051 00000000 20008078 00000000 00000000

This is the stack state for the parent context, and since we don't have
a backtrace (due to no frame pointer) this becomes guess work - frankly
I'm not going to waste my time guessing, and at this point ask you to
reproduce on a kernel _with_ frame pointers enabled.

You should then get proper stack frames which will take some of the guess
work out of working out what in the above stack dump are addresses and
what isn't.

This is a nice example where _not_ having frame pointers makes things
stupidly difficult to trace - IMHO GCC must _never_ remove support for
frame pointers on ARM for this very reason.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
