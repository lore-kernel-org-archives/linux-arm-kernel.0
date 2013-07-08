From: b32955@freescale.com (Huang Shijie)
Date: Mon, 8 Jul 2013 16:54:08 +0800
Subject: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad name
In-Reply-To: <20954.27392.875173.755391@ipc1.ka-ro>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>	<1373004752-21302-5-git-send-email-b32955@freescale.com>	<20130706050803.GC30164@S2101-09.ap.freescale.net>	<20953.22066.706534.773272@ipc1.ka-ro>	<51DA5CA7.1050305@freescale.com>
 <20954
Message-ID: <51DA7E30.3040009@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?08? 15:32, Lothar Wa?mann ??:
> Hi,
>
> Huang Shijie writes:
>> ? 2013?07?07? 19:51, Lothar Wa?mann ??:
>>> Hi,
>>>
>>> Shawn Guo writes:
>>>> On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
>>>>> There is something wrong with the RTS/CTS pads:
>>>>>     The RTS pad is assigned with the CTS's value;
>>>>>     while the CTS pad is assigned with the RTS's value.
>>>>>
>>>> So basically, you are saying that select_input should be set up for CTS
>>>> rather than RTS.  It seems that the people who generated the macro got
>>>> the wrong input from developer.
>>>>
>>> programming 'select_input' only makes sense for inputs, not outputs.
>>> Since CTS is an output signal, select_input only makes sense for the
>>> RTS function of the pads.
>> Hi Lothar:
>>
>> In our imx6 Soc, the CTS is used as a input signal, not as a output signal.
>>
>> I checked two boards, one is imx6q ARM2 armidillo board, one is
>> imx6-sabreauto board,
>> both the boards use the CTS as a input signal.
>>
> that's the problem with the DTE/DCE mode. Depending on the DCEDTE bit
> in the UARTx_UFCR we would need different pad configurations for
> RTS/CTS because in DCE mode CTS is an output and in DTE mode it's an

yes. thanks for explanation.


> input.
> Thus the correct pad config value would need the input_sel on the CTS
> pad definition for DTE mode and on the RTS pad definition for DCE
Since the default pad is used for DCE mode, what we need to do is
add two extra pads for the DTE mode.

thanks
Huang Shijie
> mode. Maybe something like:
> #define MX6Q_PAD_EIM_D19__UART1_DCE_CTS_B             0x09c 0x3b0 0x000 0x4 0x0
> #define MX6Q_PAD_EIM_D19__UART1_DCE_RTS_B             0x09c 0x3b0 0x91c 0x4 0x0
> #define MX6Q_PAD_EIM_D19__UART1_DTE_CTS_B             0x09c 0x3b0 0x91c 0x4 0x0
> #define MX6Q_PAD_EIM_D19__UART1_DTE_RTS_B             0x09c 0x3b0 0x000 0x4 0x0
>
>
> Lothar Wa?mann
