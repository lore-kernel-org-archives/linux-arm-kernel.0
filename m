From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Tue, 31 Mar 2015 22:14:20 +0300
Subject: [PATCH] ARM: dts: sun7i: Add Goodix GT911 nodes for Wexler TAB7200
In-Reply-To: <20150331144338.GG23664@lukather>
References: <1427789897-4085-1-git-send-email-mamlinav@gmail.com>
 <20150331144338.GG23664@lukather>
Message-ID: <20150331221420.3b65d2540c7dbe1d12611e12@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Mar 2015 07:43:38 -0700
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi,
> 
> On Tue, Mar 31, 2015 at 11:18:17AM +0300, Aleksei Mamlin wrote:
> > This patch adds nodes for the Goodix GT911 touchscreen controller found
> > on the Wexler TAB7200 tablet. Controller uses one of following I2C
> > addresses: 0x5d or 0x14, so just add two nodes.
> 
> In which case are these different addresses encountered? Different
> revisions of the same board?
> 
According to the datasheet it is a feature of the controller. 
The address(0x5d or 0x14) can be configured using a reset sequence,
which has not yet been implemented in the driver.
>
> > Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> > ---
> > DT support for the Goodix GT911 touchscreen controller has been queued up
> > by Dmitry Torokhov for merging into 4.1:
> > https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?h=next&id=771d8f1b178e7e09fcc641fccd48852958dbc329
> > 
> > IRQ flags are set by the touchscreen controller driver, so use IRQ_TYPE_NONE.
> > 
> >  arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> > index 2ad3b09..34e2bce 100644
> > --- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> > @@ -101,6 +101,20 @@
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&i2c2_pins_a>;
> >  	status = "okay";
> > +
> > +	gt911 at 5d {
> 
> The node name should be the class of the device. touchscreen in this
> case.
> 
> > +		compatible = "goodix,gt911";
> > +		reg = <0x5d>;
> > +		interrupt-parent = <&pio>;
> > +		interrupts = <21 IRQ_TYPE_NONE>; /* EINT21 (PH21) */
> 
> Unfortunately, IRQ_TYPE_NONE is not a valid value for the GIC
> bindings.
> 
> You're also not adding a pinctrl group for that pin?
> 
> > +	};
> > +
> > +	gt911 at 14 {
> > +		compatible = "goodix,gt911";
> > +		reg = <0x14>;
> > +		interrupt-parent = <&pio>;
> > +		interrupts = <21 IRQ_TYPE_NONE>; /* EINT21 (PH21) */
> > +	};
> 
> And nodes should be ordered by addresses ascending order.
> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com


-- 
Thanks and regards,
Aleksei Mamlin
