From: mwelling@ieee.org (Michael Welling)
Date: Thu, 16 Apr 2015 11:17:56 -0500
Subject: AM335x OMAP2 common clock external fixed-clock registration
In-Reply-To: <552F3B60.8050703@ti.com>
References: <20150414211734.GA28974@deathray> <552E0688.1020903@ti.com>
 <20150415140945.GA30787@deathray> <552EB152.7050306@ti.com>
 <20150415194707.GA11007@deathray>
 <CAPtuhTggHctp5ArGPEuKn2GuPzb-WnKv2_CzPrHzq8hwOR5Aqw@mail.gmail.com>
 <20150415205136.GA3399@deathray> <552F3B60.8050703@ti.com>
Message-ID: <20150416161756.GA27590@deathray>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 07:32:32AM +0300, Tero Kristo wrote:
> On 04/15/2015 11:51 PM, Michael Welling wrote:
> >On Wed, Apr 15, 2015 at 01:45:53PM -0700, Mike Turquette wrote:
> >>On Wed, Apr 15, 2015 at 12:47 PM, Michael Welling <mwelling@ieee.org> wrote:
> >>>On Wed, Apr 15, 2015 at 09:43:30PM +0300, Tero Kristo wrote:
> >>>>On 04/15/2015 05:09 PM, Michael Welling wrote:
> >>>>>On Wed, Apr 15, 2015 at 09:34:48AM +0300, Tero Kristo wrote:
> >>>>>>On 04/15/2015 12:17 AM, Michael Welling wrote:
> >>>>>>>Greetings,
> >>>>>>>
> >>>>>>>I have developed an AM3354 based SoM and it uses an external SI5351 clock
> >>>>>>>generator to drive the clock inputs for an external duart and I2S audio
> >>>>>>>master clock. With the registration according to the documentation the
> >>>>>>>reference clock is not being detected and hence the clock generator is
> >>>>>>>not working as expect.
> >>>>>>>
> >>>>>>>After trying many different things, I started to look around the mailing
> >>>>>>>lists to find information related to this issue.
> >>>>>>>
> >>>>>>>I came acrossed post that has the exact same issue:
> >>>>>>>https://lkml.org/lkml/2013/2/18/468
> >>>>>>>
> >>>>>>>Seeing as the patch did not land upstream, I am wondering if there is
> >>>>>>>a solution that I am not seeing.
> >>>>>>>
> >>>>>>>I am willing to provide a patch given appropriate guidance.
> >>>>>>
> >>>>>>Hi Michael,
> >>>>>>
> >>>>>>The info on the email you referenced is kind of obsolete, TI SoCs
> >>>>>>are calling of_clk_init() during boot now, and thus external clock
> >>>>>>nodes should be registered fine also. Maybe you can provide the
> >>>>>>actual DTS patch you are trying out so we can help better...? Are
> >>>>>
> >>>>>See attached patch and console output.
> >>>>
> >>>>I see a bug in your dt data.
> >>>>
> >>>><snip>
> >>>>
> >>>>+     clocks {
> >>>>+             ref27: ref27 {
> >>>>+                     #clock-cells = <0>;
> >>>>+                     compatibale = "fixed-clock";
> >>>>
> >>>>This should be compatible, right? DT is annoying in that it doesn't
> >>>>verify property names.
> >>>>
> >>>
> >>>Ooops.
> >>>
> >>>Now the clock appears in /sys/kernel/debug/clk:
> >>>root at som3517-som200:/sys/kernel/debug/clk# cat clk_summary
> >>>    clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> >>>----------------------------------------------------------------------------------------
> >>>  ref27                                    0            0    27000000          0 0
> >>>...
> >>>
> >>>There is still an issue with the si5351.
> >>>
> >>>I had to comment out the clk_put here for the frequency to show up:
> >>>http://lxr.free-electrons.com/source/drivers/clk/clk-si5351.c#L1133
> >>>
> >>>Ideas?
> >>
> >>What is the most recent upstream commit that you are based on?
> >
> >I am working from 4.0.0-rc7.
> >
> >7b43b47373d40d557cd7e1a84a0bd8ebc4d745ab
> 
> Hmm, I wonder why si5351 calls clk_put immediately after of_clk_get
> in the first place, as far as I understand this destroys the clock
> handle, which is still being used later in the code.
> 
> -Tero

Not sure how this ever worked. This has been in the code since the
initial commit.

Sebastian?

> 
> >
> >>
> >>Regards,
> >>Mike
> >>
> >>>
> >>>>+                     clock-frequency = <27000000>;
> >>>>+             };
> >>>>+     };
> >>>>
> >>>>-Tero
> >>>>
> >>>>>
> >>>>>>you seeing any boot time error / warning prints for your new clock?
> >>>>>
> >>>>>With the debug messages on you see that the reference clock is not being
> >>>>>detected.
> >>>>>
> >>>>>Whilest debugging I found that the of_clk_get is returning an error no matter
> >>>>>which clock I pass it:
> >>>>>http://lxr.free-electrons.com/source/drivers/clk/clk-si5351.c#L1131
> >>>>>
> >>>>>>
> >>>>>>-Tero
> >>>>
> 
