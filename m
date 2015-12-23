From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 23 Dec 2015 09:00:16 +0000
Subject: [PATCH] ARM: tegra: Fix suspend hang on Tegra124 Chromebooks
In-Reply-To: <20151222234203.GA28181@localhost>
References: <1449570409-30244-1-git-send-email-jonathanh@nvidia.com>
 <20151222234203.GA28181@localhost>
Message-ID: <567A62A0.1000809@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 22/12/15 23:42, Olof Johansson wrote:
> On Tue, Dec 08, 2015 at 10:26:49AM +0000, Jon Hunter wrote:
>> Enabling CPUFreq support for Tegra124 Chromebooks is causing the Tegra124
>> to hang when resuming from suspend.
>>
>> When CPUFreq is enabled, the CPU clock is changed from the PLLX clock to
>> the DFLL clock during kernel boot. When resuming from suspend the CPU
>> clock is temporarily changed back to the PLLX clock before switching back
>> to the DFLL. If the DFLL is operating at a much lower frequency than the
>> PLLX when we enter suspend, and so the CPU voltage rail is at a voltage
>> too low for the CPUs to operate at the PLLX frequency, then the device
>> will hang.
>>
>> Please note that the PLLX is used in the resume sequence to switch the CPU
>> clock from the very slow 32K clock to a faster clock during early resume
>> to speed up the resume sequence before the DFLL is resumed.
>>
>> Ideally, we should fix this by setting the suspend frequency so that it
>> matches the PLLX frequency, however, that would be a bigger change. For
>> now simply disable CPUFreq support for Tegra124 Chromebooks to avoid the
>> hang when resuming from suspend.
>>
>> Fixes: 9a0baee960a7 ("ARM: tegra: Enable CPUFreq support for Tegra124
>> 		      Chromebooks")
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>
>> Please note that this fix is required for v4.4
> 
> Since I saw this mentioned on IRC, I applied it directly to the arm-soc
> fixes branch.

Thanks!

Cheers Jon
