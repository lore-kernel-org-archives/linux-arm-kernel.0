From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2017 18:42:47 +0000
Subject: [RFC] tty: pl011: Work around stuck BUSY bit on QDF2400
In-Reply-To: <20170130234417.20855-1-cov@codeaurora.org>
References: <20170130234417.20855-1-cov@codeaurora.org>
Message-ID: <20170131184246.GA27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 06:44:17PM -0500, Christopher Covington wrote:
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> -	unsigned int status = pl011_read(uap, REG_FR);
> +	unsigned int status = pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr;
>  	return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
>  							0 : TIOCSER_TEMT;
>  }

I'd much prefer the reg & mask == val approach, but the above makes that
difficult.

So for the PL011 changes:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
