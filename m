From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Jul 2015 15:11:02 +0100
Subject: [PATCH v3 3/6] iommu: add ARM short descriptor page table
 allocator.
In-Reply-To: <55B63AB2.4050006@arm.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
 <20150721171101.GN31095@arm.com>
 <1437715466.23932.68.camel@mhfsdcap03>
 <20150724165325.GC21177@arm.com>
 <1437970868.25925.20.camel@mhfsdcap03> <55B63AB2.4050006@arm.com>
Message-ID: <20150727141102.GJ3358@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 03:05:38PM +0100, Robin Murphy wrote:
> On 27/07/15 05:21, Yong Wu wrote:
> >>>>> +       } else {        /* page or largepage */
> >>>>> +               if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK) {
> >>>>> +                       if (large) { /* special Bit */
> >>>>
> >>>> This definitely needs a better comment! What exactly are you doing here
> >>>> and what is that quirk all about?
> >>>
> >>> I use this quirk is for MTK Special Bit as we don't have the XN bit in
> >>> pagetable.
> >>
> >> I'm still not really clear about what this is.
> >
> > There is some difference between the standard spec and MTK HW,
> > Our hw don't implement some bits, like XN and AP.
> > So I add a quirk for MTK special.
> 
> When you say it doesn't implement these bits, do you mean that having 
> them set will lead to Bad Things happening in the hardware, or that it 
> will simply ignore them and not enforce any of the protections they 
> imply? The former case would definitely want clearly documenting 
> somewhere, whereas for the latter case I'm not sure it's even worth the 
> complication of having a quirk - if the value doesn't matter there seems 
> little point in doing a special dance just for the sake of semantic 
> correctness of the in-memory PTEs, in my opinion.

Agreed. We should only use quirks if the current (architecturally
compliant) code causes real issues with the hardware. Then the quirk can
be used to either avoid the problematic routines or to take extra steps
to make things work as the architecture intended.

I've asked how this IOMMU differs from the architecture on a number of
occasions, but I'm still yet to receive a response other than "it's special".

Will
