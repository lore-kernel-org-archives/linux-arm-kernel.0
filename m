From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Tue, 12 Apr 2016 11:48:46 +0200
Subject: [PATCH v2 0/6] serial: imx: handshaking fixes and improvments
In-Reply-To: <20160412074622.GQ10108@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160411160128.GD26941@ibawizard.net>
 <20160412074622.GQ10108@pengutronix.de>
Message-ID: <20160412094846.GF26941@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [2016-04-12 09:46:22]:

Hi,

> On Mon, Apr 11, 2016 at 06:01:28PM +0200, Petr ?tetiar wrote:
> > Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [2016-03-24 14:24:19]:
> > 
> > > Among others it made my i.MX25 stuck when the other side toggles DCD.
> > > The first 4 patches are fixes that I'd like to see in 4.6-rcX, the last two
> > > patches are merge window material.
> > 
> > just FYI, my i.MX6 board has stopped booting over NFS on 4.6-rc1 and I've just
> > bisected it down to the commit "serial: imx: repair and complete handshaking"
> > 90ebc48386, it's leading to the following CPU stall:
> 
> hmm, I'm confused (because I don't understand it) and something between
> happy and sad (because both 90ebc48386 and the series that fixes it are
> mine).

I don't know what's going on, probably something related to the serial IRQs?

> This is an i.MX6 Solo (i.e. only one cpu)?

This is i.MX6 Quad, Toradex Apalis Ixora (imx6q-apalis-ixora.dts).

> Which patch fixes your problem?

First 3 patches:

  [v2,1/6] serial: imx: fix polarity of RI
  [v2,2/6] serial: imx: let irq handler return IRQ_NONE if no event was handled
  [v2,3/6] serial: imx: make sure unhandled irqs are disabled

> Is it enough to revert just the last hunk of 90ebc48386?

Yes, this fixes it also:

	diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
	index 231e7d5..dab081c 100644
	--- a/drivers/tty/serial/imx.c
	+++ b/drivers/tty/serial/imx.c
	@@ -827,11 +827,6 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
			writel(temp, sport->port.membase + UCR2);
		}
	 
	-       temp = readl(sport->port.membase + UCR3) & ~UCR3_DSR;
	-       if (!(mctrl & TIOCM_DTR))
	-               temp |= UCR3_DSR;
	-       writel(temp, sport->port.membase + UCR3);
	-
		temp = readl(sport->port.membase + uts_reg(sport)) & ~UTS_LOOP;
		if (mctrl & TIOCM_LOOP)
			temp |= UTS_LOOP;

> Do you use fsl,dte-mode for the uart in question?

Yes, from imx6qdl-apalis.dtsi:

	&uart1 {
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_uart1_dte &pinctrl_uart1_ctrl>;
		fsl,dte-mode;
		fsl,uart-has-rtscts;
		status = "disabled";
	};

> IMHO patches 1-4 should get applied before 4.6.

Ok, good, but this leaves 4.5 broken, right? Thanks.

-- ynezz
