From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 07 Apr 2013 23:14:22 +0200
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <CAKGA1bnhMz-18RvUq1Bx-b_AztwspYC+Q+3QGYf=kBtMe1nq2w@mail.gmail.com>
References: <20130319170933.28337.50448.stgit@localhost>
 <CAKGA1bnt_wrNPg2JdAu=ac+WiUm8pVaGh3Tjrt3NvgdFeLxB8A@mail.gmail.com>
 <CAKGA1bnhMz-18RvUq1Bx-b_AztwspYC+Q+3QGYf=kBtMe1nq2w@mail.gmail.com>
Message-ID: <8699707.bKlCq77L0P@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 of April 2013 11:34:14 Matt Sealey wrote:
> Or actually, let me rephrase that; sure, when we decide that the
> actual clock tree is described IN the device tree and not in Linux -
> the only thing I have to test this on is i.MX and OMAP and it's all a
> huge table in the Linux kernel which the DT uses to reference
> arbitrary indices into a provider array...

I'm not sure what's wrong with that.

> I could add desired parents to the provider array but that wouldn't
> really fix the configuration problem.

I'm not really seeing any configuration problem here. This is an 
artificial problem created by looking at device tree way too 
conservatively, without any significant reason.

> Can we get an agreement that
> actually, no matter how "unwieldy" or "unreadable" some people think
> it might be, that the entire clock tree for a board should end up in
> it's device tree (muxes, selects, gates and all) with suitable
> bindings? This is the only way you'll get clock "hacks" out of the
> source.

Hardware initialization is not really a hack...

Going this way, why to keep any initialization code inside drivers at all? 
Let's initialize USB, MMC, display controllers in the bootloader and just 
make the driver handle user requests assuming that the hardware is already 
initialized.

> I do have a kernel tree for some 3.8-rc (which you know of already)
> which started work on this and I had some success with it. I'll need a
> little while to move it forward after Shawn moved some things around,
> rebase all the work.. there are more problems to fix with how
> everything "works" right now than just a need for configuration data,
> which is why I am so opposed to adding that configuration data. It
> supposes that we are giving complete descriptions already anyway, and
> my proposal relies on having complete descriptions anyway, when we are
> not in either case. Give me a couple weeks and I'll probably have it
> done, if nothing moves under my feet again..
> 
> At the point where we have two proposals here; implement 100 clocks as
> device tree nodes, or implement multiple ways of providing clock
> reparenting and frequency setting information as a configuration
> clock, I would rather implement those 100 clocks as nodes..

...or 200 or 300 or 400... (yes, there are platforms which have so many 
elements in their clock networks and they are not uncommon), good luck 
with parsing this at runtime (either with CPU or yourself when reading
a dts file).

It would make some sense if all those basic elements (divs, muxes, gates) 
on all platforms would be identical, but each platform will have its own 
specific quirks, for which such uber-generic binding would have to 
account.

Now, why the other option is to have multiple ways? What's holding us from 
defining a single way of doing so?

Best regards,
Tomasz

> Matt Sealey <matt@genesi-usa.com>
> Product Development Analyst, Genesi USA, Inc.
> 
> On Sun, Apr 7, 2013 at 11:23 AM, Matt Sealey <matt@genesi-usa.com> 
wrote:
> > On Sun, Apr 7, 2013 at 11:00 AM, Fabio Estevam <festevam@gmail.com> 
wrote:
> >> On Sun, Apr 7, 2013 at 12:50 PM, Matt Sealey <matt@genesi-usa.com> 
wrote:
> >>> If we're dealing with audio codecs, fix the audio codec to accept a
> >>> *table* of possible clock values and if that hardware operates
> >>> differently per clock value, then add that data in there too (like
> >>> the
> >>> cs42l52 audio codec). Where the software and hardware is a little
> >>> more
> >>> dynamic, the same binding works here - and the usual trick is just
> >>> force one configuration possible out of many. The board designer can
> >>> look at all the possibilities and choose the one or two or all that
> >>> will work with the design, and it can go into the device tree.
> >> 
> >> Sorry, but I have a hard time following a so long response.
> >> 
> >> Can't you just send patches to the list with your proposal so that we
> >> can move forward with the idea?
> > 
> > Sure.
> > 
> > --
> > Matt Sealey <matt@genesi-usa.com>
> > Product Development Analyst, Genesi USA, Inc.
