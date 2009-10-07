From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2009 14:20:51 +0100
Subject: i.MX31 kernel panic and irq
In-Reply-To: <4ACB659E.3000206@billgatliff.com>
References: <87077C4F48609F4392621D9F99DDE20901202E0E@tesla.star.galaxy.io>
	<4ACB659E.3000206@billgatliff.com>
Message-ID: <20091007132051.GB11371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2009 at 10:43:26AM -0500, Bill Gatliff wrote:
> The OOPS messages suggest that the machine has run off into stuff that  
> isn't code, which would be consistent with the stack pointer getting  
> blown out of the stack memory.

I don't follow your line of reasoning.  The oops dump was:

Unable to handle kernel paging request at virtual address 60000013
pgd = c0004000
[60000013] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in: test_drv
CPU: 0    Tainted: G        W   (2.6.31-mx31-spi #29)
PC is at cpu_idle+0x28/0x88
LR is at cpu_idle+0x74/0x88
pc : [<c00281e4>]    lr : [<c0028230>]    psr: 40000093
sp : c0339fc8  ip : 80000093  fp : 00000000
r10: 80020a40  r9 : 4107b364  r8 : 80020a74
r7 : c033c360  r6 : c033c36c  r5 : 60000013  r4 : c0028308
r3 : f1080080  r2 : 00000002  r1 : c03599ac  r0 : 00000009
Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 8fa10000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0338268)
Stack: (0xc0339fc8 to 0xc033a000)
9fc0:                   c037c99c c0357ad0 c0022e10 c00089a8 c0008350 00000000
9fe0: 00000000 c0022e10 00c5387d c0357b40 c0023214 80008034 00000000 00000000
[<c00281e4>] (cpu_idle+0x28/0x88) from [<c00089a8>] (start_kernel+0x1f0/0x2cc)
[<c00089a8>] (start_kernel+0x1f0/0x2cc) from [<80008034>] (0x80008034)
Code: e5943000 e3130002 1a000007 f10c0080 (e5953000)

If we look at this, we can see the following:

1. sp is pointing inside the kernel's direct mapped memory, as it should.
2. it is on an odd-number of pages, which means there's potentially more
   than 4K of space available to the stack.  Plus it's above the stack
   limit.
3. the process name is correct.  This is significant, because it means
   that (sp & ~0x1fff) ends up pointing at a valid thread_info structure,
   which then points at a valid task_struct structure.
4. the stack trace is consistent with pid 0's trace, which is basically
   the kernel boot and idle thread - in other words, it hasn't been
   overwritten by something running down into this page.

To me, it looks like somehow r5 got spuriously corrupted - I think it
should be a pointer to 'hlt_counter', but for some reason it's a PSR
value.

   0:	e5943000 	ldr	r3, [r4]
   4:	e3130002 	tst	r3, #2	; 0x2
   8:	1a000007 	bne	0x2c
   c:	f10c0080 	cpsid	i
  10:	e5953000 	ldr	r3, [r5]

which corresponds to:

                while (!need_resched()) {
                        local_irq_disable();
                        if (hlt_counter) { <== faulting

The question, therefore, is why r5 would be corrupted.
