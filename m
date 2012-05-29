From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 May 2012 14:14:11 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <20120529092129.GE12217@n2100.arm.linux.org.uk>
References: <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
 <1337932416.1580.2.camel@vkoul-udesk3>
 <20120525080500.GB24149@n2100.arm.linux.org.uk>
 <CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
 <20120525094231.GC24149@n2100.arm.linux.org.uk>
 <CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
 <1338268734.1580.26.camel@vkoul-udesk3>
 <20120529073334.GA12217@n2100.arm.linux.org.uk>
 <20120529090215.GA3954@opensource.wolfsonmicro.com>
 <20120529092129.GE12217@n2100.arm.linux.org.uk>
Message-ID: <20120529131410.GB3954@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 10:21:29AM +0100, Russell King - ARM Linux wrote:
> On Tue, May 29, 2012 at 10:02:15AM +0100, Mark Brown wrote:

> > What is the issue with the current code - it *looks* like you want to
> > use the component device for the DMA as the struct device with dmaengine
> > but I don't understand the issue that's created if we don't (and why
> > things appear to be working for people as they are).

> Look.  It's very very very very simple.

> What does the DMA API take?  A struct device.  What struct device?  Some
> random struct device for something in the system, or what?  No, it takes
> the struct device for the _device_ in the system which is _performing_
> the DMA.

I'm assuming that you mean the client rather than the DMA controller
itself (which we must already have found)?  That makes sense, 

> If you persist in not wanting to care about this, then I'm afraid I'll
> ignore soc-dmaengine-pcm.c entirely as to me its totally bolloxed code.
> What I have as my own version (now with cyclic DMA support) is IMHO a
> far superior and more correct implementation.

I'm sorry, I'm not sure what you mean when you say "if you persist"?
The mail I replied to was the first time I'd seen mention of this issue
at all.  I have to confess I haven't read every dmaengine thread in
detail, they're quite large and when they talk about generic issues they
seem to be focusing pretty much entirely on going over the issues with
the completion callbacks.

It would be enormously helpful if you could submit some code here (you
did once post a link to it but I don't recall it getting sent to the
list), probably as a replacement for the existing code if you don't want
to fix the existing code.  Even though API changes are going to be
required hopefully it should be relatively straightforward to convert
the existing users over to the new API, everything should at least be
following a common pattern so once one device is converted the rest
should be simple.  This seems much more likely to get us somewhere than
the current situation.

Currently we seem to have nobody actually working on this code in
mainline, as far as I can tell you and Vinod are the only people with
any active interest at a framework level (with Vinod's mostly being at
the dmaengine rather than ASoC level; I don't have any hardware with any
sort of dmaengine support) and because you have this out of tree
implementation you're working on you're mostly just offering feedback in
these driver review threads where apparently chunks of it are getting
missed.  Nobody else seems to be showing much inclination to get
involved so it seems unlikely to collide with other work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120529/866f0248/attachment.sig>
