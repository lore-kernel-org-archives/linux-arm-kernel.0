From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 31 Mar 2017 10:07:26 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.12
In-Reply-To: <8e708a9f-b32e-a80c-b5d7-8979e59b6662@codethink.co.uk>
References: <m28tnn69ls.fsf@baylibre.com>
 <CAK8P3a02e3DxjuW9pA66NSCc9vw_h1Xuk6TdEbRnEQ4v4W7NHA@mail.gmail.com>
 <m2fuht4eqs.fsf@baylibre.com>
 <8e708a9f-b32e-a80c-b5d7-8979e59b6662@codethink.co.uk>
Message-ID: <149098004659.31513.4466752098392400631@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ben Dooks (2017-03-31 09:11:17)
> On 31/03/17 17:01, Kevin Hilman wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> >
> >> On Wed, Mar 29, 2017 at 11:45 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> >>> Olof, Arnd,
> >>>
> >>> Below are some 64-bit DT changes for Amlogic platforms for v4.12.  Note
> >>> that this branch includes a merge of an immutable branch from the clk
> >>> tree (clk-meson) due to dependencies on new clocks added to the meson
> >>> clock driver and used in these DT updates.
> >>
> >> I did not pull this one because of the silly dependency. The device tree
> >> files should be completely independent of the driver changes.
> >
> > Aaargh, this is getting very frustrating.
> 
> I tried to make this point very early on in the development,
> we don't want to be changing both driver and dt if we are
> adding things like IDs for gated clocks.
> 
> For example, having an almost 1:1 mapping from clock-id to
> bit-in-hardware would make life much easier, even if the
> driver had a little bit more code to create clocks at the
> probe time, it would have meant that DT additions for new
> peripherals would have been much easier.

It would be great if the hardware was designed in such a way to make
that possible. A lot of clock controller hardware simply isn't.

We're talking about defining a reference to a clock control, somewhere
in the middle of the clock tree, that maybe we didn't know existed until
now. This simply is not the same as enumerating physical pins or
something like that.

To be clear, all of the leaf clock (gates) were defined in DT from the
very beginning for the SoC in question. This is perfectly in-line with
Arnd's world-view. These gates are very orderly and correspond directly
to the consumer devices that take them as input.

It's the mess of clocks that make up the "middle" of the tree that cause
these problems. I don't see why we can't agree on a way to update the DT
headers in such cases.

> 
> > [...]
> >
> >> Which add random macros in the middle of the number space.
> >>
> >> Since the header changes are in an immutable branch, it's probably
> >> too late to fix this for 4.12, but maybe we can get the header into a
> >> form that allows us to do future DT changes without having to
> >> wait an extra release. The clock driver apparently already defines
> >> some of the numbers above, so you can fill all of those in already.
> >
> > We could, but this is in direct conflict with the recommendations of the
> > clk maintainers to not expose clock IDs to the DT until we know they are
> > used because, well, things change.
> >
> > Can we *please* get some clarity on on this between arm-soc and the clk
> > maintainers?  I've been asking for a couple merge windows now.

I'm hopeful that that the arm-soc maintainers can see it my way ;-)

I'll explain the thought process behind the gxbb clk IDs in DT again:

1) we don't know about all the clocks ahead of time. New documentation
is always forthcoming, especially in regards to multimedia-focused IP

2) we do know about all of the leaf clocks that devices take as input
and expose them in DT from the very beginning, as we should

3) ideally we should not need to expose any non-leaf clocks in DT. This
would be akin to exposing private data or state machine internals in DT,
when the consumer nodes only care about a phandle to their input

4) ideally consumer devices should reference only the leaf clocks.
Ideally the framework & clk provider driver should be smart enough to Do
The Right Thing.

Items #3 and #4 are not always true, we don't life in an ideal world and
hence, sometimes we add new clock IDs to DT. This should not be grounds
for a patch not making it into the merge window IMO.

Best regards,
Mike

> >
> > Irritated,
> >
> > Kevin
> >
> > _______________________________________________
> > linux-amlogic mailing list
> > linux-amlogic at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-amlogic
> >
> 
> 
> -- 
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
