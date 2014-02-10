From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Feb 2014 13:33:50 +0100
Subject: [PATCH 07/17] spi: pl022: Don't ignore power domain and amba bus
 at system suspend
In-Reply-To: <20140204191609.GU22609@sirena.org.uk>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-8-git-send-email-ulf.hansson@linaro.org>
 <20140204191609.GU22609@sirena.org.uk>
Message-ID: <CAPDyKFqNdw-6R12cUOre8UOTOnB-PpxHD5rPAMCwuS3i--Sesg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2014 20:16, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 04, 2014 at 04:58:48PM +0100, Ulf Hansson wrote:
>
>> @@ -2328,8 +2300,23 @@ static int pl022_suspend(struct device *dev)
>>               return ret;
>>       }
>>
>> -     pm_runtime_get_sync(dev);
>> -     pl022_suspend_resources(pl022, false);
>> +     pm_runtime_disable(dev);
>> +
>> +     if (!pm_runtime_status_suspended(dev)) {
>> +             if (dev->pm_domain && dev->pm_domain->ops.runtime_suspend)
>> +                     ret = dev->pm_domain->ops.runtime_suspend(dev);
>> +             else
>> +                     ret = dev->bus->pm->runtime_suspend(dev);
>> +
>> +             if (ret) {
>> +                     pm_runtime_enable(dev);
>> +                     return ret;
>> +             }
>> +
>> +             pm_runtime_set_suspended(dev);
>> +     }
>
> This seems like a fairly hideous thing to be having to open code in an
> individual driver, it all looks generic and like something that most if
> not all devices ought to be doing and it looks very vulnerable to being
> broken by changes in the core.  At the very least I would expect this to
> be done in a helper function, though it would be even nicer if the
> driver core were figuring this stuff out for us based on the device
> level callback so that drivers didn't need to worry about being in power
> domains or manually calling bus level callbacks.
>
> Putting it in a helper would at least mean that it's easier for the
> mechanics to be transferred to the core proper later on.

I agree, a helper function would be nice. I have earlier sent a patch
to the PM core, that is similar to the code above, though it was
rejected in it's current form. Let me follow up on this again.

At this point, would a way forward be to still go ahead with this
patch and then convert to, when/if, the helper function from the PM
core becomes available?

Kind regards
Ulf Hansson
