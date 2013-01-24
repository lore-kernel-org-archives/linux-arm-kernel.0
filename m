From: olofj@chromium.org (Olof Johansson)
Date: Thu, 24 Jan 2013 08:41:20 -0800
Subject: [PATCH] i2c: samsung: resume race fix
In-Reply-To: <20130124132759.GH12933@pengutronix.de>
References: <1352284106-24988-1-git-send-email-ch.naveen@samsung.com>
 <20121107114437.0a563c7e@endymion.delvare>
 <20130124132759.GH12933@pengutronix.de>
Message-ID: <CALiw-2F7tG9ogDHj4Yf47T47rBn6mAiH2XvK8jpWB1a3OhNJBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/24 Wolfram Sang <w.sang@pengutronix.de>

> On Wed, Nov 07, 2012 at 11:44:37AM +0100, Jean Delvare wrote:
> > On Wed, 07 Nov 2012 15:58:26 +0530, Naveen Krishna Chatradhi wrote:
> > > Don't unmark the device as suspended until after it's been re-setup.
> > >
> > > The main race would be w.r.t. an i2c driver that gets resumed at the
> same
> > > time (asyncronously), that is allowed to do a transfer since suspended
> > > is set to 0 before reinit, but really should have seen the -EIO return
> > > instead.
> >
> > I thought that the suspend order was children first and the resume
> > order was parent first?
>
> Same here, why does it not work this way?
>

Sorry for being quiet on this so far, I didn't notice the controversy until
now.

This is actually about half of what the original fix was (which I wrote,
thus my signed-off-by). The original one was related to us having the GPIO
handshake for a shared bus (see separate discussions on how that should be
upstreamed, and the work on that). For reference, that patch is at:
https://gerrit.chromium.org/gerrit/#/c/28126/1/drivers/i2c/busses/i2c-s3c2410.c
.

So, I'm not sure that this patch is really needed. The significant part of
the original one was the move of our internal s3c24xx_i2c_dt_gpio_free()
below setting suspended = 1. Upstream implementation of the same
functionality will be implemented differently, most likely.


-Olof
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130124/9785789b/attachment-0001.html>
