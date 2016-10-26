From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 26 Oct 2016 19:30:13 +0200
Subject: [RFC PATCH 4/5] w1: add a callback to call slave when a new
 device is connected
In-Reply-To: <CANLsYkxfnF9-H9mawt3BWTgy5gjf8Qs3O6iSRGiLQ=8vfYACTQ@mail.gmail.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
 <20161026145756.21689-5-antoine.tenart@free-electrons.com>
 <CANLsYkxfnF9-H9mawt3BWTgy5gjf8Qs3O6iSRGiLQ=8vfYACTQ@mail.gmail.com>
Message-ID: <20161026173013.ryziy7hhtvxgtm3n@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mathieu,

On Wed, Oct 26, 2016 at 10:42:28AM -0600, Mathieu Poirier wrote:
> On 26 October 2016 at 08:57, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
> >                 }
> > +               if (fops->callback) {
> > +                       err = fops->callback(sl);
> > +                       /*
> > +                        * Do not return an error as the slave driver correctly
> > +                        * probed.
> > +                        */
> 
> I don't get this part.  What's the point of calling a callback if a
> failure is not important - maybe I'm just missing something.
> 
> > +                       if (err)
> > +                               dev_err(&sl->dev,
> > +                                       "callback call failed. err=%d\n", err);
> > +               }

In our case it can be not that important: if we fail to apply an
overlay, we can still use the w1 interfaces to access the eeprom.

Anyway, all those errors weren't taken into account by the w1 framework
before (see my other patch). Also, the w1 patches are given for the
example and could be improved. Part of the reason is the w1 framework
itself :-)

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161026/0499f6d0/attachment.sig>
