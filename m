From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 14 Nov 2014 10:30:17 +0100
Subject: [PATCH v3] of: replace Asahi Kasei Corp venter prefix
In-Reply-To: <5465BFA2.9050706@nvidia.com>
References: <20140922130026.GK3290@leverpostej>
 <CAMuHMdX22z97SbGS1HDiYfJ1PXxyEN2S8D7w4sr+4bUwD+mJZw@mail.gmail.com>
 <20140922132743.GM3290@leverpostej>
 <87y4rfhmgl.wl%kuninori.morimoto.gx@renesas.com>
 <1415845309.4269.6.camel@perches.com>
 <20141113025105.GA16652@verge.net.au>
 <87vbmjhj00.wl%kuninori.morimoto.gx@renesas.com>
 <20141113110740.GE3815@sirena.org.uk>
 <87k32yd0bd.wl%kuninori.morimoto.gx@renesas.com>
 <5465BFA2.9050706@nvidia.com>
Message-ID: <20141114093016.GB3810@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 05:38:58PM +0900, Alexandre Courbot wrote:
> On 11/14/2014 10:43 AM, Kuninori Morimoto wrote:
[...]
> >diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
> >index a1d4bf9..7f5cf80 100644
> >--- a/arch/arm/boot/dts/tegra20-seaboard.dts
> >+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
> >@@ -405,7 +405,7 @@
> >  		clock-frequency = <400000>;
> >
> >  		magnetometer at c {
> >-			compatible = "ak,ak8975";
> >+			compatible = "asahi-kasei,ak8975";
> 
> Mmm. So does this mean this device was never probed because the driver did
> not recognize its compatible property?

I2C (like SPI) has a fallback in case the OF table yields no match. The
of_modalias_node() that it uses extracts the module name from the device
tree node's compatible string by skipping the vendor prefix. The
resulting string is then set as the I2C client's name and causes the I2C
standard ID matching to succeed (see of_i2c_register_devices() for how
this is done in detail).

> I cannot find "ak,ak8975" anywhere else in the kernel.
> 
> If so,
> 
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Technically this is breaking backwards-compatibility from a DT
perspective, but I think it's safe to do because the Linux kernel has a
way of dealing with this and other operating systems should be able to
deal with this in a similar way (or even easier by letting the driver
match on the ak prefix as well for this particular chip).

So:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/28fd4c1a/attachment.sig>
