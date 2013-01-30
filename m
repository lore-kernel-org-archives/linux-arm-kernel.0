From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 29 Jan 2013 21:49:12 -0700
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130129225932.01efb45b@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301291645.08040.arnd@arndb.de> <20130129180936.3737e550@skate>
 <201301292015.21478.arnd@arndb.de> <20130129213308.7e845064@skate>
 <20130129225932.01efb45b@skate>
Message-ID: <20130130044912.GD5734@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 10:59:32PM +0100, Thomas Petazzoni wrote:
> Arnd,
> 
> On Tue, 29 Jan 2013 21:33:08 +0100, Thomas Petazzoni wrote:
> 
> > Basically, I have currently two suggestions:
> > 
> >  * From Jason Gunthorpe, to not use any host bridge, and instead use
> >    only PCI-to-PCI bridges, one per PCIe interface.
> > 
> >  * From you, to not use any PCI-to-PCI bridge, and use only host
> >    bridges, one per PCIe interface.

Arnd is suggesting to use multiple *linux* host bridges (ie host
drivers), there is never any need for a 'host bridge config space' as
in patch #7, in either case.

> However, one of the reason to use a PCI-to-PCI bridge was to ensure
> that the PCIe devices were all listed in slot 0. According to the
> Marvell engineers who work on the PCIe stuff, some new PCIe devices
> have this requirement. I don't have a lot of details about this, but I
> was told that most of the new Intel NICs require this, for example the
> Intel X520 fiber NIC. Maybe PCIe experts (Jason?) could provide more
> details about this, and confirm/infirm this statement.

I'm not sure what this is referring to.. I don't recall any specific
requirements in PCI-E for the device number, I think the spec requires
it to be learned based on the config TLPs received.

There might be a device number sensitivity in INTx translation, but
that is defined by the spec.

That said, if your root complex is PCI-E compliant then all downstream
end ports attached to a root port should have a device number of 0.

> The usage of PCI-to-PCI bridge allows to have each PCIe device on its
> own bus, at slot 0, which also solves this problem.

Hrm....

Looking at the docs, you will also need to change the internal device
number (probably reg 41a04 again) to something other than 0, otherwise
the Marvell itself will claim device number 0 and the downstream end
port will be device number 1. You should see this happen today??

You should set the Marvell internal device number to something like
all ones and then deny any Linux config register access to the all
ones device number on the subordinate bus to hide the Marvell end port
config space registers from Linux.

As for as this process goes, it doesn't matter which approach you
take. If you use multiple PCI domains then you'd still be able to
arrange things via the above so that the downstream device could
always claim device number 0.

Jason
