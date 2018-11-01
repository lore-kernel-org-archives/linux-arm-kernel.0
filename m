From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 1 Nov 2018 16:21:35 +0000
Subject: [PATCH V3 09/10] dts: fsl: add imx7ulp evk support
In-Reply-To: <CAOMZO5BmqQE4wohBwE65f667cxF8LOcSJ=jECDXLADXbK9OEZQ@mail.gmail.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
 <1540996688-23681-10-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5AZejEAHeB0hQ9T5U2ZJ7MXK=BYm8jY+yyZjbDHo4utGA@mail.gmail.com>
 <VI1PR04MB422242A027713CC447446D6780CE0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CAOMZO5BmqQE4wohBwE65f667cxF8LOcSJ=jECDXLADXbK9OEZQ@mail.gmail.com>
Message-ID: <VI1PR04MB42220F5E1D5864555F4248DF80CE0@VI1PR04MB4222.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Thursday, November 1, 2018 11:57 PM
[...]
> 
> On Thu, Nov 1, 2018 at 12:49 PM A.s. Dong <aisheng.dong@nxp.com> wrote:
> 
> > This seems a bit confusing to me.
> > That GPIO is used to control the SD card power on/off. So it's
> > naturally a GPIO regulator. Looking at exist IMX dts, you will find
> > all similar board doing like this. Pwrseq seems more like to be used for
> WiFi/eMMC card.
> > Am I missed something?
> 
> As per the board schematics the name of the signal is SD0_nRST, where RST
> means "reset".
> 

I guess you may also notice that circuit name above that signal is
" Power Switch for SD3.0".

> There is even this note in the schematics: "ROM Code will reset the SD power
> during boot up through SD_RST".
> 

Yes, but it's more like a RESET.

> eMMC reset is better handled by 'reset-gpios' property from pwrseq.

It's not eMMC.

Let's see more in binding doc:
Required properties:
- compatible : contains "mmc-pwrseq-simple".

Optional properties:
- reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
        at initialization and prior we start the power up procedure of the card.
        They will be de-asserted right after the power has been provided to the
        card.
That looks more like an auxiliary GPIO reset pin which is used along with normal
power up process (see. mmc_power_up ()) which may be commonly used for
WiFi cards. 

But for SD card with a single supply, GPIO regulator seems enough to me.
That's also the using in past years. Are things changed?

Regards
Dong Aisheng
