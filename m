From: Dave.Martin@arm.com (Dave P Martin)
Date: Tue, 20 Jan 2015 14:32:54 +0000
Subject: [PATCH 00/10] drivers: PL011: add ARM SBSA Generic UART support
In-Reply-To: <20150120130832.GA6858@xora-yoga-13.xora.org.uk>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <20150120130832.GA6858@xora-yoga-13.xora.org.uk>
Message-ID: <20150120143254.GB17657@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 01:08:32PM +0000, Graeme Gregory wrote:

[...]

> I have tested this series on Juno where it seems to work and also on FVP
> model where there are some issues.
> 
> On the FVP when we enter usespace a couple of 32 character strings are
> printed then nothing else. 32 Characters is a suspicious number.
> 
> This occurs with both OE based FS from linaro and debian ubstable FS.
> 
> My FVP is version 5602

Can you try this:

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index eb397c7..9ca78db 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1291,6 +1291,7 @@ static void pl011_tx_chars(struct uart_amba_port *uap)
 		writew(uap->port.x_char, uap->port.membase + UART01x_DR);
 		uap->port.icount.tx++;
 		uap->port.x_char = 0;
+		BUG_ON(uap->tx_avail < 1);
 		uap->tx_avail--;
 		return;
 	}


If we can hit that BUG_ON, then it's possible tx_avail is wrapping round
here, though I'm not sure if it is likely to occur in practice.

I'll have a look for other potential issues...

Cheers
---Dave
