From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 8 Dec 2016 20:46:11 +0200
Subject: [GIT PULL 1/3] ARM: exynos: Soc/mach for v4.10
In-Reply-To: <CAOesGMicc8xEvxn1k6Te20rTEv36it0PZmnXyhhn+U+oh7jdeQ@mail.gmail.com>
References: <1479967709-6619-1-git-send-email-krzk@kernel.org>
 <1479967709-6619-2-git-send-email-krzk@kernel.org>
 <20161201183404.GA2134@kozik-lap> <57568492.9hbg5JCdec@wuerfel>
 <20161203170347.GA3553@kozik-lap>
 <CAGcde9HwfPbw6NMEmcTfn+Df+-AkyyrP3u=7NUyT1XDVbCjtqg@mail.gmail.com>
 <CAOesGMicc8xEvxn1k6Te20rTEv36it0PZmnXyhhn+U+oh7jdeQ@mail.gmail.com>
Message-ID: <20161208184611.GA11463@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 10:25:35AM -0800, Olof Johansson wrote:
> On Thu, Dec 8, 2016 at 7:28 AM, Pankaj Dubey <dubepankaj1980@gmail.com> wrote:
> > On 3 December 2016 at 22:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On Fri, Dec 02, 2016 at 10:52:57PM +0100, Arnd Bergmann wrote:
> >>>
> >>> Sorry, I initially deferred it and then didn't get back to it.
> >>>
> >>> The dependency on the .dts changes made me a bit nervous about
> >>> taking it, mostly because the changelog fails to explain the
> >>> exact dependencies.
> >>>
> >>> This breaks compatibility with existing .dtb files, right?
> >>
> >> No, strictly speaking not. There was no dt-bindings change here, no DT
> >> properties for SCU before. We are converting our drivers to DTB so this
> >> is the same as before when switching for pinctrl, clocks or all other
> >> drivers to DT.
> >>
> >> We are not braking DTB ABI because there was no ABI around it before.
> >> Otherwise, one would say that lack of SCU DT node was an ABI. That is
> >> wrong, because DT should describe the hardware and SCU is in hardware.
> >>
> >>> What I'd like to see here is an explanation about:
> >>>
> >>> - what the upside of breaking compatibility is
> >>
> >> DTBs which do not have SCU are not proper because they skip that part of
> >> hardware. However we are breaking them in the way the SMP won't work
> >> there. It is not an ABI break, as I mentioned above.
> >>
> >>> - what exactly stops working with an old dtb
> >>> - why we don't keep a fallback for handling old dtb files
> >>
> >> What is the point for it? This is not an ABI break. Even if it was,
> >> Samsung guys don't care for ABI breaks at all (and in fact we wanted to
> >> mark the platform experimental...).
> >>
> >>> It would also be helpful to have a separate pull request for
> >>> the commits require the new dtb, and the stuff that is unrelated.
> >>
> >> I can do that but the pull will be small.
> >>
> >
> > Arnd,
> >
> > Any update on this? Intention of this change is to improve
> > Exynos SoC's DT support in mainline kernel. This will help in removing static
> > mapping from exynos machine files and simplify mach-exynos code-base.
> 
> Adding the SCU nodes now makes sense. So does using them if they're available.
> 
> Given the prevalence of exynos systems with DTS already out there, it
> would make sense to give an overlap of making the kernel work without
> the SCU in DT for a period of time.
> 
> This isn't like the old days of when we were mass-converting things
> and breakage was expected. We're well into a steady state here, so
> being nicer to downstream users is likely the right thing to do here.

I think that either we treat this as an ABI break, or just "being
nice to downstream".

In the first case, not breaking things would be a valid reason. But I
believe this is not an ABI break. ABI is about an interface, not about
being nice. The SCU should be defined by downstream users because this
is the description of the hardware. In the same time, kernel did not
document as an interface something like "there should be no SCU node
defined" so creating a requirement of SCU is not an breakage of existing
interface.

The second case then, being nice to downstream. Do we want to be nice or
do we want to push them to mainline? Okay, it is never black or white...
yet we should rather encourage downstream to mainline and creating
compatibility periods is rather opposite of that.

Best regards,
Krzysztof
