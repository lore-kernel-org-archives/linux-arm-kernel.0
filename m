From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 11 Nov 2013 01:32:43 +0100
Subject: [PATCH] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <527ED9E5.80800@gmail.com> (Sebastian Hesselbarth's message of
 "Sun, 10 Nov 2013 01:57:09 +0100")
References: <87bo1tmibv.fsf@natisbad.org> <527ECBDD.7050607@gmail.com>
 <87hablulxu.fsf@natisbad.org> <527ED9E5.80800@gmail.com>
Message-ID: <87fvr393ro.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I thought it would be a simple update but one of your comment gave me a
run for my money ;-)

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:

>>>> +				status = "okay";
>>>> +			};
>>>> +
>>>> +			mdio {
>>>> +				phy0: ethernet-phy at 0 {
>>>> +					reg = <0>;
>>>
>>> Can you evaluate PHYs compatible from u-boot or post vendor:prodid
>>> from MDIO registers?
>>
>> Looking at the PCB, 88E1318-NNB2. I will dig into Documentation/ the
>> associated compatible. Out of curiosity, how do you get the PHY model
>> from u-boot or userland?
>
> If it is 88e1318 the compatible is "marvell,88e1318" then. I usually
> look at u-boot messages which sometimes reveal the PHY used. If that
> is not sufficient, you can read PHY ID 1/2 (SMI address 2 and 3)
> registers and go looking for model numbers.

For the records, another solution is to look under /sys/:

root at thin:/sys/bus/mdio_bus/drivers# find -name '*mdio*'
./Marvell 88E1318S/d0072004.mdio-mi:00
./Marvell 88E1318S/d0072004.mdio-mi:01

I guess the driver just looks at the PHY ID to detect the flavour.

Now regarding the compatible string you propose,  did some grep calls
and was unable to find a reference to marvell,88e1318 or even 88e138 and
was unable to find any. How does the kernel do something with it to
somehow inflect the selection of the right driver/flavour?

>>> Both properties above are not required, so please remove them.
>>>
>>>> +	       g762_clk: fixedclk {
>>>
>>> s/fixedclk/oscillator/ ?

In fact, if I change 'fixedclk' for 'oscillator', then I am unable to
boot: my SATA disk get unrecognized in a storm of insane
messages. Obviously, because I had modified the whole .dts to handle all
the points in your revieuw, I spent some time finding the root
cause. But that was interesting on many aspects and the continuation of
a debugging week end ;-)

Can you confirm the following: g762_clk is a *label for the node*, which
is referenced via specific properties of g762 at xx nodes, so that they get
a clock frequency (a property of g762_clk). And fixedclk is *the name of
the node*. In that specific case, fixedclk is ok because it does not
collide w/ any existing node. But 'oscillator' is already defined in
armada-xp.dtsi (included via armada-370-xp.dtsi):

	clocks {
		/* 25 MHz reference crystal */
		refclk: oscillator {
			compatible = "fixed-clock";
			#clock-cells = <0>;
			clock-frequency = <25000000>;
		};
	};

So I guess the renaming I did from 'fixedclk' to 'oscillator' just
somehow overloaded the armada-xp.dtsi 25Mhz clock for a 32KHz one, hence
the inability to boot. If I am correct, I guess it would be nice to have
some checks from dtc when compiling the .dts to verify the uniqueness of
nodes in order to avoid such things.

Comments welcome.

Cheers,

a+
