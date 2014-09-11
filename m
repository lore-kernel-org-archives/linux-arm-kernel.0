From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 11 Sep 2014 16:12:58 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <16809905.2REViph6WO@fb07-iapwap2>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1410274470-12712-5-git-send-email-wsa@the-dreams.de>
 <16809905.2REViph6WO@fb07-iapwap2>
Message-ID: <20140911141257.GC5149@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 02:17:16PM +0200, Marc Dietrich wrote:
> cc'ing: devicetree

Thanks, I forgot that!

> > -&iic1	{
> > +&i2c1	{
> >  	status = "ok";
> > -	pinctrl-0 = <&iic1_pins>;
> > +	pinctrl-0 = <&i2c1_pins>;
> >  	pinctrl-names = "default";
> > +
> > +	eeprom at 64 {
> > +		compatible = "slave-24c02";
> 
> a "real" compatible value should have vendor,device syntax.

I know. This is maybe a grey line between "configuration" and "hardware
description". If we want an I2C slave, we need to things:

a) HW support in the I2C master driver
b) SW support by giving the slave callback some functionality (like my
   eeprom simulator)

a) should be compiled in with the master driver and does not need any DT
binding, so this is easy.

b) could be seen as a configuration thing since the functionality
backend could be changed at runtime even. Think of being a usb-gadget
here. However, since I2C is multi-master and not hot-pluggable, some
other master might be depending on what I2C slave is actually used.
So, it could be seen as hardware description, too? Not entirely sure.
The drawback you also noticed is that there is no vendor for these
functionalities. Maybe "wsa" since I did the functionality driver :)

To be honest, the above DT snipplet was done to get easily started. If
DT maintainers think this is more configuration, not much is lost. The
only difference is that the userspace instantiation method should be
used then:

# echo slave-24c02 0x64 > /sys/bus/i2c/devices/i2c-0/new_device

> 
> > +		reg = <0x64>;
> 
> we had some discussions in the past how to represent i2c master devices in 
> device tree. The outcome was to use to a special representation to distinguish 
> them from slave devices, e.g. something like reg = <0x1 0x64>, where the 0x1 
> would mean "master" device (0x0 -> slave). If nothing is added, then it's also 
> slave. The adapter address cell would also need to be changed if this 
> extension is used.

Please don't change the reg-layout which is around since forever.
It will break all existing devicetrees. NAK.

> An alternative would be to use a special property (e.g. slave address), but 
> that would encode the same value twice (or even three times).

As said, if all breaks we handle it at runtime.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/a454e5b8/attachment.sig>
