From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 May 2012 10:48:56 -0600
Subject: [PATCHv3 1/4] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <20120504.091736.839941449020176796.hdoyu@nvidia.com>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com><4FA2C34F.5060406@wwwdotorg.org>
 <20120504.091736.839941449020176796.hdoyu@nvidia.com>
Message-ID: <4FA40878.7070709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2012 12:17 AM, Hiroshi Doyu wrote:
> Stephen Warren wrote at Thu, 3 May 2012 19:41:35 +0200:
>> On 05/03/2012 10:05 AM, Hiroshi DOYU wrote:
>>> Tegra AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
>>> High-performance Bus (AHB) architecture.
...
>>> +static int __init tegra_ahb_module_init(void)
>>> +{
>>> +	return platform_driver_register(&tegra_ahb_driver);
>>> +}
>>> +postcore_initcall(tegra_ahb_module_init);
>>
>> Can this be a module_init() instead of postcore_initcall()?
> 
> Since this driver configures prefetch size from AHB client devices,
> it's better to make this driver available before other AHB client
> drivers get ready. So "postcore_initcall()" seems to make sense if
> there's no other better initcall.

I believe this only affects when the driver is registered and has no
influence over when the device itself is probed.

When booting with board files rather than DT, it was possible to
register drivers and platform devices early using various initcalls to
control the order. However, with DT, I believe all the devices are
instantiated from DT at the same time (well, one by one in whatever
order as the DT is parsed), so the time when the driver is registered
isn't relevant.

So, if the other AHB devices really need this AHB driver to initialize
first, you'd better move all the AHB devices inside the AHB node in DT,
so that the AHB driver can influence when the children get probed.
Still, I'd suggest leaving that to a later patch, since everything
clearly works fine right now without this driver even existing.

>>> +
>>> +static void __exit tegra_ahb_module_exit(void)
>>> +{
>>> +	platform_driver_unregister(&tegra_ahb_driver);
>>> +}
>>> +module_exit(tegra_ahb_module_exit);
>>
>> If so, all of the previous two quoted chunks can be replaced with just:
>>
>> module_platform_driver(tegra_ahb_module_init);
