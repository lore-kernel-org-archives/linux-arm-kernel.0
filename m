From: stefan@agner.ch (Stefan Agner)
Date: Sun, 27 Mar 2016 15:48:21 -0700
Subject: [PATCH v4] ARM: dts: vf610-zii-dev: Add ZII development board.
In-Reply-To: <20160327223603.GA21605@lunn.ch>
References: <1459100733-21552-1-git-send-email-andrew@lunn.ch>
 <56F84FAB.6010005@gmail.com> <20160327223603.GA21605@lunn.ch>
Message-ID: <dad27c3a958ae97869c606e9e02e2d7b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-27 15:36, Andrew Lunn wrote:
> Hi Marek
> 
>> > +&i2c2 {
>> > +	clock-frequency = <100000>;
>> > +	pinctrl-names = "default";
>> > +	pinctrl-0 = <&pinctrl_i2c2>;
>> > +	status = "okay";
>> > +
>> > +	tca9548 at 70 {
>>
>> This should be pca9... , not tca9... :-)
> 
> The schematics for the board show that the device is a tca9548, so i
> assume it is the T.I. part, not the NXP. But it is compatible at the
> register level with the pca9548, hence the compatible string. So i
> would say the label is correct, it matches the hardware.
> 
>>
>> > +		compatible = "nxp,pca9548";
>> > +		#address-cells = <1>;
>> > +		#size-cells = <0>;
>> > +		reg = <0x70>;
>> > +		reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
>> > +
>>
>> [...]
>>
>> > +&uart0 {
>> > +	pinctrl-names = "default";
>> > +	pinctrl-0 = <&pinctrl_uart0>;
>> > +	status = "okay";
>> > +	dmas = <>;
>> > +	dma-names = "";
>>
>> Why is this dma stuff here ?
> 
> We have seen corruption of the serial transmit stream, when the DMA is
> being used. As a workaround, we disable DMA.
> 

For the Colibri VF50/VF61 we used this method too to disable the DMA
(clearing dma-names). I guess using the device tree deleting
capabilities would be the more elegant way to do this.

We have seen such issues too, the DMA implementation of the LPUART
driver seems to be racy... We are working on fixing that.

--
Stefan
