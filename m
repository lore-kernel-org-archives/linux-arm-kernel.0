From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Sep 2012 13:20:42 -0700
Subject: [PATCH 0/3] Introduce devm_clk_register()
In-Reply-To: <20120922100604.GI15609@n2100.arm.linux.org.uk>
References: <1348034730-16473-1-git-send-email-sboyd@codeaurora.org>
 <20120922100604.GI15609@n2100.arm.linux.org.uk>
Message-ID: <5060C09A.6080706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/12 03:06, Russell King - ARM Linux wrote:
> On Tue, Sep 18, 2012 at 11:05:27PM -0700, Stephen Boyd wrote:
>> The first patch in this series fixes error checking in the wm831x clock
>> driver and is here to prevent context conflicts in the third patch.
>> I split it out in case it needed to merge sooner rather than later.
>>
>> The goal of this series is to add devm_clk_register() so I can use it in
>> some MSM clock code I'm sending out in the near future. The second 
>> patch adds the API and the third patch moves over an existing user of
>> clk_unregister() to the devm API.
> Can we guarantee that the clocks are unused when the module is removed?
> If we can't make that guarantee, then devm_* should not be used here,
> and instead there should be refcounting done in the clocks (that's what
> the __clk_get() and __clk_put() hooks are there for.)

We could guarantee that when clk_unregister() is actually implemented.
__clk_get() would need to forward a call to the module providing the
clock via try_module_get(). Similarly we would call module_put() in
__clk_put(). That would prevent unbinding the driver from the device via
module removal.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
