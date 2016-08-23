From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 23 Aug 2016 14:49:00 +0100
Subject: [PATCH v3 11/12] clk: tegra: Add BPMP clock driver
In-Reply-To: <20160822132833.GD17367@ulmo.ba.sec>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-12-thierry.reding@gmail.com>
 <0d7080bc-9e82-75dd-7169-0a5b7429801e@nvidia.com>
 <20160822132833.GD17367@ulmo.ba.sec>
Message-ID: <d4caf8c4-f733-5a63-fa03-f6160963fadb@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 22/08/16 14:28, Thierry Reding wrote:
> On Mon, Aug 22, 2016 at 11:11:57AM +0100, Jon Hunter wrote:
>>
>> On 19/08/16 18:32, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> This driver uses the services provided by the BPMP firmware driver to
>>> implement a clock driver based on the MRQ_CLK request. This part of the
>>> BPMP ABI provides a means to enumerate and control clocks and should
>>> allow the driver to work on any chip that supports this ABI.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>  drivers/clk/tegra/Makefile   |   1 +
>>>  drivers/clk/tegra/clk-bpmp.c | 565 +++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 566 insertions(+)
>>>  create mode 100644 drivers/clk/tegra/clk-bpmp.c

[snip]

>>> +int tegra_bpmp_init_clocks(struct tegra_bpmp *bpmp)
>>> +{
>>> +	struct tegra_bpmp_clk_info *clocks;
>>> +	unsigned int count;
>>> +	int err;
>>> +
>>> +	dev_dbg(bpmp->dev, "> %s(bpmp=%p)\n", __func__, bpmp);
>>> +
>>> +	err = tegra_bpmp_probe_clocks(bpmp, &clocks);
>>> +	if (err < 0)
>>> +		return err;
>>> +
>>> +	count = err;
>>> +
>>> +	dev_dbg(bpmp->dev, "%u clocks probed\n", count);
>>> +
>>> +	err = tegra_bpmp_register_clocks(bpmp, clocks, count);
>>> +	if (err < 0) {
>>> +		kfree(clocks);
>>> +		return err;
>>> +	}
>>> +
>>> +	kfree(clocks);
>>> +
>>> +	of_clk_add_hw_provider(bpmp->dev->of_node, tegra_bpmp_clk_of_xlate,
>>> +			       bpmp);
>>
>> We should check the return code.
> 
> Yes, I suppose we should also make sure to remove all clocks if this
> ever fails. I'll see how difficult it is to implement that.

In the unlikely event it fails, not much is going to work and so may be
warning or printing an error is enough. It seems that we don't clean-up
in the bpmp firmware driver (that calls this) and so not cleaning up
here will not make much difference.

Cheers
Jon

-- 
nvpublic
