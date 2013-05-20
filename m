From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 20 May 2013 21:18:42 +0200
Subject: [RFC PATCH 2/5] ARM: mv78x00: Convert RD-78X00-mASA board to
 device tree
In-Reply-To: <5199F428.7000305@free-electrons.com>
References: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
 <1368999578-19938-3-git-send-email-gregory.clement@free-electrons.com>
 <20130520095231.GE26249@lunn.ch> <5199F428.7000305@free-electrons.com>
Message-ID: <519A7712.3060903@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2013 12:00 PM, Gregory CLEMENT wrote:
> On 05/20/2013 11:52 AM, Andrew Lunn wrote:
>> On Sun, May 19, 2013 at 11:39:35PM +0200, Gregory CLEMENT wrote:
>>> This commit converts the 'RD-78X00-mASA' board to the Device
>>> Tree. Most of the devices are converted to the Device Tree, the only
>>> devices which have not their Device Tree bindings are the Gigabit
>>> Ethernet ones and remain instantiated in the old way.
>>>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> ---
>>>  arch/arm/mach-mv78xx0/board-dt.c           |  3 +++
>>>  arch/arm/mach-mv78xx0/common.h             |  7 +++++++
>>>  arch/arm/mach-mv78xx0/rd78x00-masa-setup.c | 10 ++++++++++
>>>  3 files changed, 20 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-mv78xx0/board-dt.c b/arch/arm/mach-mv78xx0/board-dt.c
>>> index 4995fee..5111cbd 100644
>>> --- a/arch/arm/mach-mv78xx0/board-dt.c
>>> +++ b/arch/arm/mach-mv78xx0/board-dt.c
>>> @@ -26,6 +26,9 @@ static void __init mv78x00_dt_init(void)
>>>  	 */
>>>  	mv78xx0_init();
>>>  
>>> +	if (of_machine_is_compatible("marvell,rd-78x00-masa"))
>>> +		rd78x00_masa_init_dt();
>>> +
>>>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>>  }
>>>  
>>> diff --git a/arch/arm/mach-mv78xx0/common.h b/arch/arm/mach-mv78xx0/common.h
>>> index 5e9485b..6e9140d 100644
>>> --- a/arch/arm/mach-mv78xx0/common.h
>>> +++ b/arch/arm/mach-mv78xx0/common.h
>>> @@ -17,6 +17,13 @@ struct mv_sata_platform_data;
>>>  /*
>>>   * Basic MV78xx0 init functions used early by machine-setup.
>>>   */
>>> +#ifdef CONFIG_MACH_RD78X00_MASA
>>> +void rd78x00_masa_init_dt(void);
>>> +#else
>>> +static inline void rd78x00_masa_init_dt(void) {};
>>> +#endif
>>> +
>>> +
>>>  int mv78xx0_core_index(void);
>>>  void mv78xx0_map_io(void);
>>>  void mv78xx0_init(void);
>>> diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
>>> index d2d06f3..8d88657 100644
>>> --- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
>>> +++ b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
>>> @@ -64,6 +64,16 @@ static void __init rd78x00_masa_init(void)
>>>  	}
>>>  }
>>>  
>>> +void __init rd78x00_masa_init_dt(void)
>>> +{
>>> +	/* Internal devices not ported to DT yet */
>>> +	mv78xx0_ge00_init(&rd78x00_masa_ge00_data);
>>> +	mv78xx0_ge10_init(&rd78x00_masa_ge10_data);
>>> +		mv78xx0_ge01_init(&rd78x00_masa_ge01_data);
>>> +		mv78xx0_ge11_init(&rd78x00_masa_ge11_data);
>>> +
>>> +}
>>
>> Hi Gregory
>>
>> First off, the indentation looks wrong. Might be a space/tab issue.
> 
> Thanks I will fix it
> 
>>
>> I would also be tempted to place this code into board-dt.c and not
>> touch or even compile rd78x00-masa-setup.c when using DT. If i
>> remember correctly, Jason had a patch for Kirkwood which centralized
>> all the ethernet setup code. You can maybe copy/paste that.
> 
> OK I will have a look on it.

Initially I wanted to avoid duplicating the platform data, which are
the PHY address for the ethernet. But for coherency I will do the same
that it have been done in mach-kirkwood.

>>
>>> +
>>>  static int __init rd78x00_pci_init(void)
>>>  {
>>>  	/*
>>> -- 
>>> 1.8.1.2
>>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
