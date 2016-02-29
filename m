From: fcooper@ti.com (Franklin S Cooper Jr.)
Date: Mon, 29 Feb 2016 17:11:46 -0600
Subject: [PATCH v3 1/5] pwms: pwm-ti*: Remove support for local clock
 gating
In-Reply-To: <20160229225536.GR13417@atomide.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-2-git-send-email-fcooper@ti.com>
 <20160229220444.GQ13417@atomide.com> <56D4C69D.1090100@ti.com>
 <20160229225536.GR13417@atomide.com>
Message-ID: <56D4D032.7040801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/29/2016 04:55 PM, Tony Lindgren wrote:
> * Franklin S Cooper Jr. <fcooper@ti.com> [160229 14:31]:
>> On 02/29/2016 04:04 PM, Tony Lindgren wrote:
>>> Hmm but why are you also removing the pm_runtime calls? Those
>>> actually do take care of gating the clocks via the interconnect
>>> level code that is hwmod in this case.
>> I removed all PM runtime calls that revolved around
>> pwmss_submodule_state_change. Originally the driver would do
>> a pm_runtime_get_sync then call pwmss_submodule_state_change
>> and then immediately call pm_runtime_put_sync. Without
>> pwmss_submodule_state_change those calls would be
>> meaningless.  I also removed pm_runtime calls in error paths
>> that no longer existed.
> Typically the interconnect level code can gate the clkctrl bit
> for the module with PM runtime even with no other driver specific
> registers. If you remove the pm_runtime calls, that does not
> happen.

So the clocks should be unlocked when ever the IP registers are
being read/written or if the peripheral is being used for
example
the pwm signal is being generated. All these cases are already
being handled.

Using ecap driver as an example.

Pm_runtime_get_sync is called within ecap_pwm_enable when
the pwm signal is to be generated. Pm_runtime_put_sync is called
when the pwm signal is to be stopped.

When either the pwm signal polarity is set or pwm
configuration is made
then a pm_runtime_get_sync and pm_runtime_put_sync are
called within
the same function surrounding calls to the IP's registers.

Probe is calling pm_runtime_enable while remove is calling
pm_runtime_disable.

So the correct pm_runtime calls are being made from what I
can see.
I'm not sure I understand the concern since removing those
calls aren't
creating any kind of imbalance.

If I'm not addressing your concern please give me an example
of where
you see a possible issue.

> Also, how do you know this change does not affect the other
> SoC variants using the same driver?

I've tested these changes on AM335x GP and AM437x GP evms.
AM335x
and AM437x were the only other users of this driver. Sorry 
I should of
documented this in my cover-letter.
> Regards,
>
> Tony
