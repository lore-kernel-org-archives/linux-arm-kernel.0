From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 30 Jan 2018 13:42:41 +0100
Subject: [PATCH] ARM64: dts: marvell: armada-cp110: Add registers clock
 for SPI nodes
In-Reply-To: <20180130122640.wx2r3mnqusz362ju@sapphire.tkos.co.il> (Baruch
 Siach's message of "Tue, 30 Jan 2018 14:26:40 +0200")
References: <20180130111455.10101-1-gregory.clement@free-electrons.com>
 <20180130112138.4xopqhgllnbq4xhb@sapphire.tkos.co.il>
 <20180130122640.wx2r3mnqusz362ju@sapphire.tkos.co.il>
Message-ID: <87bmhb1pry.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
 
 On mar., janv. 30 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Gregory,
>
> On Tue, Jan 30, 2018 at 01:21:38PM +0200, Baruch Siach wrote:
>> On Tue, Jan 30, 2018 at 12:14:55PM +0100, Gregory CLEMENT wrote:
>> > This extra clock is needed to access the registers of the SPI controller
>> > used on Armada 7K/8K SoCs.
>> 
>> Don't we need this also for I2C and UART?
>
> So you posted a patch for I2C as well.
>
> Looking at the cp110-system-controller.c driver (cp110_syscon_common_probe()), 
> I see that clock gate #17 (CP110_GATE_MAIN) is automatically enabled when #21 
> (CP110_GATE_SLOW_IO) is enabled. So this additional clock specifier should not 
> be needed.

Actually this is the reason of these changes. The clock driver is wrong,
now that we got new documentation about the clocks, we saw that the
clock tree descried in this driver was not correct. There is no relation
between clock 17 and clock 21 for instance. But in order to be able to
fix the clock driver, first we have to make sure that all the driver of
the peripherals really select their own clocks.

I have already the patch fixing the clock ready and once I will have
converted the remaining peripheral I will be able to submit it.

Gregory

>
> Also, as I understand, 'clocks' and 'clock-names' properties are meant to 
> describe the clock input from the peripheral device point of view. But gate 
> #17 is an internal clock controller gate that is not visible to the SPI master 
> or I2C master device.
>
> What problem is this patch meant to solve?
>
> baruch
>
>> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> > ---
>> >  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
>> > index a8af4136dbe7..0ab921861a2f 100644
>> > --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
>> > +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
>> > @@ -257,7 +257,9 @@
>> >  			reg = <0x700600 0x50>;
>> >  			#address-cells = <0x1>;
>> >  			#size-cells = <0x0>;
>> > -			clocks = <&CP110_LABEL(clk) 1 21>;
>> > +			clock-names = "core", "axi";
>> > +			clocks = <&CP110_LABEL(clk) 1 21>,
>> > +				 <&CP110_LABEL(clk) 1 17>;
>> >  			status = "disabled";
>> >  		};
>> >  
>> > @@ -266,7 +268,9 @@
>> >  			reg = <0x700680 0x50>;
>> >  			#address-cells = <1>;
>> >  			#size-cells = <0>;
>> > -			clocks = <&CP110_LABEL(clk) 1 21>;
>> > +			clock-names = "core", "axi";
>> > +			clocks = <&CP110_LABEL(clk) 1 21>,
>> > +				 <&CP110_LABEL(clk) 1 17>;
>> >  			status = "disabled";
>> >  		};
>
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
