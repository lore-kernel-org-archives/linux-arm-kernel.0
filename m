From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Feb 2015 09:41:10 +0000
Subject: [PATCH v4 02/10] mtd: st_spi_fsm: Fetch boot device locations
 from DT match tables
In-Reply-To: <20150224050452.GG18140@ld-irv-0074>
References: <1421853868-8262-1-git-send-email-lee.jones@linaro.org>
 <1421853868-8262-3-git-send-email-lee.jones@linaro.org>
 <20150206042744.GK18140@ld-irv-0074> <20150210074634.GD8020@x1>
 <20150224050452.GG18140@ld-irv-0074>
Message-ID: <20150224094110.GA20969@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Feb 2015, Brian Norris wrote:

> On Tue, Feb 10, 2015 at 03:46:34PM +0800, Lee Jones wrote:
> > On Thu, 05 Feb 2015, Brian Norris wrote:
> > > On Wed, Jan 21, 2015 at 03:24:20PM +0000, Lee Jones wrote:
> > > > To trim down on the amount of properties used by this driver and to conform
> > > > to the newly agreed method of acquiring syscfg registers/offsets, we now
> > > > obtain this information using match tables.
> > > 
> > > Where did this agreement happen? Are you only referring to the previous
> > > patch?
> > 
> > I think your interpretation of the above text and my intentions are
> > not the same.
> 
> To be clear: I'm simply asking what do you mean by "agreed method". I
> never agreed to syscfg registers/offsets. So who did? Are you agreeing
> with yourself?

Look:

> The description above is pertaining to the
> different/new way in which we obtain and request syscfg registers.

When I say "agreed method", I mean the way in which we obtain syscfg
registers/offsets, not the reason for using them.  How is that not
clear in the commit log, "agreed method of acquiring syscfg registers/
offsets"?

And no, you never agreed to that.  You weren't part of the
conversation.  For your own reference one of the first patches which
deals with this "newly agreed method" and supplies a succinct
explanation can be found here:

  https://lkml.org/lkml/2014/11/19/78

> > The description above is pertaining to the
> > different/new way in which we obtain and request syscfg registers.
> 
> OK. So you're dealing with the "how" but not the "why."

I'm dealing with answering the question that was asked.  You mentioned
that you did not "agree" to using the boot devices in this way and I
was explaining that when I said "agreed", I was talking about
something else.

> That is not a reasonable way to develop good code.

I'm not entirely sure what you're talking about.  This patch was
designed to introduce a clean way to extract important values from
syscfg to be used with functionality written by our local MTD expert.
I don't know about you, but I believe that identifying a need, setting
an aim and successfully achieving that aim is a great way to code.

Unless of course you re you insinuating that I should have been aware
of conversations which you previously had with other parties about
resilience to mode setting over reset/power-outage?

> > I have no idea why there is a different configuration
> > depending on if we booted from SPI NOR or not and hence can not answer
> > your query below.
> 
> Seriously? That's all you can come up with? Sheesh. And you wonder why I
> called you out on not understanding the code that you're sending me.

I already explained to you that I am not an MTD expert and still you
cut me no slack.  At one time I was supported by someone who can
answer all of these questions; however, as you well know, this is no
longer the case.  The company does have people that specialise in MTD,
but they are so busy with customer projects that they have no time to
support these endeavours.  So I am on my own!

Everything that I know now, I have learned from you.  So please don't
act so surprised when I struggle to answer all these new questions
you're posing.

> > In previous incarnations of this patchset, we were defining new vendor
> > specific properties in order to request and register and the mask:
> > 
> >   st,boot-device-reg = <0x958>;
> >   st,boot-device-spi = <0x1a>;
> > 
> > ... this is not optimal, as DT properties should only be created if
> > there are no other way to obtain platform specific information.  As
> > there are few supported platforms and this configuration does not
> > change through variants, we are now supplying it via static tables,
> > which can be obtained easily using the DT match framework.
> 
> I understand what you're doing with syscfg and these register offsets.
> But if you follow the code as to what they're actually producing, you
> see that it yields the 'booted_from_spi' boolean. That's a pretty simple
> concept.
> 
> Now, unless you were able to provide an additional enlightening
> viewpoint, then the following paragraph likely all holds true:
> 
> > > Also, I realized that all this boot device / syscfg gymnastics is just
> > > for one simple fact; your driver is trying to hide the fact that your
> > > system can't reliably handle 4-byte addressing for the boot device. Even
> > > if you try your best at toggling 4-byte addressing before/after each
> > > read/write/erase, you still are vulnerable to power cuts during the
> > > operation. This is a bad design, and we have consistently agreed that we
> > > aren't going to work around that in Linux.
> > > 
> > > Better solutions: hook up a reset line to your flash; improve your boot
> > > ROM / bootloader to handle 4-byte addressing for large flash.

Okay, I'm re-read the code and have a new understanding about the
boot-from-spi 'gymnastics'. 

There is a separate controller on the platform which acts as a boot
device and makes the NOR chip appear as though it is memory mapped.
This expects the NOR Controller to be in its default state [24-bit
addressing] on boot.  The issue arises if a warm-reset occurs and the
device is still in 32-bit addressing mode.  To minimise the risk, the
controller attempts to stay in 24-bit addressing mode for as long as
possible.

You mentioned power-cuts.  I do not believe this to be an issue, as
when the power is completely removed the controller will reset back
into default state.  Only warm-resets are an issue.

> And so we have also reached the boundaries of my willingness to review
> your code. There's a significant technical point here that drove you to
> define several new DT compatible strings. I propose (and am now more
> convinced) that this is not actually necessary. But apparently you are
> not equipped to have a discussion about this.
> 
> I'm tempted to:
> 
>   git rm drivers/mtd/devices/st_spi_fsm.c
> 
> (Along with the appropriate Kconfig and Makefile entries, of course.)

That would be very immature indeed.

> > > What's the possibility of dropping all this 4-byte address toggling
> > > shenanigans? This will be a blocker to merging with spi-nor.c.

We wouldn't be able to remove this code without significantly
weakening resilience to warm-reset mishaps, and changing the hardware
design for devices which have already been released is obviously out
of the question.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
