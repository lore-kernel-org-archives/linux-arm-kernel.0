From: ljkenny@gmail.com (Lee Jones)
Date: Sun, 26 Oct 2014 15:14:44 +0000
Subject: [PATCH] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <544C67D5.4020004@wwwdotorg.org>
References: <1414156789-30188-1-git-send-email-lkundrak@v3.sk>
 <20141024155115.GE10395@x1> <544C67D5.4020004@wwwdotorg.org>
Message-ID: <20141026151443.GA11689@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 25 Oct 2014, Stephen Warren wrote:
> On 10/24/2014 09:51 AM, Lee Jones wrote:
> > On Fri, 24 Oct 2014, Lubomir Rintel wrote:
> > 
> > Thanks for sending this to list, as you are aware a lot of the other
> > platform drivers depend on this.
> > 
> > FYI: I don't know much about the Mailbox FW, so I'll leave the
> > functional review to the people who do.  This is going to be a coding
> > stylesque review instead. 
> > 
> >> Implement BCM2835 mailbox support as a device registered with the
> >> general purpose mailbox framework. Implementation based on commits by
> >> Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
> >> implementation.
> 
> >> Cc: Stephen Warren <swarren@wwwdotorg.org>
> >> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Cc: linux-rpi-kernel at lists.infradead.org
> >> Cc: linux-arm-kernel at lists.infradead.org
> > 
> > As you're only sending a small patch-set, it's better to address the
> > emails to these guys directly, rather than doing so in here.  Cc's in
> > commit messages are good if there are only a few patches within a
> > large set to be sent to different addresses.
> 
> It's very useful for a submitter so they can work out the desired
> recipients once rather than repeating the process each time they run git
> send-email.

I do understand the convienience, but IMHO it's an abuse of the
function.  The Cc: tag is designed to indicate that a person has been
given the opotunity to comment on a patch, but has failed to do so:

> Documentation/SubmittingPatches:
> 
>   "13) When to use Acked-by: and Cc:
> 
>   [...]
> 
>   If a person has had the opportunity to comment on a patch, but has not
>   provided such comments, you may optionally add a "Cc:" tag to the patch.
>   This is the only tag which might be added without an explicit action by the
>   person it names.  This tag documents that potentially interested parties
>   have been included in the discussion"
> 
> Documentation/development-process/5.Posting:
> 
>   "- Cc: the named person received a copy of the patch and had the
>      opportunity to comment on it."

I also quite like 'extending' the feature to Cc people on a sub-set of
a patch-set who might not necessarily want to be bombarded with the
whole thing to lessen the burden on them; however, I do so sparingly
and with forethought.

If I had to strip out Cc: tags on every patch I applied, it would
drive me crazy.

> Perhaps the U-Boot patman tool might help; I believe it strips out such
> tags when sending email, so you get the benefit of storing metadata in
> the commit description locally, but it doesn't clutter the email that
> actually gets sent.

Perfect.

> > FWIW, you can drop Stephen and myself from Cc completely as we're both
> > subscribed to the RPi list and it's very low volume, thus we're not
> > likely to miss it.
> 
> Technically you're supposed to CC all the maintainers either way, to
> make sure the message shows up in their mailbox. You're right the list
> is low enough volume the message shouldn't be missed, but I de-dup
> message to multiple lists, so if I forgot to make the RPi list match
> higher than the ARM list match (which I admittedly haven't) I might miss
> it without a Cc.

You're right of course.  I was being a little selfish there and
assumed everyone sets up their mail in the same way as I do, therefore
it would not be missed.  Please continue to Cc interested parties
directly.

> >> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
> >> new file mode 100644
> >> index 0000000..5a37ac2
> >> --- /dev/null
> >> +++ b/drivers/mailbox/bcm2835-mailbox.c
> >> @@ -0,0 +1,291 @@
> >> +/*
> >> + *  Copyright (C) 2010 Broadcom
> >> + *  Copyright (C) 2013-2014 Lubomir Rintel
> >> + *  Copyright (C) 2013 Craig McGeachie
> > 
> > Better to put these in chronological order.
> > 
> > Does the Copyright really belong to you?
> 
> Assuming Lubomir made any non-trival changes, he certainly can claim (c)
> (on parts of the file at least).

Interesting, I didn't know it worked that way.  Thanks for answering.

> >> + * Parts of the driver are based on:
> >> + *  - arch/arm/mach-bcm2708/vcio.c file written by Gray Girling that was
> > 
> > This doesn't seem very future-proof.
> > 
> >> + *    obtained from branch "rpi-3.6.y" of git://github.com/raspberrypi/
> >> + *    linux.git
> > 
> > Drop all this please.
> > 
> >> + *  - drivers/mailbox/bcm2835-ipc.c by Lubomir Rintel at
> >> + *    https://github.com/hackerspace/rpi-linux/blob/lr-raspberry-pi/drivers/
> >> + *    mailbox/bcm2835-ipc.c
> >> + *  - documentation available on the following web site:
> >> + *    https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
> > 
> > And this.  Please don't put links to external Git repos in drivers.
> 
> Hmmm. It can be quite useful to track down the history of the driver. If
> not mentioned in the comment, it'd be useful to mention this all in the
> commit description at least.

I'll not disagree with the point that the history of the driver can be
useful, and by all means give credit to original authors (although
Authors: and the (c) do a pretty good job of that already); however,
doing so by providing URLs to personal volatile Git trees is not the
ideal method for doing so.

> >> +	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
> >> +		u32 msg = readl(mbox->regs + MAIL0_RD);
> >> +		unsigned int chan = MBOX_CHAN(msg);
> >> +
> >> +		if (!mbox->channel[chan].started) {
> >> +			dev_err(dev, "Reply on stopped channel %d\n", chan);
> >> +			continue;
> >> +		}
> >> +		dev_dbg(dev, "Reply 0x%08X\n", msg);
> > 
> > This file is riddled with dev_dbg() calls, which are great to have
> > during development, but are of very little use once in production.
> > They also make the place look untidy.  Please remove them.
> 
> They don't print at run-time unless debugging is enabled for this
> driver. Admittedly some of the dev_dbg() aren't that useful, but I think
> tracing the sent/received messages could be quite useful outside of the
> initial mailbox driver development, e.g. so that every person developing
> a driver that uses the mailbox functionality doesn't have to implement
> their own mailbox tracing mechanism. Perhaps the mailbox core provides
> this already though?

I'm not complaining that the bootlog will be filled, but I am picking
up on the overuse of uninteresting debug prints littering the code.
Of the 11 provided, probably 2 of them are useful, and as you say
these should probably live in the framework.

> >> +static const struct of_device_id bcm2835_mbox_of_match[] = {
> >> +	{ .compatible = "brcm,bcm2835-mbox", },
> >> +	{},
> >> +};
> >> +MODULE_DEVICE_TABLE(of, bcm2835_mbox_of_match);
> > 
> > If you don't depend on OF, you need to protect this.
> 
> I've never seen that protected before, but perhaps because I've only
> worked on platforms where OF was unconditionally present.

You have been blessed indeed. :)

> If this is an
> issue, I think it'd be better if the driver depended on OF for now,
> since there's no reason to expect the driver to work on a system without
> OF, since bcm2835 should always have OF.

So normally we use of_match_ptr() to NULLify the pointer to this
struct if OF isn't enabled, so IMHO it stands to reason that it would
be a good idea to not delcare/initialise the struct.

FYI:
$ git grep -C1 of_device_id | grep CONFIG_OF | wc -l
250

Kind regards,
Lee
