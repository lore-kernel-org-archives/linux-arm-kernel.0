From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 28 Jan 2015 23:59:38 +0100
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <443299280.47516.1422483725178.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
 <20150125150431.GE2719@earth.universe>
 <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150127001629.GP21293@sirena.org.uk>
 <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de>
 <20150127194346.GN21293@sirena.org.uk>
 <443299280.47516.1422483725178.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Message-ID: <20150128225937.GA12749@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 28, 2015 at 11:22:05PM +0100, Stefan Wahren wrote:
> > Mark Brown <broonie@kernel.org> hat am 27. Januar 2015 um 20:43 geschrieben:
> > On Tue, Jan 27, 2015 at 07:35:09PM +0100, Stefan Wahren wrote:
> > > > Mark Brown <broonie@kernel.org> hat am 27. Januar 2015 um 01:16
> > > > geschrieben:
> >
> > > > > okay i understand. But doesn't it need a extra driver to set the
> > > > > switching
> > > > > frequency because of the new compatible string?
> >
> > > > I don't understand this bit at all, sorry.
> >
> > > Sebastian suggested a new sub-node in the devicetree:
> >
> > > powerpll {
> > > compatible = "fsl,imx28-power-pll"
> > > #clock-cells = <0>;
> > > clock-frequency = <12345>;
> > > }
> >
> > > and i think that the new compatible string needs a separate driver to take
> > > care
> > > of the switching frequency.
> >
> > I can see that this has been suggested, what I can't understand is why
> > we would wish to do this but I am missing some context here which may
> > make it all perfectly clear.
> 
> The relevant register DC-DC Miscellaneous Register (HW_POWER_MISC) is described
> in chapter 11.12.10 of the reference manual [1].
>
> [1] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf

Having a look at the datasheet my suggestion for the sub-node
doesn't make sense. I missunderstood how the hardware architecture
looks like, sorry for the noise :(

> changing the switching frequency is not a common feature for this IC. In most
> cases the clock for the DC-DC switching frequency runs at 24 MHz (ref_xtal).
> Unfortunatelly this could cause interferences for example in UHF band. So
> switching to ref_pll and changing clock divider is a option to avoid such
> interferences without changing hardware.
>
> I decided to implement it as a module parameter, because i see it's a
> configuration option.

I think its best to use a DT property then. That way it can be set
appropiatly for boards known to use a band, which could have
interference problems.

So just add a simple property (without a subnode). If I understand
Mark correctly, there's a high chance more drivers will need to
describe the switching frequency, so I suggest to use a vendor
independent property name:

switching-frequency = <12345>;

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/2606ebdb/attachment-0001.sig>
