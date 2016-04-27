From: eric@anholt.net (Eric Anholt)
Date: Tue, 26 Apr 2016 18:30:25 -0700
Subject: [PATCH V2] clk: bcm2835: mark enabled pll_dividers as critical
In-Reply-To: <BC74AA10-C36C-4643-B979-0617D222D605@martin.sperl.org>
References: <1461660989-11846-1-git-send-email-kernel@martin.sperl.org>
 <8737q8dv5f.fsf@eliezer.anholt.net>
 <BC74AA10-C36C-4643-B979-0617D222D605@martin.sperl.org>
Message-ID: <87bn4v6dou.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

> Sent from my iPad
>> On 26.04.2016, at 21:31, Eric Anholt <eric@anholt.net> wrote:
>> 
>> kernel at martin.sperl.org writes:
>> 
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>> 
>>> The bcm2835 firmware enables several clocks and plls before
>>> booting the linux kernel.
>>> 
>>> These plls should never get disabled as it may result in a
>>> stopped system clock and more.
>>> 
>>> So during probing we check if the pll_divider is enabled
>>> and if it is then mark that pll_divider as critical.
>>> As a consequence this will also enable the corresponding parent pll.
>>> 
>>> Here the list of pll_div that are marked as critical:
>>> [    2.022437] bcm2835-clk 20101000.cprman: found enabled pll_div plla_core - marking it as critical
>>> [    2.031640] bcm2835-clk 20101000.cprman: found enabled pll_div pllb_arm - marking it as critical
>>> [    2.040966] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_core0 - marking it as critical
>>> [    2.050351] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_per - marking it as critical
>>> [    2.059427] bcm2835-clk 20101000.cprman: found enabled pll_div plld_core - marking it as critical
>>> [    2.068590] bcm2835-clk 20101000.cprman: found enabled pll_div plld_per - marking it as critical
>>> [    2.077724] bcm2835-clk 20101000.cprman: found enabled pll_div pllh_pix - marking it as critical
>> 
>> Yeah, pllh_pix isn't critical, though.  We want it to get turned off
>> when the driver asks to disable its clock, or we're going to just waste
>> a pile of power.
>> 
>> I'm sending out a patch that marks the VPU clock as critical (it's the
>> also AXI bus, so it certainly is critical), which should solve your
>> aux_uart clock disabling problem, I think.
>
> The problem is that it also fails on the pcm clock alone when pllc or 
> plld_per are used as parent, but it is fine when osc is used... 

For that you're going to want the HAND_OFF patches that mturquette is
working on: Don't let the clock and its parents get turned off until a
driver has shown up that has referenced the clock and done at least a
prepare on it once.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160426/f949ce9c/attachment.sig>
