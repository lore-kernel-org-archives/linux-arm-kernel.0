From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 May 2014 11:48:42 +0100
Subject: [PATCH v2] ARM: dt: fix up PL011 device tree bindings
In-Reply-To: <1399887437-32154-1-git-send-email-linus.walleij@linaro.org>
References: <1399887437-32154-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140512104841.GA9379@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, May 12, 2014 at 10:37:17AM +0100, Linus Walleij wrote:
> Make the map match the reality, the current binding text is
> nonsense:
> 
> - The clock required for the clocking of the serial port
>   must come first and is not optional (as the driver will
>   otherwise proceed to grab and use the apb_pclk as uartclk),
>   and the apb_pclk that clocks the logic must come second
>   as the code will retrieve the first clock by index,
>   whereas the PrimeCell but will explicitly look for
>   "apb_pclk" so this can be specified later, as it is
>   looked up by name.

This is a problem with basically all the primecell bindings. I posted a
series a while ago [1,2], but got a bit sidetracked and didn't manage to
follow it up. Sorry about that.

> - The pin control state "default" is the only mandated
>   state, the sleep state is entirely optional.
> 
> We also add an example to avoid further confusion.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rename amba_pclk to apb_pclk
> - Split clock/clocks properties and indicate that listin one
>   clock only is deprecated
> ---
>  Documentation/devicetree/bindings/serial/pl011.txt | 28 +++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
> index 5d2e840ae65c..52464918cfe2 100644
> --- a/Documentation/devicetree/bindings/serial/pl011.txt
> +++ b/Documentation/devicetree/bindings/serial/pl011.txt
> @@ -6,12 +6,34 @@ Required properties:
>  - interrupts: exactly one interrupt specifier
>  
>  Optional properties:
> -- pinctrl: When present, must have one state named "sleep"
> -	   and one state named "default"
> -- clocks:  When present, must refer to exactly one clock named
> +- pinctrl: When present, must have one state named "default",
> +	   and may contain a second name named "sleep". The former
> +	   state sets up pins for ordinary operation whereas
> +	   the latter state will put the associated pins to sleep
> +	   when the UART is unused
> +- clocks:  When present, the first clock listed must correspond to
> +	   the clock named UARTCLK on the IP block, i.e. the clock
> +	   to the external serial line, whereas the second clock
> +	   must correspond to the PCLK clocking the internal logic
> +	   of the block. Just listing one clock (the first one) is
> +	   deprecated.
> +- clocks-names: When present, the first clock listed must be named
> +	   "uartclk" and the second clock listed must be named
>  	   "apb_pclk"

This looks good to me, though I'd prefer to have the binding define the
sane case (both clocks are required and should be acquired by name), and
leave the awkward compatibility mechanism as a kernel implementation
detail if possible.

Would you be happy with the pl011 clock portions from my original
series?

Otherwise, this looks good to me.

Cheers,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231572.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231573.html
