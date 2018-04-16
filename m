From: stefan@agner.ch (Stefan Agner)
Date: Mon, 16 Apr 2018 15:01:44 +0200
Subject: serial: imx: half-duplex RS485 operation with RTS active low
In-Reply-To: <c6059022d48191909d030584f981d1a2@agner.ch>
References: <0e88706a05a302201be396d2f03c3e9e@agner.ch>
 <20180416092257.frbmooduhm4zrhhl@pengutronix.de>
 <c6059022d48191909d030584f981d1a2@agner.ch>
Message-ID: <94f7fcf8873f7607087fc3a59a9422a8@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.04.2018 12:29, Stefan Agner wrote:
> On 16.04.2018 11:22, Uwe Kleine-K?nig wrote:
>> Hi Stefan,
>>
>> On Mon, Apr 16, 2018 at 11:14:32AM +0200, Stefan Agner wrote:
>>> Using upstream I noticed that RS-485 does not work in the default
>>> configuration for our platforms (Toradex Apalis/Colibri). Closer
>>
>> This is an i.MX6?
>>
> 
> Yes, sorry about that.
> 
> But I think it is i.MX UART specific, I noticed the same behavior on
> i.MX 7 too.
> 
>>> debugging shows that it is related to "serial: imx: default to half
>>> duplex rs485".
>>>
>>> We use the i.MX UART in DTE mode and control the RS-485 transceiver
>>> using the RTS signal in low-active mode.
>>>
>>> 	uart-has-rtscts;
>>> 	fsl,dte-mode;
>>> 	linux,rs485-enabled-at-boot-time;
>>> 	rs485-rts-active-low;
>>
>> That means you're not using a GPIO for RTS signaling, right?
>>
> 
> I use native RTS capability (which is in DTE mode the CTS signal...)
> 
>>> Using this setting leads to the RTS signal not getting asserted (the
>>> oscilloscope only shows a very short fluke before the start bit is
>>> sent).
> 
> Just FYI, the fluke looks like a proper assert, but it is really only
> 50ns wide.
> 

Also tried DCE mode, the same behavior.

Two screenshots showing TX/RTS (CTS_B) in different settings:
https://imgur.com/a/PbUex

The little fluke disappears when disabling RX before setting CTSC:

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -657,6 +657,9 @@ static void imx_uart_start_tx(struct uart_port
*port)
        if (port->rs485.flags & SER_RS485_ENABLED) {
                u32 ucr2;
 
+               if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+                       imx_uart_stop_rx(port);
+
                ucr2 = imx_uart_readl(sport, UCR2);
                if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
                        imx_uart_rts_active(sport, &ucr2);
@@ -664,9 +667,6 @@ static void imx_uart_start_tx(struct uart_port
*port)
                        imx_uart_rts_inactive(sport, &ucr2);
                imx_uart_writel(sport, ucr2, UCR2);
 
-               if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
-                       imx_uart_stop_rx(port);
-
                /*
                 * Enable transmitter and shifter empty irq only if DMA
is off.
                 * In the DMA case this is done in the tx-callback.

It seems that if the RX path is disabled, CTS_B is no longer
controllable. It just stays high. That is not a problem in the high
active RTS case... However, it breaks low active half-duplex...

It seems that this thread is describing this situation:
https://community.nxp.com/thread/385047

--
Stefan

>>>
>>> However, using
>>>
>>> 	uart-has-rtscts;
>>> 	fsl,dte-mode;
>>> 	linux,rs485-enabled-at-boot-time;
>>> 	rs485-rts-active-low;
>>> 	rs485-rx-during-tx;
>>>
>>> Asserts the RTS signal low active just fine...
>>>
>>> Is this a known problem? Any idea where that could come from? It looks
>>> as if the receiver part is actually enabling RTS...?
>>
>> Which kernel version do you use? My latest rs485 related patches went
>> into v4.17-rc1. With that I managed to make rs485 half duplex work on
>> several customer boards.
> 
> I used v4.17-rc1.
> 
> I noticed your changes, but I it seems they make no difference, last
> week I noticed the same issue in v4.16.
> 
> Do those customer boards use DTE mode?
> 
> --
> Stefan
> 
>>
>>> Also, isn't enabling RX even in half-duplex mode quite common in order
>>> to detect collisions?
>>
>> I don't know.
>>
> 
> Probably also depends on the exact use case and the transceiver
> configuration.
> 
> --
> Stefan
