From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 11 Jun 2017 22:55:37 +0000
Subject: [RFC PATCH 3/4] ARM: l2x0: add arm, ecc-enable property for aurora
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
 <20170608041124.4624-4-chris.packham@alliedtelesis.co.nz>
 <1496998692.3536.24.camel@pengutronix.de>
Message-ID: <220533aeb8f64e829f483e38e209cdc8@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/17 20:58, Jan L?bbe wrote:
> On Do, 2017-06-08 at 16:11 +1200, Chris Packham wrote:
>> +       if (of_property_read_bool(np, "arm,ecc-enable")) {
>> +               mask |= L2C_AUX_CTRL_EVTMON_ENABLE;
>> +               val |= L2C_AUX_CTRL_EVTMON_ENABLE;
>> +       } else if (of_property_read_bool(np, "arm,ecc-disable")) {
>> +               mask |= L2C_AUX_CTRL_EVTMON_ENABLE;
>> +       }
> 
> Unless I misunderstand the code in __l2c_init(), the mask is used to
> specify the bits to preserve:
>          old_aux = aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
>          aux &= aux_mask;
>          aux |= aux_val;
> 
>          if (old_aux != aux)
>                  pr_warn("L2C: DT/platform modifies aux control register: 0x%08x -> 0x%08x\n",
>                          old_aux, aux);
> 
> So the arm,ecc-disable property will have no effect. This probably also
> applies to patch 2/4. The existing property *-disable code removes the
> corresponding bit from the mask.

Indeed the disable version should be mask &= ~L2C_AUX_CTRL_EVTMON_ENABLE 
and I was probably a little lazy to have used the L2C EVTMON instead of 
adding AURORA specific ones like you have in your series.

I'll rebase my series on top of yours and send it direct to you so you 
can include it in the overall submission.

> 
> Regards,
> Jan
> 
