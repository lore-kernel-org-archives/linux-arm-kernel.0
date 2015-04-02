From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 02 Apr 2015 11:37:07 +0200
Subject: [PATCH 3/3] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <551C2AC0.9030304@wwwdotorg.org>
References: <1422516022-27161-1-git-send-email-danindrey@mail.ru>
 <551AC153.7060103@mail.ru> <551C2AC0.9030304@wwwdotorg.org>
Message-ID: <21658630.CslVI5jns9@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am Mittwoch, 1. April 2015, 11:28:32 schrieb Stephen Warren:
> On 03/31/2015 09:46 AM, Andrey Danin wrote:
> > On 31.03.2015 17:09, Stephen Warren wrote:
> >> On 03/31/2015 12:40 AM, Andrey Danin wrote:
> >>> Hi,
> >>> 
> >>> Thanks for the review.
> >>> 
> >>> On 03.02.2015 0:20, Stephen Warren wrote:

[ snipped old patch parts ]

> >>>>> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> >>>>> b/arch/arm/boot/dts/tegra20-paz00.dts
> >>>>> 
> >>>>> -    nvec at 7000c500 {
> >>>>> -        compatible = "nvidia,nvec";
> >>>>> -        reg = <0x7000c500 0x100>;
> >>>>> -        interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> >>>>> -        #address-cells = <1>;
> >>>>> -        #size-cells = <0>;
> >>>>> +    i2c at 7000c500 {
> >>>>> +        status = "okay";
> >>>>> 
> >>>>>           clock-frequency = <80000>;
> >>>>> 
> >>>>> -        request-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
> >>>>> -        slave-addr = <138>;
> >>>>> -        clocks = <&tegra_car TEGRA20_CLK_I2C3>,
> >>>>> -                 <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
> >>>>> -        clock-names = "div-clk", "fast-clk";
> >>>>> -        resets = <&tegra_car 67>;
> >>>>> -        reset-names = "i2c";
> >>>>> +
> >>>>> +        nvec: nvec at 45 {
> >>>> 
> >>>> This doesn't feel correct. There's nothing here to indicate that this
> >>>> child device is a slave that is implemented by the host SoC rather than
> >>>> something external attached to the I2C bus.
> >>>> 
> >>>> Perhaps you can get away with this, since the driver for nvidia,nvec
> >>>> only calls I2C APIs suitable for internal slaves rather than external
> >>>> slaves? Even so though, I think the distinction needs to be clearly
> >>>> marked in the DT so that any generic code outside the NVEC driver that
> >>>> parses the DT can determine the difference.
> >>>> 
> >>>> I would recommend the I2C controller having #address-cells=<2> with
> >>>> cell
> >>>> 0 being 0==master,1==slave, cell 1 being the I2C address. The I2C
> >>>> driver
> >>>> would need to support #address-cells=<1> for backwards-compatibility.

Stephen, we haven't used your suggestion because Wolfram disliked the idea in 
e.g. http://lkml.iu.edu/hypermail/linux/kernel/1409.1/03446.html

> >>> Driver (nvec in this case) can decide what mode should it use according
> >>> to compatible value. Is it not enough ?
> >> 
> >> No, I don't think so.
> >> 
> >> The I2C binding model is that each child of an I2C controller represents
> >> a device attached to the bus. which SW will communicate with using the
> >> I2C controller as master and the device as a slave. If there's no
> >> explicit representation of child-vs-slave in the DT, how does the I2C
> >> core know whether a particular node is intended to be accessed as a
> >> master or slave?
> > 
> > Device driver registers itself via slave API. Bus driver calls
> > appropriate callback function when needed.
> > If device driver decides to access hardware via master API, then it can
> > do it.
> > 
> > Am I missing something ?
> > 
> >> In other words, without an explicit "communicate with this device" or
> >> "implement this device as a slave" flag, how could DT contain:
> >> 
> >> i2c-controller {
> >> 
> >>      ...
> >>      master at 1a {
> >>      
> >>          compatible = "foo,device";
> >>          reg = <0x1a 1>;
> >>      
> >>      };
> >>      slave at 1a {
> >>      
> >>          compatible = "foo,device-slave";
> >>          reg = <0x1a 1>;
> >>      
> >>      };
> >> 
> >> };
> >> 
> >> where:
> >> 
> >> - "foo,device" means: instantiate a driver to communicate with a device
> >> of this type.
> >> 
> >> - "foo,device-slave" means: instantiate a driver to act as this I2C
> >> device.
> >> 
> >> Sure it's possible for the drivers for those two nodes to simply use the
> >> I2C subsystem's master or slave APIs, but I suspect DT content would
> >> confuse the I2C core into thinking that two I2C devices with the same
> >> address had been represented in DT, and the I2C core would refuse to
> >> instantiate one of them. The solution here is for the reg value to
> >> encode a "master" vs. "slave" flag, so the I2C core can allow both a
> >> master and a slave for each address.
> > 
> > If there is one device, then it must be one node. If there is two
> > devices then it looks incorrect to me to have two devices with the same
> > address. Does I2C allow two devices with same address ?
> 
> One of the nodes is to indicate that the kernel should implement the
> slave mode device and one is to indicate that the kernel should
> implement the master mode device. Those two devices/nodes have
> completely different semantics, so while they share the I2C bus address
> they don't represent the same thing.
> 
> Admittedly it would be uncommon to do this, since it'd be using the I2C
> bus in loopback mode. However, I don't see why we should set out to
> prevent that.

We are sitting between the chairs currently. I hope Wolfram can further 
comment on this.

Having a generic loopback slave driver which just echos all messages it 
received back to the master (on the same controller or a different one) would 
be nice IMHO. 

> > I can imagine this:
> > - we have hardware with I2C device. This device can act as master or as
> > slave
> > - we have device driver, that can work in one, other or both modes.
> > 
> > If we want to force master or slave mode, we can use flags (for combined
> > mode we can use two nodes, but it looks weird).
> > If we want to let driver decide (preferred mode, arbitration, something
> > else), we can use current rules.
> > 
> >> I'm pretty sure this is the nth time I've explained this.
> > 
> > Sorry. I don't understand why you still suggest to use flags. We can use
> > existing infrastructure in this case. There is already similar case in
> > arch/arm/boot/dts/r8a7790-lager.dts (see i2c1 and eeprom).
> > 
> > Do we *really* need this extra rules at this moment ?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150402/a61f8d04/attachment.sig>
