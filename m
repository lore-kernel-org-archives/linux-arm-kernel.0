From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 12 Feb 2016 15:14:04 -0800
Subject: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
In-Reply-To: <CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
 (Ulf Hansson's message of "Thu, 4 Feb 2016 16:44:59 +0100")
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
Message-ID: <7hh9hdzflv.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 28 January 2016 at 17:33, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Adds generic PM support to the PMC driver where the PM domains are
>> populated from device-tree and the PM domain consumer devices are
>> bound to their relevant PM domains via device-tree as well.
>>
>> Update the tegra_powergate_sequence_power_up() API so that internally
>> it calls the same tegra_powergate_xxx functions that are used by the
>> tegra generic power domain code for consistency.
>>
>> This is based upon work by Thierry Reding <treding@nvidia.com>
>> and Vince Hsu <vinceh@nvidia.com>.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

[...]

>> +static void tegra_powergate_disable_clocks(struct tegra_powergate *pg)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < pg->num_clks; i++)
>> +               clk_disable_unprepare(pg->clks[i]);
>> +}
>> +
>> +static int tegra_powergate_enable_clocks(struct tegra_powergate *pg)
>> +{
>> +       unsigned int i;
>> +       int err;
>> +
>> +       for (i = 0; i < pg->num_clks; i++) {
>> +               err = clk_prepare_enable(pg->clks[i]);
>> +               if (err)
>> +                       goto out;
>> +       }
>> +
>> +       return 0;
>> +
>> +out:
>> +       while (i--)
>> +               clk_disable_unprepare(pg->clks[i]);
>> +
>> +       return err;
>> +}
>
> I have seen similar code around in other PM domains, dealing with
> enabling/disabling a *list* of clocks.
> Perhaps we should invent a new clock API that helps with this to
> prevents code duplication!?

What about the pm_clk_* API which was built for tracking clocks
associated with devices for runtime PM.

IOW, you could pm_clk_add(pg->pmc->dev, pg->clks[i]) and then your
_enable_clocks() would become pm_clk_suspend() an dyour
_disable_clocks() would become pm_clk_resume().

I might not be following the mapping between PMC and PGs though so not
sure pg->pmc->dev is the right struct device, but you get the idea.

Kevin
