From: sre@debian.org (Sebastian Reichel)
Date: Thu, 21 Nov 2013 03:21:27 +0100
Subject: [RFCv2 3/3] ARM: dts: N900: Add SSI information
In-Reply-To: <20131121013858.GK10317@atomide.com>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-4-git-send-email-sre@debian.org>
 <20131121013858.GK10317@atomide.com>
Message-ID: <20131121022125.GA2445@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Nov 20, 2013 at 05:38:59PM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@debian.org> [130915 13:56]:
> > +
> > +Example for Nokia N900:
> > +
> > +ssi-controller at 48058000 {
> > +	compatible = "ti,omap3-ssi";
> > +	ti,hwmods = "ssi";
> > +
> > +	reg = <0x48058000 0x1000>,
> > +	      <0x48059000 0x1000>;
> > +	reg-names = "sys",
> > +		    "gdd";
> > +
> > +	interrupts = <55>;
> > +	interrupt-names = "gdd_mpu";
> > +
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	ranges;
> > +
> > +	ssi-port at 0 {
> > +		compatible = "ti,omap3-ssi-port";
> > +
> > +		reg = <0x4805a000 0x800>,
> > +		      <0x4805a800 0x800>;
> > +		reg-names = "tx",
> > +			    "rx";
> > +
> > +		interrupt-parent = <&intc>;
> > +		interrupts = <51>,
> > +			     <52>;
> > +		interrupt-names = "mpu_irq0",
> > +				  "mpu_irq1";
> > +
> > +		ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
> > +	}
> > +}
> 
> These should be in the omap3.dtsi file and not nested but separate. I'm almost
> certain that these are completely independent hardware modules and this
> means they can live their own PM life independently.
>
> So can you please do a minimal patch for omap3.dtsi that just sets up
> the standard resources separately for both modules the same way we have
> for other hardware modules in omap3.dtsi do?
> 
> One of them should be called ssi, no idea what the other module name should
> be as those register ranges show up as reserved in the docs I have.

In the public documentation of the omaps all SSI related stuff is
missing and memory areas are marked as reserved. I could not find
out how to receive the NDA version, so the following is purely
speculation based on the code.

If I understand it right the HW looks like this:

+-----------------+
|    GDD (DMA)    | <- this one is currently called ssi-controller
+--------+--------+
| Port 1 | Port 2 | <- these are currently called ssi-port
+--------+--------+

I think the GDD part must be enabled while Port 1 or Port 2 is
enabled. The last RFC driver from Carlos did not even split up the
irq/memory areas into different platform devices, but just requested
all of them in one ssi platform device.

> The other binding pieces can be added later on as they get are ready.

Sure. They are almost finished btw. I was able to get a gsm network
scan.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131121/b7b8674a/attachment.sig>
