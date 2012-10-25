From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 25 Oct 2012 14:53:33 +0200
Subject: [PATCH v2 2/7] i2c: omap: reorder exit path of omap_i2c_xfer_msg()
In-Reply-To: <50893398.6070004@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-3-git-send-email-balbi@ti.com>
 <50893398.6070004@ti.com>
Message-ID: <20617.13901.479604.302420@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Santosh Shilimkar writes:
> On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> > just a cleanup patch trying to make exit path
> > more straightforward. No changes otherwise.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >   drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++++++---------
> >   1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index c07d9c4..bea0277 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -505,6 +505,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> >   {
> >   	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
> >   	unsigned long timeout;
> > +	int ret;
[...]
> > +		ret = -EREMOTEIO;
> > +		goto err;
> >   	}
> > -	return -EIO;
> > +
> > +	return 0;
> With initialized value you can use
> return ret;
> 
Doing it this way has the advantage, that if an additional error exit
is added it will generate an 'uninitialized variable' warning, if it
fails to set the return value.



Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
