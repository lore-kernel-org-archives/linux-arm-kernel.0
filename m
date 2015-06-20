From: rogershimizu@gmail.com (Roger Shimizu)
Date: Sun, 21 Jun 2015 00:56:19 +0900
Subject: [PATCH 1/2] ARM: dts: add buffalo linkstation ls-wxl/wsxl
In-Reply-To: <20150620145108.GF1116@lunn.ch>
References: <1434713319-8691-1-git-send-email-rogershimizu@gmail.com>
 <1434713319-8691-2-git-send-email-rogershimizu@gmail.com>
 <20150619221448.GA1116@lunn.ch>
 <CAEQ9gEkSYtBtmzN3+0FXFeYJZfGFQNQz=nX+54LDTbniQREqPQ@mail.gmail.com>
 <20150620145108.GF1116@lunn.ch>
Message-ID: <CAEQ9gEm9xi53oB+tOuJAcDVka-VtSc=vmU_MyKWzNMjKLeDgLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew,

>> >> +                             compatible = "m25p40";

Thanks for tell me the history.
I checked around and am going to change to:

+                             compatible = "st,m25p40", "jedec,spi-nor";


> Describe to us the use case for the button. What do users expect to
> happen when this button is pressed. Is it actually a push button, or a
> slider?  With more than 2 positions? Is there some user space software
> listening for these particular events?

> So i would at least put WOL in the label. What sort of switch is it,
> push button, slider? Is there some code in user space setting up the
> Ethernet for WOL when this button is pressed?

Actually the button at 2 and button at 3 are bundled on a slider with 3
possible position: power off/on/auto.
Quite a few Buffalo NAS designs take this kind of power switch/slider.

For the "auto" position, the box will be powered on only when get some
signal, which seems to be WOL,
but as matter of fact I didn't capture the network packet to confirm this.
Original feature by Buffalo also includes auto power down if not get
that signal for a few minutes.
After I installed Debian on the NAS, the "auto" button became useless,
since no daemon is monitoring the power slider anymore.

Please inform me whether it's OK to keep what kirkwood-lsxl.dtsi is
now for the power slider.

> In DT, eth1 is correct, not eth0. The kernel should be giving out
> names on a first come, first served bases, unless something is
> renaming them.  What user space are you running?  Debian? Do you have
> a /etc/udev/rules.d/70-persistent-net.rules?  Does it have entries
> based on the MAC addresses?

I understand and agree that from DT spec point of view, the only
network device on board should be called "eth1" still.
But as a normal Linux user, I feel not comfortable when there's no
"eth0" at all, but only one "eth1".
I think the defected hardware can be fixed by software, which is by
dts for this case.

Yes, I have Debian running on the NAS boxes and there's
/etc/udev/rules.d/70-persistent-net.rules.
It has the entry to create "eth0" based on MAC address, which I
believe was generated automatically:

> # Unknown net device (/devices/platform/mv643xx_eth_port.0/net/eth0) (mv643xx_eth_port)
> SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="xx:xx:xx:xx:xx:xx", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"

If I modify dts to let the only network device be called as "eth1",
there would be still one entry generated, because there's no "eth0" at
all.

I'm not sure whether this kind of hardware defect by Buffalo is
intentional or not.
If it's, I guess the reason is make it harder for user to replace
original firmware with self bootstrapped Linux system.
Have you met situation similar before? Please let me know your thought.

Thank you!

Cheers,
Roger

On Sat, Jun 20, 2015 at 11:51 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sat, Jun 20, 2015 at 09:36:54PM +0900, Roger Shimizu wrote:
>> Dear Andrew,
>>
>> Thanks for your comments!
>>
>> Let me clarify and confirm with you before sending the modified patches.
>>
>> >> +     compatible = "buffalo,linkstation,lswxl", "buffalo,lswxl", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>> >
>> > Compatibility strings don't normally have two , in them. I would drop
>> > the first one.
>>
>> So the following would be OK for you?
>> +     compatible = "buffalo,lswxl", "marvell,kirkwood-88f6281",
>> "marvell,kirkwood";
>
> Yes, that is good.
>
>>
>> >> +                             compatible = "m25p40";
>> >
>> > There should be a vendor in this compatibility string, probably "st".
>>
>> I wrote this based on kirkwood-lsxl.dtsi and other dts files.
>> Maybe those are quite old, and I'll follow your suggestion.
>
> There are a few subsystems that don't require a vendor in order to
> work, like mtd, and i2c. But the DT specification says there should be
> one. So we have become more strict with time when accepting patches,
> but not yet gone back and added the missing vendors to existing files.
>
>> >> +             button at 2 {
>> >> +                     label = "Power-on Switch";
>> >> +                     linux,code = <KEY_RESERVED>;
>> >> +                     linux,input-type = <5>;
>> >> +                     gpios = <&gpio1 42 GPIO_ACTIVE_LOW>;
>> >> +             };
>> >
>> > Why did you pick these values? <KEY_POWER> is a more common code for a
>> > power button.
>>
>> I copied this part exact from kirkwood-lsxl.dtsi, only changed the
>> gpio pin number.
>
> So maybe we will just copy what kirkwood-lsxl.dtsi does, but....
>
> Describe to us the use case for the button. What do users expect to
> happen when this button is pressed. Is it actually a push button, or a
> slider?  With more than 2 positions? Is there some user space software
> listening for these particular events?
>
>> >> +             button at 3 {
>> >> +                     label = "Power-auto Switch";
>> >> +                     linux,code = <KEY_ESC>;
>> >> +                     linux,input-type = <5>;
>> >> +                     gpios = <&gpio1 43 GPIO_ACTIVE_LOW>;
>> >
>> > Also a bit unusual. What is this button used for?
>>
>> This button is for auto power-on when getting WOL (wake-on-lan) signal.
>
> So i would at least put WOL in the label. What sort of switch is it,
> push button, slider? Is there some code in user space setting up the
> Ethernet for WOL when this button is pressed?
>
>> >> +&eth0 {
>> >> +     status = "okay";
>> >> +     reg = <0x76000 0x4000>;
>> >> +     clocks = <&gate_clk 19>;
>> >> +     ethernet0-port at 0 {
>> >> +             phy-handle = <&ethphy1>;
>> >> +             interrupts = <15>;
>> >> +     };
>> >
>> > Why reg, clocks and interrupts here? These values belong to eth1.
>>
>> Originally, I tried the same as the dts for ls-wvl, but I see no eth0
>> but only eth1 in linux system,
>
> In DT, eth1 is correct, not eth0. The kernel should be giving out
> names on a first come, first served bases, unless something is
> renaming them.  What user space are you running?  Debian? Do you have
> a /etc/udev/rules.d/70-persistent-net.rules?  Does it have entries
> based on the MAC addresses?
>
>       Andrew
