From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Feb 2012 23:28:52 +0000
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F481BA6.7050705@freescale.com>
References: <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
 <20120223165242.GB22562@n2100.arm.linux.org.uk>
 <4F4671BB.7060409@freescale.com>
 <20120223171407.GC22562@n2100.arm.linux.org.uk>
 <4F480120.6080409@freescale.com>
 <20120224231501.GD15120@n2100.arm.linux.org.uk>
 <4F481BA6.7050705@freescale.com>
Message-ID: <20120224232851.GF15120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 05:22:14PM -0600, Timur Tabi wrote:
> Russell King - ARM Linux wrote:
> > What would be wrong with converting in_be32() in these drivers to
> > instead ioread32be()?
> 
> Well, it wouldn't actually fix any problems.   It's just a stylistic
> change for PowerPC.  On ARM, however, ioread32be() is wrong because the
> SSI registers are little-endian.

So, to go around the loop a little further: to make this driver work
_unaltered_ on ARM, we'd need an in_32be() that read the register
_without_ doing the byte swapping.

But then, such an implementation of in_32be() would be absurd because
it's not doing what it says.

So, the driver needs to change its accessor method.  There is no
accessor in existance at present which does the right thing.

And then I went on to explain that there's more complicated cases too,
where it seems that in theory you can end up with the same IP connected
in BE mode and sitting behind a PCI bus, which presents the need for
accessors which know the bus type by some means.
