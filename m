From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Oct 2017 17:32:08 +0100
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <CAKv+Gu9Ygu4UELUbWD8sTzdL8ZQRWPAtQWaM6qTd2GyzuEDN5g@mail.gmail.com>
References: <CAKv+Gu_pGeDxK_vD9iGUO486VgLsntMQwVs9wGKa79pkx7paMQ@mail.gmail.com>
 <20171004124320.GP20805@n2100.armlinux.org.uk>
 <CAKv+Gu_t+oLJKGzy3LxgLZqqYsd9eQiwZRr6dgPbqpsHnQUUxw@mail.gmail.com>
 <874lr4d8gm.fsf@free-electrons.com>
 <20171012094517.GB20805@n2100.armlinux.org.uk>
 <CAKv+Gu_+D+d+5Zi8LRmi3_sHEVx-FLLKHsi9aUUmNB8VvcHANQ@mail.gmail.com>
 <878tg56dtn.fsf@free-electrons.com>
 <CAKv+Gu_q0A+42ht1f4o_SToWSV4OBThV=gtyfBoGYFZyKWNW5Q@mail.gmail.com>
 <20171020161133.GG20805@n2100.armlinux.org.uk>
 <CAKv+Gu9Ygu4UELUbWD8sTzdL8ZQRWPAtQWaM6qTd2GyzuEDN5g@mail.gmail.com>
Message-ID: <20171020163207.GH20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 05:20:26PM +0100, Ard Biesheuvel wrote:
> On 20 October 2017 at 17:11, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Fri, Oct 20, 2017 at 04:28:49PM +0100, Ard Biesheuvel wrote:
> >> On 20 October 2017 at 16:25, Gregory CLEMENT
> >> <gregory.clement@free-electrons.com> wrote:
> >> > Hi Ard,
> >> >
> >> >  On jeu., oct. 12 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> >
> >> >> On 12 October 2017 at 10:45, Russell King - ARM Linux
> >> >> <linux@armlinux.org.uk> wrote:
> >> >>> On Thu, Oct 12, 2017 at 11:24:57AM +0200, Gregory CLEMENT wrote:
> >> >>>> Hi Ard,
> >> >>>>
> >> >>>> Can we move forward to fix the booting problem ?
> >> >>>>
> >> >>>> What about amending your commit log with this new information and then
> >> >>>> submit it to Russell patch system?
> >> >>>
> >> >>> Well, I think there's a choice that needs to be made between this
> >> >>> approach and Arnd's approach.
> >> >>>
> >> >>> I'm not all that thrilled with the need to add explicit alignment to
> >> >>> data that is inherently a byte stream, and that invariably results in
> >> >>> unaligned data words even if you do align the start of it.  That
> >> >>> sounds to me very much like a hack rather than a proper solution.
> >> >>> So, right now I'm leaning more towards Arnd's solution than Ard's
> >> >>> from what's been said in this thread.
> >> >>>
> >> >>
> >> >> I agree that the struct type unaligned accessors are the best choice
> >> >> for ARM in any case, given that it will also prevent hitting the
> >> >> alignment fixup handler in the kernel unnecessarily.
> >> >>
> >> >>> However, I don't recall Arnd's patch, it's probably buried deep in
> >> >>> my mailbox.
> >> >>>
> >> >>
> >> >> Well, unless you are considering changing the unaligned accessors from
> >> >> access_ok.h to le_struct.h as a bugfix, I think we need both patches.
> >> >
> >> > We will soon reach v4.14-rc6 and the Armada XP and Armada 370 still not
> >> > boot. I also didn't see your patch in rmk patch system.
> >> >
> >> > Waiting for you find a agreement an other option is to remove CONFIG_EFI
> >> > from multi_v7_defconfig as I don't really see any armv7 base board using
> >> > EFI.
> >> >
> >>
> >> It is up to Russell to decide how he wants to proceed. Russell?
> >
> > Well, having failed to attract Arnd's attention, I've spent 20 minutes
> > searching my mailbox to find it.
> >
> > It turns out that there was never a proper patch from Arnd - it was a
> > patch in pastebin.  It's not ARM specific either, it's an asm-generic
> > change, for which Arnd is the maintainer for.
> >
> > I've just replied to that old thread and I've included Gregory and some
> > PXA folk who are also having alignment problems in the decompressor.  It
> > could all be due to this same issue.
> >
> > There's also one additional factor that hasn't been considered, and I'm
> > scared to point it out, but:
> >
> > 1. Does Arnd's patch fix the PXA problem as well?
> >
> 
> I don't think it will help configs that don't have
> HAVE_EFFICIENT_UNALIGNED_ACCESS set, given that they don't use
> access_ok.h in the first place.
> 
> > 2. What is the performance impact of Arnd's fix?
> >
> 
> Well, given that we may be relying on the alignment fixup handler to
> fix up kernel accesses, the performance impact could actually be
> favorable in some cases. But I don't have any numbers, nor do I have
> access to a representative sampling of ARM hardware so I can't be of
> any help here, unfortunately.

Well, everyone can tell whether alignment fixups get used on their
platforms, by looking at /proc/cpu/alignment - this counts any
alignment faults and their types.  If it's all zeros, then the
alignment fixup handler isn't being used.

I just checked one of my imx6 platforms (3G/wifi gateway), all the
stats are zero.  Another imx6 platform (whose port 80 is open to the
world) has one double-word fault in nsm_get_handle+0x200/0x484.
My ARMv5 gateway here also has all zero stats.

However, all these are built with GCC 4.7.4, and we already know
that newer compilers behave significantly differently.  So, I don't
think what I see here is representative, so I can't decide based on
what I see locally.

So, it seems we're rather stuck.

I suppose I could set up a dart board, and throw a dart blind folded
and if it hits a red area, pick one patch, otherwise take the other.
Or toss a coin.  Or some other rediculous game.

It would be much better if there was some way to evaluate the impact,
but I see that no one is interested in lifting a finger to help with
that.

Meanwhile, I'm quite sure there'll be an on-going cry for me to make
a decision.  A decision based on a whim.  Yea, great basis for taking
decisions.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
