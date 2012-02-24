From: timur@freescale.com (Timur Tabi)
Date: Fri, 24 Feb 2012 17:38:11 -0600
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120224232851.GF15120@n2100.arm.linux.org.uk>
References: <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
 <20120223165242.GB22562@n2100.arm.linux.org.uk>
 <4F4671BB.7060409@freescale.com>
 <20120223171407.GC22562@n2100.arm.linux.org.uk>
 <4F480120.6080409@freescale.com> <20120224231501
 <20120224232851.GF15120@n2100.arm.linux.org.uk>
Message-ID: <4F481F63.7090504@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:

> So, to go around the loop a little further: to make this driver work
> _unaltered_ on ARM, we'd need an in_32be() that read the register
> _without_ doing the byte swapping.
> 
> But then, such an implementation of in_32be() would be absurd because
> it's not doing what it says.

Exactly.

> So, the driver needs to change its accessor method.  There is no
> accessor in existance at present which does the right thing.

Yes, that is my assessment.

> And then I went on to explain that there's more complicated cases too,
> where it seems that in theory you can end up with the same IP connected
> in BE mode and sitting behind a PCI bus, which presents the need for
> accessors which know the bus type by some means.

And since most PCI devices are little-endian, I think that's why readl()
is always little-endian.

We might be able to modify the PowerPC version of ioread32() to be
native-endian without too much difficulty, but that's something that Ben
Herrenschmidt would need to approve.

-- 
Timur Tabi
Linux kernel developer at Freescale
