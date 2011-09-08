From: khilman@ti.com (Kevin Hilman)
Date: Thu, 08 Sep 2011 10:30:49 -0700
Subject: [RFC PATCH v2 5/6] TI81XX: Add minimal hwmod data
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4AAB78D@dbde02.ent.ti.com>
	(Hemant Pedanekar's message of "Thu, 8 Sep 2011 06:49:39 +0530")
References: <1314119627-23088-1-git-send-email-hemantp@ti.com>
	<87ty8zoi15.fsf@ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03B4AAB78D@dbde02.ent.ti.com>
Message-ID: <87ehzrj60m.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Pedanekar, Hemant" <hemantp@ti.com> writes:

> Hilman, Kevin wrote on Tuesday, August 30, 2011 6:03 AM:
>
>> Hemant Pedanekar <hemantp@ti.com> writes:
>> 
>>> This patch adds minimum required hwmod data (e.g., UARTs) for bootup of
>>> TI81XX devices (currently common data for TI816X and TI814X is added).
>>> 
>>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
>> 
>> I haven't looked at the details yet, but just tried to boot this using
>> current mainline and it fails.
>> 
>> My first guess is that it appears to be related to a missing clkdm for the
>> MPU hwmod. 
>> 
>> Kevin
>
> Thanks for the feedback.
>
> I think that the issue is bacause clk_get() on fck_source is failing
> as TI816X clock data had different clock source names compared to
> OMAP3 (e.g., osc_sys_ck instead of sys_ck). I will update this in next
> version.

Actually, I realized also that ti816x doesn't boot on current l-o master
branch, even without this series.

> Even after this, the kernel would get stuck at "Calibrating delay loop..."
> because a few timer register offsets on TI81XX are different than
> OMAP3. 

At least with my tests, it's getting past that and failing here:

[...]
[    0.000000] NR_IRQS:410                                                      
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrup
ts                                                                              
[    0.000000] Total of 128 interrupts on 1 active controller                   
[    0.000000] omap_hwmod: timer1: cannot setup_one: MPU initiator hwmod mpu not
 yet registered                                                                 

The reason seems to be that no hwmods are getting registered at all.

> I see there are some patches floating on ML which add reg_map array
> (similar to i2c driver) but seems they have not (yet) been
> accepted. Any chance that this will get added to kernel?

I'm not sure.  Which series are you referring to?

Kevin
