From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 May 2012 10:18:25 -0600
Subject: [PATCH V2 1/3] ARM: tegra: trimslice: enable PCIe when booting
 from device tree
In-Reply-To: <4FBB67A0.9010606@codethink.co.uk>
References: <1337289674-18581-1-git-send-email-swarren@wwwdotorg.org>
 <4FBB67A0.9010606@codethink.co.uk>
Message-ID: <4FBBBC51.1080800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2012 04:17 AM, Ben Dooks wrote:
> On 17/05/12 22:21, Stephen Warren wrote:
>> From: Stephen Warren<swarren@nvidia.com>
>>
>> There currently aren't bindings for the Tegra PCIe controller. Work on
>> this is in progress, but not yet complete. Manually initialize PCIe when
>> booting from device tree, in order to bring DT support to the same
>> feature level as board files, which will in turn allow board files to be
>> deprecated.
>>
>> PCIe hosts the wired Ethernet controller on TrimSlice.
>>
>> To support this, add infra-structure to board-dt-tegra20.c for board-
>> specific initialization code. Once device tree support for the relevant
>> features is in place, this code will be removed.
>>
>> Signed-off-by: Stephen Warren<swarren@nvidia.com>

>> +++ b/arch/arm/mach-tegra/board-dt-tegra20.c

>> +#ifdef CONFIG_MACH_TRIMSLICE
>> +static void __init trimslice_init(void)
>> +{
>> +    int ret;
>> +
>> +    ret = tegra_pcie_init(true, true);
>> +    if (ret)
>> +        pr_err("tegra_pci_init() failed: %d\n", ret);
>> +}
>> +#endif
> 
> Given the size of some of these functions, is it worth even
> bothering with an #ifdef around them, especially as they are
> marked init.

The TrimSlice init function doesn't pull in anything beyond the raw
driver itself, but the Harmony and Paz00 functions do. I made everything
ifdef'd for consistency.

> How about having some sort of standard pcie binding for the pcie
> part?

Thierry Redding is working on a standardized binding and converting the
driver to a platform driver. As soon as that's complete and checked in,
we can remove some of these custom init functions.
