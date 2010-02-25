From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 12:56:11 +0000
Subject: ARM 2.6.30.9 OOPS question -- stack limit?
In-Reply-To: <D27CA15508148C428A25104ADEFAAC81057281E1@CORPUSMX50C.corp.emc.com>
References: <D27CA15508148C428A25104ADEFAAC81057281E1@CORPUSMX50C.corp.emc.com>
Message-ID: <20100225125611.GB3101@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 07:34:34AM -0500, Foster_Brian at emc.com wrote:
> In short, I'm curious about the state of the stack as shown in the OOPS.
> I'm suspicious that excessively large stacks in this app could be
> causing a problem, but the OOPS is not clear enough to me to indicate
> whether that is the case here (a HUGE stack dump is printed between the
> Stack: and Code: lines).

I don't think it's overflowed.  Please try to ensure that dumps
are formatted as they came out of the kernel - this one is horribly
line wrapped - so I've undone that to read it.

> Unable to handle kernel paging request at virtual address 000b9a34
> pgd = cb2e8000 [000b9a34]
> *pgd=0f021031, *pte=055de34f, *ppte=055deaae
> Internal error: Oops: 81f
> [#1] PREEMPT Modules linked in: sr_mod cdrom usblp usbhid rt3090sta(P)
> msdos udf crc_itu_t isofs ufsd(P)
> CPU: 0    Tainted: P        W   (2.6.30.9 #1)
> PC is at 0x40a95d60
> LR is at 0x40a95d5c
> pc : [<40a95d60>]    lr : [<40a95d5c>]    psr: 80000010
> sp : bec6a388  ip : 40aa216c  fp : 40aa21b0
> r10: 40aa2000  r9 : 000001b4  r8 : 000b9a34
> r7 : 000b9a34  r6 : bec6a5c8  r5 : 00000000  r4 : 00000000
> r3 : 00000000  r2 : 00000002  r1 : 00000081  r0 : 00000000
> Flags: Nzcv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user
> Control: 0005397f  Table: 0b2e8000  DAC: 00000015
> Process appweb (pid: 26569, stack limit = 0xcb206268)
> Stack: (0xbec6a388 to 0xcb208000)

Hmm, we really shouldn't be dumping this much stack.

In any case:
1. PC is in userspace, not kernel.
2. PSR is telling us we were in 'user_32' mode.
3. SP is a userspace pointer
4. Error code 81f (FSR value) tells us that it was a page permission
   fault (0x00f) in domain 1 (0x010) due to a write (0x800).

Now, this style of message is produced by __do_kernel_fault(), which is
called when:

1. we receive a page fault while in an atomic context
2. we receive a page fault when there is no mm_struct for the thread
3. not in user_32 mode and we have no exception fixup handler for the
   faulting instruction
4. not in user_32 mode and we have no mapping information for the address
   being accessed (iow, address being accessed wasn't mmap'd or part of
   the application bss)

(3) and (4) don't apply because you are in user_32 mode.  (2) is
highly unlikely, so that leaves (1) - I suspect the futex code is
issuing this WARN_ON() and then returning to userspace leaving the
kernel in an atomic state - and the next page fault causes this oops.

I don't have 2.6.30.9 sources to hand to see what the futex code is
doing around line 1003 to know what it's complaining about...
