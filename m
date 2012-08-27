From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 27 Aug 2012 12:12:19 +0200
Subject: [PATCH] gpio: samsung: add devicetree init for s3c24xx arches
In-Reply-To: <CA+E=qVf9+J1rtvr7snhfRgqKHgWZ+g7TfcQuP8qm00+HH86CDQ@mail.gmail.com>
References: <201208252353.59345.heiko@sntech.de>
 <201208271144.03681.heiko@sntech.de>
 <CA+E=qVf9+J1rtvr7snhfRgqKHgWZ+g7TfcQuP8qm00+HH86CDQ@mail.gmail.com>
Message-ID: <201208271212.20016.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 27. August 2012, 11:51:27 schrieb Vasily Khoruzhick:
> On Mon, Aug 27, 2012 at 12:44 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > Hi Vasily,
> > 
> > I'm not sure I follow :-) .
> > 
> > The compatible property here only sets the mechanism on how to handle the
> > gpios defined in the devicetree - here to use the s3c24xx-style. As you
> > can see in gpio-samsung.c the handling is already unified for all the
> > s3c24xx architectures.
> > 
> > The definition of what gpio banks exist is then done in the respective
> > devicetree file for the individual SoC. And of course here one would have
> > individual definitions, depending on the banks present.
> > 
> > For reference my quite empty s3c2416.dtsi file currently looks like:
> > 
> > /include/ "skeleton.dtsi"
> > 
> > / {
> > 
> >         compatible = "samsung,s3c2416";
> >         
> >         cpus {
> >         
> >                 cpu at 0 {
> >                 
> >                         compatible = "arm,arm926ejs";
> >                 
> >                 };
> >         
> >         };
> >         
> >         gpio-controllers {
> >         
> >                 #address-cells = <1>;
> >                 #size-cells = <1>;
> >                 gpio-controller;
> >                 ranges;
> >                 
> >                 gpa: gpio-controller at 56000000 {
> >                 
> >                         compatible = "samsung,s3c24xx-gpio";
> >                         reg = <0x56000000 0x10>;
> >                         #gpio-cells = <3>;
> >                 
> >                 };
> >                 
> >                 gpb: gpio-controller at 56000010 {
> >                 
> >                         compatible = "samsung,s3c24xx-gpio";
> >                         reg = <0x56000010 0x10>;
> >                         #gpio-cells = <3>;
> >                 
> >                 };

[ ... ]

> >         };
> > 
> > };
> > 
> > Other s3c24xx SoCs would of course need to define their own.
> 
> I see. But how does it handle GPA bank (which is output-only, and
> GPACON differs a bit from GP{B-J}CON? And some banks has lower number
> (not 16) of GPIOs, like GPH.
> 
> Also, what would be value for S3C_GPIO_END?

The creation of the banks is still done in gpio-samsung.c and the special 
handling of bank-a is still sitting in the s3c24xx_gpios[] array there.

In general the gpios are still created completely like before and the 
devicetree information is only attached to them so that dt-devices can 
reference them.

As you can see in the original patch, after the respective chip got created in 
s3c24xx_gpiolib_add_chips, s3c24xx_gpiolib_attach_ofnode searches for the 
representation of it in the device tree and attaches this to the chip.

So nothing really changed, except that dt-devices can now reference gpios and 
if they do s3c24xx_gpio_xlate will get called to configure them with the 
target values from the dt.

Currently I'm also only using it in a mixed mode configuration [1], 
supplementing a normal machine file with some devices from the devicetree - 
especially as I still need to figure out, what to do about the interrupt 
controller.


Heiko


[1] https://github.com/mmind/linux-es600/blob/topic/es600-
devel/arch/arm/boot/dts/s3c24xx-sg06.dts
