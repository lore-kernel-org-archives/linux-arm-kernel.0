From: jeffy.chen@rock-chips.com (jeffy)
Date: Sat, 14 Oct 2017 03:01:42 +0800
Subject: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early system
 PM callbacks
In-Reply-To: <59E10971.6020200@rock-chips.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com>
 <20171013155120.GA137489@google.com>
 <20171013164235.thgqha7sl5tdptwv@sirena.co.uk>
 <59E103B0.8060705@rock-chips.com> <20171013183006.k6pzcr5tcwsxxtmp@dtor-ws>
 <59E10971.6020200@rock-chips.com>
Message-ID: <59E10D96.90307@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

so what happens here is:
1/ we put display-subsystem dt node before spi node, which cause 
rockchip drm driver probed before spi(also before edp driver/vop driver...)

2/ rockchip drm driver bound after spi/edp/vop... drivers probed

3/ in rockchip drm driver's resume callback, it would try to enable edp 
panel backlight(through spi), but spi master is still suspended, then we 
got these errors:

1970-01-01T08:02:59.607315+08:00 ERR kernel: [  178.754005] cros-ec-spi 
spi2.0: spi
  transfer failed: -108
1970-01-01T08:02:59.607320+08:00 ERR kernel: [  178.760102] cros-ec-spi 
spi2.0: cs-
deassert spi transfer failed: -108
1970-01-01T08:02:59.607325+08:00 ERR kernel: [  178.767380] cros-ec-spi 
spi2.0: Com
mand xfer error (err:-108)
1970-01-01T08:02:59.607331+08:00 ERR kernel: [  178.773963] cros-ec-spi 
spi2.0: spi
  transfer failed: -108
1970-01-01T08:02:59.607336+08:00 ERR kernel: [  178.780066] cros-ec-spi 
spi2.0: cs-
deassert spi transfer failed: -108
1970-01-01T08:02:59.607341+08:00 ERR kernel: [  178.787359] cros-ec-spi 
spi2.0: Com
mand xfer error (err:-108)

so other than move spi master suspend to late suspend, maybe we could 
defer rockchip drm driver probe after it's component drivers somehow?



On 10/14/2017 02:44 AM, jeffy wrote:
> Hi Dmitry,
>
> On 10/14/2017 02:30 AM, Dmitry Torokhov wrote:
>> On Sat, Oct 14, 2017 at 02:19:28AM +0800, jeffy wrote:
>>> Hi guys,
>>>
>>> it looks like the suspend sequence depends on the dt node sequence,
>>> and we
>>> are putting display-subsystem dt node above spi dt node, so it would be
>>> earlier in the device list, then got suspended later than spi device.
>>
>> Would it not get a deferral when trying to get resource reference, which
>> would cause it bumped down to the end of dpm list?
> hmm, right, check again, the rockchip drm would not depend on spi, but
> the edp driver does.
>
> so the drm driver(display-subsystem) would probed before spi, but try to
> control the backlight in the suspend/resume...
>
> so i was wrong in the commit message, will fix it in next version.
>>
>>>
>>> the pwm backlight and cros_ec_spi pwm are very interesting, not only
>>> about
>>> suspend dependency... if we unbind cros_ec_spi pwm, the pwm backlight
>>> would
>>> still hold a reference to it, and crash the kernel later.
>>
>> That would be a bug in PWM/cors_ec and it should keep the PWM object
>> until last reference drops and simply error out on all requests.
> right, and maybe try to refresh the pwm reference when we bind it again
>>
>>>
>>> On 10/14/2017 12:42 AM, Mark Brown wrote:
>>>> On Fri, Oct 13, 2017 at 08:51:21AM -0700, Brian Norris wrote:
>>>>
>>>>> Yes, this does seem odd to me too. This looks like an arms race hack
>>>>> that should be avoided unless we know a legit root cause. Also,
>>>>> "probe order implies suspend order" doesn't quite work for async
>>>>> suspend
>>>>> anyway, so we'd probably want to express the dependency properly
>>>>> anyway.
>>>>
>>>> Yeah, it's the same stuff as we get with initcall ordering.  This sort
>>>> of thing does happen with things like PMICs which tend to have hardware
>>>> that the system wants to manipulate in the IRQs off part of suspend.
>>>> Ideally the dependency annotation stuff would figure things out though
>>>> I'm not sure what the status of that is.
>>
>> I'd say non-existent for resources such as regulators, pwms, clocks,
>> etc. I do not think many places call device_link_add()... I think adding
>> this to devm_* APIs might be easiest to get the ball going as they
>> naturally have consumer device and can easily figure out the supplier
>> side.
>>
>>>>
>>>>> Any chance this is related? Seems like that might break the
>>>>> parent/child
>>>>> relationship for master/slave:
>>>>
>>>>> commit d7e2ee257038baeb03baef602500368a51ee9eef
>>>>> Author: Linus Walleij <linus.walleij@linaro.org>
>>>>> Date:   Mon Apr 11 13:51:03 2016 +0200
>>>>
>>>>>       spi: let SPI masters ignore their children for PM
>>>>
>>>> That's for runtime PM, I'd not expect it to affect system suspend.
>>>>
>>>
>>>
>>
>> Thanks.
>>
>
