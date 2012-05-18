From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 May 2012 21:04:55 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <CAJe_ZhebPfmLS8ur8FAnmdj37ye25HrE2QF-Qk5PVDnzmpAniQ@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201205161942.20296.arnd@arndb.de>
 <CAJe_ZhebPfmLS8ur8FAnmdj37ye25HrE2QF-Qk5PVDnzmpAniQ@mail.gmail.com>
Message-ID: <201205182104.55990.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Jassi Brar wrote:
> On 17 May 2012 01:12, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > I'm still anything but convinced by this model. Basically it's the
> > exact opposite of what we do for every other subsystem (irq, pinctrl,
> > regulator, gpio, ...), where the device using some infrastructure
> > contains the information about who provides it, whereas here you
> > move all the information into the device that provides the functionality,
> > and have no handle in the device using it by which the driver can
> > identify it.
> >
> The idea was that a client shouldn't need to know/tell which dma controller
> serves it or which peripheral interface of a dma controller.
> I think in future third-party device IPs, like ARM's Primecell, are only gonna
> get more common so it makes even more sense.

I don't understand why this is an advantage. I definitely agree that the
client driver should not know or care about the type of DMA controller
that is being used, IMHO it makes a lot of sense if the device node
specifies the dma line in the way that is specific to the controller.
It already does the same thing for IRQ, GPIO and other stuff, so it's
consistent and not an additional burden on the author of the device
tree source file.

> > I believe that it can work and that it solves the problem you are
> > faced with at minimal complexity, but you put the burden of this
> > complexity on everybody who does not have this issue, and make
> > the general binding confusing and harder to read.
> >
> I am sorry if I gave you the wrong impression, but I didn't intend to just
> scratch my personal itch. I truly believed I and Stephen reached a generic
> solution i.e, as much as it could be.

Yes, I realize I should have stepped in earlier. The proposal you have made
is indeed generic and can cover important cases that the original proposal
did not. My objection is that it's too complex at doing that for the common
case though and that I think we can get a simpler solution that still
solves the same problem.

I already replied to Stephen expanding on his proposed solution, which I
find reasonable, especially in the refined version of my reply. Like your
proposal, it treats multiple dma engines for the same client as the normal
case, by slightly extending the binding that Jon posted.

Another solution that I find equally ok is the one that I proposed earlier
in this thread, where we assume that for each dma request line there is
exactly one dma engine master, and then add either a map (similar to the
interrupt-map property) to cover the complex case in a special way, or
to extend the binding for a specific dma engine so that you can have a
single device node represent all dma engines of the same soc, separating
this from the multiple struct dma_device instances that represent the
multiple hardware blocks in Linux.

	Arnd
