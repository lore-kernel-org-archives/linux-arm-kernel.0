From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Nov 2010 15:05:50 +0000
Subject: [PATCH] ARM amba: optional PrimeCell core voltage switch
In-Reply-To: <AANLkTimPH7KHZrTtdGSSno7zz7tH56KCbYjoJibK=WwL@mail.gmail.com>
References: <1288778988-11041-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTimPH7KHZrTtdGSSno7zz7tH56KCbYjoJibK=WwL@mail.gmail.com>
Message-ID: <20101103150550.GA11751@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 03, 2010 at 07:41:44PM +0530, Sundar wrote:
> On Wed, Nov 3, 2010 at 3:39 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
> >
> > +static int amba_get_enable_vcore(struct amba_device *pcdev)
> > +{
> > + ? ? ? struct regulator *vcore = regulator_get(&pcdev->dev, "vcore");
> > + ? ? ? int ret;
> > +
> > + ? ? ? pcdev->vcore = vcore;
> > +
> > + ? ? ? if (IS_ERR(vcore)) {
> > + ? ? ? ? ? ? ? /* It is OK not to supply a vcore regulator */
> > + ? ? ? ? ? ? ? if (PTR_ERR(vcore) == -ENODEV)
> > + ? ? ? ? ? ? ? ? ? ? ? return 0;
> > + ? ? ? ? ? ? ? return PTR_ERR(vcore);
> > + ? ? ? }
> 
> If i am right, you corrupt the pcdev->vcore even in an error case.

So?  It's previous value is meaningless, and on failure the amba device
is not registered, and so this value won't be used.
