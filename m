From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 15 Dec 2011 07:23:42 +0000
Subject: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux subsystem
In-Reply-To: <CACRpkdYHtgx3Qgx4QRdgOahQXjvSWE_iogWCZjaYQ-VnyS62uQ@mail.gmail.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-5-git-send-email-b29396@freescale.com>
 <20111214211152.GM27267@pengutronix.de>
 <CACRpkdYHtgx3Qgx4QRdgOahQXjvSWE_iogWCZjaYQ-VnyS62uQ@mail.gmail.com>
Message-ID: <7FE21149F4667147B645348EC60578850561FF@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Thursday, December 15, 2011 6:16 AM
> To: Sascha Hauer
> Cc: Dong Aisheng-B29396; linus.walleij at stericsson.com; linux-
> kernel at vger.kernel.org; rob.herring at calxeda.com;
> grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
> kernel at pengutronix.de; Guo Shawn-R65073
> Subject: Re: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux
> subsystem
> Importance: High
> 
> On Wed, Dec 14, 2011 at 10:11 PM, Sascha Hauer <s.hauer@pengutronix.de>
> wrote:
> > On Thu, Dec 15, 2011 at 12:03:42AM +0800, Dong Aisheng wrote:
> 
> >> + ? ? pmx = pinmux_get(&pdev->dev, NULL);
> >> + ? ? if (IS_ERR(pmx)) {
> >> + ? ? ? ? ? ? err = PTR_ERR(pmx);
> >> + ? ? ? ? ? ? goto err_pmx_get;
> >> + ? ? }
> >> + ? ? err = pinmux_enable(pmx);
> >> + ? ? if (err)
> >> + ? ? ? ? ? ? goto err_pmx_enable;
> >> + ? ? imx_data->pmx = pmx;
> >> +
> >
> > Won't this break every i.MX except i.MX6?
>

If not select PINCTRL, pinmux_enable returns ok by default and pinmux_get
Returns NULL which also does not block.
So it will not break other i.MX currently since only mx6q are using PINCTRL.
 
> Not this patch on its own, first the machines have to select PINCTRL
> select PINMUX_FOO
> 
> *Then* it will break :-D
> 

After we move to one single image for mx5 and mx6, it could be an issue
Since PINCTRL may be selected by default.
So mx5 pinmux driver is in my TODO list.

> So if you want to do this for i.MX you need something like selectable
> dummy pinmuxes, i.e. pinmux_get() to return something that just say "OK"
> to everything like the dummy regulators.
> 
> Shall I try to create something like that?
> 
For those platforms do not select PINCTRL, current code does not block.
For platforms do select PINCTRL but does not have pinmux driver ready,
for example, single image for both mx5&mx6,
IMHO it may be better to fix in driver to avoid introduce too much
complexity in pinctrl core.

Regards
Dong Aisheng
