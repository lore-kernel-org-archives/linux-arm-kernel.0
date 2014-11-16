From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 14:14:29 +0100
Subject: [PATCHv1 2/3] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <20141116020024.GC15870@lunn.ch> (Andrew Lunn's message of "Sun,
 16 Nov 2014 03:00:24 +0100")
References: <cover.1416095841.git.arno@natisbad.org>
 <1eb26f8c1946622910a7e2318c895a7082fea7e5.1416095841.git.arno@natisbad.org>
 <20141116020024.GC15870@lunn.ch>
Message-ID: <87d28nb83u.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Lunn <andrew@lunn.ch> writes:

>> +		internal-regs {
>> +
>> +			sata at a0000 {
>> +				nr-ports = <2>;
>> +				status = "okay";
>> +			};
>> +
>> +			pinctrl {
>> +				pmx_ge0: pmx-ge0 {
>> +					marvell,pins = "mpp5", "mpp6", "mpp7", "mpp8",
>> +						       "mpp9", "mpp10", "mpp11", "mpp12",
>> +						       "mpp13", "mpp14", "mpp15", "mpp16";
>> +					marvell,function = "ge0";
>> +				};
>
> This is already available in armada-370.dtsi as ge0_rgmii_pins.

Will use armada-370.dtsi ones.


>> +
>> +				pmx_uart0: pmx-uart0 {
>> +					marvell,pins = "mpp0", "mpp1";
>> +					marvell,function = "uart0";
>> +				};
>
> This however does not seem to be in armada-370.dtsi. This is probably
> because there are a few options:
>
>            MPP_FUNCTION(0x0, "gpio", NULL),
>            MPP_FUNCTION(0x1, "uart0", "rxd")),
>         MPP_MODE(1,
>            MPP_FUNCTION(0x0, "gpo", NULL),
>            MPP_FUNCTION(0x1, "uart0", "txd")),
>         MPP_MODE(2,
>            MPP_FUNCTION(0x0, "gpio", NULL),
>            MPP_FUNCTION(0x1, "i2c0", "sck"),
>            MPP_FUNCTION(0x2, "uart0", "txd")),
>         MPP_MODE(3,
>            MPP_FUNCTION(0x0, "gpio", NULL),
>            MPP_FUNCTION(0x1, "i2c0", "sda"),
>            MPP_FUNCTION(0x2, "uart0", "rxd")),
>
> What we found with Kirkwood, is that everybody picks the
> same. Probably because of Marvell's RDK and U-boot etc.  It is not
> clear from the current 370 boards what is being used. I should go look
> at Mirabox and 370 RD. If they are all mpp0 & mpp1, i suggest we put
> this into armada-370.dtsi

Will do.


>> +
>> +				pmx_i2c: pmx-i2c {
>> +					marvell,pins = "mpp2", "mpp3";
>> +					marvell,function = "i2c0";
>> +				};
>
> i2c0_pins

ack. will also rename everything to -/_pins instead of pmx_/-


>> +				pmx_spi: pmx-spi {
>> +					marvell,pins = "mpp33", "mpp34",
>> +						       "mpp35", "mpp36";
>> +					marvell,function = "spi0";
>> +				};
>
> Again, we might want to put this in armada-370.dtsi.

will do.


>> +				pmx_smi: pmx-smi {
>> +					marvell,pins = "mpp17", "mpp18";
>> +					marvell,function = "ge";
>> +				};
>
> mdio_pins

ack.


>> +					 * if you do a 'saveenv' under u-boot, your modified
>> +					 * environment be saved will at 1MB after the start
>
> 					 * environment will be saved at 1MB after the start
>
>
>> +					 * of the flash, i.e. in the middle of the uImage.
>> +					 * For that reason, it is strongly advised not to
>> +					 * change default environment, unless you know what
>
>  					 * change the default environment, unless you know what

ack.


>> +				compatible = "marvell,mv64xxx-i2c";
>> +				clock-frequency = <400000>;
>> +				status = "okay";
>> +
>> +				/* Main device RTC chip */
>> +				s35390a: s35390a at 30 {
>> +					 compatible = "ssi,s35390a";
>
> sii not ssi.

My bad. I reused what I found in kirkwood files w/o checking
trivial-devices.txt or vendor-prefixes.txt. Do you want me to add an
additional patch for kirkwood files too?

>> +					 reg = <0x30>;
>> +				};
>> +			};
>> +
>> +			/* RTC provided by Seiko S-35390A above */
>> +			rtc at 10300 {
>> +				status = "disabled";
>> +			};
>> +
>> +			/* Connected to a header on device's PCB */
>> +			serial at 12000 {
>> +				status = "okay";
>> +			};
>> +
>> +			/* Connected to a TI MSP430F2111 for power control */
>> +			serial at 12100 {
>> +				status = "okay";
>> +			};
>> +
>> +			poweroff at 12100 {
>> +				compatible = "synology,power-off";
>> +				reg = <0x12100 0x100>;
>> +				clocks = <&coreclk 0>;
>> +			};
>> +		};
>> +	};
>> +
>> +	gpio-fan-100-32-35 {
>
> There is some logic to this naming, but i don't remember what it is.
> Did you check this is appropriate?

The 32-35 is for the MPP i.e. fan uses mpp32 to mpp35 (3 MPP for speed,
one for alarm). I don't know what the 100 part means. What I did is I
googled to see which fan supported kirkwood models have and noticed
that the DS212j uses the exact same fan, i.e. Y.S.Tech FD129225LL-N so
I opted for the same naming.

On that aspect, you may be able to explain why the speed-map for this
fan goes up to 5000 RPM. This fan is supposed to operate at 1900RPM.
Note that it does not matter in practice.

Cheers,

a+
