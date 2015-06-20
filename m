From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Jun 2015 16:51:08 +0200
Subject: [PATCH 1/2] ARM: dts: add buffalo linkstation ls-wxl/wsxl
In-Reply-To: <CAEQ9gEkSYtBtmzN3+0FXFeYJZfGFQNQz=nX+54LDTbniQREqPQ@mail.gmail.com>
References: <1434713319-8691-1-git-send-email-rogershimizu@gmail.com>
 <1434713319-8691-2-git-send-email-rogershimizu@gmail.com>
 <20150619221448.GA1116@lunn.ch>
 <CAEQ9gEkSYtBtmzN3+0FXFeYJZfGFQNQz=nX+54LDTbniQREqPQ@mail.gmail.com>
Message-ID: <20150620145108.GF1116@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 20, 2015 at 09:36:54PM +0900, Roger Shimizu wrote:
> Dear Andrew,
> 
> Thanks for your comments!
> 
> Let me clarify and confirm with you before sending the modified patches.
> 
> >> +     compatible = "buffalo,linkstation,lswxl", "buffalo,lswxl", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> >
> > Compatibility strings don't normally have two , in them. I would drop
> > the first one.
> 
> So the following would be OK for you?
> +     compatible = "buffalo,lswxl", "marvell,kirkwood-88f6281",
> "marvell,kirkwood";

Yes, that is good.

> 
> >> +                             compatible = "m25p40";
> >
> > There should be a vendor in this compatibility string, probably "st".
> 
> I wrote this based on kirkwood-lsxl.dtsi and other dts files.
> Maybe those are quite old, and I'll follow your suggestion.

There are a few subsystems that don't require a vendor in order to
work, like mtd, and i2c. But the DT specification says there should be
one. So we have become more strict with time when accepting patches,
but not yet gone back and added the missing vendors to existing files.
 
> >> +             button at 2 {
> >> +                     label = "Power-on Switch";
> >> +                     linux,code = <KEY_RESERVED>;
> >> +                     linux,input-type = <5>;
> >> +                     gpios = <&gpio1 42 GPIO_ACTIVE_LOW>;
> >> +             };
> >
> > Why did you pick these values? <KEY_POWER> is a more common code for a
> > power button.
> 
> I copied this part exact from kirkwood-lsxl.dtsi, only changed the
> gpio pin number.

So maybe we will just copy what kirkwood-lsxl.dtsi does, but....

Describe to us the use case for the button. What do users expect to
happen when this button is pressed. Is it actually a push button, or a
slider?  With more than 2 positions? Is there some user space software
listening for these particular events?
 
> >> +             button at 3 {
> >> +                     label = "Power-auto Switch";
> >> +                     linux,code = <KEY_ESC>;
> >> +                     linux,input-type = <5>;
> >> +                     gpios = <&gpio1 43 GPIO_ACTIVE_LOW>;
> >
> > Also a bit unusual. What is this button used for?
> 
> This button is for auto power-on when getting WOL (wake-on-lan) signal.

So i would at least put WOL in the label. What sort of switch is it,
push button, slider? Is there some code in user space setting up the
Ethernet for WOL when this button is pressed?

> >> +&eth0 {
> >> +     status = "okay";
> >> +     reg = <0x76000 0x4000>;
> >> +     clocks = <&gate_clk 19>;
> >> +     ethernet0-port at 0 {
> >> +             phy-handle = <&ethphy1>;
> >> +             interrupts = <15>;
> >> +     };
> >
> > Why reg, clocks and interrupts here? These values belong to eth1.
> 
> Originally, I tried the same as the dts for ls-wvl, but I see no eth0
> but only eth1 in linux system,

In DT, eth1 is correct, not eth0. The kernel should be giving out
names on a first come, first served bases, unless something is
renaming them.  What user space are you running?  Debian? Do you have
a /etc/udev/rules.d/70-persistent-net.rules?  Does it have entries
based on the MAC addresses?

      Andrew
