From: horms@verge.net.au (Simon Horman)
Date: Wed, 14 Jan 2015 13:08:24 +0900
Subject: [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Complete multiplatform
 support
In-Reply-To: <CAMuHMdVbuM3oR1KQDzAodp_Y-aWFncPRn48-F9HmrVkGDS36RQ@mail.gmail.com>
References: <1420809866-4330-1-git-send-email-geert+renesas@glider.be>
 <20150113020818.GB21265@verge.net.au>
 <CAMuHMdVbuM3oR1KQDzAodp_Y-aWFncPRn48-F9HmrVkGDS36RQ@mail.gmail.com>
Message-ID: <20150114040822.GA14661@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 11:08:20AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Jan 13, 2015 at 3:08 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Jan 09, 2015 at 02:24:26PM +0100, Geert Uytterhoeven wrote:
> >>       Hi Simon, Magnus,
> >>
> >> This patch series completes the migration from kzm9g-reference (legacy
> >> DT based) to kzm9g-multiplatform (ARM multiplatform DT based with
> >> common clock framework).
> >>
> >>   - The first two patches fix Ethernet on kzm9g, by adding a Bus State
> >>     Controller node, as introduced in "[PATCH v3 0/4] drivers: bus:
> >>     Add Simple Power-Managed Bus", and moving the Ethernet node to it,
> >>   - The third path enables kzm9g support in shmobile_defconfig,
> >>   - The fourth patch removes all kzm9g-reference support, now the
> >>     sh73a0 generic multiplatform case has the same feature set
> >>     (better, it provides 16 MiB more RAM!).
> >>
> >> Thanks for applying!
> >
> > It seems to me that at the first two patches require the patchset
> > referenced above in order to work. For that reason I am holding off
> 
> Yes it does.
> 
> > on applying this series. I am quite happy to negotiate merging
> > some or all of this series earlier than later :)
> 
> Hence please merge both the dependency and this series.
> 
>   1. Both sh73a0/kzm9g-multiplatform and r8a73a4/ape6evm-multiplatform
>       depend on "[PATCH v3 0/4] drivers: bus: Add Simple Power-Managed Bus",

For some reason I assumed this would go through a different subsystem tree.
I'm fine with taking it through my tree, if you think that is best.

I am a bit worried about handling conflicts that may arise, especially from
the first two patches in that series which re-arrange things
alphabetically. But I see that the files in question are not updated very
often, so I suppose we should be safe enough.


For now I have tentatively queued up both this patchset and the
dependency listed immediately above. Please take a look
at the sh73a0-multiplatform-for-v3.20 and drivers-for-v3.20 branches
and the renesas-next-20150114-v3.19-rc1 tag to see if I missed something.

>   2. DT PM domain for sh73a0 and r8a73a4 depends on
>       sh73a0/kzm9g-multiplatform and r8a73a4/ape6evm-multiplatform,
>   3. CONFIG_CPU_IDLE=y hangs on sh73a0 without an early timer.
>        - On kzm9g-multiplatform this can be fixed by adding an
>          arm,cortex-a9-twd-timer node, but that breaks kzm9g-reference as
>          the TWD driver requires CCF when instantiated from DT,
>        - Fixing this on kzm9g-reference requires setting
>          ".init_time = sh73a0_earlytimer_init", and also instantiating the GIC
>          from C board code, as the TWD platform device uses an hardcoded
>          interrupt number.
>          It seems simpler to let kzm9g-reference die, so this problem goes
>          away.
> 
> Thanks for your consideration!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
