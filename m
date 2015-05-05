From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 May 2015 18:13:49 +0100
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
Message-ID: <20150505171349.GA30215@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +/*Reserved 1MB memory for MCU*/
> +/memreserve/ 0x05e00000 0x00100000;

What exactly is the MCU used for, and what does it use this memory for?

Can this be carved out from the memory node instead? If the OS doesn't
need to access this memory to communicate with the MCU, preventing the
OS from mapping the memory avoids a number of potential issues.

I take it that with UEFI this region is not described to the OS?

[...]

> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};

Are all the PSCI 0.2 mandatory features implemented?

Can CPU0 be hot unplugged?

[...]

> +		uart0: uart at f8015000 {	/* console */
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x0 0xf8015000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ao_ctrl HI6220_UART0_PCLK>, <&ao_ctrl HI6220_UART0_PCLK>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};

In a previous discussion [1] the UART on HI6220 was described as not
fully PL011 compliant, with a number of differences (e.g. the FIFO
length).

Given that, I feel somewhat uncomfortable with the current compatible
string list. What exactly are those differences? We may need a more
specific compatible string (even if in addition to those existing ones),
or perhaps other properties.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328978.html
