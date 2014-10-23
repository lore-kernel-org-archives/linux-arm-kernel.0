From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 23 Oct 2014 12:53:02 +0300
Subject: [PATCH v2] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <CAMuHMdV4S+bV8C-aiHuYShjSNaGx6wD1C3uJRjRGqZ7U9SAFXw@mail.gmail.com>
References: <1413993263-10444-1-git-send-email-geert+renesas@glider.be>
 <1467605.AdUxz6EOpv@avalon>
 <CAMuHMdV4S+bV8C-aiHuYShjSNaGx6wD1C3uJRjRGqZ7U9SAFXw@mail.gmail.com>
Message-ID: <16849819.4PUYgNsGu5@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Thursday 23 October 2014 09:02:46 Geert Uytterhoeven wrote:
> On Wed, Oct 22, 2014 at 10:59 PM, Laurent Pinchart wrote:
> > On Wednesday 22 October 2014 19:34:17 Geert Uytterhoeven wrote:
> >> On Wed, Oct 22, 2014 at 6:08 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> >> I'm wondering whether this can be fixed in the i2c driver? Does it
> >> >> really
> >> >> have to enable and disable the clock?
> >> > 
> >> > From a power-saving PoV, this makes sense. I assume serial output works
> >> > again as soon as the regular scif driver takes over? Isn't that a
> >> 
> >> Yes it continues fine afterwards.
> >> With TMU0 in DT, it's enabled again even earlier, as they share the
> >> parent.
> > 
> > Would it make sense to have a list of clocks to reference from setup code
> > when DEBUG_LL is defined ? It's a bit hackish, but DEBUG_LL is hackish
> > anyway.
>
> With setup code you mean platform or MSTP setup code?

I was thinking about platform setup code, but I'm open to other options as 
well.

> That would be an option. The clock to enable depends on the SoC and SCIF(A)
> address, so it's gonna need a large table.

I know. It's not an ideal solution, I agree.

> >> BTW, the code in sh_mobile_i2c_init() does this:
> >>         /* Get clock rate after clock is enabled */
> >>         clk_prepare_enable(pd->clk);
> >>         i2c_clk_khz = clk_get_rate(pd->clk) / 1000;
> >>         clk_disable_unprepare(pd->clk);
> >> 
> >> I assume the enable/disable is no longer needed with CCF?
> > 
> > I assume so as well.
> 
> Is it still needed with non-CCF? This driver is shared with arch/sh/.

I haven't checked. If it is, I wonder whether we could move the prepare_enable 
and disable_unprepare calls to inside the non-CCF clk_get_rate() 
implementation.

-- 
Regards,

Laurent Pinchart
