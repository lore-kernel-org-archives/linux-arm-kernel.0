From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 12 Nov 2013 20:00:15 -0800
Subject: [PATCH 1/2] watchdog: bcm281xx: Watchdog Driver
In-Reply-To: <CAPdLdqn5bvxnURdcy0JATBWmyJsbL=EJ65repSVxchw7srWpfQ@mail.gmail.com>
References: <1383943488-6537-1-git-send-email-markus.mayer@linaro.org>	<1383943488-6537-2-git-send-email-markus.mayer@linaro.org>	<20131111173434.GA25532@roeck-us.net>
 <CAPdLdqn5bvxnURdcy0JATBWmyJsbL=EJ65repSVxchw7srWpfQ@mail.gmail.com>
Message-ID: <5282F94F.2060208@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2013 02:17 PM, Markus Mayer wrote:

>>> +
>>> +     if (!timeout)
>>> +             dev_info(wdog->dev, "Watchdog timer stopped");
>>> +
>> All that noise.
>
> Would it be acceptable to turn these calls into dev_dbg() calls, here
> and elsewhere?
>

Ok with me.


>>> +
>>> +     wdt->resolution = SECWDOG_DEFAULT_RESOLUTION;
>>> +     ret = bcm_kona_wdt_set_resolution_reg(wdt);
>>> +     if (ret) {
>>> +             dev_err(dev, "Failed to set resolution (error: %d)", ret);
>>
>> ret can be -EAGAIN or -EINVAL. -EINVAL suggests a bad internale error (hopefully
>> SECWDOG_DEFAULT_RESOLUTION is defined to be smaller than SECWDOG_MAX_RES),
>> and if it is -EAGAIN there should be no error message.
>>
>> Actually, bcm_kona_wdt_set_resolution_reg is only called from here, meaning the
>> error check in the function is really unnecessary.
>
> This again goes back to making resolution available to userland. Then
> bcm_kona_wdt_set_resolution_reg() would be called from elsewhere. Why
> is it bad to print an error message on timeout? Would this still apply

That was related to -EAGAIN. Which would be bad here anyway as it could result
in an endless loop if there is a problem with the chip.

> if I switch the code to -ETIMEDOUT?
>
That is one option, or -EIO if the condition indicates a chip error.

>>> +             return ret;
>>> +     }
>>> +
>>> +     spin_lock_init(&wdt->lock);
>>> +     platform_set_drvdata(pdev, wdt);
>>> +     watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
>>> +
>>> +     ret = bcm_kona_wdt_set_timeout_reg(&bcm_kona_wdt_wdd);
>>> +     if (ret) {
>>> +             dev_err(dev, "Failed set watchdog timeout");
>>
>> The only error case is -EAGAIN. I don't think there should be an error mesasge
>> in this case (though I am not sure what the reaction should be).
>
> I am thinking that probe() needs to return an error if setting the
> timeout fails, as it can't really rely on the watchdog timer or let
> the system use it. Shouldn't that be accompanied by an error message
> letting the user know what happened?
>
Oh, I agree it should return an error, and an error message is ok as well.
I am just sure it should not be -EAGAIN, but I don't know what it should be.
Maybe -ETIMEDOUT, or -EIO.

>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = watchdog_register_device(&bcm_kona_wdt_wdd);
>>> +     if (ret) {
>>> +             dev_err(dev, "Failed to register watchdog device");
>>> +             return ret;
>>> +     }
>>> +
>>> +#ifdef CONFIG_BCM_KONA_WDT_DEBUG
>>> +     wdt->debugfs = bcm_kona_wdt_debugfs_init(wdt, &bcm_kona_wdt_wdd);
>>> +#endif
>>> +     dev_info(dev, "Broadcom Kona Watchdog Timer");
>>> +
>> Such messages are in general considered nuisance nowadays. I would suggest to
>> remove it (or ask Greg KH for advice).
>>

Referring to your other mail.... seems those messages are falling out of favor.
I consider it a nuisance, though so far I let it go through. The messages do
increase boot time, especially on systems with slow serial console, and IMO
do not provide any real value. Users either don't care, or can check if the
driver is loaded by other means. I would suggest to at least make it dev_dbg.

Thanks,
Guenter
