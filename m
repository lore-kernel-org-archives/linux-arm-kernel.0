From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Jan 2013 09:55:49 +0000
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130130042103.GB5734@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301292254.01069.arnd@arndb.de>
 <20130130042103.GB5734@obsidianresearch.com>
Message-ID: <201301300955.49473.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013, Jason Gunthorpe wrote:
> On Tue, Jan 29, 2013 at 10:54:00PM +0000, Arnd Bergmann wrote:

> > The part that I did not like about having emulated PCI-to-PCI bridges
> > is that it seems to just work around a (percieved or real) limitation
> > in the Linux kernel by adding a piece of infrastructure, rather than
> > lifting that limitation by making the kernel deal with what the
> > hardware provides. That reminded me of the original mach-vt8500
> 
> Well.. in this case there is a standard - PCI-E for what HW vendors
> are supposed to do. The kernel core code follows it and works with
> compliant hardware.
> 
> Marvell HW is not compliant.
> 
> So..
> 
> Should the kernel core PCI code support this particular non-compliance?
> Should the driver work around the non-compliance and present a
> compliant interface to the kernel and userspace?
> 
> My take is the kernel core PCI code is fine, and I hope
> this will be an isolated issue with one family of Marvell IP. So
> working around the HW problem in the driver seems best.

I don't remember the kernel ever caring about whether hardware complies
to a standard or not. The kernel's job is to make hardware work, based
on the actual implementation of that hardware. In a lot of cases that
means taking the standard document as a reference, and adding quirks
for the devices that are different.

In the end, it comes down to the impact on the code complexity, and
the run-time overhead for whatever hardware is most common when adding
those quirks.

Can you (or someone else) describe what kind of changes to the core
code we would actually need to make it work without emulting the
bridge?

> If we learn of many more instances like this then, yah, update the
> core code and rip out this driver work around...

But the code was specifically written to be reusable, which is normally
a good thing.

	Arnd
