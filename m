From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 9 Jul 2010 09:16:04 +0200
Subject: [PATCH 3/5] colibri-pxa300: add uart support
In-Reply-To: <201007081904.08769.pieterg@gmx.com>
References: <201007081904.08769.pieterg@gmx.com>
Message-ID: <20100709071604.GS17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi pieterg,

thanks for your patches :)

On Thu, Jul 08, 2010 at 07:04:08PM +0200, pieterg wrote:
> Signed-off-by: pieter <p.grimmerink@inepro.com>
> ---
>  arch/arm/mach-pxa/colibri-pxa300.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/colibri-pxa300.c 
> b/arch/arm/mach-pxa/colibri-pxa300.c
> index e7762ae..381857d 100644
> --- a/arch/arm/mach-pxa/colibri-pxa300.c
> +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> @@ -170,6 +170,33 @@ static inline void __init colibri_pxa310_init_ac97
> (void)
>  static inline void colibri_pxa310_init_ac97(void) {}
>  #endif
>  
> +static mfp_cfg_t colibri_pxa300_uart_pin_config[] __initdata = {
> +	/* FFUART */
> +	GPIO99_UART1_RXD,
> +	GPIO100_UART1_TXD,
> +	GPIO101_UART1_CTS,
> +	GPIO102_UART1_DCD,
> +	GPIO103_UART1_DTR,
> +	GPIO104_UART1_RI,
> +	GPIO105_UART1_DSR,
> +	GPIO106_UART1_RTS,
> +
> +	/* BTUART */
> +	GPIO111_UART2_CTS,
> +	GPIO112_UART2_RXD,
> +	GPIO113_UART2_TXD,
> +	GPIO114_UART2_RTS,
> +
> +	/* STUART */
> +	GPIO8_UART3_TXD,
> +	GPIO110_UART3_RXD,
> +};

Hmm, no. These lines are GPIOs and might be used differently by other
base boards, depending on their pin allocation. So I'd really like to
keep the board support code clean from such assumptions.

Have a look at Eric's devel branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git

and find the patches for the recently done refactoring of the pxa270
colibri module. The idea is to keep everything that is module specific
in one file, and everything which assumes the module is connected to a
certain baseboard somewhere else.

In this tree, you can also see support for the "income" boards, which
are based on the pxa270 module but use the pins differently, have
different hardware connected etc. It's a good example for why the split
made sense.

So I'd suggest you do something similar for the pxa3xx modules and
create a colibri-pxa3xx-evalboard.c or anything and put all baseboard
specific code there. That would also imply moving code that already
exists.

The same counts for the I2C patch. Users of the module might not have
I2C in use, and want to use the pins for other stuff.


Thanks,
Daniel
