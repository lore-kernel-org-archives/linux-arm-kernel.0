From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Jul 2014 18:51:24 +0200
Subject: [RFC 1/2] pwrseq: Add subsystem to handle complex power sequences
In-Reply-To: <CAPDyKFqi2NH1r=Q13iOu2ruuvaj1xJeoERiy2WJBVbQ2b1tc_A@mail.gmail.com>
References: <1403183091-27876-1-git-send-email-ulf.hansson@linaro.org>
 <53A3ED65.80605@redhat.com>
 <CAPDyKFqi2NH1r=Q13iOu2ruuvaj1xJeoERiy2WJBVbQ2b1tc_A@mail.gmail.com>
Message-ID: <4396181.E2W0ve8f6g@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 18:42:51 Ulf Hansson wrote:
> On 20 June 2014 10:14, Hans de Goede <hdegoede@redhat.com> wrote:
> > On 06/20/2014 10:02 AM, Olof Johansson wrote:
> >> On Fri, Jun 20, 2014 at 12:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> >> I disagree.
> >>
> >> The clock is the input to the module, and it is what needs to be
> >> enabled for the module to work. It's not the input to some
> >> power-sequence component on the module, or next to the module on the
> >> bus.
> >
> > Right, it is an input to the sdio-module, not to the mmc-host, so its an
> > input to a different piece of hardware (at different ends of the mmc bus),
> > but since the mmc-bus normally is fully discoverable we've no node for the
> > other end of the bus.
> >
> > So from the mmc-host pov, which is the one which needs to bind the pwrseq
> > driver, as that needs to be done before it can probe its bus, this is
> > a different piece of hardware, hence a subnode to the host makes perfect
> > sense.  This is in no way part of the host, so certainly it does not belong
> > inside the hosts subnode.
> 
> I fully agree with you Hans here.
> 
> If we were to put this information in the host's DT node, that would
> be a wrong description of the hardware. Currently, I can't think of
> anything better than a subnode, but I am open to suggestions.

The problem that I see with your approach is that you use a subnode
to describe an abstract concept, which isn't really a better description
of the hardware than putting the contents in the parent node itself.

It would be more sensible if the subnode was defined (in this case)
as describing the attached device (sdio card or similar), and restructure
the code around that concept.

	Arnd
