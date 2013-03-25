From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Mar 2013 18:27:20 +0000
Subject: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
In-Reply-To: <51433949.1030204@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
 <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
 <201303151447.06150.arnd@arndb.de> <51433949.1030204@linaro.org>
Message-ID: <CAHkRjk45cGSKiC003izHrLSZPb3wsmjXPTG3e0raSaXAdQRqEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 March 2013 15:07, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 03/15/2013 03:47 PM, Arnd Bergmann wrote:
>> On Friday 15 March 2013, Daniel Lezcano wrote:
>>> The cpuidle drivers are duplicating a lot of code and in most
>>> of the case there is a common pattern we can factor out:
>>>
>>>         * setup the broadcast timers
>>>         * register the driver
>>>         * register the devices
>>>
>>> This arm driver is the common part between all the ARM cpuidle drivers,
>>> with the code factored out.
>>>
>>> It does not handle the coupled idle state for now but it is the first
>>> step to have everyone to converge to the same code pattern.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Unfortunately, I missed the session in Hong Kong, but I'd like to understand
>> what part of this driver is actually ARM specific. I assume there is nothing
>> in it that depends on 32 bit ARM hardware, right?
>
> What depends on the 32bits ARM hardware is the drivers themselves. This
> ARM driver is the first step to consolidate all SoC cpuidle specific
> code we find in arch/arm. The code is designated to factor out these
> drivers, as a first step. The second step is to consolidate more this
> driver (eg. moving the code in arch/arm/kernel/cpuidle.c in this driver).
>
> The last man standing algorithm we have in mach-ux500 and mach-imx is
> the same, and will be moved in the ARM cpuidle driver.
>
> The more it will be consolidated, the more it will be ARM specific.
>
> The final step will be to use the device tree to be passed to this
> driver and do the cpuidle driver initialization from there.
>
>> Would the same code be used with arch/arm64?
>
> I can't tell but IIUC, a single ARM driver will be used based on the
> psci for ARM64, but it does not exist for now. It is possible some code
> pattern could be used from the ARM32 cpuidle driver.

While we recommend PSCI if EL3 (secure mode) is available, not all
ARMv8 CPU implementations will have this and most likely we'll have to
reuse existing cpuidle drivers. So if you can make it as generic as
possible it would really help.

-- 
Catalin
