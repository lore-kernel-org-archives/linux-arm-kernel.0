From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 10:28:37 +0000
Subject: [PATCH 2/2] ARM: dts: AM33XX: Add lis331dlh device tree data to
 am335x-evm
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2F0AB@DBDE01.ent.ti.com>
References: <1347551685-19781-1-git-send-email-anilkumar@ti.com>
 <201209140826.07069.arnd@arndb.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA2F0AB@DBDE01.ent.ti.com>
Message-ID: <201209141028.38185.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, AnilKumar, Chimata wrote:
>> On Fri, Sep 14, 2012 at 13:56:06, Arnd Bergmann wrote:
> > On Thursday 13 September 2012, AnilKumar Ch wrote:

> > 
> > Why do you put the "reg" property here
> 
> Here I specified reg property because lis331dlh I2C slave address is 0x18.
> 
> > 
> > >  		dcan1: d_can at 481d0000 {
> > >  			status = "okay";
> > >  			pinctrl-names = "default";
> > > @@ -61,6 +70,39 @@
> > >  		regulator-max-microvolt = <5000000>;
> > >  		regulator-boot-on;
> > >  	};
> > > +
> > > +	lis3_reg: fixedregulator at 1 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "lis3_reg";
> > > +		regulator-boot-on;
> > > +	};
> > > +};
> > > +&lis331dlh {
> > > +	compatible = "st,lis3lv02d-i2c";
> > 
> > and all the rest here? At least I would expect the "compatible" property
> > to be in the same place above.
> 
> This data is appended to above one, to make it readable I moved remaining
> properties to here.

I don't follow how this is making things more readable.

Maybe a more logical way to do this would be use the existing i2c2 label
and write all the additions as

i2c2: {
	status = "okay";
	clock-frequency = <400000>;

	lis331dlh at 18 {
		compatible = "st,lis3lv02d";
		reg = <0x18>;

		vdd-supply = <&lis3_reg>;
		vdd-io-supply = <&lis3_reg>;
		...
	};

> > Also, I think you should remove the "-i2c" postfix from the name, that
> > is already implied by the parent bus.
> 
> I will remove, but in case of spi the compatible name is lis3lv02d_spi.
> By mistake I have uses "-i2c" instead of "_i2c".

The normal convention is to use '-', not '_', so that part was ok.

I think naming the other one lis3lv02d_spi was a mistake, it should
be named 'st,lis3lv02d' independent of the bus IMHO.

> Document is already present, 
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;h=2f2ff3cc8d930493f9a598b9192706c09403e12e
> 
> Some minor changes in docs, in my next version I will update document
> as well. I will send V3 if there are no comments on v2.

Ok.

	Arnd
