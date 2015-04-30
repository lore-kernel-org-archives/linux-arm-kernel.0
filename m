From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 01 May 2015 00:21:20 +0200
Subject: [PATCH 0/4] clk: si5351: Some fixes
In-Reply-To: <20150430212059.GA14026@deathray>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150430193317.GC22000@deathray> <55429417.4070103@gmail.com>
 <20150430212059.GA14026@deathray>
Message-ID: <5542AAE0.5020204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.04.2015 23:20, Michael Welling wrote:
> On Thu, Apr 30, 2015 at 10:44:07PM +0200, Sebastian Hesselbarth wrote:
[...]
>> What I noticed about your clk2 that you always measure as 0 Hz is
>> that none of your clocks is prepared/enabled.
>>
>> Currently, the si5351 driver only ensures the output is enabled
>> when si5351_clkout_prepare() is called.
>>
>> As long as you do not have a clk consumer that properly prepare/enables
>> the clock output, it may remain disabled.
>>
>> We should probably have additional DT properties and corresponding
>> pdata to force clkoutN always on.
>
> Does the silabs,disable-state of 3 (SI5351_DISABLE_NEVER) take care
> of this?

That would be the HW version of never disabling the clock output.
I never really tried the property, does it work as expected?

> Otherwise is there a simple registration that will do this?

The SW version of such a property would involve CLK_IGNORE_UNUSED
and enabling all requested clock outputs on probe().

If above HW property already works, I think it should be enough.

[...]
>>> It should be noted that if I program the device's register map in the
>>> bootloader the device keeps the correct frequency outputs.
>>
>> "keeps"? You mean "generates", don't you?
>>
>
> Yes the clocks are generated and do not get effected by the driver.

IIRC, clk API does check if requested rate and current rate match
already. If they do, it does not request the same rate again.

Sebastian
