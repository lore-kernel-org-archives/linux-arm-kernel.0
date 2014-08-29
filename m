From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Aug 2014 09:16:19 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <CAKON4OyB55L5q7fVo43V8kgtqHRZ3vkBMaA+Htxpob-FA1obaA@mail.gmail.com>
References: <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <53FDE0CE.5030807@redhat.com> <20140827141632.GB32243@ulmo>
 <53FF1D6C.6090205@redhat.com>
 <CAKON4OyXPjXx4q828kFgMsC_u7u3nqLPLxOp-kRZbS27yRKOEg@mail.gmail.com>
 <CAMuHMdU+zxUCU05YOpyuP1fx=Dgb5SZu=vbaJW13sQAaMBwU_w@mail.gmail.com>
 <CAKON4Oy8X9CSpZjYnTRgZ_MsxXQ=zaP+kxiZ2b7Es4GjN+1iJw@mail.gmail.com>
 <CAOMqctRvNbvFTb9dixCO1D0PfOWDgmBBs2U3yR5pvL8dFM_Lvw@mail.gmail.com>
 <CAKON4OyB55L5q7fVo43V8kgtqHRZ3vkBMaA+Htxpob-FA1obaA@mail.gmail.com>
Message-ID: <20140829071617.GE13106@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 12:34:58PM -0400, jonsmirl at gmail.com wrote:
> On Thu, Aug 28, 2014 at 12:25 PM, Michal Suchanek <hramrach@gmail.com> wrote:
> > On 28 August 2014 16:33, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> >> On Thu, Aug 28, 2014 at 10:20 AM, Geert Uytterhoeven
> >> <geert@linux-m68k.org> wrote:
> >>> On Thu, Aug 28, 2014 at 3:22 PM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> >>>>> 2) We don't want to hardcode these clocks into the kernel (sunxi) clk
> >>>>> driver, instead the bootloader should tell the kernel about these clocks.
> >>>>>
> >>>>> So the only point of discussion left seems to be how to do 2...
> >>>>
> >>>> Wouldn't it be a lot simpler just to use existing fbdev (not KMS) and
> >>>> whip together a device specific driver that claims the proper
> >>>> resources? And just implement the minimal about of fbdev possible?
> >>>> fbdev already is a driver library.
> >>>
> >>> Like... drivers/video/fbdev/offb.c?
> >>
> >> I'd probably reclassify drivers/video/fbdev/simplefb.c as a skeleton
> >> and use it as a template for making device specific versions of it.
> >>
> >> I don't see why there is so much resistance to just making device
> >> specific fb drivers.  Whenever the KMS driver gets written just
> >> disable the device specific fb driver in the build.
> >
> > Except that is not the goal here. The simplefb or whatever replacement
> > is supposed to stay as a  generic driver compiled into kernel whereas
> 
> There is no generic solution to this problem as this entire thread has
> illustrated. The clocks/regulators needed by each SOC vary.

There is a generic solution. Genericity only works if you define a well
defined set of assumptions. In this case the assumptions are that some
firmware sets up display hardware to scan out from a memory region and
communicates the location, layout and format of that memory region so
that a generic driver can write into that framebuffer.

The generic solution here works because we've eliminated the platform
specificities and let firmware take care of it.

> So there are two solutions..
> 1) modify simplefb to have some kind of heuristic that tries to guess
> what needs to be protected. A heuristic that is probably going to fail
> on every new SOC.
> 
> 2) Spend a day implementing a device specific fbdev driver that does
> the correct thing all of the time. These drivers would sit in initrd
> and load before the clock/regulator clean up shuts everything off. Use
> the existing simplefb code as a template for doing this.

There's a third possibility: find a way to prevent the clock framework
(and any other resource framework for that matter) from forcefully
disabling things that they shouldn't.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/e055b012/attachment.sig>
