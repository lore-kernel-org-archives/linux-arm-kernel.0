From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Jul 2012 12:10:29 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <20120705094824.GO17534@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch>
Message-ID: <20120705121029.782b5346@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Thu, 5 Jul 2012 11:48:24 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> Hi Thomas
> 
> You are not the only one working in this area. Arnaud Patard said he
> was look at this as well. 

Ok, I added Arnaud in the Cc list. Arnaud, what is the status of you
work?

> > So far, the pin muxing part is working (needs some polishing, but the
> > foundation is here), with device tree bindings. I think the pin muxing
> > could be used for Orion as well.
> 
> Great. This is one of the big things which we are missing when moving
> a system over the DT. Being able to describe this in DT in a
> standardized way is very much welcome.

For the DT binding, I took my inspiration from the MXS and Samsung
pinctrl drivers, as those platforms also have independent pin muxing
(while some platforms such as Tegra, have hardware pin groups).

The .dtsi side looks like:

                pinctrl at d0018000 {
                               compatible = "marvell,mv78230-pinmux";
                               reg = <0xd0018000 0x38>;


                               uart_2: uart-2 {
                                            marvell,pins = <42 43>;
                                            marvell,pins-function = <1>;
                               };

                               uart_3: uart-3 {
                                            marvell,pins = <44 45>;
                                            marvell,pins-function = <2>;
                               };

                               uart_0_control: uart-0-control {
                                            marvell,pins = <42 43>;
                                            marvell,pins-function = <2>;
                               };

                               uart_1_control: uart-1-control {
                                            marvell,pins = <46 47>;
                                            marvell,pins-function = <2>;
                               };

                               uart_2_control: uart-2-control {
                                            marvell,pins = <44 45>;
                                            marvell,pins-function = <1>;
                               };

                               uart_3_control: uart-3-control {
                                            marvell,pins = <46 47>;
                                            marvell,pins-function = <1>;
                               };

                };

This defines the various pin muxing options, and then when
instantiating a device, you do:

               test at 12 {
                       compatible = "marvell,testdrv";
                       pinctrl-names = "default";
                       pinctrl-0 = <&uart_0_control>;
               };

(This is with a dummy test driver that I'm using for testing). Then
the driver can use the pinctrl API to get the proper muxing for its
pins.

> > Now, I'm planning to start working on the gpio + gpio interrupts parts
> > of the driver, and I'm wondering how to interact with your work on the
> > matter.
> 
> I've publicly said, what i have is enough to get it working, but i
> know its not the end solution. What i have is enough that gpio-key,
> gpio-led, as described in DT, works. Boards can start using these and
> as far as i can tell, the binding should not need to change. The GPIO
> controller binding should also be sufficiently generic that it should
> also not need changes when we replace the driver with pinctrl.
> 
> The biggest problem i had, is the interaction between generic chip
> interrupts and irqdomain. There has been work to integrate the two,
> but its stalled. Either the work needs restarting and completing, or
> you need to throw away the use of generic interrupt so that you can
> use irqdomain linear. IMHO, throwing away generic interrupt is the
> wrong way.
> 
> The other thing you need to keep in mind is the namespace issues
> between normal interrupts and GPIO interrupts. The way my patch works
> is that normal interrupts are setup first, counting how many have been
> created. Then GPIO interrupts are added, starting off where the normal
> interrupts ended. Since 370/XP uses different interrupt code, you need
> to think how to solve this issue.

Ok, thanks for those hints.

> > Should I continue working on a drivers/pinctrl/ driver for mvebu for
> > Armada 370/XP, and then we see together if it makes sense to extend to
> > Orion, and if so, what changes are needed?
> 
> I know Marvell has contracted you to port to Armada 370/XP, not mvebu,
> aka all chips which might be able to share this code. This IMHO is
> wrong. So i personally would put the kirkwood and the Armada 370/XP
> data sheets next to each other, and from the beginning on write the
> driver so it supports them all. This assumes the ASIC engineers have
> not radically changed anything... Please also try to stick to the DT
> binding i've used.

I've looked at the datasheet for the 88F6281, and the GPIO registers
look fairly similar with Armada 370/XP, except that:

 * On 88F6281, there are two GPIO banks, while on Armada 370/XP it's a
   continuous range of registers that control the GPIOs. But it can be
   assimilated as one bank handling more than 32 GPIOs. So shouldn't be
   a big problem to handle.

 * The Armada 370/XP have additional set/clear registers that allow to
   modify the GPIO states without having to do a read/mask/write
   sequence, which is nicer on SMP. I guess we can handle that as a
   variant inside the driver without too much problem.

Marvell has given me a 88F6282 eval board, so I guess they are fine
with me spending some time ensuring that the new code works properly on
the previous platforms, especially in this case where the amount of
work does not seem to be enormous to keep the compatibility.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
