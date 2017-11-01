From: dianders@chromium.org (Doug Anderson)
Date: Wed, 1 Nov 2017 08:53:40 -0700
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <20171101092618.GN9463@n2100.armlinux.org.uk>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
 <20171031165629.GF9463@n2100.armlinux.org.uk>
 <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
 <CAD=FV=V3n0gjzpL860V6cgf8JVh5pmoL+i0t63Oot19T2afTPw@mail.gmail.com>
 <20171101092618.GN9463@n2100.armlinux.org.uk>
Message-ID: <CAD=FV=VKEz9jvJaD2KTitH=2G+wb42RXHyRVKi4-zrypAu9jSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 1, 2017 at 2:26 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Oct 31, 2017 at 05:23:19PM -0700, Doug Anderson wrote:
>> Hi,
>>
>> On Tue, Oct 31, 2017 at 10:45 AM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> > So I'm very much open to udelay improvements, and if somebody sends
>> > patches for particular platforms to do particularly well on that
>> > platform, I think we should merge them. But ...
>>
>> If I'm reading this all correctly, this sounds like you'd be willing
>> to merge <https://patchwork.kernel.org/patch/9429841/>.  This makes
>> udelay() guaranteed not to underrun on arm32 platforms.
>
> That's a mis-representation again.  It stops a timer-based udelay()
> possibly underrunning by one tick if we are close to the start of
> a count increment.  However, it does nothing for the loops_per_jiffy
> udelay(), which can still underrun.
>
> My argument against merging that patch is that with it merged, we get
> (as you say) a udelay() that doesn't underrun _when using a timer_
> but when we end up using the loops_per_jiffy udelay(), we're back to
> the old problem.
>
> My opinion is that's bad, because it encourages people to write drivers
> that rely on udelay() having "good" behaviour, which it is not guaranteed
> to have.  So, they'll specify a delay period of exactly what they want,
> and their drivers will then fail when running on systems that aren't
> using a timer-based udelay().

IMHO the current udelay is broken in an off-by-one way and it's easy
to fix.  Intentionally leaving a bug in the code seems silly.  This
seems to by what Linus is saying with his statement that "(a) platform
code could try to make their udelay/ndelay() be as good as it can be
on a particular platform".

So no matter the rest of the discussions, we should land that.  If you
disagree then I'm happy to re-post that patch straight to Linus later
this week since it sounds as if he'd take it.


> If we want udelay() to have this behaviour, it needs to _always_ have
> this behaviour irrespective of the implementation.  So that means
> the loops_per_jiffy version also needs to be fixed in the same way,
> which IMHO is impossible.

As Linus indicates, if there is a way to code things up that doesn't
rely on udelay then that should be preferred.  However, there may be
cases where this is exceedingly difficult.  If you're writing a driver
at a high enough level that will work on a lot of underlying platforms
(AKA it's platform-agnostic) then you can't necessarily rely on timing
an individual hardware read.  Since you're writing high-level
platform-agnostic code, presumably implementing a 1 us delay in a
generic way is equally difficult to making the platform-agnostic
udelay() reliable.


IMHO it would be OK to put in a requirement in a driver saying that it
will only function properly on hardware that has a udelay() that is
guaranteed to never return early.  As Linus says: "most core kernel
developers even have access to platforms that have unstable TSC's any
more."  Presumably all those old platforms aren't suddenly going to be
attached to new devices unless those new devices are connected by a
PCI, ISA, USB, etc. bus.  Drivers for components connected by
non-external busses seem like they don't need to take into account the
quirks of really ancient hardware.

Yes, I know there are still some arm32 chips that aren't that old and
that don't have a CP15-based timer.  We should make sure we don't
change existing drivers and frameworks in a way that will break those
boards.  If that means we need to figure out how to add an API, as
Linus says, to indicate how accurate udelay is then that might be a
solution.  Another would be to come up with some clever solution on
affected boards.  Most arm32 boards I'm aware of have other
(non-CP15-based) timers.  ...if they don't and these are real boards
that are actually using a driver relying on udelay() then perhaps they
could add a new board-specific udelay() implementation that delayed by
reading a specific hardware register with known timing.


Said another way: if we're writing a high level NAND driver and we
can't find a better way than udelay() to ensure timing requirements,
then the driver should use udelay() and document the fact that it must
not underrun (ideally it could even test for it at runtime).  If that
NAND driver will never be used on platforms with an unreliable
udelay() then we don't need to worry about it.  If we find a platform
where we need this NAND driver, we should find a way to implement a
udelay() that will, at least, never underestimate.


-Doug
