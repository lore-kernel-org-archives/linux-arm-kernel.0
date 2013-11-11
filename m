From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 11 Nov 2013 02:09:08 +0100
Subject: [PATCH] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <87fvr393ro.fsf@natisbad.org>
References: <87bo1tmibv.fsf@natisbad.org> <527ECBDD.7050607@gmail.com>
 <87hablulxu.fsf@natisbad.org> <527ED9E5.80800@gmail.com>
 <87fvr393ro.fsf@natisbad.org>
Message-ID: <52802E34.5020209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 01:32 AM, Arnaud Ebalard wrote:
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:
>>>>> +				status = "okay";
>>>>> +			};
>>>>> +
>>>>> +			mdio {
>>>>> +				phy0: ethernet-phy at 0 {
>>>>> +					reg = <0>;
>>>>
>>>> Can you evaluate PHYs compatible from u-boot or post vendor:prodid
>>>> from MDIO registers?
>>>
>>> Looking at the PCB, 88E1318-NNB2. I will dig into Documentation/ the
>>> associated compatible. Out of curiosity, how do you get the PHY model
>>> from u-boot or userland?
>>
>> If it is 88e1318 the compatible is "marvell,88e1318" then. I usually
>> look at u-boot messages which sometimes reveal the PHY used. If that
>> is not sufficient, you can read PHY ID 1/2 (SMI address 2 and 3)
>> registers and go looking for model numbers.
>
> For the records, another solution is to look under /sys/:
>
> root at thin:/sys/bus/mdio_bus/drivers# find -name '*mdio*'
> ./Marvell 88E1318S/d0072004.mdio-mi:00
> ./Marvell 88E1318S/d0072004.mdio-mi:01

Well, the compatible is "marvell,88e1318s" then.

> I guess the driver just looks at the PHY ID to detect the flavour.
>
> Now regarding the compatible string you propose,  did some grep calls
> and was unable to find a reference to marvell,88e1318 or even 88e138 and
> was unable to find any. How does the kernel do something with it to
> somehow inflect the selection of the right driver/flavour?

You are right, it uses PHYID registers. The compatible is not used by
the driver. Anyway, it is nice to have it in there.

>>>> Both properties above are not required, so please remove them.
>>>>
>>>>> +	       g762_clk: fixedclk {
>>>>
>>>> s/fixedclk/oscillator/ ?
>
> In fact, if I change 'fixedclk' for 'oscillator', then I am unable to
> boot: my SATA disk get unrecognized in a storm of insane
> messages. Obviously, because I had modified the whole .dts to handle all
> the points in your revieuw, I spent some time finding the root
> cause. But that was interesting on many aspects and the continuation of
> a debugging week end ;-)

Ah, sorry for that. You can try to make the node name unique by either
choosing a different meaningful name or try to add @1 after the node
name. G762 datasheet might have a good name for it, like clock-crystal
or something.

> Can you confirm the following: g762_clk is a *label for the node*, which
> is referenced via specific properties of g762 at xx nodes, so that they get
> a clock frequency (a property of g762_clk). And fixedclk is *the name of
> the node*. In that specific case, fixedclk is ok because it does not
> collide w/ any existing node. But 'oscillator' is already defined in
> armada-xp.dtsi (included via armada-370-xp.dtsi):
>
> 	clocks {
> 		/* 25 MHz reference crystal */
> 		refclk: oscillator {
> 			compatible = "fixed-clock";
> 			#clock-cells = <0>;
> 			clock-frequency = <25000000>;
> 		};
> 	};

Confirmed.

> So I guess the renaming I did from 'fixedclk' to 'oscillator' just
> somehow overloaded the armada-xp.dtsi 25Mhz clock for a 32KHz one, hence
> the inability to boot. If I am correct, I guess it would be nice to have
> some checks from dtc when compiling the .dts to verify the uniqueness of
> nodes in order to avoid such things.

Hmm, that's difficult because dtc cannot know if you intentionally want
to overwrite that node or I gave you the wrong name for it. The
different node label could be a hint for the latter though.

Sorry for the extra work that comment caused.

Sebastian
