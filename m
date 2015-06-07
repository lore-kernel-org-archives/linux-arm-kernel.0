From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 07 Jun 2015 11:02:18 +0200
Subject: [PATCH v4 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <5573DBDC.2010204@rock-chips.com>
References: <1433523923-4755-1-git-send-email-wxt@rock-chips.com>
 <CAD=FV=VswV+MAgYr084VOxQynHrL1fdwnVb4b_W_bHUZgoW4mg@mail.gmail.com>
 <5573DBDC.2010204@rock-chips.com>
Message-ID: <3887846.0ppL0Y56At@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar, Doug,

Am Sonntag, 7. Juni 2015, 13:51:24 schrieb Caesar Wang:
> ? 2015?06?07? 11:43, Doug Anderson ??:
> > Caesar,
> > 
> > On Sat, Jun 6, 2015 at 7:51 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> >> @@ -150,13 +159,15 @@ static int __cpuinit
> >> rockchip_boot_secondary(unsigned
> >> int cpu,
> >> 
> >>                   * sram_base_addr + 4: 0xdeadbeaf
> >>                   * sram_base_addr + 8: start address for pc
> >>                   * */
> >> 
> >> -               udelay(10);
> >> +               udelay(20);
> >> 
> >> I increased the 'udelay(20)' or 'udelay(50)' in
> >> rockchip_boot_secondary().
> >> Set#2 also can repro this issue over 22600 cycles with testing scripts.
> >> (about 1 hours)
> >> 
> >> log:
> >> ================= 226 ============
> >> [ 4069.134419] CPU1: shutdown
> >> [ 4069.164431] CPU2: shutdown
> >> [ 4069.204475] CPU3: shutdown
> >> ......
> >> [ 4072.454453] CPU1: shutdown
> >> [ 4072.504436] CPU2: shutdown
> >> [ 4072.554426] CPU3: shutdown
> >> [ 4072.577827] CPU1: Booted secondary processor
> >> [ 4072.582611] CPU2: Booted secondary processor
> >> [ 4072.587426] CPU3: Booted secondary processor
> >> <hang>
> >> 
> >> The set #4 will be better work.
> > 
> > OK, I'm OK with this, but I'd like to get Heiko's opinion.
> > 
> > Also:
> > * Just for kicks, does mdelay(1) work?  I know that's 100x more than
> 
> OK, it should delay more time.
> 
> the mdelay(1) can be work over 50000 cycles, so that should be work.
> 
> 
> Perhaps, can we use 'usleep_range(500, 1000)' to work.
> Heiko, do you agree with it?

yep :-)

As I said before, doing

	powerup, deassert_reset, wait_for_powerdomain

feels like it is only moving the problem a bit but is actually only working by 
chance, as my [little bit of :-) ] common sense tells me, that we really only 
should deassert the reset when we're sure that the core has power, i.e.

	powerup, wait_for_powerdomain, deassert_reset

Also, when going down this path, please take a look at the slightly different 
variant I posted as response to v3, as it makes the diff a bit smaller :-)


As for {u/m}delay vs. your usleep_ranges, I don't know if you're allowed to 
sleep in this area. Other architectures only seem to use udelay in __cpu_up 
which calls the smp_secondary_startup callback, like:

- arch/sh/kernel/smp.c
- arch/m32r/kernel/smpboot.c [is even a udelay(1000)
and more


Heiko

> > udelay(10), but previously we were actually looping waiting for the
> > power domain, right?  ...so maybe the old code used to introduce a
> > pretty big delay.
> > 
> > * Does anyone from the chip design team have any idea why patch set #4
> > works but patch set #2 doesn't?  I know it's Sunday morning in China
> > right now, but maybe you could ask Monday?
> > 
> > 
> > Thanks!
> > 
> > -Doug
