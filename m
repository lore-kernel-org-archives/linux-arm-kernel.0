From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 9 Mar 2013 12:10:03 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <513A7044.1020700@gmail.com>
References: <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <513A7044.1020700@gmail.com>
Message-ID: <20130309111003.GA495@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 05:12:04PM -0600, Rob Herring wrote:
> On 03/08/2013 01:14 AM, Thierry Reding wrote:
> > On Thu, Mar 07, 2013 at 06:05:33PM -0600, Rob Herring wrote:
> >> On 03/07/2013 02:47 PM, Thierry Reding wrote:
> > [...]
> >>> In a nutshell (since some of the context isn't quoted anymore) the
> >>> problem that we're trying to solve is that some of the embedded SoCs
> >>> require per-root-port registers for configuration. The PCI DT
> >>> specification doesn't make any provisions for this. A few alternatives
> >>> have been discussed so far:
> >>
> >> I'm not sure I follow. This is different than the host controller
> >> registers? Why would this not just be multiple entries in the reg property?
> > 
> > Well the register regions are per root-port. On Tegra20 there's 2 of
> > them, Tegra30 has 3 and if I understand correctly Marvell can have up to
> > 10 (!). Adding all of them to the reg property of the host controller
> > could work but it needs some way to match the reg entry to the root port
> > similar to option 1 below.
> 
> The compatible property of the PCI host controller can imply what each
> index of the reg property entries is for.
> 
> > 
> > Adding a property in the root port nodes seems like a cleaner and more
> > accurate representation of the hardware to me, but if that's not
> > acceptable perhaps we need to bite the bullet and add the code to look
> > the registers up from the parent's reg property.
> 
> What I don't like is a new property defined to describe mmio addresses.
> We already have a property for that and it is "reg".

Okay, understood.

> But I think I'm still missing something:
> 
> >>> 			pci at 0,1 {
> >>> 				...
> >>> 				reg = <0x00000800 0 0 0 0>;
> 
> Is this a PCI bus address?

Yes. The example is slightly wrong. pci at 0,1 should actually be pci at 1,0.
That means it is device 1, function 0 on the bus (implicitly 0 in this
case). That matches the values in the reg property, whose first cell is
defined as follows, quoting the PCI OF specification:

	npt000ss bbbbbbbb dddddfff rrrrrrrr

Where:

	n         is 0 if the address is relocatable, 1 otherwise
	p         is 1 if the addressable region is "prefetchable", 0
	          otherwise
	t         is 1 if the address is aliased (for non-relocatable
	          I/O), below 1 MB (for Memory), or below 64 KB (for
	          relocatable I/O).
	ss        is the space code, denoting the address space
	bbbbbbbb  is the 8-bit Bus Number
	ddddd     is the 5-bit Device Number
	fff       is the 3-bit Function Number
	rrrrrrrr  is the 8-bit Register Number

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130309/5685c82c/attachment-0001.sig>
