From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 26 Apr 2016 23:07:53 +0200
Subject: [PATCH V2] clk: bcm2835: mark enabled pll_dividers as critical
In-Reply-To: <8737q8dv5f.fsf@eliezer.anholt.net>
References: <1461660989-11846-1-git-send-email-kernel@martin.sperl.org>
 <8737q8dv5f.fsf@eliezer.anholt.net>
Message-ID: <BC74AA10-C36C-4643-B979-0617D222D605@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Sent from my iPad
> On 26.04.2016, at 21:31, Eric Anholt <eric@anholt.net> wrote:
> 
> kernel at martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> The bcm2835 firmware enables several clocks and plls before
>> booting the linux kernel.
>> 
>> These plls should never get disabled as it may result in a
>> stopped system clock and more.
>> 
>> So during probing we check if the pll_divider is enabled
>> and if it is then mark that pll_divider as critical.
>> As a consequence this will also enable the corresponding parent pll.
>> 
>> Here the list of pll_div that are marked as critical:
>> [    2.022437] bcm2835-clk 20101000.cprman: found enabled pll_div plla_core - marking it as critical
>> [    2.031640] bcm2835-clk 20101000.cprman: found enabled pll_div pllb_arm - marking it as critical
>> [    2.040966] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_core0 - marking it as critical
>> [    2.050351] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_per - marking it as critical
>> [    2.059427] bcm2835-clk 20101000.cprman: found enabled pll_div plld_core - marking it as critical
>> [    2.068590] bcm2835-clk 20101000.cprman: found enabled pll_div plld_per - marking it as critical
>> [    2.077724] bcm2835-clk 20101000.cprman: found enabled pll_div pllh_pix - marking it as critical
> 
> Yeah, pllh_pix isn't critical, though.  We want it to get turned off
> when the driver asks to disable its clock, or we're going to just waste
> a pile of power.
> 
> I'm sending out a patch that marks the VPU clock as critical (it's the
> also AXI bus, so it certainly is critical), which should solve your
> aux_uart clock disabling problem, I think.

The problem is that it also fails on the pcm clock alone when pllc or 
plld_per are used as parent, but it is fine when osc is used...

This started to show during the steps towards migration of 
downstream to use the new driver -PCM was the only clock that was 
referred in the dt to use the new clock driver while all others were 
using fixed clocks.

So as far as I can see this is a bigger problem and making all 
running pll_div Critical makes it work fine.

We potentially could mask pllh as non-critical, but even then
the parent selector could choose pllh-per and then release it
and then the hdmi would stop working... E.g if we would request a
PCM clock rate of  290039- then Pllh_aux would be ideal with 
a divider of 2 and on releasing it it would stop the pllh (assuming
no KMS)

There was this other approach proposed by Michael some time ago
that might be the better solution, but then I guess it had its own
drawbacks, which may not make it applicable in our situation.

Critical seems the right choice, but we would need a means
that would allow us to remove the critical flag when first requesting
the clock for some clocks - maybe via dt - so that when KMS is
enabled the critical flag for pllh_aux is removed.

As an alternative: maybe set the flag to use in case the pll-div
is enabled in the pll_div_data structure. That way we can
make some decisions on a per pll-div basis...

Martin
