From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Tue, 19 Aug 2014 22:44:00 +0300
Subject: [PATCH v3 13/15] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <CAKohpokQOALPH13Ykz4nTBOby8J1X6_F30LNKz=gsC4wN3=3vg@mail.gmail.com>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>	<1408419205-10048-14-git-send-email-tuomas.tynkkynen@iki.fi>
 <CAKohpokQOALPH13Ykz4nTBOby8J1X6_F30LNKz=gsC4wN3=3vg@mail.gmail.com>
Message-ID: <53F3A900.8010805@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/14 08:55, Viresh Kumar wrote:
> On 19 August 2014 09:03, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> wrote:
>>  - use 'select GENERIC_CPUFREQ_CPU0', not depends
> 
> Bad :(
> 
> It *has* to be a depends here, its not optional. That was outcome of the
> chat we had last time, if I remember it well..

Okay, I misread that conversation then.

>> ---
> 
> You don't need to add these --- here, just add a blank line and git
> will take care of things for you :)

There's actually a (mis-?)feature in git format-patch: a literal '---'
line in a commit message won't be escaped, so the patch notes can be
written in the commit message directly so the patch files don't need
to be modified by hand.

>>  drivers/cpufreq/Kconfig.arm        |   8 ++
>>  drivers/cpufreq/Makefile           |   1 +
>>  drivers/cpufreq/tegra124-cpufreq.c | 206 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 215 insertions(+)
>>  create mode 100644 drivers/cpufreq/tegra124-cpufreq.c
>>
[...]
>> +static int tegra124_cpufreq_probe(struct platform_device *pdev)
>> +{
> 
>> +       priv->vdd_cpu_reg = regulator_get(get_cpu_device(0), "vdd-cpu");
> 
> get_cpu_device() can fail as well, and so you may want to check its return
> value as well..
> 

Oh, right.

>> +static int __init tegra_cpufreq_init(void)
>> +{
>> +       int ret;
>> +       struct platform_device *pdev;
>> +
>> +       if (!of_match_machine(soc_of_matches))
>> +               return -ENODEV;
> 
> You may want to add a comment here on why you chose to add another layer
> of platform device/driver.. i.e. to catch -EPROBE_DEFER from clk-APIs..
>

Yes, a good idea.

-- 
nvpublic
