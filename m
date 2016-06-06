From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jun 2016 12:43:21 +0100
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <20160606085627.GA6831@leverpostej>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-5-git-send-email-wmills@ti.com>
 <20160606085627.GA6831@leverpostej>
Message-ID: <20160606114321.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 09:56:27AM +0100, Mark Rutland wrote:
> I very much do not like this. As I previously mentioned [1],
> dma-coherent has de-facto semantics today. This series deliberately
> changes that, and inverts the relationship between DT and kernel (as the
> describption in the DT would now depend on the configuration of the
> kernel).

dma-coherent's semantics are not very well defined - just grep for it
in Documention/devicetree/ and you'll find several different wordings
for what this property means.

Anyway, my point here is that all of these merely say that the hardware
is coherent in _some regard_ - it doesn't specify under what conditions
DMA coherency is guaranteed by the hardware.  It happens that on ARM,
most platforms give that guarantee when using inner shared mappings.  If
we were to use some other sharing, or disable sharing altogether (eg, by
disabling SMP support) then all these platforms would immediately break.

In other words, DMA coherence today already depends on the kernel's setup
of the page tables corresponding to the requirements of the hardware.

Keystone II is just slightly different - and as I understand it, TI
followed one of the early specifications that ARM Ltd produced.  That
specification may have contained errors, but unfortunately, we now have
a situation where there is hardware out there which followed in good
faith.

So, it seems to me to be entirely reasonable that Keystone II should
mark devices with the "dma-coherent" property - just the same way as
every other platform does.  It also seems to be entirely appropriate for
a platform to remove this property if it determines that the conditions
for DMA coherency are not met - in order to save the users data from
corruption.

TI Keystone II is not the only platform with issues here: there are
Marvell Armada platforms out there which have DMA coherence, but are
uniprocessor, we don't set the shared bit (which they require for
DMA coherence) and so we omit the dma-coherent property from the
device tree at the moment.  And they're inner-shared coherent.  We
just don't set the page tables up so that they can work.

So, I think to require a whole new property is absurd.  The existing
property means "if the rest of the system is appropriately configured,
this device can be dma-coherent".  So, what I think we need is a way
to communicate whether the rest of the system has been appropriately
configured, so the property can be attached to devices which meet the
criteria, but the arch/platform level can signal whether the conditions
for device DMA coherence have been met.  That's not a DT property,
that's a matter of how the kernel has setup the system.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
