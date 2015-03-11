From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 11 Mar 2015 22:43:39 +0100
Subject: [PATCH 2/2] ARM: rockchip: disable watchdog during suspend
In-Reply-To: <CAD=FV=WqdVD9_LGtYCHV-T3hTbq8wZ8z52rdD5HF7eHLWf8kTQ@mail.gmail.com>
References: <1423487543-10593-1-git-send-email-zyw@rock-chips.com>
 <54F54D55.8040200@rock-chips.com>
 <CAD=FV=WqdVD9_LGtYCHV-T3hTbq8wZ8z52rdD5HF7eHLWf8kTQ@mail.gmail.com>
Message-ID: <2571344.24clYEvdNe@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris & Doug,

Am Mittwoch, 11. M?rz 2015, 14:23:38 schrieb Doug Anderson:
> On Mon, Mar 2, 2015 at 9:57 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> > On 03/03/2015 04:50 AM, Heiko Stuebner wrote:
> >> Hi Chris,
> >> 
> >> Am Montag, 9. Februar 2015, 21:12:23 schrieb Chris Zhong:
> >>> The watchdog clock should be disable in dw_wdt_suspend, but we set a
> >>> dummy clock to watchdog for rk3288. So the watchdog will continue to
> >>> work during suspend. And we switch the system clock to 32khz from 24Mhz,
> >>> during suspend, so the watchdog timer over count will increase to
> >>> 755 times, about 12.5 hours, the original value is 60 seconds. So
> >>> watchdog will reset the system over a night,  but voltage are all
> >>> incorrect, then it hang on reset.
> >>> 
> >>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> >>> Signed-off-by: Daniel Kurtz <djkurtz@google.com>
> >> 
> >> The SGRF is not writeable in all bootmodes (I've talked with Doug about
> >> this
> >> to verify I remembered this correctly), so handling the sgrf gate for the
> >> watchdog is not safe for all possible boards.
> >> 
> >> Why not simply turn off the watchdog in the driver during suspend?
> > 
> > I think SGRF is writeable, since we would set this RK3288_SGRF_SOC_CON0
> > register when suspend.
> > and this SGRF_PCLK_WDT_GATE is one bit of RK3288_SGRF_SOC_CON0.
> 
> OK, hmmm.  ...so I guess you're right that our current suspend/resume
> code assumes that this register is writable...
> 
> I was relatively certain that SGRF was supposed to be non-accessible
> in boot modes when we're running the kernel at a lower privilege
> level.  I think I remember thinking that whenever someone finally
> manages to implement that they would be in for quite a task dealing
> with suspend/resume.  This is one thing that they'd have to deal with,
> but they'd also have to deal with the fact that we program the CPU to
> jump straight back to the kernel at resume time and the CPU will (as I
> understand it) be in "secure SVC" mode.
> 
> ...so my thought is that it's OK to add this to the suspend/resume
> code and it'll just be another thing to figure out if anyone ever runs
> this in a different mode.

with Chris recent comments I was leaning towards this as well, so I'm very 
happy to have someone share these thoughts :-)


> I guess that brings up the question about whether we should revisit
> (e142a4e clk: rockchip: add a dummy clock for the watchdog pclk on
> rk3288) and actually try to implement it correctly.  I'm still leaning
> towards leave it the way it is with the dummy clock, but if someone
> wants to try implementing it for real then I suppose you could have a
> nicer way to implement dw_wdt (no need for a kernel thread to keep
> patting).

There are some more clocks living in the GRF and SGRF (muxes relating to 
vcodec and some more). At some point I want to tackle this, but for now I 
think that it can stay how it is.


> > I tried to set wdt_en(WDT_CR[bit 0]) to 0 in watchdog driver, but that
> > would cause system reboot.
> 
> Wow, that stinks.  That explains some of the hackiness of the current
> dw_wdt driver that was wondering about.  That stinks that it's totally
> not documented in the user manual (unless I missed it).
> 
> With all that:
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>

I've now applied both patches with Doug's tags to my v4.1-armsoc/soc branch, 
but adapted the commit message for patch1 a tiny bit.


Heiko
