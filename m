From: bintian.wang@huawei.com (Bintian)
Date: Wed, 6 May 2015 11:16:12 +0800
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <20150505171349.GA30215@leverpostej>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
 <20150505171349.GA30215@leverpostej>
Message-ID: <5549877C.10408@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 2015/5/6 1:13, Mark Rutland wrote:
> Hi,
>
>> +/*Reserved 1MB memory for MCU*/
>> +/memreserve/ 0x05e00000 0x00100000;
>
> What exactly is the MCU used for, and what does it use this memory for?
>
> Can this be carved out from the memory node instead? If the OS doesn't
> need to access this memory to communicate with the MCU, preventing the
> OS from mapping the memory avoids a number of potential issues.
>
> I take it that with UEFI this region is not described to the OS?

MCU is used for system low power control, the reserved memory is hard
coded by hardware and used by MCU, OS will access this memory to
communicate with the MCU to change the CPU frequency.

>
> [...]
>
>> +	psci {
>> +		compatible = "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>
> Are all the PSCI 0.2 mandatory features implemented?
The system off/suspend is under development, and system off will
be released in next months, and system suspend may be released in the
following two months.

Leo does the development of PSCI, and he can give more detailed plan.

So can I keep "arm,psci-0.2" here?

> Can CPU0 be hot unplugged?
Yes, CPU0~CPU7 all can be hot unplugged.


> [...]
>
>> +		uart0: uart at f8015000 {	/* console */
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x0 0xf8015000 0x0 0x1000>;
>> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ao_ctrl HI6220_UART0_PCLK>, <&ao_ctrl HI6220_UART0_PCLK>;
>> +			clock-names = "uartclk", "apb_pclk";
>> +		};
>
> In a previous discussion [1] the UART on HI6220 was described as not
> fully PL011 compliant, with a number of differences (e.g. the FIFO
> length).
>
> Given that, I feel somewhat uncomfortable with the current compatible
> string list. What exactly are those differences? We may need a more
> specific compatible string (even if in addition to those existing ones),
> or perhaps other properties.
The small system can be booted and the console also works well without
changing any code of driver amba-pl011.c, so I think the compatible
string is OK for this patch set.

Hisilicon do some performance enhancements based on PL011, but the
current driver "amba-pl011.c" also works on hi6220 without those
enhancements driver code.

Thanks,

Bintian

>
> Thanks,
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328978.html
>
> .
>
