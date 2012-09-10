From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Sep 2012 13:21:30 -0600
Subject: [PATCH 1/2] i2c: s3c2410: add optional pin configuration using
 pinctrl interface
In-Reply-To: <CAJuYYwQCQDTnpPR5WABtbozZOgc6_SZRBv3b6D8KY78tzMt-Eg@mail.gmail.com>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
 <1346923381-14144-2-git-send-email-thomas.abraham@linaro.org>
 <2444562.GB3nOHUb9M@amdc1227>
 <CAJuYYwQCQDTnpPR5WABtbozZOgc6_SZRBv3b6D8KY78tzMt-Eg@mail.gmail.com>
Message-ID: <504E3DBA.3080603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 05:06 AM, Thomas Abraham wrote:
> On 6 September 2012 15:04, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi,
>>
>> This patch shows the problem of the need to explicitly migrate all drivers
>> to pinctrl.
>>
>> Maybe we should consider extending the pinctrl subsystem to set the default
>> state automatically before binding a driver to a device, at least in case
>> of DT-based platforms?
> 
> The pinctrl driver allows for activating default pin configuration
> when the pinctrl driver loads. This is referred to as "hogging". But
> should hog be used or not is something that needs to be decided. Some
> of the factors which favor the driver explicitly setting up the pin
> configuration are
> 
> 1. After a suspend and resume cycle, the pin configuration registers
> may be reset to default values. Hence, during resume, the pin
> configuration has be redone.

I'd think it's the pinctrl driver's responsibility to make hogging work
correctly across suspend/resume.

> 2. Runtime muxing/config is possible.

The "client" driver would definitely have to be involved there, I agree.

> 3. Setting some of the config options such as pull-up by default might
> start consuming power from boot time itself, which could be avoided if
> such setup is done only when needed.

Well, the difference in time between "just before driver binding" and
"during probe" is minimal. If the driver/HW really needs to explicitly
differentiate between those states to save power, I'd assert that it's
covered by case (2) above.

> Adding pinctrl driver support in device drivers seems to be simple
> task. And it is just one time effort which can be reused on multiple
> SoC's.
> 
>>
>> This would be similar to what is done currently with samsung-gpio bindings
>> - the pin is being configured by custom xlate callback based on additional
>> cells in GPIO specifier, when the driver retrieves the pin using
>> of_get{_named,}_gpio without the need of setting it up in the driver.
> 
> The Samsung gpio dt bindings was just a bootstrap method to get device
> tree support going for Samsung platforms. The gpio xlate callback was
> used as a back door to setup the pinmux/pinconfig due to lack of
> generic driver interface to setup the pinmux/pinconfig for Samsung
> platforms. From a linux perspective, gpio and pinmux/pinconfig are
> separate entities. So using gpio xlate to setup pinmux/pinconfig was
> not correct but helped getting device tree enabled for Samsung
> platforms. With the pinctrl framework available now, there are generic
> interfaces to setup gpio and pinmux /pinconfig.

I agree; the Samsung GPIO bindings were surprising to me when I first
realized what was in the GPIO specifiers...
