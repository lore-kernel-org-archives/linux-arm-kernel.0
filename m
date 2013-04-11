From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 11 Apr 2013 07:24:32 +0200
Subject: [PATCHv2 08/10] arm: kirkwood: convert QNAP TS219 to use DT for
 the PCIe interface
In-Reply-To: <20130411003301.GH28693@titan.lakedaemon.net>
References: <1365632436-25367-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365632436-25367-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130411003301.GH28693@titan.lakedaemon.net>
Message-ID: <20130411052432.GP13524@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 08:33:01PM -0400, Jason Cooper wrote:
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
> > diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
> > index acb0187..4695d5f 100644
> > --- a/arch/arm/mach-kirkwood/board-ts219.c
> > +++ b/arch/arm/mach-kirkwood/board-ts219.c
> > @@ -41,13 +41,3 @@ void __init qnap_dt_ts219_init(void)
> >  
> >  	pm_power_off = qnap_tsx1x_power_off;
> >  }
> > -
> > -/* FIXME: Will not work with DT. Maybe use MPP40_GPIO? */
> > -static int __init ts219_pci_init(void)
> > -{
> > -	if (machine_is_ts219())
> > -		kirkwood_pcie_init(KW_PCIE0);
> > -
> > -	return 0;
> > -}
> > -subsys_initcall(ts219_pci_init);
> 
> This doesn't look right.  There are two dts files, one for 6281, and one
> for 6282...
> 
> thx,
> 
> Jason.

Hi Jason

It has been broken for a while, hence the FIXME!

Looking at the old style code, only a machine whos bootloader passed
the machine ID ts219 has PCI. This is the only difference between
ts219 and all other similar devices that use this DT description.

The FIXME comment is referring to a comment in the code:

        MPP44_GPIO,             /* Board ID: 0: TS-11x, 1: TS-21x */

so it seems like you can read this gpio line but strictly, this tells
you how many disks bays the box has, and not if its a ts219.

I've hacked around with PCI driver on my QNAP TS119P+, which does not
have any PCI devices, and never had any problems with the driver
enabled and finding two empty PCI busses. PCI does not share any pins
with anything else. So i think it is safe to just enable it for all
devices.

I will test it out on my device and report back.

  Andrew
