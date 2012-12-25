From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 25 Dec 2012 21:53:32 +0300
Subject: [PATCH] seria: sirf: only use lookup table to set baudrate when
 ioclk=150MHz
In-Reply-To: <1356431162-8372-1-git-send-email-Barry.Song@csr.com>
References: <1356431162-8372-1-git-send-email-Barry.Song@csr.com>
Message-ID: <50D9F62C.6010601@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/25/2012 01:26 PM, Barry Song wrote:

> From: Barry Song <Baohua.Song@csr.com>

> The fast lookup table to set baudrate is only right when ioclk
> is 150MHz. for most platforms, ioclk is 150MHz, but some boards
> might set ioclk to other frequency.

> so re-calc the clk_div_reg when ioclk is not 150MHz.

> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/tty/serial/sirfsoc_uart.c |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)

> diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
> index 142217c..fe28b1f 100644
> --- a/drivers/tty/serial/sirfsoc_uart.c
> +++ b/drivers/tty/serial/sirfsoc_uart.c
> @@ -375,7 +375,12 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
>  	int		threshold_div;
>  	int		temp;
>  
> -	ioclk_rate = 150000000;
> +	struct clk *clk = clk_get_sys("io", NULL);

   Please keep the coding style and insert emoty line here; you can also remove
preceding empty line (not to break the declaration block).

> +	BUG_ON(IS_ERR(clk));
> +
> +	ioclk_rate = clk_get_rate(clk);
> +	clk_put(clk);
> +
>  	switch (termios->c_cflag & CSIZE) {
>  	default:
>  	case CS8:

WBR, Sergei
