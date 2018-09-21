From: rafal@milecki.pl (=?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=)
Date: Fri, 21 Sep 2018 16:36:51 +0200
Subject: [PATCH] ARM: add serial.h and set BASE_BAUD to 0
In-Reply-To: <20180921135913.GM30658@n2100.armlinux.org.uk>
References: <20180920201357.16426-1-zajec5@gmail.com>
 <20180921135913.GM30658@n2100.armlinux.org.uk>
Message-ID: <45c1302d81faf4e77555c3710b793d36@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-09-21 15:59, Russell King - ARM Linux wrote:
> On Thu, Sep 20, 2018 at 10:13:57PM +0200, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>> 
>> For years arm has been using serial.h from asm-generic which sets
>> BASE_BAUD value to the (1843200 / 16). This is incorrect as:
>> 1) This value obviously isn't correct for all devices
>> 2) There are no device specific serial.h with 
>> CONFIG_ARCH_MULTIPLATFORM
> 
> This goes back a long way.  The BASE_BAUD definition is the base baud
> for 8250 compatible UARTs _only_, no others.
> 
> However, as of 182ead3e418a ("earlycon: Remove hardcoded port->uartclk
> initialization in of_setup_earlycon"), port->uartclk is no longer
> initialised using BASE_BAUD.  As acknowledged in 814453adea7d
> ("earlycon: Initialize port->uartclk based on clock-frequency 
> property")
> the initialisation using BASE_BAUD was bogus, and there is now the
> clock-frequency DT property which should be present to set this up.

Thanks a lot for looking at that. I was not aware of the commit
182ead3e418a ("earlycon: Remove hardcoded port->uartclk initialization
in of_setup_earlycon"), too bad it wasn't marked for stable.

I simply assumed that
port->uartclk = BASE_BAUD * 16;
is correct and that has poisoned all my further reasoning.

I've just confirmed that backporting 182ead3e418a to the 4.14 fixes the
problem for me (it results in the same 8250_early.c behavior as setting
BASE_BAUD to 0).

I'm planning to backport both:
182ead3e418a ("earlycon: Remove hardcoded port->uartclk initialization 
in of_setup_earlycon")
814453adea7d ("earlycon: Initialize port->uartclk based on 
clock-frequency property")
to 4.14+ as they fix regression triggered (not to say "caused") by the
commit 31cb9a8575ca0 ("earlycon: initialise baud field of earlycon
device structure").

Please DROP my serial.h patch and thanks again.


> Now, setting BASE_BAUD to zero as per your patch will break the
> 8250 serial driver - this relies on BASE_BAUD being set to the
> current value, and yes, ARM hardware that uses this will break.  So
> this is not a solution.
> 
> The only solution is that BASE_BAUD must not be abused - it must not
> be used by non-8250 hardware, and thankfully there are already
> solutions in the kernel (such as clock-frequency) to allow the clock
> rate to be specified.

Somehow my serial console kept working with BASE_BAUD set to 0. I'm not
sure why.
