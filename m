From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 19 Jan 2017 18:41:44 +0100
Subject: [linux-sunxi] [PATCH 1/2] drivers: pinctrl: add driver for
 Allwinner H5 SoC
In-Reply-To: <87a535d3-1170-c388-ce7d-4921e69f4cab@arm.com>
References: <20161223125001.1176-1-icenowy@aosc.xyz>
 <1280f095-ab03-93f8-14d2-99d13ba1ce55@arm.com>
 <CACRpkdYQhfid3VRcaj=7as_+Zg=pX3Svp9FJ_W_Ft8nVuoZqKQ@mail.gmail.com>
 <20170105224210.wfinfucbpkkd44om@lukather>
 <38fe3491-457a-f0c5-54fb-9defdcd45045@arm.com>
 <20170116163124.c5gusyd3j3goivnf@lukather>
 <87a535d3-1170-c388-ce7d-4921e69f4cab@arm.com>
Message-ID: <20170119174144.hiw7lmvdh2tzxtd7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 09:44:37AM +0000, Andre Przywara wrote:
> Hi,
> 
> On 16/01/17 16:31, Maxime Ripard wrote:
> > On Mon, Jan 09, 2017 at 12:16:00AM +0000, Andr? Przywara wrote:
> >> On 05/01/17 22:42, Maxime Ripard wrote:
> >>> On Fri, Dec 30, 2016 at 01:55:44PM +0100, Linus Walleij wrote:
> >>>> On Mon, Dec 26, 2016 at 3:33 PM, Andr? Przywara <andre.przywara@arm.com> wrote:
> >>>>
> >>>>> So while this patch technically looks correct, I was wondering if we
> >>>>> should really explore the possibility of making the whole of sunxi
> >>>>> pinctrl DT controlled.
> >>>>> I brought this up a while ago, but people weren't overly enthusiastic
> >>>>> about it, though their argument weren't really convincing to me[1].
> >>>>>
> >>>>> So:
> >>>>> As this "driver" here is basically a table linking GPIO bit settings
> >>>>> (the actual mux value) to names and every pin we care about needs to be
> >>>>> enumerated in the DT anyway, why not just add something like:
> >>>>> allwinner,pinmux = <4>;
> >>>>> to each pin(group) in the DT and get rid of this "driver" file here
> >>>>> entirely?
> >>>>
> >>>> I'm open to that if you can use pinctrl-single which is in the kernel
> >>>> for this purpose only, and is used with both OMAPs and HiSilicon.
> >>>
> >>> I'm not open to that, and I'm getting tired of discussing it over and
> >>> over again. Andre, if you want to be convinced again, please read the
> >>> last discussion we had on this topic.
> >>
> >> As I said: It didn't convince me back then. And frankly we didn't really
> >> discuss it back then, I just refrained from entering a discussion
> >> against _two_ maintainers at this time, since my capacity on this kind
> >> of email threads is really very limited - especially for something that
> >> is a hobby to me.
> > 
> > This is also (mostly) a hobby to me, which is exactly why I prefer to
> > work on something actually useful, rather than just discussing this
> > over and over again. Just like I don't want (myself, or anyone,
> > really, since we're all in the same boat) to have to maintain two
> > separate pinctrl drivers.
> > 
> > We're having a documented, simple, pinctrl binding, using the generic
> > bindings now (that almost everyone else is using now, or is very close
> > to), and we can leverage as much documentation and code from that. Why
> > would we want to create and maintain a new driver with a new binding,
> > that will need to be documented again, learned by everyone, and will
> > lead only to confusion across the people who just want to have their
> > board supported?
> 
> I agree, and thus was proposing a _slightly changed_ pinctrl driver
> which actually *reduces* the maintenance burden in the kernel.
> In the moment we need to add _both_ a pinctrl .dtsi node _and_ a kernel
> "driver" file, which is really boilerplate code plus a table.
> Also we need to make sure that both these files match.
> If a new SoC is really 99% similar to an existing one, atm we still need
> explicit kernel support if only one pin is changed (see the H5).

That's not true anymore. And while it's true that it reduces the
amount of maintainance on the kernel side and more on the DT side. And
from what you're constantly saying, the thing we can't plan on fixing
/ upgrading is the DT, while the kernel is easy to change.

Which means that if we ever want to fix a non-upgradable DT, the only
way to do that would be to add quirks fixing it in the kernel
itself. Adding more maintainance burden to the kernel.

But really, this is not up for debate. You're 4 years too late for
that for the original binding, and almost 2 years for the generic
binding.

> > I'm sorry, but this is also our jobs as maintainers to prevent all
> > these kind of issues, and to maintain consistency. Switching to one
> > binding to another breaks that consistency on many level,
> 
> Yet we did it for the clocks. The very same argumentation that you gave
> above applies there as well (two different bindings, two sets of drivers
> in the kernel, new learnings for people, etc.)

No, this is very different. An end user just wanting to plug a dumb
device on his i2c bus will never even see how clocks are
described. This is not true for pinctrl.

And all the other arguments for the clocks have been the same than the
pinctrl driver: every driver is converging to the new binding we've
been using, the table in the kernel is easier to fix, etc.

> One difference would be that the new pinctrl binding wouldn't be
> fundamentally different to the old one, up to the point where the old
> driver could possibly use the very same DT nodes (but that would need to
> be worked out).

The story is different if you manage to keep the binding. Every
platform (but TI's) is converging to the generic bindings. Not using
them is not an option. Having a different implementation is.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/17c72b5a/attachment-0001.sig>
