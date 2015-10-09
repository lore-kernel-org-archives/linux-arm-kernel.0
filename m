From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Oct 2015 16:44:08 +0100
Subject: [PATCH 3/4] arm64: Juno: Add support for the PCIe host bridge on
 Juno R1
In-Reply-To: <20151009141107.GD3394@e106497-lin.cambridge.arm.com>
References: <1444398323-17354-1-git-send-email-Liviu.Dudau@arm.com>
 <1444398323-17354-4-git-send-email-Liviu.Dudau@arm.com>
 <CAL_JsqJsb53VXiUfjGBXK37dBEi1r-PXVohg-c-7_x63R04VMA@mail.gmail.com>
 <20151009141107.GD3394@e106497-lin.cambridge.arm.com>
Message-ID: <20151009154408.GD21629@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 03:11:07PM +0100, Liviu Dudau wrote:
> On Fri, Oct 09, 2015 at 08:54:33AM -0500, Rob Herring wrote:
> > On Fri, Oct 9, 2015 at 8:45 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > > Juno R1 board sports a functional PCIe host bridge that is
> > > compliant with the SBSA standard found here[1]. With the right
> > > firmware that initialises the XpressRICH3 controller one can
> > > use the generic Host Bridge driver to use the PCIe hardware.
> > >
> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > >
> > > [1] http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
> > > ---
> > >  arch/arm64/boot/dts/arm/juno-r1.dts | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> > > index c627511..a702a6b 100644
> > > --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> > > +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> > > @@ -109,6 +109,26 @@
> > >
> > >         #include "juno-base.dtsi"
> > >
> > > +       pcie-controller at 40000000 {
> > > +               compatible = "pci-host-ecam-generic";
> > 
> > I think this is the first case of real h/w using this. We should have
> > a specific compatible here additionally.
> 
> Or maybe I can claim the use of the string on account on being the first on arm64 ;)
> 
> I can add a vendor prefix if you want, but pci-host-generic is going to ignore it 
> *because* it is trying to be a generic driver.

The point here is to have the string ready if we need it later, so it's
fine that it's not used currently.

Rob's suggestion is that the compatible list should look something like:

compatible = "arm,juno-r1-pcie", "plda,xpressrich3", "pci-host-ecam-generic";

We can match on "pci-host-ecam-generic" for now (and hopefully forever),
but if for some reason we need to special-case this host controller (or
Juno's integration thereof), we can do that based on the compatible
string.

Thanks,
Mark.
