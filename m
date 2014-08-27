From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Aug 2014 12:07:47 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140827085538.GS15297@lukather>
References: <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
 <20140827082208.GQ15297@lukather>
 <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
 <20140827085538.GS15297@lukather>
Message-ID: <20140827100744.GD23186@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 10:55:38AM +0200, Maxime Ripard wrote:
> Hi!
> 
> On Wed, Aug 27, 2014 at 10:37:36AM +0200, Geert Uytterhoeven wrote:
> > Hi Maxime,
> > 
> > On Wed, Aug 27, 2014 at 10:22 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > On Wed, Aug 27, 2014 at 08:40:57AM +0100, Mark Brown wrote:
> > >> On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr?m wrote:
> > >>
> > >> > It is not clear to me where the hardware resources should be listed in
> > >> > DT, being it a simplefb node or part of the actual hardware device node
> > >> > properly marked as dynamic boot defaults or something else? It's
> > >> > somewhere inbetween hardware and virtual device, and somewhat volatile.
> > >> > As far as simplefb is concerned it is a hardware desription of the
> > >> > framebuffer, but for a kms driver it's no more than firmware handover of
> > >> > boottime settings and ceases to exists once the kms driver have
> > >> > reconfigured the hardware.
> > >>
> > >> Is simplefb something that should be in the device tree distinctly in
> > >> the first place - shouldn't it be a subset of the functionality of the
> > >> video nodes?  It's the same hardware being driven differently.
> > >
> > > Therorically, yes, but that would mean knowing beforehand what the
> > > final binding will look like, even before submitting the driver. Since
> > > the bindings are always reviewed, and most of the time changed
> > > slightly, that wouldn't work very well with the DT as a stable ABI
> > > policy I guess.
> > 
> > If you don't know how the bindings for a device will look like at the time of
> > writing your DTS, you're always screwed, whether you add a simpefb
> > node or not.
> > 
> > If you know how the bindings look like, just add the device, with an extra
> > "linux,simplefb" compatibility value.
> > If you don't know how the bindings look like, do your utter best in
> > guessing. Your DTS must be amended later anyway, either because
> > you guessed wrong[*] (in case you added a node to have simplefb
> > working), or because you have to add a real device node (in case you
> > didn't add one for simplefb).
> 
> Let's be conservative and consider the case where we would guess
> wrong.
> 
> If we just rely on a simplefb node, when reviewing and integrating the
> "new" bindings to describe accureately the various IPs involved in the
> display path, we would obviously create new compatibles for
> them. Since it's new compatibles, we can come up with any binding we'd
> like, without have to consider the backward compatibility, since it's
> a new binding.
> 
> Then, we just remove the simplefb, all is good.
> 
> If we were to try to create our bindings for all the IPs involved, and
> were not pleased with the binding anymore when merging the driver,
> then we would have to break the bindings, since we don't introduce a
> new compatible anymore, but modifying an existing one.

It's usually a bad idea to merge a binding without an appropriate
implementation thereof in a driver. It's been done in the past and very
often has resulted in bindings that turned out unusable.

You could start out small and only describe the various individual IP
blocks that exist in the hardware with reg, interrupts, clock, etc.
properties, most of which should be known up front. Then you could try
to find out where simplefb fits best.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/3c54a330/attachment.sig>
