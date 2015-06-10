From: r.spliet@ultimaker.com (Roy Spliet)
Date: Wed, 10 Jun 2015 09:31:40 +0200
Subject: [PATCH v2] mtd: nand: Sunxi calculate timing cfg
In-Reply-To: <20150609162007.7b19e8e2@bbrezillon>
References: <1433849498-3270-1-git-send-email-r.spliet@ultimaker.com>	<20150609142308.0fd0952a@bbrezillon>	<5576E7C2.10604@ultimaker.com>
 <20150609162007.7b19e8e2@bbrezillon>
Message-ID: <5577E7DC.9000707@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Boris!

Op 09-06-15 om 16:20 schreef Boris Brezillon:
> On Tue, 09 Jun 2015 15:18:58 +0200
> Roy Spliet<r.spliet@ultimaker.com>  wrote:
>
>>   >> +
>>   >> +static s32 sunxi_nand_lookup_timing(const s32 *lut, lut, u32
>> period, u32 clk_period)
>>   > I'm not sure the period name is appropriate here, what you're actually
>>   > passing is the timing you're expecting.
>>   > How about renaming it 'min_timing'
>>
>> What it encodes is the minimum or maximum time or delay for given timing
>> parameter in picoseconds. Given this definition, I think period actually
>> describes the parameter better than "min_timing". Alternatively, I could go
>> for period_ps or perhaps timing_period_ps (with matching clk_period_ps).
> Hm, I don't agree here. From my POV, a period is something used to
> describe cyclic operations. If you take a clk, the period encodes the
> time required a clk cycle (a rising and a falling edge).
> Here the timings you're passing are not cyclic at all.
For the sake of argument: within a cyclic event (wave theory) you are 
quite right with
this definition: the period describes the time to complete one cycle (or 
oscillation).
However, in English[1] a period is simply a length of time, carrying no 
further
specification about any recurrence of events.
Having said that, you're the person who still has to look at this code 
three weeks from
now. I personally find "timing" a confusing name because it is more 
abstract than
what the value holds (the interval/period/duration of a memory "state"), 
but if you find
that clearer, it's your final call!
>>   >> +{
>>   >> +    u32 clks = (period + clk_period - 1) / clk_period;
>>   >     u32 clks = DIV_ROUND_UP(period, clk_period);
>>   >
>>   > And again, IMO the variable name does not match what it's really
>>   > encoding. How about div or divisor ?
>>
>> This value encodes the period in number of clock cycles. If period_ps is
>> acceptable, how about period_cycles here?
> I'd rather use clk_cycles, or just cycles then.
clk_cycles it is.
>
>>   >> +    tADL = DIV_ROUND_UP(timings->tADL_min, min_clk_period) >> 3;
>>   >> +    tWHR = DIV_ROUND_UP(timings->tWHR_min, min_clk_period) >> 3;
>>   >> +    tRHW = sunxi_nand_lookup_timing(tRHW_lut, timings->tRHW_min,
>>   >> +            min_clk_period);
>>   >> +    tCAD = 0x7;
>>   >> +    chip->timing_cfg = (tWB & 0x3) |
>>   >> +               (tADL & 0x3) << 2 |
>>   >> +               (tWHR & 0x3) << 4 |
>>   >> +               (tRHW & 0x3) << 6 |
>>   >> +               (tCAD & 0x7) << 8;
>>   >> +    /* \todo A83 has some more bits for CDQSS, CS, CLHZ, CCS, WC */
>>   > Use the "TODO:" or "FIXME:" keywords so that people greping on these
>>   > pattern will be able to find them.
>>
>> I used \todo as the (assumed) preferred notation for doxygen (... but
>> omitted
>> the second * denoting doxygen documentation formatting) Eclipse picks it up
>> fine, but if you prefer TODO: for your toolchain, it's the same to me.
> It depends on the kernel coding style rules, and AFAIR they use the
> TODO and FIXME (in capital letters) keywords.
Works for me.
>>   >>      /*
>>   >> -     * TODO: replace these magic values with proper flags as soon as we
>>   >> -     * know what they are encoding.
>>   >> +     * TODO: replace this magic values with EDO flag
>>   >>       */
>>   >>      writel(0x100, nfc->regs + NFC_REG_TIMING_CTL);
>>   >> -    writel(0x7ff, nfc->regs + NFC_REG_TIMING_CFG);
>>   > Are you planning to post another patch defining the EDO mode flag and
>>   > using it instead of keeping this magic value (note that I'm not
>>   > asking you to make this change in the same patch, but that would be
>>   > great to have it in the same patch series) ?
>>
>> I agree that it would be good, but it is derived from the 6th ID byte, which
>> I have already seen omitted in several datasheets. I'm not sure if we can do
>> this without at least offering the option for overriding this value in
>> the DT?
> Actually, I was just asking for a flag definition. You can keep the
> assignment here till we find a proper solution to extract it from the
> read-id (or ONFI information).
I hope to send you a V3 today once we get that bike shed painted :-). Yours,

Roy

[1] http://dictionary.cambridge.org/dictionary/business-english/period

-- 


IMAGINE IT >> MAKE IT

Meet us online at Twitter <http://twitter.com/ultimaker>, Facebook 
<http://facebook.com/ultimaker>, Google+ <http://google.com/+Ultimaker>

www.ultimaker.com
