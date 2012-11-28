From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Wed, 28 Nov 2012 10:18:35 -0600
Subject: [PATCH 6/6 v6] cpufreq, highbank: add support for highbank cpufreq
In-Reply-To: <20121128160115.21126.3841@nucleus>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com>
 <20121128023240.GA28170@S2100-06.ap.freescale.net>
 <50B60E9C.9000405@calxeda.com>
 <20121128145759.GB28170@S2100-06.ap.freescale.net>
 <20121128151741.GC28170@S2100-06.ap.freescale.net>
 <20121128160115.21126.3841@nucleus>
Message-ID: <50B6395B.806@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2012 10:01 AM, Mike Turquette wrote:
> Quoting Shawn Guo (2012-11-28 07:17:44)
>> On Wed, Nov 28, 2012 at 10:58:02PM +0800, Shawn Guo wrote:
>>> On Wed, Nov 28, 2012 at 07:16:12AM -0600, Mark Langsdorf wrote:
>>>> I'd
>>>> have to move most of the logic of hb_set_target() into
>>>> clk_highbank.c:clk_pll_set_rate() and then add extra logic for when
>>>> cpufreq is not enabled/loaded.
>>>
>>> You only need to move hb_voltage_change() into cpu clock's .set_rate()
>>> hook with no need of checking if cpufreq is enabled or not.
>>>
>> Need to also check whether frequency or voltage should be changed first
>> in .set_rate() though.
>>
>> Shawn
>>
> 
> The notifiers in the clk framework might be a better place for this than
> just simply hacking the logic into the .set_rate callback.

Unless the clk notifiers are different than the cpufreq notifiers, they
don't handle returning error conditions very well. And given that the
voltage change operation can fail (though it almost always succeeds on a
retry) I need to be able to handle and detect that error condition.

> I haven't looked at the definition of hb_voltage_change but does the
> call graph make any clk api calls?  Are you talking over i2c to a
> regulator?  If so then you'll probably hit the same reentrancy problem I
> hit when trying to make a general solution.

I'm talking over a pl320 Interprocessor Communication Mailbox to a
separate core running it's own RTOS. The RTOS might speak i2c to a
regulator but it's a black box to me.

hb_voltage_change() doesn't make any clk api calls. It changes the
voltages, and then hb_set_target() makes clk api calls to change the
frequency.

--Mark Langsdorf
Calxeda, Inc.
