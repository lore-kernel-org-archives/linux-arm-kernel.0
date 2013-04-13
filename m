From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 13 Apr 2013 12:36:50 +0200
Subject: [PATCHv2 08/10] arm: kirkwood: convert QNAP TS219 to use DT for
 the PCIe interface
In-Reply-To: <20130411193349.GA5061@lunn.ch>
References: <1365632436-25367-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365632436-25367-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130411193349.GA5061@lunn.ch>
Message-ID: <20130413103650.GH2824@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 09:33:49PM +0200, Andrew Lunn wrote:
> On Thu, Apr 11, 2013 at 12:20:34AM +0200, Thomas Petazzoni wrote:
> > Now that the PCIe mvebu driver is usable on Kirkwood, use it instead
> > of the legacy PCIe code, since it allows to describe the PCIe
> > interfaces in the Device Tree.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/kirkwood-ts219.dtsi |    7 +++++++
> >  arch/arm/mach-kirkwood/board-ts219.c  |   10 ----------
> >  2 files changed, 7 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
> > index 64ea27c..341e1d8 100644
> > --- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
> > +++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
> > @@ -74,5 +74,12 @@
> >  			status = "okay";
> >  			nr-ports = <2>;
> >  		};
> > +		pcie-controller {
> > +			status = "okay";
> > +
> > +			pcie at 1,0 {
> > +				status = "okay";
> > +			};
> > +		};
> >  	};
> >  };
> 
> Hi Thomas
> 
> There is some DT weirdness going on here. With that you have above,
> the .dtb file has both status="disabled" when i convert it back to dts
> format.
> 
> In order to get it to work, i had to move this fragment into the
> kirkwood-ts219-628[12].dtsi files.
> 
> Can some dtc guru comment if this is supposed to work with the
> arrangement of includes we have?

Hi Thomas

I got my head around what is happening here.

When the dtc merges nodes, it replaces an old property value with the
new proper value. For this "okay" above to work, is has to be the new
property. When in fact, due to the order of the include files, it was
actually the old property value. It was reading kirkwood-ts219.dtsi
first, and then later merging in kirkwood-6282.dtsi, replacing the
status okay with status disabled :-(

I will send an updated version soon.

  Andrew
