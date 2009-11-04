From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 4 Nov 2009 12:35:36 +0100
Subject: [PATCH 1/3] ezx: Add camera support for A780 and A910 EZX phones
In-Reply-To: <Pine.LNX.4.64.0911040907400.4837@axis700.grange>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
	<1257266734-28673-2-git-send-email-ospite@studenti.unina.it>
	<f17812d70911032238i3ae6fa19g24720662b9079f24@mail.gmail.com>
	<Pine.LNX.4.64.0911040907400.4837@axis700.grange>
Message-ID: <20091104123536.9b95d161.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Nov 2009 09:13:16 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> On Wed, 4 Nov 2009, Eric Miao wrote:
> 
> > Hi Antonio,
> > 
> > Patch looks generally OK except for the MFP/GPIO usage, check my
> > comments below, thanks.
> > 
> > > +/* camera */
> > > +static int a780_pxacamera_init(struct device *dev)
> > > +{
> > > + ? ? ? int err;
> > > +
> > > + ? ? ? /*
> > > + ? ? ? ?* GPIO50_GPIO is CAM_EN: active low
> > > + ? ? ? ?* GPIO19_GPIO is CAM_RST: active high
> > > + ? ? ? ?*/
> > > + ? ? ? err = gpio_request(MFP_PIN_GPIO50, "nCAM_EN");
> > 
> > Mmm... MFP != GPIO, so this probably should be written simply as:
> > 
> > #define GPIO_nCAM_EN	(50)
> 
> ...but without parenthesis, please:
> 
> #define GPIO_nCAM_EN	50
> 
> same everywhere below
>

OK.

BTW, Guennadi, shouldn't the pxa_camera platform_data expose also an
exit() method for symmetry with the init() one, where we can free the
requested resources?

If you want I think I can add it.

[...]
> > > +
> > > +static int a780_pxacamera_power(struct device *dev, int on)
> > > +{
> > > + ? ? ? gpio_set_value(MFP_PIN_GPIO50, on ? 0 : 1);
> > 
> > 	gpio_set_value(GPIO_nCAM_EN, on ? 0 : 1);
> 
> IMHO better yet
> 
> 	gpio_set_value(GPIO_nCAM_EN, !on);
> 
> Also throughout the patch below.
> 
> I'm still to look at it miself and maybe provide a couple more comments, 
> if any.
> 

Ok, thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091104/a4c5d482/attachment-0001.sig>
