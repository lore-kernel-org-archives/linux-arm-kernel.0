From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 4 Nov 2009 10:14:29 +0100
Subject: [PATCH 1/3] ezx: Add camera support for A780 and A910 EZX phones
In-Reply-To: <f17812d70911032238i3ae6fa19g24720662b9079f24@mail.gmail.com>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
	<1257266734-28673-2-git-send-email-ospite@studenti.unina.it>
	<f17812d70911032238i3ae6fa19g24720662b9079f24@mail.gmail.com>
Message-ID: <20091104101429.23338a42.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Nov 2009 14:38:40 +0800
Eric Miao <eric.y.miao@gmail.com> wrote:

> Hi Antonio,
> 
> Patch looks generally OK except for the MFP/GPIO usage, check my
> comments below, thanks.
>

Ok, will resend ASAP. Some questions inlined below after your comments.

> > +/* camera */
> > +static int a780_pxacamera_init(struct device *dev)
> > +{
> > + ? ? ? int err;
> > +
> > + ? ? ? /*
> > + ? ? ? ?* GPIO50_GPIO is CAM_EN: active low
> > + ? ? ? ?* GPIO19_GPIO is CAM_RST: active high
> > + ? ? ? ?*/
> > + ? ? ? err = gpio_request(MFP_PIN_GPIO50, "nCAM_EN");
> 
> Mmm... MFP != GPIO, so this probably should be written simply as:
> 
> #define GPIO_nCAM_EN	(50)
>

If the use of parentheses here is recommended, should I send another
patch to add them to current defines for GPIOs in ezx.c, for style
consistency?

> or (which tends to be more accurate but not necessary)
> 
> #define GPIO_nCAM_EN	mfp_to_gpio(MFP_PIN_GPIO50)
>

For me it is the same, just tell me if you really prefer this one.

> > +
> > +static int a780_pxacamera_power(struct device *dev, int on)
> > +{
> > + ? ? ? gpio_set_value(MFP_PIN_GPIO50, on ? 0 : 1);
> 
> 	gpio_set_value(GPIO_nCAM_EN, on ? 0 : 1);
> 
> > +
> > +#if 0
> > + ? ? ? /*
> > + ? ? ? ?* This is reported to resolve the "vertical line in view finder"
> > + ? ? ? ?* issue (LIBff11930), in the original source code released by
> > + ? ? ? ?* Motorola, but we never experienced the problem, so we don't use
> > + ? ? ? ?* this for now.
> > + ? ? ? ?*
> > + ? ? ? ?* AP Kernel camera driver: set TC_MM_EN to low when camera is running
> > + ? ? ? ?* and TC_MM_EN to high when camera stops.
> > + ? ? ? ?*
> > + ? ? ? ?* BP Software: if TC_MM_EN is low, BP do not shut off 26M clock, but
> > + ? ? ? ?* BP can sleep itself.
> > + ? ? ? ?*/
> > + ? ? ? gpio_set_value(MFP_PIN_GPIO99, on ? 0 : 1);
> > +#endif
> 
> This is a little bit confusing - can we remove this for this stage?
>

Ok, I am removing it for now. I might put this note in again in
future, hopefully with a better description.

[...]

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091104/34863856/attachment-0001.sig>
