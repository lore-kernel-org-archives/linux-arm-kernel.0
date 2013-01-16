From: rogerq@ti.com (Roger Quadros)
Date: Wed, 16 Jan 2013 17:05:49 +0200
Subject: [PATCH v6 04/22] mfd: omap-usb-tll: Clean up clock handling
In-Reply-To: <20130116145530.GU23505@n2100.arm.linux.org.uk>
References: <1358347433-329-1-git-send-email-rogerq@ti.com>
 <1358347433-329-5-git-send-email-rogerq@ti.com>
 <20130116145530.GU23505@n2100.arm.linux.org.uk>
Message-ID: <50F6C1CD.7020001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 04:55 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 16, 2013 at 04:43:35PM +0200, Roger Quadros wrote:
>> +	spin_lock_irqsave(&tll->lock, flags);
>> +
>> +	for (i = 0; i < tll->nch; i++) {
>> +		char clkname[] = "usb_tll_hs_usb_chx_clk";
>> +		struct clk *fck;
>> +
>> +		snprintf(clkname, sizeof(clkname),
>> +					"usb_tll_hs_usb_ch%d_clk", i);
>> +		fck = clk_get(dev, clkname);
> 
> NAK.  Why are you doing this under a spinlock?
> 
> clk_get() takes a mutex.  You must not be in an atomic region (iow, you
> must not be holding a spinlock, and you must not have IRQs disabled)
> when you call clk_get().
> 
Right. Good catch :).

--
cheers,
-roger.
