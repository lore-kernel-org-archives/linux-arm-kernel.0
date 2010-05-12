From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Wed, 12 May 2010 09:39:23 +0200
Subject: [PATCH 1/7] DMAENGINE: add generic PrimeCell interface to COH
	901 	318 v6
In-Reply-To: <AANLkTim7Tp8lCwMbQwW5QiQ49j7idFFUWdU3x8azIlok@mail.gmail.com>
References: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
	<AANLkTim7Tp8lCwMbQwW5QiQ49j7idFFUWdU3x8azIlok@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025A6DE803@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Dan]

> >> +void dma_set_ambaconfig(struct dma_chan *chan,
> >> + ? ? ? ? ? ? ? ? ? ? ? struct amba_dma_channel_config *config)
> >
> > What happens when two primecell dma devices are present on one soc?
> > Can that happen? ?In that case we'll have conflicting providers of
> > dma_set_ambaconfig().
> >
> 
> ...the ->device_control() method is already approaching an ioctl()
> let's just add the argument parameter to complete the capability,
> i.e.:
> 
> int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> unsigned long arg);

So the unsigned long arg is to match an ioctl? Okidoki...

If it was only for in-kernel use a void* would be preferred
I believe since assuming unsigned long to be == bus width
is ... well, disturbing, since we'll be casting this into
a struct pointer.

So this should also be used for the AMBA configuration stuff
then, so I have to make first a patch to convert all the
device_control functions and then a patch on top of that to
implement the AMBA call as a device_control() thingie?

(Should work out...)

Just a bit of work, so will take some more hours :-)

I will just have to make a proof-of-concept for the AMBA config
interface for Russell first, then I'll be on the ioctl-like API.

Yours,
Linus Walleij
