From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 18 Feb 2016 17:00:08 +0100
Subject: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
In-Reply-To: <56C1B62B.5060708@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
 <7hh9hdzflv.fsf@baylibre.com> <56C1B62B.5060708@nvidia.com>
Message-ID: <CAPDyKFoPrFoMOFxC37zXX4L3VdLKknaw_LUTw7ycr9mfa_=7_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>
>> What about the pm_clk_* API which was built for tracking clocks
>> associated with devices for runtime PM.
>>
>> IOW, you could pm_clk_add(pg->pmc->dev, pg->clks[i]) and then your
>> _enable_clocks() would become pm_clk_suspend() an dyour
>> _disable_clocks() would become pm_clk_resume().
>
> Very interesting, I was not aware of this.
>
>> I might not be following the mapping between PMC and PGs though so not
>> sure pg->pmc->dev is the right struct device, but you get the idea.
>
> Yes, so this will not work here as-is, because the pmc->dev is common to
> all pm-domains (it is the device that creates all the pm-domains). So to
> make this work, I would need to create a device for each pm-domain and
> add the clocks to that.
>
> I see that this works very well for normal drivers, but it does not feel
> so natural for pm-domains where we don't have a device struct today. By
> the way, the rockchip pm-domains implementation is very much in the same
> boat as tegra, where there are multiple clocks per pm-domain and it is
> handled by a simple list. So I am not sure if you think that we should
> be turning all pm-domains registered by pm_genpd_init() into a device
> and then we can make use of these pm_clk_XXXX() APIs?
>
> I have implemented the generic clk APIs that Ulf and I discussed for
> handling multiple clocks, but if we think that this is a better way,
> then I will hold off for now.

I think Kevin has a point that we already have PM clocks to build upon.
Could we perhaps try to extend that API instead to suite this needs as well?

I do realize that it will make this patchset more complicated. As I
stated earlier, this was just an idea I had, so to be clear I won't
hold back an ack for this patchset, if you decide to deal with this in
separate "improvement" step.

Kind regards
Uffe
