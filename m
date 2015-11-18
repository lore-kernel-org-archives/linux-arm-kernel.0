From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Nov 2015 16:29:32 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <564CA29A.9050905@arm.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
Message-ID: <20151118162932.GA13355@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 10:08:58AM -0600, Jeremy Linton wrote:
> On 11/18/2015 09:20 AM, Mark Rutland wrote:
> >Hi Jeremy,
> >
> >On Wed, Nov 18, 2015 at 09:03:19AM -0600, Jeremy Linton wrote:
> >>The HP m400 fails to boot the linux 4.4rc1 kernel.
> >
> >Are you using defconfig? If not, can you share your config?
> 	No, its not defconfig, its roughly the RHELSA config tossed into a
> mainline 4.4 tree and all the default options selected. AFAIK RHELSA
> is still limited access.

That renders this extremely difficult for anyone else to reproduce...

> >>It usually hangs or sometimes takes an unhanded exception around the
> >>DMA zone messages. This was bisected to the new CONT PTE changes.
> >
> >Do you have any examples of the unhandled exception cases? Are they a
> >mixed bag, or a consistent exception class?
> 
> I'm guessing about 90% of the time its a dead hang, the remaining
> are the faults of which there is one that happens more frequently
> than the others. Here is one i found in my notes..

Ok. In future please provide a sample with any bug report.

> [    0.000000] On node 0 totalpages: 1048512
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 65472 pages, LIFO batch:1
> [    0.000000] Unhandled fault: unknown 48 (0x96000070) at
> 0xfffffe0000d60588

>From a quick grep that's from do_mem_abort, where the "unknown 48" is
the DFSC, the bit in brackets is the ESR, and the address is the
faulting address from FAR_EL1.

That 48 / 0b110000 for the DFSC decodes as "TLB conflict abort" per the
ARM ARM. Other than that, the WnR bit is set in the ISS.

So this is probably a break-before-make issue.

Can you figure out where 0xfffffe0000d60588 pointed to, and where in the
kernel the access was performed? It would be nice to know if this is
consistently happening at some edge of the kernel address space.

FWIW, Will had a patch [1] for detecting PTE level break-before-make
violations. I gave this a go on Juno with v4.4-rc1, and saw an issue in
the EFI virtmap code that I'm currently investigating.

> >>Adding an extra flush_tlb_all() in the code path which is
> >>changing the kernel permissions allows the machine to boot
> >>consistently.
> >
> >As you mention changing permissions, I take it you're using
> >CONFIG_DEBUG_RODATA?
> 
> The failing configuration doesn't have DEBUG_RODATA set, I might
> have been pretty loose with my terminology.

Ok, good to know.

> Frankly, I wondered originally how config RODATA was working
> reliably because the flushes were only around the directories
> getting split, fixup_init() (and basically anything calling
> create_mapping_late()) looked like there were paths that could avoid
> flushing. When I added the CONT changes I didn't add flushes to
> paths that didn't previously have them (except in the split cont
> range case, which matched the spit p[mu]d case). I made the mistake
> of assuming someone knew about some edge case that avoided the need
> for the flush.

I'll need to page the code back into my head, but I recall I had
concerns about break-before-make, so there's some auditing to be done.

> Once I find/fix the console issue on that machine with 4.4rc1 (there
> are a small handful of issues that keep mainline from working on it,
> including the sata patch that was posted, and rejected), I will
> focus on hoisting the tlb flush into create_mapping_late() and
> removing the splattering of flushes in those code paths. That is
> unless there is a reason to be preforming them as soon as the
> directories are split.

We need to figure out exactly what maintenance we actually need.

Hoisting the TLB flush isn't necessarily possible if we need to perform
break-before-make at the PTE level, and even that may not be possible
for the kernel page tables; we might need to do something more
drastic like using ASIDs and double-buffering them...

We also need to figure out what's happening with the code as it is.

Thanks,
Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=aarch64/devel&id=372f39220ad35fa39a75419f2221ffeb6ffd78d3
