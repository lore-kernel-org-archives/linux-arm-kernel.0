From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 23 Mar 2017 07:43:25 -0700
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <CACRpkdZRfLh9RXRycW_cAxuTYE6tPd7LR32EkAW8y2fh=AxhXA@mail.gmail.com>
References: <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
 <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
 <20170320110718.e44s2gip36m75bqj@pengutronix.de>
 <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
 <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
 <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
 <CAMuHMdUWybAZXc2RbGMGyp4DYQZU9BS8MxXKE5Kfd+aH8+w9sA@mail.gmail.com>
 <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de>
 <CACRpkdZRfLh9RXRycW_cAxuTYE6tPd7LR32EkAW8y2fh=AxhXA@mail.gmail.com>
Message-ID: <20170323144325.GA952@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 02:41:53PM +0100, Linus Walleij wrote:
> On Thu, Mar 23, 2017 at 1:34 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Maybe we can make gpiod_get_optional look like this:
> >
> >         if (!dev->of_node && isnt_a_acpi_device(dev) && !IS_ENABLED(GPIOLIB))
> >                 return NULL;
> >         else
> >                 return -ENOSYS;
> >
> > I don't know how isnt_a_acpi_device looks like, probably it involves
> > CONFIG_ACPI and/or dev->acpi_node.
> >
> > This should be safe and still comfortable for legacy platforms, isn't it?
> 
> I like the looks of this.
> 
> Can we revert Dmitry's patch and apply something like this instead?
> 
> Dmitry, how do you feel about this?

I frankly do not see the point. It still makes driver code more complex
for no good reason. I also think that not having optional GPIO is not an
error, so returning value from error space is not correct. NULL is value
from another space altogether.

Uwe seems to be concerned about case that I find extremely unlikely. We
are talking about a system that does not have GPIO support and behaves
just fine, with the exception that it actually has (physically) a
*single* GPIO, and that GPIO happens to be optional in a single driver,
but in this particular system is actually needed (but that need
manifests in a non-obvious way). And we have system integrator that has
no idea what they are doing (no schematic, etc).

I think that if there is one optional GPIO there will be mandatiry GPIOs
in such system as well and selection of GPIOLIB will be forced early on
in board bringup.

Thanks.

-- 
Dmitry
