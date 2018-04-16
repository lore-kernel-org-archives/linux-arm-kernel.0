From: stefan@agner.ch (Stefan Agner)
Date: Mon, 16 Apr 2018 12:29:11 +0200
Subject: serial: imx: half-duplex RS485 operation with RTS active low
In-Reply-To: <20180416092257.frbmooduhm4zrhhl@pengutronix.de>
References: <0e88706a05a302201be396d2f03c3e9e@agner.ch>
 <20180416092257.frbmooduhm4zrhhl@pengutronix.de>
Message-ID: <c6059022d48191909d030584f981d1a2@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.04.2018 11:22, Uwe Kleine-K?nig wrote:
> Hi Stefan,
> 
> On Mon, Apr 16, 2018 at 11:14:32AM +0200, Stefan Agner wrote:
>> Using upstream I noticed that RS-485 does not work in the default
>> configuration for our platforms (Toradex Apalis/Colibri). Closer
> 
> This is an i.MX6?
> 

Yes, sorry about that.

But I think it is i.MX UART specific, I noticed the same behavior on
i.MX 7 too.

>> debugging shows that it is related to "serial: imx: default to half
>> duplex rs485".
>>
>> We use the i.MX UART in DTE mode and control the RS-485 transceiver
>> using the RTS signal in low-active mode.
>>
>> 	uart-has-rtscts;
>> 	fsl,dte-mode;
>> 	linux,rs485-enabled-at-boot-time;
>> 	rs485-rts-active-low;
> 
> That means you're not using a GPIO for RTS signaling, right?
>  

I use native RTS capability (which is in DTE mode the CTS signal...)

>> Using this setting leads to the RTS signal not getting asserted (the
>> oscilloscope only shows a very short fluke before the start bit is
>> sent).

Just FYI, the fluke looks like a proper assert, but it is really only
50ns wide.

>>
>> However, using
>>
>> 	uart-has-rtscts;
>> 	fsl,dte-mode;
>> 	linux,rs485-enabled-at-boot-time;
>> 	rs485-rts-active-low;
>> 	rs485-rx-during-tx;
>>
>> Asserts the RTS signal low active just fine...
>>
>> Is this a known problem? Any idea where that could come from? It looks
>> as if the receiver part is actually enabling RTS...?
> 
> Which kernel version do you use? My latest rs485 related patches went
> into v4.17-rc1. With that I managed to make rs485 half duplex work on
> several customer boards.

I used v4.17-rc1.

I noticed your changes, but I it seems they make no difference, last
week I noticed the same issue in v4.16.

Do those customer boards use DTE mode?

--
Stefan

> 
>> Also, isn't enabling RX even in half-duplex mode quite common in order
>> to detect collisions?
> 
> I don't know.
> 

Probably also depends on the exact use case and the transceiver
configuration.

--
Stefan
