From: jeffy.chen@rock-chips.com (jeffy)
Date: Sat, 14 Oct 2017 02:19:28 +0800
Subject: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early system
 PM callbacks
In-Reply-To: <20171013164235.thgqha7sl5tdptwv@sirena.co.uk>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com>
 <20171013155120.GA137489@google.com>
 <20171013164235.thgqha7sl5tdptwv@sirena.co.uk>
Message-ID: <59E103B0.8060705@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

it looks like the suspend sequence depends on the dt node sequence, and 
we are putting display-subsystem dt node above spi dt node, so it would 
be earlier in the device list, then got suspended later than spi device.

the pwm backlight and cros_ec_spi pwm are very interesting, not only 
about suspend dependency... if we unbind cros_ec_spi pwm, the pwm 
backlight would still hold a reference to it, and crash the kernel later.

On 10/14/2017 12:42 AM, Mark Brown wrote:
> On Fri, Oct 13, 2017 at 08:51:21AM -0700, Brian Norris wrote:
>
>> Yes, this does seem odd to me too. This looks like an arms race hack
>> that should be avoided unless we know a legit root cause. Also,
>> "probe order implies suspend order" doesn't quite work for async suspend
>> anyway, so we'd probably want to express the dependency properly
>> anyway.
>
> Yeah, it's the same stuff as we get with initcall ordering.  This sort
> of thing does happen with things like PMICs which tend to have hardware
> that the system wants to manipulate in the IRQs off part of suspend.
> Ideally the dependency annotation stuff would figure things out though
> I'm not sure what the status of that is.
>
>> Any chance this is related? Seems like that might break the parent/child
>> relationship for master/slave:
>
>> commit d7e2ee257038baeb03baef602500368a51ee9eef
>> Author: Linus Walleij <linus.walleij@linaro.org>
>> Date:   Mon Apr 11 13:51:03 2016 +0200
>
>>      spi: let SPI masters ignore their children for PM
>
> That's for runtime PM, I'd not expect it to affect system suspend.
>
