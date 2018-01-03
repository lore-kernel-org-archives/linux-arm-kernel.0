From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 3 Jan 2018 11:25:53 +0100
Subject: [PATCH] nokia N9: Add support for magnetometer and touchscreen
In-Reply-To: <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
References: <20180102131722.GA20706@amd>
 <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
Message-ID: <20180103102553.GA28083@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-01-02 18:27:20, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jan 02, 2018 at 02:17:22PM +0100, Pavel Machek wrote:
> > This adds dts support for magnetometer and touchscreen on Nokia N9.
> 
> I think it makes sense to have this splitted.

Creating more work for everyone for little gain? Meh.

> > diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
> > index 39e35f8..57a6679 100644
> > --- a/arch/arm/boot/dts/omap3-n9.dts
> > +++ b/arch/arm/boot/dts/omap3-n9.dts
> > @@ -36,6 +57,22 @@
> >  			};
> >  		};
> >  	};
> > +
> > +	touch at 4b {
> 
> touchscreen@

Ok.

> > +		compatible = "atmel,maxtouch";
> > +		reg = <0x4b>;
> > +		interrupt-parent = <&gpio2>;
> > +		interrupts = <29 2>; /* gpio_61, IRQF_TRIGGER_FALLING*/
> 
> reset-gpios = <&gpio3 17 GPIO_ACTIVE_SOMETHING>;
> 
> > +		vdd-supply = <&vio>;
> > +		avdd-supply = <&vaux1>;
> 
> Those two are not mentioned in the binding and not supported by the
> driver as far as I can see?

Driver will need to be fixed, AFAICT :-(.

> Touchscreen with the same settings is required for n950, so it
> should be in the shared n950 + n9 file.

In future, settings will be different for n9/n950: calibration matrix
is different as panel is rotated in different way. Still it probably
makes sense to share. Ok.

> > +&i2c3 {
> > +	ak8975 at 0f {
> > +		compatible = "asahi-kasei,ak8975";
> > +		reg = <0x0f>;
> > +	};
> >  };
> 
> Looking at the N9 board file this is missing a rotation matrix. This
> is supported by the binding:
> 
> Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt

Do you have an idea how the rotation matrix should look like? I don't
currently have an userland software that could calibrate and test the
sensor, so I'd prefer to merge basic binding now and do calibration
later.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180103/f2e1f8bd/attachment.sig>
