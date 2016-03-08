From: phil@nwl.cc (Phil Sutter)
Date: Tue, 8 Mar 2016 15:04:12 +0100
Subject: Broken PCIe on Synology DS414
In-Reply-To: <20160308144524.5f47c217@free-electrons.com>
References: <20160305143445.827496739A@mail.nwl.cc>
 <20160308144524.5f47c217@free-electrons.com>
Message-ID: <20160308140412.GD6517@orbyte.nwl.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, Mar 08, 2016 at 02:45:24PM +0100, Thomas Petazzoni wrote:
> Thanks for reporting the issue. There is indeed an issue with the
> crypto SRAM region overlapping with the PCIe aperture. However, this
> does not prevent 'lspci' from enumerating the device.

OK, that's strange then. As said, I don't see an error message when
crypto SRAM regions are present in DT. It's just that the kernel does
not see any PCI devices (therefore no messages from the drivers, either)
and lspci shows no output. I would expect to see at least the PCI
bridge?!

Sadly, I can't change the PCI device configuration, as the two devices
are built-in (didn't disassemble the box yet). Installed are a Marvell
SATA controller and some XHCI controller (don't remember the
manufacturer, but it's handled by generic xhci-pci driver).

Indeed the situation is resolved by removing the crypto SRAM range
definitions - of course, the kernel complains about not being able to
register the crypto engine driver, but the PCI devices appear and the
HDD is found (so they seem to be functional, too).

Maybe all this is a configuration issue? Can you possibly send me your
kernel .config so I can compare?

Could this be affected by U-Boot? I use mainline U-Boot which just
recently accepted my board support patches. I tried to add the crypto
SRAM ranges to U-Boot's DTS file also, but that alone did not help.
But this reminds me to test mainline kernel again with proprietary
U-Boot, which luckily is still present in flash. I'll get back once I
did.

> I'll cook and send a patch to fix the crypto SRAM ranges nonetheless.

I'm happy to test, just let me know.

Thanks for your help!

Phil
