From: caesar.upstream@gmail.com (Caesar Wang)
Date: Mon, 1 Feb 2016 14:32:59 +0800
Subject: [PATCH v4 9/9] ARM: dts: rockchip: support the spi for rk3036
In-Reply-To: <3295129.SttO6ack9z@phil>
References: <1453970618-4383-1-git-send-email-wxt@rock-chips.com>
 <1453970618-4383-10-git-send-email-wxt@rock-chips.com>
 <3295129.SttO6ack9z@phil>
Message-ID: <56AEFC1B.60407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

? 2016?01?31? 19:06, Heiko Stuebner ??:
> Hi Caesar,
>
> Am Donnerstag, 28. Januar 2016, 16:43:38 schrieb Caesar Wang:

[...]

>
>   	memory {
> @@ -485,6 +486,23 @@
>   		status = "disabled";
>   	};
>
> +	spi: spi at 20074000 {
> +		compatible = "rockchip,rockchip-spi";
> +		reg = <0x20074000 0x1000>;
> +		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spi_txd &spi_rxd &spi_clk &spi_cs0 &spi_cs1>;
> Do we really want to enable both chip-selects by default?
>
> On the rk3288 Lin Huang wrote:
>      * It's assumed that most users of the SPI ports are using chip select
>        0.  Thus the default pinctrl for the ports enables chip select 0
>        (but not chip select 1 on ports that have it).  If a board wants to
>        use chip select 1 or wants a GPIO chip select the board should
>        override the pinctrl (just like boards can override UART pinctrl if
>        they have hardware flow control).
>
> Do we expect again mostly a use of cs0 or will in the major cases both chip-
> selects be needed?

Sound resonable.
In general, every cs and spi devices should be the one match one.

That should be resonable if we want to use chip select 1 or want a GPIO chip select the board should
override the pinctrl.

>> +		num-cs = <2>;
>> +		clocks =<&cru PCLK_SPI>, <&cru SCLK_SPI>;
>> +		clock-names = "apb-pclk","spi_pclk";
>> +		dmas = <&pdma 8>, <&pdma 9>;
>> +		#dma-cells = <2>;
> What do you need #dma-cells for? This is not a dma-controller :-)

Fixed.

>
>
>> +		dma-names = "tx", "rx";
>> +		status = "disabled";
>> +	};
>
> Also I'd suggest an ordering like:
>
> +	spi: spi at 20074000 {
> +		compatible = "rockchip,rockchip-spi";
> +		reg = <0x20074000 0x1000>;
> +		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =<&cru PCLK_SPI>, <&cru SCLK_SPI>;
> +		clock-names = "apb-pclk","spi_pclk";
> +		dmas = <&pdma 8>, <&pdma 9>;
> +		dma-names = "tx", "rx";
> +		num-cs = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spi_txd &spi_rxd &spi_clk &spi_cs0 &spi_cs1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};

Okay, I will remove the cs1/num-cs in here.

Thanks.

-
Caesar

>
> Heiko
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
