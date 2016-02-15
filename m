From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 15 Feb 2016 11:27:39 +0000
Subject: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
In-Reply-To: <7hh9hdzflv.fsf@baylibre.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
 <7hh9hdzflv.fsf@baylibre.com>
Message-ID: <56C1B62B.5060708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/02/16 23:14, Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
>> On 28 January 2016 at 17:33, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> Adds generic PM support to the PMC driver where the PM domains are
>>> populated from device-tree and the PM domain consumer devices are
>>> bound to their relevant PM domains via device-tree as well.
>>>
>>> Update the tegra_powergate_sequence_power_up() API so that internally
>>> it calls the same tegra_powergate_xxx functions that are used by the
>>> tegra generic power domain code for consistency.
>>>
>>> This is based upon work by Thierry Reding <treding@nvidia.com>
>>> and Vince Hsu <vinceh@nvidia.com>.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> [...]
> 
>>> +static void tegra_powergate_disable_clocks(struct tegra_powergate *pg)
>>> +{
>>> +       unsigned int i;
>>> +
>>> +       for (i = 0; i < pg->num_clks; i++)
>>> +               clk_disable_unprepare(pg->clks[i]);
>>> +}
>>> +
>>> +static int tegra_powergate_enable_clocks(struct tegra_powergate *pg)
>>> +{
>>> +       unsigned int i;
>>> +       int err;
>>> +
>>> +       for (i = 0; i < pg->num_clks; i++) {
>>> +               err = clk_prepare_enable(pg->clks[i]);
>>> +               if (err)
>>> +                       goto out;
>>> +       }
>>> +
>>> +       return 0;
>>> +
>>> +out:
>>> +       while (i--)
>>> +               clk_disable_unprepare(pg->clks[i]);
>>> +
>>> +       return err;
>>> +}
>>
>> I have seen similar code around in other PM domains, dealing with
>> enabling/disabling a *list* of clocks.
>> Perhaps we should invent a new clock API that helps with this to
>> prevents code duplication!?
> 
> What about the pm_clk_* API which was built for tracking clocks
> associated with devices for runtime PM.
> 
> IOW, you could pm_clk_add(pg->pmc->dev, pg->clks[i]) and then your
> _enable_clocks() would become pm_clk_suspend() an dyour
> _disable_clocks() would become pm_clk_resume().

Very interesting, I was not aware of this.

> I might not be following the mapping between PMC and PGs though so not
> sure pg->pmc->dev is the right struct device, but you get the idea.

Yes, so this will not work here as-is, because the pmc->dev is common to
all pm-domains (it is the device that creates all the pm-domains). So to
make this work, I would need to create a device for each pm-domain and
add the clocks to that.

I see that this works very well for normal drivers, but it does not feel
so natural for pm-domains where we don't have a device struct today. By
the way, the rockchip pm-domains implementation is very much in the same
boat as tegra, where there are multiple clocks per pm-domain and it is
handled by a simple list. So I am not sure if you think that we should
be turning all pm-domains registered by pm_genpd_init() into a device
and then we can make use of these pm_clk_XXXX() APIs?

I have implemented the generic clk APIs that Ulf and I discussed for
handling multiple clocks, but if we think that this is a better way,
then I will hold off for now.

Cheers
Jon
