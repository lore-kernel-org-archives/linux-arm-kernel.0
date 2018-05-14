From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 May 2018 15:19:41 +0530
Subject: [PATCH 2/2] clk: davinci: psc-dm365: fix few clocks
In-Reply-To: <afdf0f39-1035-117e-a319-f615ac109902@lechnology.com>
References: <20180511141037.25250-1-nsekhar@ti.com>
 <20180511141037.25250-3-nsekhar@ti.com>
 <afdf0f39-1035-117e-a319-f615ac109902@lechnology.com>
Message-ID: <7cd9d990-26d5-f7d4-291b-a4e4e905cabc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Saturday 12 May 2018 07:12 AM, David Lechner wrote:
> On 05/11/2018 09:10 AM, Sekhar Nori wrote:
>> Fix parent of emac and voice codec PSC clocks. This now matches
>> existing implementation in arch/arm/mach-davinci/dm365.c
>>
>> Also, there is only one power domain on DM365. Fix the power
>> domain of voice codec and vpss dac modules.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>> ? drivers/clk/davinci/psc-dm365.c | 6 +++---
>> ? 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/davinci/psc-dm365.c
>> b/drivers/clk/davinci/psc-dm365.c
>> index 5b5b55b0b59a..beeda10fd2f0 100644
>> --- a/drivers/clk/davinci/psc-dm365.c
>> +++ b/drivers/clk/davinci/psc-dm365.c
>> @@ -65,9 +65,9 @@ static const struct davinci_lpsc_clk_info
>> dm365_psc_info[] = {
>> ????? LPSC(31, 0, arm,???????? pll2_sysclk2, NULL,??????????????
>> LPSC_ALWAYS_ENABLED),
>> ????? LPSC(38, 0, spi3,??????? pll1_sysclk4, spi3_clkdev,??????? 0),
>> ????? LPSC(39, 0, spi4,??????? pll1_auxclk,? spi4_clkdev,??????? 0),
>> -??? LPSC(40, 0, emac,??????? pll2_sysclk4, emac_clkdev,??????? 0),
>> -??? LPSC(44, 1, voice_codec, pll1_sysclk3, voice_codec_clkdev, 0),
>> -??? LPSC(46, 1, vpss_dac,??? pll1_sysclk3, vpss_dac_clkdev,??? 0),
>> +??? LPSC(40, 0, emac,??????? pll1_sysclk4, emac_clkdev,??????? 0),
>> +??? LPSC(44, 0, voice_codec, pll2_sysclk4, voice_codec_clkdev, 0),
>> +??? LPSC(46, 0, vpss_dac,??? pll1_sysclk3, vpss_dac_clkdev,??? 0),
>> ????? LPSC(47, 0, vpss_master, pll1_sysclk5, vpss_master_clkdev, 0),
>> ????? LPSC(50, 0, mjcp,??????? pll1_sysclk3, NULL,?????????????? 0),
>> ????? { }
>>
> 
> Slightly off topic...
> 
> Hmm... Looking at the TRM, I see that there are a bunch of mux clocks
> that we
> have not implemented for the DM365 (all of the clocks in the
> VPSS_CLK_CTRL and
> PERI_CLKCTL registers). I'm wondering if we should be creating drivers for
> those like the DA8XX CFGCHIP clock driver.

Yes, but lets leave that to after the current version is merged. That
way we have one kernel version which is just replacing the private clock
implementation and that will be good to bisect any regressions.
VPSS_CLK_CTRL for example is being set directly by the VPSS driver. That
driver will have to change too once we model the mux as a proper clock.

> 
> Back on topic...
> 
> The emac fix here looks good.

Okay.

> 
> The TRM (sprufg5a.pdf) shows that there is a DIV2 clock (part of the
> PERI_CLKCTL register) between PLL2 SYSCLK4 and Voice Codec in Figure 5,
> It also shows PLL1 SYSCLK4 as a second parent clock to Voice Codec, however
> this dependency has probably gone unnoticed because so many other devices
> also use that same clock, it will pretty much always be on. In Figure 38,
> on the other hand, PLL1 SYSCLK4 is shown as the only parent of Voice Codec.
> 
> So, I am thinking that pll1_sysclk4 is the correct parent for the
> voice_codec clock here since it is the only one listed in Figure 38
> (which is in the PSC section of the TRM). The pll2_sysclk4 clock should
> probably be used by the video codec device driver directly (well, the
> DIV2 clock really, but we don't have a driver for that yet).

Well the main thing I went with here is compatibility with existing code
which uses pll2_sysclk4. You are right that pll1_sysclk4 is probably a
better parent clock to model for the PSC. But, this will break existing
functionality as no one will be enabling pll2_sysclk4 then. And I
suspect that will break voice codec driver. The documentation for voice
codec does not seem to do a good job of explaining what the two clocks
are for. And without some thorough testing of voice codec (I have never
used it myself), I would just keep the functionality as-is.

I can add a comment on how the parent was arrived at though, so there is
some reference to when we look at this again.

> 
> The vpss_dac clock in not very clear in the TRM. In Table 39, the name
> for LPSC 46, which we are calling "vpss_dac", is "VDAC CLK". In Figure
> 37, however, there is not a node that matches exactly. There is "VIDEO
> DAC", which I take to be the same clock though. This has parent clocks
> of PLL1 SYSCLK6 and PLL1 AUXCLK. So, I am guessing that pll1_sysclk6
> should be the parent here rather than pll1_sysclk3. According to Figure
> 5, PLL1 SYSCLK3 only feeds HDVPID and MJCP, which I don't think are the
> same as the video DAC since they are also listed separately in Figure 5.

The HDVICP is a subsystem in itself, so I am not so sure about that. The
problem here is compounded by the fact that some of these video
subsystems are not publicly documented. Here too, I think the safer
approach is to be compliant with existing code at least for one kernel
version. Otherwise, we run into the issue of too many things changing at
the same time making it tough to nail regressions.

we can add a comment here too on how the parent was arrived at (refer
back to existing code).

Thanks,
Sekhar
