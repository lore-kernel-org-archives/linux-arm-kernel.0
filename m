From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 May 2012 00:55:01 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <20120529134632.GB24623@n2100.arm.linux.org.uk>
References: <20120525080500.GB24149@n2100.arm.linux.org.uk>
 <CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
 <20120525094231.GC24149@n2100.arm.linux.org.uk>
 <CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
 <1338268734.1580.26.camel@vkoul-udesk3>
 <20120529073334.GA12217@n2100.arm.linux.org.uk>
 <20120529090215.GA3954@opensource.wolfsonmicro.com>
 <20120529092129.GE12217@n2100.arm.linux.org.uk>
 <20120529131410.GB3954@opensource.wolfsonmicro.com>
 <20120529134632.GB24623@n2100.arm.linux.org.uk>
Message-ID: <20120529235459.GA4054@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 02:46:32PM +0100, Russell King - ARM Linux wrote:
> On Tue, May 29, 2012 at 02:14:11PM +0100, Mark Brown wrote:

> > I'm assuming that you mean the client rather than the DMA controller
> > itself (which we must already have found)?  That makes sense,

> No, I mean the DMA controller *itself*.

I'm quite famililar with the hardware, the issue here is about knowing
what the device is being used for.  In this case due to context being
lost in the quotes I hadn't realised exactly what the bug you were
identifying in the current code actually was, I had thought there was a
DMA channel already at this point but the lack of one is in fact the
problem.

You did identify this briefly on the original submission though as an
issue for sa11x0 (which you were higlighting is very oddball and
indicated you didn't really want in mainline) rather than a widespread
issue and the discussion (well, single followup from Lars-Peter) was
that this could be done incrementally which did seem resonable. After
that nobody did anything.

> That's partly because you took in soc-dmaengine.c, after you ridiculed
> my version - mainly because it didn't support cyclic DMA at the time.

I don't recall ever ridiculing your version, that's an extremely strong
term.  Can you please be more specific?  The nearest I can find to that
is Lars-Peter saying "I had a look at your 'generic' dmaengine PCM
driver patch" (which is rather dismissive).  I did say that the his idea
of moving the cyclic emulation down into dmaengine seemed sensible but I
did also agree that perhaps it was sensible to keep it further up the
stack if depending on other factors and I'm struggling to see this as
ridicule, and I did also express some displeasure at the SA11x0 hardware
design but that's definitely a separate thing.

In terms of the decision to apply the library code it's simply a case of
the fact that it was the only thing submitted, the only issue anyone had
with it was the allocation issue which seemed fixable incrementally, and
it was posted with all the relevant mainline platforms converted over.
This seems like a clear win, providing a noticable improvement on the
previous situation.

Having the library doesn't stop anyone creating a generic DMA driver on
top of it or otherwise fixing or improving on the merged code and it
does provide useful code sharing to the platforms.

> And so I assumed that you'd made up your mind, and just plain weren't
> interested.

I think you're reading something into things that just isn't there.  You
seem to see this as an either/or thing but really as with everything
else in the kernel the current code is just a useful point at which to
start doing incremental development in tree.

As I said at the time I think the final result should be a merge of the
two sets of code, and the addition of cyclic DMA support to your code is
one example of this happening though sadly out of mainline.  Looking at
the current state of things the changes I'd hope to see happen if
anyone's willing to work on it are something like (in no real order):

 - Move the channel acquisition earlier and use that device to allocate
   buffers.
 - Merge the non-cyclic support into mainline.
 - Add the generic driver into mainline in some form or other (or
   otherwise factor even more code out into the generic code).
 - Provide the ability for DAIs to register an ASoC DMA driver for
   themselves from data (like the dmaengine based DT systems want to
   do).
 - Give platforms more control over the parameters for the generic
   driver than they currently do (there's some stuff still #defined in
   the file).

Possibly split up differently somehow but broadly speaking that's where
I'd like to see us going.  Hopefully some or all of this will happen
before I have a dmaengine based platform running mainline, but if not I
guess I'll do some stuff myself.

In short there's clearly room for improvement in what's in mainline,
let's fix it with code.

>              You have been very resistive towards discussing issues
> coming up in this area, and in other areas I've raised with ASoC such
> as the struct device lifetime issues - even when I've created patches
> for you.

The one case I can recall not applying a patch you've sent was those
device lifetime things where my point was that unless there's an issue
being seen in actual systems that really isn't the sort of thing to be
fixing in -rc (which was what you were pushing strongly for), especially
when the patch only addresses a subset of the issue.  I have to say I am
rather conservative about what I'll apply during -rc, especially to core
code and around areas of code like that which are poorly tested
minefields.

Besides, the fix should be done at AC'97 bus level anyway since the
non-ASoC AC'97 code follows exactly the same pattern - if it's worth
fixing it's worth fixing for non-ASoC AC'97 systems too.

Otherwise for things other than patches you have to be aware that, in
common with most other maintainers, I've got a limited amount of time to
work on things and a whole bunch of different priorities both within the
kernel and in the rest of my life so if you're asking for something
that's hard or time consuming it might not happen immediately.  There
are a bunch of other people who work full time on ASoC things with a
similar mandate to me you can ask as well.

> Moreover, because I don't see any hope for the SA11x0 PCM support going
> in (it certainly won't support capture mode due to the need to run the
> playback side to receive capture samples) I'm really not pushing it; it's
> more my testbed for testing out my DMA engine work than serious ASoC
> work.

I really don't recall anything fundamental that would block it at least
for a playback only driver.  There were some issues with L3 but you
explained what they were and otherwise it just seemed to be updating to
current APIs and what looked like fairly straightforward code motion
stuff.

Doing capture might be more tricky but if the bodge is well enough
hidden in the driver or sufficiently non-invasive to the core it
shouldn't be that big a deal.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120530/d65b6b20/attachment.sig>
