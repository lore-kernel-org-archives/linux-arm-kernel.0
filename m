From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 15:46:18 +0000
Subject: [PATCH v3  10/15] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <5511ABAA.2010303@hurleysoftware.com>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
 <1426197361-19290-11-git-send-email-maxime.coquelin@st.com>
 <5511ABAA.2010303@hurleysoftware.com>
Message-ID: <20150326154618.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 02:23:38PM -0400, Peter Hurley wrote:
> Hi Maxime,
> 
> On 03/12/2015 05:55 PM, Maxime Coquelin wrote:
> > +static unsigned int stm32_get_mctrl(struct uart_port *port)
> > +{
> > +	/*
> > +	 * This routine is used for geting signals of: DTR, DCD, DSR, RI,
> > +	 * and CTS/RTS

It's also worth noting that this comment is wrong.  This is used to get
the state of DCD, DSR, RI and CTS.  DTR and RTS are *not* included
because the core tracks their state.

...

> > +	stm32port->clk = devm_clk_get(&pdev->dev, NULL);
> > +
> > +	if (WARN_ON(IS_ERR(stm32port->clk)))
> 
> Do you really need a stack trace here? Could this be dev_err() instead?
> 
> > +		return -EINVAL;

Also, propagate the error code.

> > +
> > +	/* ensure that clk rate is correct by enabling the clk */
> > +	clk_prepare_enable(stm32port->clk);

And remember to check the return value of clk_prepare_enable().

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
