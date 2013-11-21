From: olof@lixom.net (Olof Johansson)
Date: Thu, 21 Nov 2013 09:58:22 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <20131121162944.F087FC406A3@trevor.secretlab.ca>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
 <20131121162944.F087FC406A3@trevor.secretlab.ca>
Message-ID: <20131121175822.GA9590@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 04:29:44PM +0000, Grant Likely wrote:
> On Tue, 19 Nov 2013 11:30:15 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Nov 15, 2013 at 05:52:41PM +0000, Olof Johansson wrote: > > On Fri, Nov 15, 2013 at 09:57:17AM +0000, Mark Rutland wrote:
> > > > On Fri, Nov 15, 2013 at 01:44:10AM +0000, Olof Johansson wrote:
> > The UEFI spec pulls in portions of ACPI. I do not know the full extent
> > of the interaction between the two, but I know that they are not
> > completely decoupled. As you have pointed out we are not experienced
> > with ACPI or UEFI, so I don't think we can make statements that one is
> > perfectly fine without the other.
> 
> Not actually. The UEFI spec does define how to pass ACPI, but it can
> boot the system without any ACPI at all. Merging UEFI support should
> pretty much be a non-issue.
> 
> > > > I think that trying to shoe-horn ACPI-derived information into device
> > > > tree is fundamentally the wrong approach. I don't think it encourages
> > > > best practices, and I don't think it's beneficial to the long term
> > > > health of Linux or the ecosystem as a whole.
> > >
> > > There are no known best practices with ACPI. It's a complete fumbling
> > > around in the dark right now. We're complaining about reviewer bandwith
> > > on DT -- do we have a single reviewer for ACPI on ARM that actually
> > > knows what a good solution looks like? I don't think so.
> > 
> > There are many people in the Linux community who have ACPI experience.
> > They may not be active on the ARM side, but it's not fair to say there
> > are no known best practices. I will agree that for the level of
> > variation we're likely to expect we are pushing the boundaries.
> 
> We are pushing a lot of boundaries and doing things on ACPI that have
> never been done before. SPI, GPIOs, Clocks, Regulators, composite
> devices, key-value properties. All brand new territory, and the Linux
> world is driving a lot of it.

This is a bit of a surprise and a significant concern.

The whole point behind ACPI is that it's supposed to abstract away nearly
all of that, and _not_ expose clocks, regulators and other things to
the kernel. If we're going to expose it, then we might as well go all
the way and do it with DT.

Exposing all the low-level details of the platform is very much an
embedded mindset today. Servers don't do it with DT, nor with ACPI
today. So if you're going to build a platform for servers that is
modelled after what's done successfully so far, then sticking to that
basic concept seems like an appropriate thing to do.

> > > So, until there's strong evidence that ACPI is actually going to be
> > > a sane solution, in other words, until someone has shipped a system
> > > that uses it (with Windows) and does it successfully without being
> > > a hot mess, we shouldn't litter the kernel with it.
> > 
> > Again, I'm not sure that we should rely on Windows as our saviour from
> > insanity. A lot of the issues we are going to encounter are going to be
> > in vendor-specific code (i.e. drivers), and I do not believe that is
> > solved by having a single entity in charge of the general frameworks
> > those are built upon.
> 
> Personally, I think the issue of ACPI support should be taken on a
> patch-by-patch basis. A lot of the things that need to be done are quite
> discrete and fairly well contained. If the patches don't look that way
> then push back on them. For the parts that look ready, go ahead and
> merge it. Push back on the ones that don't.

The additional abstractions that are now pushed onto us has impact for
everybody, and will cause churn on a lot of drivers. Things such as
moving to named resources, etc. While it's easy to say "let's take the
patches one by one", that also means nobody keeps an eye on the bigger
picture and whether the whole thing makes sense or not.

So, I think we need both. Of course we're going to review patches as
they're posted (the alternative doesn't make sense). But we also need
to know what the end goal is. Nobody is presenting that today, and until
we know how steep the slippery slope will get (based on what we can see
so far), we shouldn't start down it.


-Olof
