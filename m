From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 14:32:56 -0600
Subject: [PATCHv3 2/4] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <20120426202610.GA30690@arwen.pp.htv.fi>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
 <1335352072-4001-2-git-send-email-hdoyu@nvidia.com>
 <4F99A821.2040406@wwwdotorg.org> <20120426202610.GA30690@arwen.pp.htv.fi>
Message-ID: <4F99B0F8.4040308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2012 02:26 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Apr 26, 2012 at 01:55:13PM -0600, Stephen Warren wrote:
>> On 04/25/2012 05:07 AM, Hiroshi DOYU wrote:
>>> Add extern func, "tegra_ahb_enable_smmu()" to inform AHB that SMMU is
>>> ready.
>>
>>> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
>>> +static int __tegra_ahb_enable_smmu(struct device *dev, void *data)
>> ...
>>> +int tegra_ahb_enable_smmu(void)
>>> +{
>>> +	return driver_for_each_device(&tegra_ahb_driver.driver, NULL, NULL,
>>> +				      __tegra_ahb_enable_smmu);
>>> +}
>>> +EXPORT_SYMBOL(tegra_ahb_enable_smmu);
>>> +#endif
>>
>> That looks like a neat solution to avoid having a global device object.
> 
> except that it won't work always. If you happen to have two AHB bridges,
> each using a separate smmu but only one smmu is ready, this will set
> SMMU_INIT_DONE on both bridges.

There is only 1.

>> However, if that driver_for_each_device finds no devices, the function
>> still succeeds. That doesn't seem right, and doesn't allow e.g. the SMMU
>> to defer its probe until the AHB driver has completed.
>>
>> Perhaps add a local int variable to tegra_ahb_enable_smmu(), pass the
>> address to __tegra_ahb_enable_smmu, and have it increment the int. Then,
>> after calling driver_for_each_device,:
>>
>> if (!ahb_device_count)
>>     return -EPROBE_DEFER
>> if (WARN_ON(ahb_device_count != 1))
>>     return -EINVAL;
>> return 0;
> 
> that would look, well, weird. Why don't you just different initcall
> leves for this ? Maybe smmu goes into postcore_initcall() and tegra_ahb
> goes into postcore_initcall_sync() ?? then you know that SMMU will be
> ready by the time you call tegra_ahb probe. Well, unless smmu's probe
> fail, but then again, IIUC it won't work anyway...

Uggh. I'd rather all these devices just got instantiated from device
tree and relied on deferred probe to manage any ordering, rather than
playing complex games with multiple initcall levels (and in the end
probably having to invent more and more initcall levels to correctly
represent all the dependencies).
