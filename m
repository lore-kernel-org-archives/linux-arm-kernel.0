From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 15 Mar 2012 11:27:36 +0100
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <201203150922.06379.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <201203150922.06379.arnd@arndb.de>
Message-ID: <20120315102736.GA25371@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann wrote:
> On Thursday 15 March 2012, Nicolas Ferre wrote:
[...]
> > +	i2c1: i2c at 1 {
> > +		...
> > +		dma-request = <&sdma 2 &sdma 3>;
> > +		dma-request-names = "tx", "rx";
> > +		...
> > +	};
> 
> This is slightly different from how the proposed pwm binding works that
> Thierry is working on, which uses an arbitrary property name instead of
> requiring the use of a specific property but then allowing to give names
> in another property.
> 
> I don't care much which way it's done, but please try to agree on one
> approach that is used for both.
> 
> The one you have here is already used by reg and irq, while the other
> one is used in gpio.

I think we can just use pwm as the fixed property name. Or alternatively do
something along the lines of the regulator bindings, where we use "-pwm" as
the suffix for specifying PWM devices. For instance if a named PWM is
requested, the OF support code would look for a <name>-pwm property, while
requesting an unnamed PWM would simply look at the pwm property.

When it comes to the labelling of PWM devices, I don't think both variants
are exclusive. Currently the PWM framework uses name of the user OF device
node for the PWM label. That is, if I have the following in the DTS:

	pwm {
		...
	};

	backlight {
		compatible = "pwm-backlight";
		pwm = <&pwm 0 5000000>;
		...
	};

Then the PWM will be labelled "backlight":

	$ cat cat /sys/kernel/debug/pwm
	platform/tegra-pwm, 4 PWM devices
	pwm-0   (backlight           ): requested enabled
	pwm-1   ((null)              ):
	pwm-2   ((null)              ):
	pwm-3   ((null)              ):

So if we decide to explicitly allow specifying names, then we can always add
a pwm-names property (or <name>-pwm-names respectively) to use as label and
fallback to the user OF device node name if that property is not present.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/ffaa7df4/attachment.sig>
