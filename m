From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 15:22:18 +0300
Subject: [RFC/PATCH 4/4] gpio: smscece: Add support for gpio IO expander
 feature
In-Reply-To: <CAKdam55SqXiCGv766yxoY1GdDjxNCYNaDdNZPaeLTAXc+3+c6g@mail.gmail.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-5-git-send-email-sourav.poddar@ti.com>
 <20120821105333.GW10347@arwen.pp.htv.fi>
 <CAKdam56DiFpnoQwrHe1tjQWLMy5vP9ynstNj_n=OyMxkJJAUOA@mail.gmail.com>
 <20120821120052.GD10347@arwen.pp.htv.fi>
 <CAKdam55SqXiCGv766yxoY1GdDjxNCYNaDdNZPaeLTAXc+3+c6g@mail.gmail.com>
Message-ID: <20120821122217.GF10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 05:50:28PM +0530, Poddar, Sourav wrote:
> Hi,
> 
> On Tue, Aug 21, 2012 at 5:30 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Tue, Aug 21, 2012 at 05:17:37PM +0530, Poddar, Sourav wrote:
> >> >> +     if (type & IRQ_TYPE_LEVEL_HIGH)
> >> >> +             sg->int_lvl[bank] |= bit;
> >> >> +     else if (type & IRQ_TYPE_LEVEL_LOW)
> >> >> +             sg->int_lvl[bank] &= ~bit;
> >> >> +     else
> >> >> +             return -EINVAL;
> >> >
> >> > this looks wrong. You could have a user who wants to trigger on both
> >> > HIGH and LOW levels, no ?
> >> >
> >> Yes, I think there can be a scenario where gpio_keys are attached
> >> to this driver and signals a "key press" at low and "key release" at
> >> high. ?
> >>  Will figure out a way to add support to check for case where
> >> both High and low levels are used.
> >
> > could probably be done on a separate patch, maybe... Just now I saw that
> > HIGH and LOW levels use the same bit.
> >
> If I am understanding correctly, if they both uses the same bit we cannot
> use both for a particular user. ?

we can, it's just a bit more complex. If a user request both LOW and
HIGH, then you start with HIGH, once it triggers, before calling the
nested IRQ handler, you need to change it LOW. When low triggers, before
calling the nested IRQ handler, you need to change it to HIGH again. And
so on. I'm just not sure if that's valid on linux IRQ subsystem.

Anyone ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/6d7f7c26/attachment.sig>
