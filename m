From: horms@verge.net.au (Simon Horman)
Date: Mon, 28 May 2018 10:41:36 +0200
Subject: [PATCH 6/9] ARM: dts: wheat: Drop MTD partitioning from DT
In-Reply-To: <7e1563c3-3e13-235b-3071-c3936502530f@gmail.com>
References: <20180522120257.13232-1-marek.vasut+renesas@gmail.com>
 <20180522120257.13232-6-marek.vasut+renesas@gmail.com>
 <CAMuHMdXRnoyhNz=3v_=ZCV=FWX4TwKqx7MpH0g3c7GwtXKP1tg@mail.gmail.com>
 <fc1cfd7e-db27-9277-dbed-cc2274c614a6@gmail.com>
 <CAMuHMdXnNABJSJZ6MLF+aQu8QKpFoMCAvno9Yc-9LOe810NtbA@mail.gmail.com>
 <7e1563c3-3e13-235b-3071-c3936502530f@gmail.com>
Message-ID: <20180528084135.q5xng5eaypprsypr@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 04:52:59PM +0200, Marek Vasut wrote:
> On 05/23/2018 08:25 AM, Geert Uytterhoeven wrote:
> > Hi Marek,
> > 
> > On Wed, May 23, 2018 at 12:01 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >> On 05/22/2018 04:43 PM, Geert Uytterhoeven wrote:
> >>> On Tue, May 22, 2018 at 2:02 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >>>> Drop the MTD partitioning from DT, since it does not describe HW
> >>>> and to give way to a more flexible kernel command line partition
> >>>> passing.
> >>>>
> >>>> To retain the original partitioning, assure you have enabled
> >>>> CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
> >>>> following to your kernel command line:
> >>>>
> >>>>   mtdparts=spi0.0:256k at 0(loader),4096k(user),-(flash)
> >>>
> >>> I think the "@0" can be dropped, as it's optional?
> >>> 4m?
> >>
> >> My take on this is that the loader is actually at offset 0x0 of the MTD
> >> device and we explicitly state that in the mtdparts to anchor the first
> >> partition within the MTD device and all the other partitions are at
> >> offset +(sum of the sizes of all partitions listed before the current
> >> one) relative to that first partition.
> > 
> > Where is this explicitly states for the first partition?
> > 
> >> Removing the @0 feels fragile at best and it seems to depend on the
> >> current behavior of the code.
> > 
> > Better, it also depends on the documented behavior:
> > 
> > Documentation/admin-guide/kernel-parameters.txt refers to
> > drivers/mtd/cmdlinepart.c, which states:
> > 
> >  * <offset>  := standard linux memsize
> >  *              if omitted the part will immediately follow the previous part
> >  *              or 0 if the first part
> > 
> > None of the examples listed there or under the MTD_CMDLINE_PARTS Kconfig
> > help text, or in a defconfig bundled with the kernel, use @0 for the first
> > partition.
> 
> I think this is exceptionally fragile and dangerous to depend on this,
> but so be it.

Could you respin with this change?

I would also like to ask for another change, in light of recent
feedback from Olof Johansson ("Re: [GIT PULL] Renesas ARM64 Based SoC DT
Updates for v4.18").

Please consolidate the dts patches into a single patch?

I have applied the defconfig patch, so there is no need to repost that one.
