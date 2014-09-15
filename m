From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 15 Sep 2014 23:27:55 +0200
Subject: [PATCH v4 5/7] ARM: EXYNOS: Add .write_sec outer cache callback
 for L2C-310
In-Reply-To: <20140915085845.GC12379@n2100.arm.linux.org.uk>
References: <1409062680-15906-1-git-send-email-t.figa@samsung.com>
 <1409062680-15906-6-git-send-email-t.figa@samsung.com>
 <20140915085845.GC12379@n2100.arm.linux.org.uk>
Message-ID: <541759DB.8090408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static void exynos_l2_write_sec(unsigned long val, unsigned reg)
>> +{
>> +	switch (reg) {
>> +	case L2X0_CTRL:
>> +		if (val & L2X0_CTRL_EN)
>> +			exynos_smc(SMC_CMD_L2X0INVALL, 0, 0, 0);
> 
> If we're calling this with the cache already enabled, presumably you're
> doing this to cover the case where we're disabling the cache.

Can we ever call this with L2X0_CTRL_EN set in val, while the cache is
already enabled?

Anyway, calling of this firmware operation is necessary before enabling
the cache and this code is here to cover this requirement. Whether this
function simply invalidates the cache or does something else is unknown
to me, as all the information I got is that this needs to be done.

> 
> 1. Do you really want to *invalidate* the L2 cache, discarding its
>    contents?
> 2. Don't you think that... if you needed something like this here, then
>    it could be a defficiency in the common code?
> 
> If (2) doesn't apply, then should be a comment here why this is needed.
> 

This is a quirk specific to Exynos firmware and I suspect it doesn't
even have anything to do with cache invalidation, but rather some
internal logic inside the firmware.

I agree, though, that a comment might be useful here.

Best regards,
Tomasz
