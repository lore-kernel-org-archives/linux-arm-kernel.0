From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 18 Aug 2013 01:10:05 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBSRVNFTkRdIGNhbjogbWNwMjUxeDogUmVwbGFjZSBwb3dl?=
 =?UTF-8?B?ciBjYWxsYmFja3Mgd2l0aCByZWd1bGF0b3IgQVBJ?=
In-Reply-To: <520FD60E.4040709@pengutronix.de>
References: <1375963227-6468-1-git-send-email-shc_work@mail.ru>
 <20130817083014.a01144051b158c34ec7dd9d9@mail.ru>
 <520FD60E.4040709@pengutronix.de>
Message-ID: <1376773805.878998573@f169.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 08/17/2013 06:30 AM, Alexander Shiyan wrote:
> [...]
> >> Since DT conversion isn't finished, I still accept the board files.
> >> But this patch should be split into two parts. One is for pxa, and the
> >> other one is for net.
> > 
> > Patch cannot be splitted because this can create hole which break git-bisect.
> > 
> > In any case, I want to create a v2 with a more detailed description, and I
> > have a supplementary question for the CAN subsystem maintainers.
> > "Transciever power" is not used by any of the boards, can we remove it
> > completely? This will greatly simplify driver.
> 
> Do you mean the former transceiver_enable() callback?

Yes.

> >  struct mcp251x_platform_data {
> >  	unsigned long oscillator_frequency;
> >  	unsigned long irq_flags;
> > -	int (*board_specific_setup)(struct spi_device *spi);
> > -	int (*transceiver_enable)(int enable);
> > -	int (*power_enable) (int enable);
> >  };
> 
> Having a switchable transceiver is a quite common thing. So I'd like
> that you keep it. The flexcan driver was just converted from a callback
> to a regulator too. It already has device tree bindings and I'd like to
> use these bindings as a standard for new drivers. From flexcan's dt
> bindings:
> 
> > - xceiver-supply: Regulator that powers the CAN transceiver
> 
> which translates into:
> 
> > priv->reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
> 
> Can you please use "xceiver" instead of "transceiver", so that future DT
> binding will fit the scheme.

OK. I am not ready to add DT support yet, but it can be added later,
so v2 will contain 3 parts:
1 - Replace power callbacks with regulator API
2 - Eliminate mcp251x_platform_data->irq_flags
3 - Replace oscillator_frequency with CLK API (and remove mcp251x.h header)

Are you OK with such changes?

---
