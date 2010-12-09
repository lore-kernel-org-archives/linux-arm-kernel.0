From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 09 Dec 2010 14:19:59 -0800
Subject: [PATCH v8 01/11] OMAP: GPIO: prepare for platform driver
In-Reply-To: <4D014B3C.7040806@ti.com> (Benoit Cousson's message of "Thu, 9
	Dec 2010 22:33:48 +0100")
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<1290689318-10191-2-git-send-email-charu@ti.com>
	<8762v292ld.fsf@deeprootsystems.com> <4D014B3C.7040806@ti.com>
Message-ID: <871v5q7fn4.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Salut Kevin,
>
> On 12/9/2010 8:18 PM, Kevin Hilman wrote:
>> Hi Charu,
>>
>> "Varadarajan, Charulatha"<charu@ti.com>  writes:
>>
>>> Prepare for implementing GPIO as a platform driver.
>>>
>>> Modifies omap_gpio_init() to make use of omap_gpio_chip_init()
>>> and omap_gpio_mod_init(). omap_gpio_mod_init() does the module init
>>> by clearing the status register and initializing the GPIO control register.
>>> omap_gpio_chip_init() initializes the chip request, free, get, set and
>>> other function pointers and sets the gpio irq handler.
>>>
>>> This is only to reorganize the code so that the "omap gpio platform driver
>>> implementation patch" looks cleaner and better to review.
>>>
>>> Signed-off-by: Charulatha V<charu@ti.com>
>>
>> I just noticed while testing on 36xx/Zoom3 that GPIO wakeups are no
>> longer working after this series.
>>
>> The problem seems to be that for OMAP2+, this series removed manual
>> SYSCONFIG register setting in favor of using omap_hwmod (which is good),
>> however some of the SYSCONFIG values, specifically, in the current code,
>> the ENAWAKEUP bit was set in each bank, but this is no longer the
>> default with omap_hwmod.
>
> That part is strange, because Rajendra did a patch to enable the
> wakeup bit during _omap_hwmod_enable as soon as the idlemode is set to
> smartidle.
>
> /* If slave port is in SMARTIDLE, also enable wakeup */
> if ((sf & SYSC_HAS_SIDLEMODE) && (s_idlemode == HWMOD_IDLEMODE_SMART))
> 	_enable_wakeup(oh);
>
> The _disable_wakeup is never called, so in theory once it is set, it
> should remain enabled.
>
> Does that mean that this the GPIO is not in smartidle anymore in your case?

Looks like a bug in the patch that added automatic wakeup enables.
Basically, wakeups are enabled, but are promptly disabled if
SYSC_HAS_AUTOIDLE.  Here's the code:

	/*
	 * XXX The clock framework should handle this, by
	 * calling into this code.  But this must wait until the
	 * clock structures are tagged with omap_hwmod entries
	 */
	if ((oh->flags & HWMOD_SET_DEFAULT_CLOCKACT) &&
	    (sf & SYSC_HAS_CLOCKACTIVITY))
		_set_clockactivity(oh, oh->class->sysc->clockact, &v);

	_write_sysconfig(v, oh);

OK, so here, 'v' has wakeups disabled.

	/* If slave is in SMARTIDLE, also enable wakeup */
	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
		_enable_wakeup(oh);

Here we enabled them directly in SYSC (but 'v' is not updated)

	/*
	 * Set the autoidle bit only after setting the smartidle bit
	 * Setting this will not have any impact on the other modules.
	 */
	if (sf & SYSC_HAS_AUTOIDLE) {
		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
			0 : 1;
		_set_module_autoidle(oh, idlemode, &v);
		_write_sysconfig(v, oh);
	}

And here, SYSCONFIG is updated again using 'v', which does not have
wakeups enabled.

A quick patch (below) shows that if I update 'v' after enabling wakeups, 
the problem is fixed.

I'll cook up a cleaner patch for this, but I think the solution is
probably to change _enable_wakeup() to take the 'v' argument and modify
it instead of directly writing SYSCONFIG.  That will make it more like
all the other helper functions.

Kevin



diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 12856eb..adcb1fc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -791,8 +791,10 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	_write_sysconfig(v, oh);
 
 	/* If slave is in SMARTIDLE, also enable wakeup */
-	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
+	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE)) {
 		_enable_wakeup(oh);
+		v = oh->_sysc_cache;
+	}
 
 	/*
 	 * Set the autoidle bit only after setting the smartidle bit
