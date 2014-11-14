From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Nov 2014 10:35:28 +0000
Subject: [PATCH] efi: Fix free_end build warning
In-Reply-To: <CAKv+Gu8JrX4WBThhi5fWN5RuUDV3tui=Ey87himRCbXhyXbvEg@mail.gmail.com>
References: <1415824050.15847.9.camel@smoke> <20141114102254.GB27963@arm.com>
 <CAKv+Gu8JrX4WBThhi5fWN5RuUDV3tui=Ey87himRCbXhyXbvEg@mail.gmail.com>
Message-ID: <20141114103528.GC27963@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:29:59AM +0000, Ard Biesheuvel wrote:
> On 14 November 2014 11:22, Will Deacon <will.deacon@arm.com> wrote:
> > [Adding original authors]
> >
> > On Wed, Nov 12, 2014 at 08:27:30PM +0000, Geoff Levand wrote:
> >> Initialize the free_end variable to zero.  Fixes build warnings
> >> like these:
> >>
> >>   arch/arm64/kernel/efi.c: warning: ?free_end? may be used uninitialized in this function
> >>
> >> Signed-off-by: Geoff Levand <geoff@infradead.org>
> >> ---
> >> Got this with the latest arm64/for-next/core branch.  Please consider.
> >>
> >> -Geoff
> >>
> >>  arch/arm64/kernel/efi.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> >> index 4f39a18..83fc53c 100644
> >> --- a/arch/arm64/kernel/efi.c
> >> +++ b/arch/arm64/kernel/efi.c
> >> @@ -239,6 +239,7 @@ static void __init free_boot_services(void)
> >>        * want to keep for UEFI.
> >>        */
> >>
> >> +     free_end = 0;
> >>       keep_end = 0;
> >>       free_start = 0;
> >
> > Whilst I can't see how free_end gets used uninitialized in this function,
> > the code is really hard to read and I'd like to get an Ack from one of the
> > people on CC before merging this, just in case GCC is actually telling us
> > something useful for a change.
> >
> 
> We are planning to remove this code entirely in the 3.20 timeframe.
> Freeing boot services will not be necessary any longer once we stop
> reserving it in the first place, and I agree that the function is hard
> to read. Also, it depends on the UEFI memory map being sorted, which
> is not mandated by the spec so we can't actually rely on it. (Even if
> it usually is the case)
> 
> So I don't object to this patch, if the warning is bothering people,
> but perhaps we can just wait for the warning to go away once the new
> stuff lands.

Ok, thanks Ard. I think I'll leave it alone for now, then.

Will
