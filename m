From: Eugeniy.Paltsev@synopsys.com (Eugeniy Paltsev)
Date: Thu, 29 Mar 2018 13:17:01 +0000
Subject: ns16550 earlycon baud broken on BCM5301X since commit
 31cb9a8575ca0 ("earlycon: initialise baud field of earlycon device
 structure")
In-Reply-To: <CACna6rzki=sjXQS12eF3yPXH7XeFYTCXVOdj--F=P=jkJZX7fg@mail.gmail.com>
References: <CACna6rzki=sjXQS12eF3yPXH7XeFYTCXVOdj--F=P=jkJZX7fg@mail.gmail.com>
Message-ID: <1522329420.32101.3.camel@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafa?,

Hm, your 'port->uartclk' value (and therefore 'BASE_BAUD' value) looks strange to me...
Looks like you have 'BASE_BAUD' set to 115200.


Here is my example:
uart clock is 33333333Hz (fixed 33.33MHz xtal clock)
So 'BASE_BAUD' is 33333333/16 = 2083333
So 'port->uartclk' is BASE_BAUD*16 = 33333328
'device->baud' is 115200 (which is read from device tree)
So when we calculate divisor with this code
------------------->8---------------
divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
------------------->8---------------
We got 'divisor' = 181 which is correct value for us.


On Thu, 2018-03-29 at 14:34 +0200, Rafa? Mi?ecki wrote:
> Hi,
> 
> I upgraded my BCM5301X device based on BCM4708 SoC from 4.13 to 4.14
> and noticed earlycon output is corrupted (a wrong baud rate is used).
> 
> 
> I bisected this problem down to the:
> 
> commit 31cb9a8575ca04f47ea113434d4782b695638b62
> Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Date:   Mon Aug 21 19:22:13 2017 +0300
> 
>     earlycon: initialise baud field of earlycon device structure
> 
> 
> My device uses arch/arm/boot/dts/bcm4708.dtsi:
> 
> uart0: serial at 0300 {
>         compatible = "ns16550";
>         reg = <0x0300 0x100>;
>         interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>         clocks = <&iprocslow>;
>         status = "okay";
> };
> 
> aliases {
>         serial0 = &uart0;
> };
> 
> chosen {
>         stdout-path = "serial0:115200n8";
> };
> 
> 
> A valid UART divisor for my device is 54. This is what bootloader sets
> and what works with my serial console running 115200 8n1.
> 
> 
> Before the commit 31cb9a8575ca0 early_serial8250_setup() never tried
> setting baud because device->baud was 0. It left baud (divisor) to
> whatever was configured by the bootloader. It has changed with above
> commit though. So now the setup looks like that:
> 1) port->uartclk equals 1843200 as set in the of_setup_earlycon():
> port->uartclk = BASE_BAUD * 16;
> 2) [NEW] device->baud equals 115200 as set in the of_setup_earlycon():
> early_console_dev.baud = simple_strtoul(options, NULL, 0);
> (a value of options is "115200n8")
> 3) [NEW] divisor is calculated to 1 in the init_port():
> divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
> 4) [NEW] divisor is set using UART_DLL and UART_DLM in the init_port()
> 
> Obviously setting divisor 1 instead of 54 results in a wrong baud.
> 
> 
> So right now my serial console output looks like that:
> ?6;'+{.??s?.???.".??4??.?????.??J|?.?.8??.?..??????g??~.????L>.??,?9z9?{?Z?.."???NC?<?9.?/???.?.?}??~.???"?.?|????;??.??yy?.[
>    0.043623] console [ttyS0] enabled
> [    0.043623] console [ttyS0] enabled
> [    0.050842] bootconsole [ns16550] disabled
> [    0.050842] bootconsole [ns16550] disabled
> [    0.062939] libphy: Fixed MDIO Bus: probed
> (...)
> 
> For a complete log (coming from dmesg command) see attachment.
> 
> 
> Can you take a look at this problem, please? Is there something wrong
> with my DT? Or is a problem in 8250 or earlycon?
> 
-- 
 Eugeniy Paltsev
