From: greg@kroah.com (Greg KH)
Date: Fri, 20 Jan 2012 13:20:22 -0500
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <CANmRt2gZe7dfRe5T8fS-1LGkeQXOBzcrbzL8xU+J9M7X4ZuDrA@mail.gmail.com>
References: <1327075829-14346-1-git-send-email-lee.jones@linaro.org>
 <1327075829-14346-3-git-send-email-lee.jones@linaro.org>
 <20120120163646.GA4900@kroah.com>
 <CANmRt2gZe7dfRe5T8fS-1LGkeQXOBzcrbzL8xU+J9M7X4ZuDrA@mail.gmail.com>
Message-ID: <20120120182022.GB9999@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 05:13:33PM +0000, Lee Jones wrote:

[hint, turn off html in gmail, your messages are not getting through to
the mailing lists...]

> On Fri, Jan 20, 2012 at 4:36 PM, Greg KH <greg@kroah.com> wrote:
> 
> > On Fri, Jan 20, 2012 at 04:10:25PM +0000, Lee Jones wrote:
> > > +struct soc_device *soc_device_register(struct soc_device_attribute
> > *soc_dev_attr)
> > > +{
> > > +     struct soc_device *soc_dev;
> > > +     int ret;
> > > +     int i, j = 0;
> > > +
> > > +     soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
> > > +     if (!soc_dev) {
> > > +             ret = -ENOMEM;
> > > +             goto out1;
> > > +     }
> > > +
> > > +     /* Ensure no empty attributes are created. */
> > > +     for (i = 0; i < sizeof(*soc_attr); i++) {
> > > +             if ( soc_attr[i] != NULL ) {
> > > +                     soc_attr[j++] = soc_attr[i];
> > > +             }
> > > +     }
> > > +     for (i = j; i < sizeof(*soc_attr); i++) {
> > > +             soc_attr[i] = NULL;
> > > +     }
> >
> > Huh?
> >
> > Ick, no, don't do this, that's just looney.  Use the api WE ALREADY HAVE
> > for this type of thing.
> >
> > Sometimes I wonder why we even write core code, if people just ignore it
> > and try to do it on their own...
> >
> 
> Sorry. Just another splash of ignorance on my part.
> 
> If I would have known about an API to use, I would have used it (as it
> would have saved me time).
> 
> I'll go mindlessly grepping for things that my be of use and replace it.
> 
> (Of course a hint wouldn't go a miss if you're feeling charitable - every
> day's a school day and all that.) :)

Hey, I offered to write this whole chunk of code myself in the past, and
that was rejected, so I'm not feeling all that generous myself...

But I'll be nice, just this once.

Look at the is_visible() callback in the attribute group structure, that
is what you want to set.

You owe me a beer.

greg k-h
