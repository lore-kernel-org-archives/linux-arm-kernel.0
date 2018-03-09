From: npcomplete13@gmail.com (Vivek Unune)
Date: Fri, 9 Mar 2018 17:05:30 -0500
Subject: [PATCH v2] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <88e9d209-c45e-0e8f-53ce-4705d0b7e3c2@gmail.com>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
 <20180302194155.50808-1-npcomplete13@gmail.com>
 <88e9d209-c45e-0e8f-53ce-4705d0b7e3c2@gmail.com>
Message-ID: <20180309220530.nz2qkuipjqabus5h@osboxes>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Date: Fri, 9 Mar 2018 16:56:11 -0500
From: Vivek Unune <npcomplete13@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: hauke at hauke-m.de, zajec5 at gmail.com, jonmason at broadcom.com,
	bcm-kernel-feedback-list at broadcom.com, robh+dt at kernel.org,
	mark.rutland at arm.com, linux at armlinux.org.uk,
	linux-arm-kernel at lists.infradead.org, devicetree at vger.kernel.org,
	linux-kernel at vger.kernel.org, Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH v2] ARM: dts: BCM5301X: Add support for Linksys EA9500
Message-ID: <20180309215611.ip7uvnpwfkfwfmx3@osboxes>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
 <20180302194155.50808-1-npcomplete13@gmail.com>
 <88e9d209-c45e-0e8f-53ce-4705d0b7e3c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e9d209-c45e-0e8f-53ce-4705d0b7e3c2@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

Hi Florian,

On Fri, Mar 09, 2018 at 11:17:21AM -0800, Florian Fainelli wrote:
> 
> Glad you got it working finally! Out of curiosity, I am assuming you
> have Broadcom tags enabled on the internal switch and disabled on the
> external BCM53125 switch, is that correct?

No, I did not enable tagging, as I thought this might have undesired effect
with internal switch enabled and external disabled. I understand that
BCM53125 needs additional plumbing and it's tagging is disabled in mainline.

> >  
> >  #include "bcm47094.dtsi"
> > -#include "bcm5301x-nand-cs0-bch8.dtsi"
> > +#include "bcm5301x-nand-cs0-bch1.dtsi"
> 
> This sounds like an independent bugfix, can you submit that separately?

Will do.

> > +
> > +		port at 5 {
> > +			reg = <5>;
> > +			ethernet = <&gmac0>;
> > +			label = "cpu";
> > +
> > +			fixed-link {
> > +				speed = <1000>;
> > +				full-duplex;
> > +			};
> > +		};
> > +
> > +		port at 7 {
> > +			reg = <7>;
> > +			ethernet = <&gmac1>;
> > +			label = "cpu";
> > +
> > +			fixed-link {
> > +				speed = <1000>;
> > +				full-duplex;
> > +			};
> > +		};
> > +
> > +		port at 8 {
> > +			reg = <8>;
> > +			ethernet = <&gmac2>;
> > +			label = "cpu";
> > +
> > +			fixed-link {
> > +				speed = <1000>;
> > +				full-duplex;
> > +			};
> > +		};
> 
> None of this is wrong, but DSA effectively will take the first port
> specified with a "cpu" label and declare it as the one and only CPU port
> it supports. If the architecture on Northstar is similar to what is done
> on Northstar Plus, port 5 can be either internal or external PHY, port 7
> is indeed gmac1, and port 8 is connected to the flow accelerator, which
> should be in "bypass" mode by default. We can always change that later
> on if we have to anyway.

>From what I understand from the source is that gmac0 and gmac1 in NorthStar
are connected to FA while gmac2 is connected to port8
Although I could be completely wrong :)

Snippet from GPL source [1]:

 * A typical GMAC configuration is:
 *   GMAC#0 - port#5 - fwd0 <---> wl0 (radio 0) on CPU core0
 *   GMAC#1 - port#7 - fwd1 <---> wl1 (radio 1) on CPU core1
 *
 *   GMAC#2 - port#8 - eth0 <--- vlan1 ---> br0

Note: EA9500 has three radios, fwd0 is connected to even numbered radios
While odd numbered radios are connected to fwd1. Also, fw0,fw1 and eth0
listed above are devices created by the factory firmware.

> > +
> > +		sw0_p0: port at 0 {
> 
> switch0port0 would be a nicer label and unit name to use.
> 
> 
> Similarly, this would be better with switch1port8?

Will do.


> >  
> > -/ {
> > -	usb3_phy: usb3-phy {
> > -		compatible = "brcm,ns-bx-usb3-phy";
> > -	};
> > +&usb3_phy {
> > +	compatible = "brcm,ns-bx-usb3-phy";
> >  };
> 
> I would probably create a separate commit which explains why yuo are
> relocating the USB 3.0 PHY into the mdiomux node, and then only add
> support for the EA9500 model.
> 

Will do.

Thanks,

Vivek

[1] https://github.com/RMerl/asuswrt-merlin/blob/master/release/src-rt-7.x.main/src/include/hndfwd.h
