From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 14 Jul 2012 13:29:29 +0200
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <201207131410.29469.marex@denx.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <1341850974-11977-2-git-send-email-marex@denx.de>
 <20120713082249.GF32184@pengutronix.de>
 <201207131410.29469.marex@denx.de>
Message-ID: <20120714112929.GB29529@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek,

> It'd be cool if someone complained earlier and the responses to new patches 
> would be faster. This series has been going on for more than two months and 

I agree it would be cool to response faster. Maintaining being mostly my
priavte fun, I can't make guarantees, though. It just happened that I
didn't have much time for Linux in the last weeks. Actually, I am quite
happy that I managed to work through most of the backlog for the next
merge-window at all (in my holidays!). That's from my side, I can't tell
why other people didn't review; all being too busy is the most likely
guess.

> noone complained about this part until now. Instead I was made to document this 
> and now I have to do it in completely different way? Decide already ...

When we decided to have the fallback mode as a configuration option, the
driver was still considering platform_data. That would have been no
problem...

> 
> > For one reason, this is not a
> > hardware property or board specific, so not a good device tree property.
> 
> Actually, there're still people who might benefit of doing PIOq only, since they 
> do small (eg. one byte) transfers. And this is good to have configurable per 
> bus.

... but we are now on devicetree and things are different there, sadly.
"use-pio" is exposing a driver specific detail which is neither
describing the hardware nor it is OS agnostic. Other drivers from other
OS might not even have the seperation, because they might only use PIO
mode (not even PIOQUEUE). So, the binding is not acceptable AFAIK.
We can add devicetree-discuss to the CC-list.

> > Also, it is implicitly deprecated somehow since either we want DMA to
> > fully work
> 
> And the DMA doesn't fully work?

It probably does. I was just stating the intention.

> > or, even better, somewhen be able to automatically switch
> > between PIOQUEUE and DMA depending on the i2c_msg size.
> 
> That'd be cool. Some months ago, you promised to take a look. I tried it 
> recently again with not much luck.

Yes, I wanted to. I couldn't (see above). I do imagine that it really
might not be possible to switch modes at runtime. This is why I was
trying to get the patch into the next release without the
mode-switching. But for that to happen, there was the binding issue. I
came up with the module parameter as the easiest way to fix it. I am
open to other solutions. Simply dropping the binding might be another
idea if we pay attention that there are no regressions, going from
PIOQUEUE to DMA.

I am also still interested to check the runtime switching, but it might
take another month until I can really hack on it.

> > Deprecated
> > properties are also troublesome. Third, we don't really need this per
> > instance, if somebody really has problems with DMA, it will apply to all
> > i2c busses. Makes sense?
> 
> No, it doesn't. See above about small transfers. Consider the easy situation 
> where you have sensor on one bus (so you do PIO because you transfer small data) 
> and you have EEPROM on other bus, where you use DMA because you transfer large 
> data. And the mixed mode isn't there yet.

I fully understand what you want to configure. I did before. Yet,
devicetree bindings are not platform_data and shouldn't be used like
them.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120714/bcd928c3/attachment.sig>
