From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jan 2011 09:07:09 +0000
Subject: Warning from might_sleep() in SWI handler
In-Reply-To: <AANLkTi=gakqH9i5m6CjKd__LHSZwFoaEOLAim0Wsehk2@mail.gmail.com>
References: <AANLkTi=gakqH9i5m6CjKd__LHSZwFoaEOLAim0Wsehk2@mail.gmail.com>
Message-ID: <20110113090709.GA24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 02:34:39PM +0800, TAO HU wrote:
> <3>[35403.916595] BUG: sleeping function called from invalid context
> at /Volumes/data/hudson/workspace/integrated_device-cdma-solana-eng_main-dev_linux_continuous/platform/kernel/omap4/arch/arm/mm/fault.c:295
> <3>[35403.935455] in_atomic(): 0, irqs_disabled(): 128, pid: 25390,
> name: Thread-9
> <4>[35403.942901] [<c004b7a0>] (unwind_backtrace+0x0/0xf0) from
> [<c007eb24>] (__might_sleep+0x11c/0x148)
> <4>[35403.952301] [<c007eb24>] (__might_sleep+0x11c/0x148) from
> [<c004eccc>] (do_page_fault+0xa8/0x2e8)
> <4>[35403.961608] [<c004eccc>] (do_page_fault+0xa8/0x2e8) from
> [<c0044488>] (do_DataAbort+0x34/0xa8)
> <4>[35403.970642] [<c0044488>] (do_DataAbort+0x34/0xa8) from
> [<c0044bec>] (__dabt_svc+0x4c/0x60)
> <4>[35403.979309] Exception stack(0xd1b79f68 to 0xd1b79fb0)
> <4>[35403.984588] 9f60:?????????????????? 4624d868 00020241 00000180
> 4847ba4c 00000241 00228e58
> <4>[35403.993164] 9f80: 00000180 00000005 20000010 43c66d8c 43c66d74
> 46251a60 ad12e228 d1b79fb0
> <4>[35404.001739] 9fa0: afd0da0c c0045228 60000093 ffffffff
> <4>[35404.007019] [<c0044bec>] (__dabt_svc+0x4c/0x60) from
> [<c0045228>] (vector_swi+0x28/0x88)

It would be nice if the trace continued beyond this point.

It looks like userspace tried to execute an instruction at 0xafd0da0c,
and it was available to the instruction stream (which knew it as a SWI
instruction) but not the data stream.

I guess we have a race in the swap-out code on SMP:

	CPU0		CPU1
	clears pte
			executes instruction from page,
			already has I-TLB but no D-TLB entry,
			takes SWI exception
			tries to load instruction, data abort
	tlb flush

This isn't trivial to resolve...  In the meantime, the workaround is to
disable OABI compatibility.
