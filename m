From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Jan 2012 11:24:32 +0000
Subject: [PATCH 08/15] ARM: shmobile: convert to twd_local_timer_register()
 interface
In-Reply-To: <20120112091905.GJ1068@n2100.arm.linux.org.uk>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-9-git-send-email-marc.zyngier@arm.com>
 <20120112091905.GJ1068@n2100.arm.linux.org.uk>
Message-ID: <4F0EC2F0.1000409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/12 09:19, Russell King - ARM Linux wrote:
> On Wed, Jan 11, 2012 at 01:08:47PM +0000, Marc Zyngier wrote:
>>  static void __init shmobile_late_time_init(void)
>>  {
>>  	/*
>> @@ -34,6 +37,8 @@ static void __init shmobile_late_time_init(void)
>>  	 */
>>  	early_platform_driver_register_all("earlytimer");
>>  	early_platform_driver_probe("earlytimer", 2, 0);
>> +	if (local_timer_hook)
>> +		local_timer_hook();
> 
> This is why late_timer_init() should be avoided at all cost - you can
> only have one of them and once you've used it once, you need to invent
> new hooks to hook other stuff into there.
> 
> In any case, I don't think this is necessary for TWD as ioremap should
> be available for regions which have already been statically mapped now
> that Nicolas' patches are in mainline.

Indeed, it should work now, and I'll remove the use of late_time_init.

shmobile has another problem though: it doesn't have the smp_twd clock,
which means we have to rely on calibration, and this will only work if
the global timer is already up and running (hence the ugly hook).

	M.
-- 
Jazz is not dead. It just smells funny...
