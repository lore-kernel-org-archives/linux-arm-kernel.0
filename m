From: dianders@chromium.org (Doug Anderson)
Date: Mon, 13 Jun 2016 16:05:59 -0700
Subject: [PATCH 09/11] phy: rockchip-emmc: Set phyctrl_frqsel based on
 card clock
In-Reply-To: <937cbbc5-f9dc-bdf0-c46a-c7e814b9b373@rock-chips.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-10-git-send-email-dianders@chromium.org>
 <937cbbc5-f9dc-bdf0-c46a-c7e814b9b373@rock-chips.com>
Message-ID: <CAD=FV=VA6vmfzHEOZwAFJvNXRDhPmf+bX-Jw1eFboOdP6kD3dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Mon, Jun 13, 2016 at 1:54 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2016/6/8 6:44, Douglas Anderson wrote:
>>
>> The "phyctrl_frqsel" is described in the Arasan datasheet [1] as "the
>> frequency range of DLL operation".  Although the Rockchip variant of
>> this PHY has different ranges than the reference Arasan PHY it appears
>> as if the functionality is similar.  We should set this phyctrl field
>> properly.
>>
>> Note: as per Rockchip engineers, apparently the "phyctrl_frqsel" is
>> actually only useful in HS200 / HS400 modes even though the DLL itself
>> it used for some purposes in all modes.  See the discussion in the
>> earlier change in this series: ("mmc: sdhci-of-arasan: Always power the
>> PHY off/on when clock changes").  In any case, it shouldn't hurt to set
>> this always.
>>
>> Note that this change should allow boards to run at HS200 / HS400 speed
>> modes while running at 100 MHz or 150 MHz.  In fact, running HS400 at
>> 150 MHz (giving 300 MB/s) is the main motivation of this series, since
>> performance is still good but signal integrity problems are less
>> prevelant at 150 MHz.
>
>
> Thanks for doing this, but I think we should limit freq if assigning
> max-frequency from DT more explicitly since the PHY could only support
> 50/100/150/200M for hs200/400? Otherwise I can't say if the PHY could
> always work well. i.e if geting 125000000 ... 174999999 , you code make
> the phyctrl_frqsel to be 150M, so it will be 15% missing of precision
> for tuning delay element. Ideally, the sample point should be in the
> middle of window, but I don't know if there is a bad HW design makes
> the window small enough which need special care about it.

What would you suggest as a valid range, then?

>From the public Arasan datasheet they seem to indicate +/- 15 MHz is
sane.  Does that sound OK?  Presuming that all of your numbers
(50/100/150/200) are centers, that means that we could support clock
rates of:

35 MHz - 65 MHz
85 MHz - 115 MHz
135 MHz - 165 MHz
185 MHz - 200 MHz


So how about if we add a warning for things that are outside of those
ranges?  ...except no warning for < 35 MHz since presumably we're not
using high speed modes when the DLL is that slow and so we're OK.


NOTE: In rk3399 it's actually quite important to handle clocks that
aren't exactly the right MHz.  When you ask for 150 MHz you actually
end up a child of GPLL and actually end up@148.5 MHz.  This should
be close enough, but it's not exactly 150 MHz.  If we can't handle
148.5 MHz then the 150 MHz setting in the PHY is useless.

Also note that on rk3399 we're fairly limited on the number of rates
we can actually make since they need to be even divisors of 594 MHz or
800 MHz (assuming you don't rejigger all the PLLs in the SoC or
something).  Most of the rates are actually in those ranges...


-Doug
