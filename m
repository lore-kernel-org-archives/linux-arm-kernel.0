From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 20 Mar 2015 14:28:49 +0000
Subject: [RFC PATCH 1/7] serial: Emulate break using control characters
In-Reply-To: <1426688428-3150-2-git-send-email-daniel.thompson@linaro.org>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
 <1426688428-3150-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150320142847.GB4725@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 02:20:22PM +0000, Daniel Thompson wrote:
> Currently the magic SysRq functions can accessed by sending a break on
> the serial port. Unfortunately some networked serial proxies make it
> difficult to send a break meaning SysRq functions cannot be used. This
> patch provides a workaround by allowing the (fairly unlikely) sequence
> of ^B^R^K characters to emulate a real break.

This is neat, but as it stands it feels like a bit of a hack.  It would
be preferable to make the magic string configurable, since almost any
choice is going to upset somebody.

Since this also breaks the console (i.e., changes the behaviour)
It should probably not be on by default: a command-line option or
/proc/sys/kernel tweak should be required in order to turn it on.
Otherwise, this is likely to get activated unconditionally in production
kernels.

A particular concern is that something other than a human user could be
connected to the UART.

I also feel it doesn't really belong in this series.  NMI doesn't
require this in order to be useful, this patch doesn't require NMI, and
anyway it's not specific to arm.


I suggest posting this separately, CCing linux-serial.

Cheers
--Dave

> This approach is very nearly as robust as normal sysrq/break handling
> because all trigger recognition happens during interrupt handling. Only
> major difference is that to emulate a break we must enter the ISR four
> times (instead of twice) and manage an extra byte of state.
> 
> No means is provided to escape the trigger sequence (and pass ^B^R^K to
> the underlying process) however the sequence is proved reasonably pretty
> collision resistant in practice. The most significant consequence is
> that ^B and ^B^R are delayed until a new character is observed.
> 
> The most significant collision I am aware of is with emacs-like
> backward-char bindings (^B) because the character movement will become
> lumpy (two characters every two key presses rather than one character
> per key press). Arrow keys or ^B^B^F provide workarounds.
> 
> Special note for tmux users:
>   tmux defaults to using ^B as its escape character but does not have a
>   default binding for ^B^R. Likewise tmux had no visual indicator
>   showing the beginning of break sequence meaning delayed the delivery
>   of ^B is not observable. Thus serial break emulation does not interfere
>   with the use of tmux's default key bindings.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  include/linux/serial_core.h | 83 +++++++++++++++++++++++++++++++++++----------
>  lib/Kconfig.debug           | 15 ++++++++
>  2 files changed, 80 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index cf9c2ce9479d..56f8e3daf42c 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -160,6 +160,9 @@ struct uart_port {
>  	struct console		*cons;			/* struct console, if any */
>  #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
>  	unsigned long		sysrq;			/* sysrq timeout */
> +#ifdef CONFIG_MAGIC_SYSRQ_BREAK_EMULATION
> +	char                    sysrq_emul;             /* emulation state */
> +#endif
>  #endif
>  
>  	/* flags must be updated while holding port mutex */
> @@ -420,24 +423,6 @@ extern void uart_handle_cts_change(struct uart_port *uport,
>  extern void uart_insert_char(struct uart_port *port, unsigned int status,
>  		 unsigned int overrun, unsigned int ch, unsigned int flag);
>  
> -#ifdef SUPPORT_SYSRQ
> -static inline int
> -uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
> -{
> -	if (port->sysrq) {
> -		if (ch && time_before(jiffies, port->sysrq)) {
> -			handle_sysrq(ch);
> -			port->sysrq = 0;
> -			return 1;
> -		}
> -		port->sysrq = 0;
> -	}
> -	return 0;
> -}
> -#else
> -#define uart_handle_sysrq_char(port,ch) ({ (void)port; 0; })
> -#endif
> -
>  /*
>   * We do the SysRQ and SAK checking like this...
>   */
> @@ -462,6 +447,68 @@ static inline int uart_handle_break(struct uart_port *port)
>  	return 0;
>  }
>  
> +#if defined(SUPPORT_SYSRQ) && defined(CONFIG_MAGIC_SYSRQ_BREAK_EMULATION)
> +/*
> + * Emulate a break if we are the serial console and receive ^B, ^R, ^K.
> + */
> +static inline int
> +uart_handle_sysrq_break_emulation(struct uart_port *port, unsigned int ch)
> +{
> +	const unsigned int ctrlb = 'B' & 31;
> +	const unsigned int ctrlr = 'R' & 31;
> +	const unsigned int ctrlk = 'K' & 31;
> +
> +	if (uart_console(port)) {
> +		if ((port->sysrq_emul == 0 && ch == ctrlb) ||
> +		    (port->sysrq_emul == ctrlb && ch == ctrlr)) {
> +			/* for either of the first two trigger characters
> +			 * update the state variable and move on.
> +			 */
> +			port->sysrq_emul = ch;
> +			return 1;
> +		} else if (port->sysrq_emul == ctrlr && ch == ctrlk &&
> +			   uart_handle_break(port)) {
> +			/* the break has already been emulated whilst
> +			 * evaluating the condition, tidy up and move on
> +			 */
> +			port->sysrq_emul = 0;
> +			return 1;
> +		}
> +	}
> +
> +	if (port->sysrq_emul) {
> +		/* received a partial (false) trigger, tidy up and move on */
> +		uart_insert_char(port, 0, 0, ctrlb, TTY_NORMAL);
> +		if (port->sysrq_emul == ctrlr)
> +			uart_insert_char(port, 0, 0, ctrlr, TTY_NORMAL);
> +		port->sysrq_emul = 0;
> +	}
> +
> +	return 0;
> +}
> +#else
> +#define uart_handle_sysrq_break_emulation(port, ch) ({ (void)port; 0; })
> +#endif
> +
> +#ifdef SUPPORT_SYSRQ
> +static inline int
> +uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
> +{
> +	if (port->sysrq) {
> +		if (ch && time_before(jiffies, port->sysrq)) {
> +			handle_sysrq(ch);
> +			port->sysrq = 0;
> +			return 1;
> +		}
> +		port->sysrq = 0;
> +	}
> +
> +	return uart_handle_sysrq_break_emulation(port, ch);
> +}
> +#else
> +#define uart_handle_sysrq_char(port, ch) ({ (void)port; 0; })
> +#endif
> +
>  /*
>   *	UART_ENABLE_MS - determine if port should enable modem status irqs
>   */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c2d51af327bc..3f54e85c27d2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -372,6 +372,21 @@ config MAGIC_SYSRQ_DEFAULT_ENABLE
>  	  This may be set to 1 or 0 to enable or disable them all, or
>  	  to a bitmask as described in Documentation/sysrq.txt.
>  
> +config MAGIC_SYSRQ_BREAK_EMULATION
> +	bool "Enable magic SysRq serial break emulation"
> +	depends on MAGIC_SYSRQ && SERIAL_CORE_CONSOLE
> +	default n
> +	help
> +	  If you say Y here, then you can use the character sequence ^B^R^K
> +	  to simulate a BREAK on the serial console. This is useful if for
> +	  some reason you cannot send a BREAK to your console's serial port.
> +	  For example, if you have a serial device server that cannot
> +	  send a BREAK. Enabling this feature can delay the delivery of
> +	  characters to the TTY because the ^B and a subsequent ^R will be
> +	  delayed until we know what the next character is.
> +
> +	  If unsure, say N.
> +
>  config DEBUG_KERNEL
>  	bool "Kernel debugging"
>  	help
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
