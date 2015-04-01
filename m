From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 01 Apr 2015 10:26:50 +0200
Subject: [RFC PATCH v3 1/2] clk: samsung: Add a clock lookup function
In-Reply-To: <20150401012955.25195.29066@quantum>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-2-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22Fn+TRGcFXH7m=LkOCpAtbdKq98jNNNDM0shYWvfHEBiA@mail.gmail.com>
 <55197508.5030501@collabora.co.uk> <20150331014013.25195.26862@quantum>
 <551A61FB.1040401@collabora.co.uk> <20150401012955.25195.29066@quantum>
Message-ID: <551BABCA.5070800@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

On 04/01/2015 03:29 AM, Michael Turquette wrote:
> Quoting Javier Martinez Canillas (2015-03-31 01:59:39)
>> +Tomeu who I forgot to add to the cc list.
>> 
>> Hello Mike,
>> 
>> Thanks a lot for your feedback.
>> 
>> On 03/31/2015 03:40 AM, Michael Turquette wrote:
>> >> 
>> >> I don't performance is a big issue here. I just thought that since the
>> >> lookup table is already filled by the driver and the lookup function
>> >> is one line, we could use that instead to get the performance benefit.
>> >> 
>> >> But I don't mind to drop this patch and use the generic lookup function
>> >> from the CCF API if that is preferred.
>> > 
>> > Hello,
>> > 
>> > I am not a fan of __clk_lookup and I don't like to see it used more and
>> > more outside of drivers/clk/clk.c. You mentioned that performance wasn't
>> > really the problem here.  The real method for a driver to get a clock is
>> > with clk_get(). Any reason to not use that?
>> >
>> 
>> I can certainly use clk_get() but I thought that the clk consumer API was
>> not supposed to be used from within clock drivers. That's why I mentioned
>> __clk_lookup() as a possibility since that is part of the provider API.
> 
> I would like to remove __clk_lookup some day, so the fewer users now the
> better. Additionally, now that we have unique struct clk pointers from
> clk_get it makes a lot of sense for clk_register to stop returning
> pointers to a struct clk. Hopefully we can get around to that soon.
> 
> These two points above are enough reason for the clock provider to use
> clk_get.
>

Got it.
 
>> 
>> Below is a RFC patch that uses clk_get() [0]. That needs another patch
>> which was part of a previous RFC and adds an alias for the mdma0 clock:
>> 
>> https://lkml.org/lkml/2015/3/27/769
>> 
>> If you think that is the correct approach then I can post it as a patch.
>> 
>> It would be great if you can also provide some feedback about the other
>> patch in the first RFC that instead of enabling and disabling the mdma0
>> clock in driver, does it in the exynos5420 platform PM callbacks:
>> 
>> https://lkml.org/lkml/2015/3/27/770
> 
> This seems like a big hack to me.
> 

Ok, good to know. I just did because initially I thought that the clock
consumer API was not allowed to be used from within clock drivers.

>> 
>> I was asked to do it in the exynos5420 clk driver instead but maybe you
>> have a different opinion on that.
>> 
>> Best regards,
>> Javier
>> 
>> [0]:
>> From c118df83da8cac65cc218ae9443622592222f5d0 Mon Sep 17 00:00:00 2001
>> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Date: Mon, 30 Mar 2015 17:11:40 +0200
>> Subject: [RFC] clk: exynos5420: Make sure MDMA0 clock is enabled during
>>  suspend
>> 
>> Commit ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power
>> Management support v12") added pm support for the pl330 dma driver but
>> it makes the clock for the Exynos5420 MDMA0 DMA controller to be gated
>> during suspend and this clock needs to remain enabled in order to make
>> the system resume from a system suspend state.
>> 
>> To make sure that the clock is enabled during suspend, enable it prior
>> to entering a suspend state and disable it once the system has resumed.
> 
> I'd like to understand the issue a bit further. Isn't the correct
> solution that the clk's prepare/unprepare and enable/disable callbacks
> should support the CG_STATUS requirement?
> 

Agreed, I'll take a look to that.

> Regards,
> Mike
> 

Best regards,
Javier
