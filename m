From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Nov 2017 18:11:01 +0000
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <CAKv+Gu8F8PKSecjt2pze=9rd-TNDWs6n1+nV8GYyF+ZGunMiNQ@mail.gmail.com>
References: <87bmko1v6f.fsf@free-electrons.com>
 <20171030161207.GS20805@n2100.armlinux.org.uk>
 <8737601u4d.fsf@free-electrons.com>
 <20171030163816.GA27404@n2100.armlinux.org.uk>
 <20171031124707.GD9463@n2100.armlinux.org.uk>
 <CAKv+Gu-te-Q+em36jM-dyouZuov_=xJaVY0Yr-3JCmJn6Zi4sg@mail.gmail.com>
 <87mv478na9.fsf@free-electrons.com>
 <CAKv+Gu9d2TUQHavs-rasKFcNmmwo22dwiGuD2+jBLqawbZAwuA@mail.gmail.com>
 <20171101180033.GP9463@n2100.armlinux.org.uk>
 <CAKv+Gu8F8PKSecjt2pze=9rd-TNDWs6n1+nV8GYyF+ZGunMiNQ@mail.gmail.com>
Message-ID: <20171101181101.GQ9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 06:02:24PM +0000, Ard Biesheuvel wrote:
> On 1 November 2017 at 18:00, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Nov 01, 2017 at 03:57:36PM +0000, Ard Biesheuvel wrote:
> >> On 31 October 2017 at 13:22, Gregory CLEMENT
> >> <gregory.clement@free-electrons.com> wrote:
> >> > Hi Ard,
> >> >
> >> >  On mar., oct. 31 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> >
> >> >> On 31 October 2017 at 12:47, Russell King - ARM Linux
> >> >> <linux@armlinux.org.uk> wrote:
> >> >>> On Mon, Oct 30, 2017 at 04:38:17PM +0000, Russell King - ARM Linux wrote:
> >> >>>> On Mon, Oct 30, 2017 at 05:24:34PM +0100, Gregory CLEMENT wrote:
> >> >>>> > Hi Russell King,
> >> >>>> >
> >> >>>> > Here you will find all the objects included the vmlinux:
> >> >>>> >
> >> >>>> > http://free-electrons.com/~gregory/pub/compressed.tgz
> >> >>>>
> >> >>>> Thanks.  Unfortunately, nothing stands out, but I do see a difference
> >> >>>> between the output of your linker from mine.
> >> >>>>
> >> >>>> Yours:
> >> >>>>
> >> >>>> Idx Name          Size      VMA       LMA       File off  Algn
> >> >>>>   0 .text         00005ef8  00000000  00000000  00010000  2**5
> >> >>>>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
> >> >>>>
> >> >>>> Mine:
> >> >>>>
> >> >>>> Idx Name          Size      VMA       LMA       File off  Algn
> >> >>>>   0 .text         00005f00  00000000  00000000  00010000  2**5
> >> >>>>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
> >> >>>>
> >> >>>> That has the effect of moving the addresses of the following
> >> >>>> sections in your vmlinux down by 8 bytes.  However, I don't think
> >> >>>> that's the cause of this - but it does hint at something being
> >> >>>> different in binutils in the way sections are processed in the
> >> >>>> linker.
> >> >>>>
> >> >>>> Please add to your linker script after the assignment of _edata:
> >> >>>>
> >> >>>>   .image_end (NOLOAD) : {
> >> >>>>     _edata_foo = .;
> >> >>>>   }
> >> >>>>
> >> >>>> relink the decompressor, and see what value _edata_foo ends up with
> >> >>>> compared to _edata?  They should be the same, but I suspect using
> >> >>>> your linker, they will be different.
> >> >>>>
> >> >>>> Also try adding
> >> >>>>     BYTE(0);
> >> >>>>
> >> >>>> after the _edata_foo assignment as a separate test, and see whether
> >> >>>> that makes any difference - with that you should end up with the
> >> >>>> .image_end section in the output image.
> >> >>>
> >> >>> Gregory sent me has new url... for _both_ changes, which gives me:
> >> >
> >> > If needed I can provide this url.
> >> >
> >> >>>
> >> >>> $ arm-linux-nm vmlinux |grep _edata
> >> >>> 00491160 D _edata
> >> >>> 00491160 D _edata_foo
> >> >>>
> >> >>> So there's no reason that ASSERT() should be failing!  However, as I
> >> >>> don't have the intermediate step, I can't say whether the addition
> >> >>> of the BYTE() affected it in some way - sorry, but I asked for _both_
> >> >>> to be tested above because I wanted to speed up the process, and
> >> >>> clearly that's backfired.
> >> >>>
> >> >>> Given how close we potentially are to 4.14, I don't think we're going
> >> >>> to get to the bottom of this to make 4.14.  I'd want to get this
> >> >>> sorted by Wednesday so linux-next (which is resuming this evening)
> >> >>> can grab a copy of my tree with it in, and we have another day to
> >> >>> sort out any remaining issues, but I'm basically out of time to do
> >> >>> anything further with this as of now.
> >> >>
> >> >>> So, 4.14 will likely be released without any of this being fixed.
> >> >>>
> >> >>
> >> >> IIUC, the current issue is limited to the ASSERT() itself, which is
> >> >> there to prevent future regressions, while the other two patches deal
> >> >> with severe and difficult to diagnose known issues.
> >> >
> >> > I confirm that whithout the last commit (adding the ASSERT()) in the
> >> > fixes branch it worked well.
> >> >
> >> >>
> >> >> So why can't we apply those two patches as fixes, and revisit the
> >> >> patch that helps us prevent this from regressing in the future for
> >> >> v4.15?
> >> >
> >> > I also agree with this.
> >> >
> >>
> >> Russell,
> >>
> >> Please drop the EFI patch from your tree. I will forward it myself.
> >
> > Really, no, I'm not going to.  I've enough to do than chase around
> > playing political games about who should send what patches.  You
> > asked me to merge it, and I will merge it.
> >
> 
> Fine, then merge it. I am not the one who is playing games here, I
> just want to get stuff fixed. I don't understand why you are dragging
> your feet like this.

You think I'm playing games?  I most certainly am not.  I'm not going
to send it tonight because there's further fixes in the pipeline from
Nicolas, and I don't have time to merge those tonight _and_ test them.
And I certainly do not want to be sending multiple pull requests to
Linus, because that annoys Linus and I've been flamed for doing that.

I haven't had time to drop the ASSERT() patch from my tree either since
Tuesday morning.

I guess you have very little patience and you have no appreciation of
the fact that when someone states that they want to get an issue sorted
quickly because of lack of time, they actually really do mean that they
have very little availability...

I said on Monday that time was short, and that I had precious little
available time.  That was because I was out on Monday evening.  I was
out on Tuesday afternoon for a medical appointment.  I was out Tuesday
evening.  I've been out Wednesday afternoon.  This is not "games", this
is reality, this is health issues.

Have some patience and give your fellow developers some breathing space.

Remember, many people have been at ELC and have been unavailable for
much of last week.  Those who weren't at ELC were available, willing
and able to try and address these issues, but it was impossible because
of everyone else being away.  Now they're back, it seems they're banging
on about getting some action.  That's really unfair - _they're_ the ones
who've held up progress for a week.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
