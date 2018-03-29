From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 29 Mar 2018 16:37:51 +0200
Subject: ns16550 earlycon baud broken on BCM5301X since commit
 31cb9a8575ca0 ("earlycon: initialise baud field of earlycon device structure")
In-Reply-To: <1522329420.32101.3.camel@synopsys.com>
References: <CACna6rzki=sjXQS12eF3yPXH7XeFYTCXVOdj--F=P=jkJZX7fg@mail.gmail.com>
 <1522329420.32101.3.camel@synopsys.com>
Message-ID: <CACna6rwfCVFHLc_uVQRR=F+53uj8OVtMi1jUygJfTSmDK99+zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 March 2018 at 15:17, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com> wrote:
> Hm, your 'port->uartclk' value (and therefore 'BASE_BAUD' value) looks strange to me...
> Looks like you have 'BASE_BAUD' set to 115200.
>
>
> Here is my example:
> uart clock is 33333333Hz (fixed 33.33MHz xtal clock)
> So 'BASE_BAUD' is 33333333/16 = 2083333
> So 'port->uartclk' is BASE_BAUD*16 = 33333328
> 'device->baud' is 115200 (which is read from device tree)
> So when we calculate divisor with this code
> ------------------->8---------------
> divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
> ------------------->8---------------
> We got 'divisor' = 181 which is correct value for us.

You're right. 115200 is the default BASE_BAUD value coming from:
./include/asm-generic/serial.h:#define BASE_BAUD (1843200 / 16)

You must be using arch/machine that has custom serial.h with different value.

Could there be some wrong logic regarding uartclk / BASE_BAUD / baud
in the tty subsystem?
