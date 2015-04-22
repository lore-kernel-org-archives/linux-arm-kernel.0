From: joshc@ni.com (Josh Cartwright)
Date: Wed, 22 Apr 2015 09:33:52 -0500
Subject: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <CALx668W6nJkYR325BhxOXMF1z=i7mkYbh3pyBFDNoZC9NZ0dVw@mail.gmail.com>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
 <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
 <20150420141719.GF27115@jcartwri.amer.corp.natinst.com>
 <CALx668W6nJkYR325BhxOXMF1z=i7mkYbh3pyBFDNoZC9NZ0dVw@mail.gmail.com>
Message-ID: <20150422143352.GJ27115@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 22, 2015 at 11:11:34AM +0800, Pi-Cheng Chen wrote:
[..]
> >> +config ARM_MT8173_CPUFREQ
> >> +     bool "Mediatek MT8173 CPUFreq support"
> >> +     depends on ARCH_MEDIATEK && REGULATOR
> >
> > I think you want to 'select REGULATOR' here; because REGULATOR isn't
> > a user-visible option.
> 
> I am not sure but I need it to be "depends on" as other SoC cpufreq
> drivers. Please check
> ARM_S3C2416_CPUFREQ_VCORESCALE in drivers/cpufreq/Kconfig.arm
> By the way, I would like to know more details about the visibility of
> these configurable
> options, would you kindly point me out some documents about it?

Paul pointed out that I was wrong, so I'll defer to him.  My knowledge
has likely been outdated.

[..]
> >> +/* OPP table for LITTLE cores of MT8173 */
> >> +struct mtk_cpu_opp mt8173_l_opp[] = {
> >
> > static const?
> 
> Yes. I miss "static" here. But I need those two array to be non-const
> so that I could
> fix up the exact voltage values by querying the supported voltages of
> regulators.
> Please check the mt8173_cpufreq_cpu_opp_fixup() function below.

Indeed.  Thanks.

[..]
> >> +static int mtk_cpufreq_voltage_trace(struct cpu_dvfs_info *info,
> >> +                                  struct mtk_cpu_opp *opp)
> >> +{
> >> +     struct regulator *proc_reg = info->proc_reg;
> >> +     struct regulator *sram_reg = info->sram_reg;
> >> +     int old_vproc, new_vproc, old_vsram, new_vsram, vsram, vproc, ret;
> >> +
> >> +     old_vproc = regulator_get_voltage(proc_reg);
> >> +     old_vsram = regulator_get_voltage(sram_reg);
> >> +
> >> +     new_vproc = opp->vproc;
> >> +     new_vsram = opp->vsram;
> >> +
> >> +     /*
> >> +      * In the case the voltage is going to be scaled up, Vsram and Vproc
> >> +      * need to be scaled up step by step. In each step, Vsram needs to be
> >> +      * set to (Vproc + 200mV) first, then Vproc is set to (Vsram - 100mV).
> >> +      * Repeat the step until Vsram and Vproc are set to target voltage.
> >> +      */
> >> +     if (old_vproc < new_vproc) {
> >> +next_up_step:
> >> +             old_vsram = regulator_get_voltage(sram_reg);
> >> +
> >> +             vsram = (new_vsram - old_vproc < MAX_VOLT_SHIFT) ?
> >> +                     new_vsram : old_vproc + MAX_VOLT_SHIFT;
> >> +             vsram = get_regulator_voltage_floor(sram_reg, vsram);
> >> +
> >> +             ret = regulator_set_voltage(sram_reg, vsram, vsram);
> >> +             if (ret)
> >> +                     return ret;
> >> +
> >> +             vproc = (new_vsram == vsram) ?
> >> +                     new_vproc : vsram - MIN_VOLT_SHIFT;
> >> +             vproc = get_regulator_voltage_ceil(proc_reg, vproc);
> >> +
> >> +             ret = regulator_set_voltage(proc_reg, vproc, vproc);
> >> +             if (ret) {
> >> +                     regulator_set_voltage(sram_reg, old_vsram, old_vsram);
> >> +                     return ret;
> >> +             }
> >> +
> >> +             if (new_vproc == vproc && new_vsram == vsram)
> >> +                     return 0;
> >> +
> >> +             old_vproc = vproc;
> >> +             goto next_up_step;
> >
> > Perhaps a naive question: but, is this the correct place to do this?  I
> > would expect this stepping behavior to be implemented in the driver
> > controlling the regulator you are consuming.  It seems strange to do it
> > here.
> 
> This was already discussed in the last round of this series of patches.
> Please check the discussion[1]. Any suggestion would be welcomed.
> Thanks.

Interesting, thanks.  Sorry for rehashing already-covered territory!

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150422/0c3b0988/attachment-0001.sig>
