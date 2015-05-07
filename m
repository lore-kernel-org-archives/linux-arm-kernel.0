From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu, 7 May 2015 17:42:44 +0800
Subject: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <20150424125521.GU6325@pengutronix.de>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
 <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
 <20150423120152.GM6325@pengutronix.de>
 <CALx668VsT60+kx7o-ZM5Wxk7Nn-rXS21O5SDYr++EeY-zEJ6ew@mail.gmail.com>
 <20150424125521.GU6325@pengutronix.de>
Message-ID: <CALx668V4Ri_7cEefY8pZW7YkGcnf1JU-VD1bka0Rzc1xjC9dqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 8:55 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Apr 24, 2015 at 02:46:25PM +0800, Pi-Cheng Chen wrote:
>> Hi Sascha,
>>
>> Thanks for reviewing.
>>
>> On Thu, Apr 23, 2015 at 8:01 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > On Mon, Apr 20, 2015 at 05:27:26PM +0800, pi-cheng.chen wrote:
>> >> This patch implements MT8173 specific cpufreq driver with OPP table defined
>> >> in the driver code.
>> >>
>> >> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
>> >> ---
>> >>  drivers/cpufreq/Kconfig.arm      |   6 +
>> >>  drivers/cpufreq/Makefile         |   1 +
>> >>  drivers/cpufreq/mt8173-cpufreq.c | 509 +++++++++++++++++++++++++++++++++++++++
>> >>  3 files changed, 516 insertions(+)
>> >>  create mode 100644 drivers/cpufreq/mt8173-cpufreq.c
>> >>
>> >> +static int mtk_cpufreq_voltage_trace(struct cpu_dvfs_info *info,
>> >> +                                  struct mtk_cpu_opp *opp)
>> >> +{
>> >> +     struct regulator *proc_reg = info->proc_reg;
>> >> +     struct regulator *sram_reg = info->sram_reg;
>> >> +     int old_vproc, new_vproc, old_vsram, new_vsram, vsram, vproc, ret;
>> >> +
>> >> +     old_vproc = regulator_get_voltage(proc_reg);
>> >> +     old_vsram = regulator_get_voltage(sram_reg);
>> >> +
>> >> +     new_vproc = opp->vproc;
>> >> +     new_vsram = opp->vsram;
>> >> +
>> >> +     /*
>> >> +      * In the case the voltage is going to be scaled up, Vsram and Vproc
>> >> +      * need to be scaled up step by step. In each step, Vsram needs to be
>> >> +      * set to (Vproc + 200mV) first, then Vproc is set to (Vsram - 100mV).
>> >> +      * Repeat the step until Vsram and Vproc are set to target voltage.
>> >> +      */
>> >> +     if (old_vproc < new_vproc) {
>> >> +next_up_step:
>> >> +             old_vsram = regulator_get_voltage(sram_reg);
>> >> +
>> >> +             vsram = (new_vsram - old_vproc < MAX_VOLT_SHIFT) ?
>> >> +                     new_vsram : old_vproc + MAX_VOLT_SHIFT;
>> >> +             vsram = get_regulator_voltage_floor(sram_reg, vsram);
>> >> +
>> >> +             ret = regulator_set_voltage(sram_reg, vsram, vsram);
>> >> +             if (ret)
>> >> +                     return ret;
>> >
>> > This introspecting the regulators for possible voltages looks hacky and
>> > unnecessary. regulator_set_voltage() can be passed minimum and maximum
>> > values, why don't you use it to increase the voltage within sensible
>> > limit, like
>> >
>> >         regulator_set_voltage(sram_reg, old_vsram + 100000, old_vsram + 200000);
>> >
>> > or similar?
>>
>> I am sorry I don't understand how could I do it. Would you elaborate?
>
> You try to set the OPPs to the exact voltages, then next use functions
> to determine the next exact higher voltage and set the regulator voltage
> to an exact value. Instead of doing this you can let the ability to
> specify a voltage range work for you, something like:
>
>         int tolerance = 50000;
>
>         while (vproc < new_vproc) {
>                 int next = min(new_vproc - vproc, 200000);
>                 int next_sram = next + 100000;
>
>                 regulator_set_voltage(sram_reg, next_sram - tolerance, next_sram + tolerance);
>                 regulator_set_voltage(vproc_reg, next - tolerance, next + tolerance);
>                 vproc = regulator_get_voltage(vproc_reg);
>         }

Thanks for your explanation.
I'll try it to get rid of those functions to find out the exact voltages.

Best Regards,
Pi-Cheng

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
