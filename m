From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 18 Nov 2015 10:08:58 -0600
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151118152044.GD10644@leverpostej>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej>
Message-ID: <564CA29A.9050905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 09:20 AM, Mark Rutland wrote:
> Hi Jeremy,
>
> On Wed, Nov 18, 2015 at 09:03:19AM -0600, Jeremy Linton wrote:
>> The HP m400 fails to boot the linux 4.4rc1 kernel.
>
> Are you using defconfig? If not, can you share your config?
	No, its not defconfig, its roughly the RHELSA config tossed into a 
mainline 4.4 tree and all the default options selected. AFAIK RHELSA is 
still limited access.

>
>> It usually hangs or sometimes takes an unhanded exception around the
>> DMA zone messages. This was bisected to the new CONT PTE changes.
>
> Do you have any examples of the unhandled exception cases? Are they a
> mixed bag, or a consistent exception class?

I'm guessing about 90% of the time its a dead hang, the remaining are 
the faults of which there is one that happens more frequently than the 
others. Here is one i found in my notes..

[    0.000000] On node 0 totalpages: 1048512
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 65472 pages, LIFO batch:1
[    0.000000] Unhandled fault: unknown 48 (0x96000070) at 
0xfffffe0000d60588

>> Adding an extra flush_tlb_all() in the code path which is
>> changing the kernel permissions allows the machine to boot
>> consistently.
>
> As you mention changing permissions, I take it you're using
> CONFIG_DEBUG_RODATA?

The failing configuration doesn't have DEBUG_RODATA set, I might have 
been pretty loose with my terminology.

Frankly, I wondered originally how config RODATA was working reliably 
because the flushes were only around the directories getting split, 
fixup_init() (and basically anything calling create_mapping_late()) 
looked like there were paths that could avoid flushing. When I added the 
CONT changes I didn't add flushes to paths that didn't previously have 
them (except in the split cont range case, which matched the spit p[mu]d 
case). I made the mistake of assuming someone knew about some edge case 
that avoided the need for the flush.

Once I find/fix the console issue on that machine with 4.4rc1 (there are 
a small handful of issues that keep mainline from working on it, 
including the sata patch that was posted, and rejected), I will focus on 
hoisting the tlb flush into create_mapping_late() and removing the 
splattering of flushes in those code paths. That is unless there is a 
reason to be preforming them as soon as the directories are split.
