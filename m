From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 29 Aug 2011 15:04:29 +0530
Subject: [PATCHv6 2/3] OMAP: I2C: Remove the reset in the init path
In-Reply-To: <87pqjrydih.fsf@ti.com>
References: <1312524035-5549-1-git-send-email-shubhrajyoti@ti.com>	<1312524035-5549-2-git-send-email-shubhrajyoti@ti.com>
	<87pqjrydih.fsf@ti.com>
Message-ID: <4E5B5D25.3000903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 August 2011 04:41 AM, Kevin Hilman wrote:
> Shubhrajyoti D<shubhrajyoti@ti.com>  writes:
>
>> -  The reset in the driver at init is not needed anymore as the
>>     hwmod framework takes care of reseting it.
>> -  Reset is removed from omap_i2c_init, which was called
>>     not only during probe, but also after time out and error handling.
>>     device_reset were added in those places to effect the reset.
>> -  Earlier the hwmod SYSC settings were over-written in the driver.
>>     Removing the same and letting the hwmod take care of the settings.
>> -  Clean up the SYSS_RESETDONE_MASK macro as it is no longer needed.
>> -  Clean up the SYSCONFIG SYSC bit defination macros.
>> -  Fix the typos in wakeup.
>>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> I asked this in an earlier version, but here it is again.
>
> Are you sure a full IP reset is needed on the timeout and error
> conditions and not just the module-level one done by:
>
> 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>
>          [ and later... ]
>
> 	/* Take the I2C module out of reset: */
> 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>
> I kind of suspect that the IP rese was done because the omap_i2c_init()
> function was callled under the timeout/error conditions, but that a full
> IP SW reset is a bit heavy handed.
My idea is that case of lockup  in error path it could be helpful.

We internally had a discussion on this
https://gforge01.dal.design.ti.com/gf/project/opbu_mail_arcv/mailman/?action=ListThreads&mailman_id=218&_forum_action=ForumMessageBrowse&thread_id=12483

> Kevin
