From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 12 Apr 2013 09:34:13 -0600
Subject: [PATCH 1/3] ARM: tegra: pcie: Add tegra3 support
In-Reply-To: <C79B248886DD134989C8FF6B096A91AB91B36FB2FD@BGMAIL01.nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
 <51630852.1000107@wwwdotorg.org>
 <C79B248886DD134989C8FF6B096A91AB91B36FB2FD@BGMAIL01.nvidia.com>
Message-ID: <51682975.1080302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2013 08:58 AM, Jay Agarwal wrote:
>>>  	err = regulator_disable(pcie->pex_clk_supply);
>>>  	if (err < 0)
>>> -		dev_err(pcie->dev, "failed to disable pex-clk regulator:
>> %d\n",
>>> +		dev_warn(pcie->dev, "failed to disable pex-clk regulator:
>> %d\n",
>>>  			err);
>>>
>>>  	err = regulator_disable(pcie->vdd_supply);
>>>  	if (err < 0)
>>> -		dev_err(pcie->dev, "failed to disable VDD regulator: %d\n",
>>> +		dev_warn(pcie->dev, "failed to disable VDD regulator:
>> %d\n",
>>>  			err);
>>
>> Please explain why that change is correct. If the regulators only exist on
>> Tegra20, please represent that fact in the SoC data. Regulators must always
>> exist, so enable/disable should never fail due to missing regulators. Actual
>> run-time failures seem like something that really is an error.
>>
> [>] These regulators are needed for both tegra20 & tegra30. Since we are not returning error here, so changed to dev_warn.

If the regulators are required, then any failure to operate them should
be an error, hence dev_err() seems correct.

As to why the code doesn't actually return an error? I'm not sure.
Perhaps that should be fixed with a separate patch, although I don't
recall exactly where in the code the above excerpt is; if it's in
remove(), then continuing on without returning an error would be
appropriate.
