From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 16:49:43 +0200
Subject: [PATCH v2 2/3] drivers: pci: host-generic: claim bus resources on
 PCI_PROBE_ONLY set-ups
In-Reply-To: <20160418100154.GB2427@red-moon>
References: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160415130803.GA2105@localhost> <20160418100154.GB2427@red-moon>
Message-ID: <5357164.ryYLtkY3PQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 11:01:54 Lorenzo Pieralisi wrote:
> On Fri, Apr 15, 2016 at 08:08:03AM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 12, 2016 at 04:48:10PM +0100, Lorenzo Pieralisi wrote:

> > This last case 3) is the problem.  I'm guessing this case doesn't
> > currently occur on arm/arm64, but it's the normal case on x86, and it
> > seems perverse that things work if firmware does nothing, but they
> > don't work if firmware does more setup.
> 
> IIUC X86 claim resources as programmed by FW so it is not really the
> same situation as arm64, that claims nothing. Claimed resources are not
> reassigned, they are skipped by resource allocation/sizing code
> (because their parent pointer is set).
> 
> And as I said above even if FW does some set-up that will still work
> on ARM/ARM64, otherwise this means that on ALL ARM/ARM64 systems out there
> PCI set-up at kernel handover is non-existent, otherwise we would
> have resource enablement failures NOW, right ?

The embedded systems (in which I would count all arm32 machines) tend
to not do proper bus probing in their bootloaders, so we have to do it
ourselves in the kernel.

For server systems (all UEFI based ones), I'd argue that we should
rely on the firmware to do it just like we do on x86, possibly with
a blacklist of known-broken machines on which we have to do it
manually as well. Once ACPI spreads, we will likely see an increasing
number of machines on which we must not reassign the resources or
bad things happen to stuff that is owned by the BIOS.

	Arnd
