From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 19:36:47 +0000
Subject: [PATCH 2/2] ARM: clps711x: Added support for CPU frequencies
 other than 73 MHz
In-Reply-To: <1337104502-5292-3-git-send-email-shc_work@mail.ru>
References: <1337104502-5292-1-git-send-email-shc_work@mail.ru>
 <1337104502-5292-3-git-send-email-shc_work@mail.ru>
Message-ID: <201205151936.48048.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Alexander Shiyan wrote:
> Modern CPUs from CLPS711X-line can operate at frequencies other than 73 MHz.
> This patch adds calculation of system clock frequency and the frequency of
> UART, depending on processor speed. Kconfig option "CPU frequency" was added
> for this purposes.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

I'm sceptical about this patch. While it is an improvement, it doesn't
really go far enough and does not make it possible to build a kernel
that runs on multiple mach-clps711x based machines that each have different
clock frequencies. It would be much better to make it a run-time option
like most other platforms rather than hardcode at compile time.

> diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
> index ea036d6..24a7279 100644
> --- a/arch/arm/mach-clps711x/Kconfig
> +++ b/arch/arm/mach-clps711x/Kconfig
> @@ -45,6 +45,15 @@ config ARCH_P720T
>  config ARCH_FORTUNET
>  	bool "FORTUNET"
>  
> +config EP72XX_CPU_SPEED
> +	int "CPU frequency"
> +	default 73728000
> +	help
> +	  This is a CPU frequency. This value must be setup in bootlader,
> +	  before loading kernel.
> +	  The value can be one of: 18432000, 36864000, 49152000, 73728000 or
> +	  90316800.
> +

I think it would be better to express this as a "choice" statement if you end
up requiring this to be a compile-time option.

> diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b
> diff --git a/arch/arm/mach-clps711x/include/mach/timex.h b/arch/arm/mach-clps711x/include/mach/timex.h
> index ac8823c..fa5ad13 100644
> --- a/arch/arm/mach-clps711x/include/mach/timex.h
> +++ b/arch/arm/mach-clps711x/include/mach/timex.h
> @@ -20,4 +20,6 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>  
> -#define CLOCK_TICK_RATE 512000
> +#include <mach/hardware.h>
> +
> +#define CLOCK_TICK_RATE		(CONFIG_EP72XX_CPU_SPEED / 144)

We're actually trying hard to remove CLOCK_TICK_RATE in the long run.
Most people believe that by now it's completely bogus for all common code,
but I think Russell still isn't convinced.

> diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
> index d0f719f..bae678d 100644
> --- a/drivers/tty/serial/clps711x.c
> +++ b/drivers/tty/serial/clps711x.c
> @@ -401,7 +401,7 @@ static struct uart_port clps711x_ports[UART_NR] = {
>  	{
>  		.iobase		= SYSCON1,
>  		.irq		= IRQ_UTXINT1, /* IRQ_URXINT1, IRQ_UMSINT */
> -		.uartclk	= 3686400,
> +		.uartclk	= UART_BAUD_BASE,
>  		.fifosize	= 16,
>  		.ops		= &clps711x_pops,
>  		.line		= 0,
> @@ -410,7 +410,7 @@ static struct uart_port clps711x_ports[UART_NR] = {
>  	{
>  		.iobase		= SYSCON2,
>  		.irq		= IRQ_UTXINT2, /* IRQ_URXINT2 */
> -		.uartclk	= 3686400,
> +		.uartclk	= UART_BAUD_BASE,
>  		.fifosize	= 16,
>  		.ops		= &clps711x_pops,
>  		.line		= 1,

I think the right way to do this is to move the uart_add_one_port() call
and the clps711x_ports array into platform code, so you can modify the
frequency at boot time, but leave the uart_driver where it is.
That will require some other changes for the console.

It's probably best to leave this patch for after the merge window, so you
can come up with a good solution for 3.6, ok?

	Arnd
