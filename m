From: w@1wt.eu (Willy Tarreau)
Date: Mon, 5 Oct 2015 23:05:24 +0200
Subject: [PATCH 0/9] Further mvebu PCIe patches
In-Reply-To: <20151003200026.6eea945d@free-electrons.com>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
 <20151003200026.6eea945d@free-electrons.com>
Message-ID: <20151005210524.GA2292@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 03, 2015 at 08:00:26PM +0100, Thomas Petazzoni wrote:
> Hello Russell,
> 
> On Sat, 3 Oct 2015 19:12:28 +0100, Russell King - ARM Linux wrote:
> 
> > Here are further PCIe patches which follow on from the previous set of
> > six I sent earlier in September.  This set:
> > 
> > * Separates the DT parsing from the use of this parsed data.
> > * Fixes memory leaks from kasprintf() and refcount leaks of the DT
> >   node where we break out from the loop early.
> > * Uses gpio_set_value_cansleep() so that GPIOs on I2C expanders can
> >   be used for the PCIe reset functionality.
> > * Switch to using devm_kcalloc() instead of devm_kzalloc(), which
> >   eliminates the multiplication, moving it into core code.
> > * Switch to using a gpio descriptor for the reset gpio, which can
> >   contain the active level information from DT.  (It would be nice
> >   if gpiolib automated some of the resource claiming there.)
> > * Make PERST# vs clock timing to match PCIe specifications.  PCIe
> >   specs require the clock to be running for 100us prior to releasing
> >   reset.
> > * Add the standard PCIe capability block in root port form to the
> >   emulated PCIe configuration block.  This allows the PCI layer to
> >   identify the "host bridge" as a PCIe device, and allows us to
> >   take advantage of the code in drivers/pci/pcie, particularly
> >   aspm for link power management.
> > * As a result of identifying ourselves as a PCIe root port, this
> >   eliminates the need to special case accesses to non-slot 0 in
> >   the driver; the lack of other "slots" is something which the
> >   generic PCI code knows about for PCIe root ports.
> 
> Thanks for these patches! They look good. However, I'm away for the
> Embedded Linux Conference Europe in Dublin right now, and therefore
> don't have access to my boards to test that it works OK on platforms
> other than Armada 38x (which you tested). I will try to do this testing
> next week, hopefully on Friday.

Just FWIW, I could run this series on top of the previous one on top
of 4.3-rc4. It ran fine (ie no regressions observed) on :

  - Iomega iconnect (kirkwood) with an RT3090 WiFi card (I could verify
    that the card was detected in lspci, module loaded without error
    and the interface appeared)

  - mirabox (armada370) with a dual-igb NIC (i350), Marvell 88E8053 (sky2),
    realtek 8168, and bcm5721. For the first one, I only verified that the
    driver loaded properly and that I could set the links up on the two
    NICs. For the last 3, I could even check that the NIC could receive
    traffic.

I could not test on the XPGP board, it didn't boot regardless of the
patches, I'll have to redo a clean config. This happens once in a while
during "make oldconfig" over a too large version jump.

So far so good!

Cheers,
Willy
