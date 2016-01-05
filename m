From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jan 2016 12:30:19 +0000
Subject: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
In-Reply-To: <CAPKp9ubdS+R8U-W+LxYEp_sGxZVBDGBJ48+N7Pw3k9A+=F4pww@mail.gmail.com>
References: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
 <20151224164723.GK8644@n2100.arm.linux.org.uk>
 <CAPKp9ubdS+R8U-W+LxYEp_sGxZVBDGBJ48+N7Pw3k9A+=F4pww@mail.gmail.com>
Message-ID: <20160105123018.GU19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 12:12:31PM +0000, Sudeep Holla wrote:
> Hi Russell,
> 
> On Thu, Dec 24, 2015 at 4:47 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Dec 24, 2015 at 09:49:48AM -0600, Timur Tabi wrote:
> >> The REG_x macros are indices into a table, not register offsets.  Since
> >> earlycon does not have access to the vendor data, we can currently only
> >> support standard ARM PL011 devices.
> >>
> >> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> >
> > Please credit me with the change; this was obviously a change I made
> > when I posted the updated patches, which Greg had failed to take
> > instead of the original set.  Thanks.
> >
> 
> I don't see this patch in linux-next. Without this it fails to boot(panics) on
> ARM64 when earlycon is enabled.

I guess that's the way 4.4 is going to be then, because GregKH has not
been anywhere near "responsive" during the last cycle, but he did say
yesterday (in response to questions about driver model stuff) that he's
closed his trees for the merge window last week.

All in all, this situation is entirely GregKH's making, as he took the
wrong set of patches, and has yet to respond to _any_ of the resulting
mails about it... I guess GregKH knows what he's doing as he's one of
the top (and vocal) kernel developers far more than I do, so I guess he
has his reasons for crapping up the AMBA PL011 driver...

Greg's also been totally silent on the component helper changes, and I've
decided that I'm pushing those upstream myself irrespective of anything
else (and I really don't care at this point if Greg objects to this; he's
already had plenty of time to comment, and has chosen not to.)

I rather wish that I'd decided to do the same with the AMBA PL011 driver,
because this seems to be the only sensible way of ensuring that the right
set of patches get to Linus.

I had put the _right_ set of AMBA PL011 driver changes into linux-next
just before Christmas, but Stephen Rothwell tells me that they merge
without conflict with the set that Greg merged, and we still end up with
the broken code.  So there's nothing I can do about it at this point.

As far as 4.4 goes, I think it's fate was sealed when Greg took the
wrong set of patches.  It's Greg's problem to sort out now.

> Also I think this fix might not be correct
> for ZTE pl011, though it works for ST and standard PL011.

Yes, earlycon won't work for ZTE PL011.  This isn't a big problem at
the moment, because the patch set doesn't wire up the ZTE PL011 itself.
The reason there is that I'm saying no to using a platform device; I
really do not like drivers which end up with multiple different probe
and remove methods.  The AMBA PL011 driver is an AMBA primecell driver,
and it sits on the AMBA primecell bus, not the platform bus.

What I want to see is some way of having the ZTE PL011 appearing on the
AMBA bus, which means we need to come up with some way to deal with
primecells which don't have an ID.  That is an open issue, as is how
to deal with earlycon.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
