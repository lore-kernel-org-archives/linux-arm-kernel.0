From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 1 Apr 2014 10:41:10 -0600
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
References: <CAFJTrDt7OrtE4B52419F2KGbmXeLR9NEcgF6yMTMUBe5vdKwfg@mail.gmail.com>
 <20140326180634.4ac266b2@skate>
 <20140326171828.GA31887@obsidianresearch.com>
 <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
Message-ID: <20140401164110.GA26093@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 03:17:24PM +0100, Matthew Minter wrote:
> Just to give an update of what I have tried. I noticed that there was
> a PCI quirk available for a similar PLX chip which forced the kernel
> to see the slots as hot-plug slots (unfortunately some PLX chips
> falsely report themselves to be non hotplug capable bridges from my
> understanding). I tried extending this quirk to run on my chip also.
> This significantly changed the results in that along with the use of
> pci=hpmemsize=xM I managed to force the chip to pre-allocate some
> memory for the hotplug slot. Specifically I added this line:
> DECLARE_PCI_FIXUP_HEADER(0x10b5, 0x8617, quirk_hotplug_bridge);
> to linux-3.14-rc7/drivers/pci/quirks.c

This all sounds right to me, it is probably the proper approach,
things could be refined a bit by adding a DT property to indicate hot
plug, but that won't help your oops.

The oops kinda looks like something went wrong during a PCI memory
read.

> Internal error: : 1008 [#1] PREEMPT SMP ARM

Which is a call to die, but the string that should tell us where is ""
There are cases like that in the kernel, but all are prefixed by
another line - did a line go missing (Unhandled Fault perhaps?)

First guess would be something went wrong when the mbus windows were
created after the rescan. Some debugging prints from that part of the
flow might be informative, as well as a dump from the mbus debugfs..

Second guess, something went wrong during the hot plug, and the PLX is
not forwarding TLPs.. lpsci -v might give a clue.

> I am currently working on a way to modify the scan order as Jason as
> suggested, as soon as I have worked out exactly how the scan order is
> determined I will try modifying the DT or any code needed to force the
> port with the PLX chip to be scanned last. However I first need to
> read some more of the code to understand what it orders on, eg: order
> in DT, bus number, memory address.

That suggestion was a hack, you have found the 'proper' way to do hot
plug. If you can resolve this oops you should be golden :)

Jason
