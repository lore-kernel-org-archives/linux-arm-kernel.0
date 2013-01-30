From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Jan 2013 17:38:38 +0100
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <201301301617.38883.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301300955.49473.arnd@arndb.de> <20130130124721.0ad0294e@skate>
 <201301301617.38883.arnd@arndb.de>
Message-ID: <20130130173838.76114b4c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 30 Jan 2013 16:17:38 +0000, Arnd Bergmann wrote:

> > However, one major drawback of my RFCv1 version is that since I didn't
> > know how much I/O space and memory space was needed for each PCIe
> > device, I had to oversize the address decoding windows. And also, I had
> > to have a special allocator (certainly simple, but still) to find an
> > available physical address to set up each address decoding window.
> 
> Well, for the I/O space, there is no oversizing because either way you
> end up with exactly 64KB per root port, right?

Correct I/O space is not an issue, of course. Only the memory windows
are an issue (in terms of quantity of address space used).

That said, the PCI-to-PCI bridge solution doesn't solve the fact that
I/O addresses get assigned even though the driver will most likely use
them. This means that one I/O window is consumed for each PCIe
interface, even though it is not being used in practice. And see I have
10 PCIe interfaces in this SoC, and only 20 windows available globally
(not only for PCIe, but also for NAND, NOR, etc.). But for now, I'd
like to leave this potential problem on the side, and get something
working. If it seems useful to remove this problem later, we'll work on
it.

> > Emulating a PCI-to-PCI bridge very nicely allows to re-use the PCI core
> > resource allocation code. I think it's really the main reason for
> > emulated those PCI-to-PCI bridges, rather than willing to comply to
> > some standards.
> > 
> > So what I'm going to do now is rework my patch series by removing the
> > emulated host bridge (which is normally mandatory by PCIe standard, but
> > Linux doesn't need it, so we don't care), but I'll keep the emulated
> > PCI-to-PCI bridges in order to benefit for the PCI core resource
> > allocation mechanisms.
> > 
> > Is this ok for you?
> 
> Using the Linux allocator for memory resources does sound useful,
> so if that requires using the emulated PCI-to-PCI bridges, I guess
> it's the best compromise.

Yes, that was Jason's original idea when he suggested to use PCI-to-PCI
bridges. And when I did the implementation, it really worked nicely.
And this PCI-to-PCI bridge emulation stuff is really not a big deal,
look at drivers/pci/sw-pci-pci-bridge.c: 185 lines in total, including
10 lines of comment header at the top.

> I'm sorry about this situation. Unfortunatly the way that such decisions
> are made is not always straightforward, and what seems like a good idea
> at one point turns out to be a mistake or more complex than anticipated
> later. With the description of the first patch set, I did not think
> it would be necessary to fake a bridge device and their config space.

Sure, I understand this. I guess you also understand my slight
frustration when I propose A, I'm told to do B, I propose B, and I'm
then suggested to do A again :-) But I agree, it's part of the
technical discussion, and we can't get it right on the first shot.

> What I had guessed you could do was to call pci_scan_root_bus on
> each of the ports, and then set up the memory space window for
> the bus including all of its child devices.

But where would I read how much space is needed for the I/O and memory
regions of each bus?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
