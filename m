From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 26 Sep 2017 15:14:25 -0700
Subject: [PATCH v5 2/2] thermal: add brcmstb AVS TMON driver
In-Reply-To: <9bdd9959-da47-9adb-e550-31bf06254310@broadcom.com>
References: <20170926212800.4879-1-code@mmayer.net>
 <20170926212800.4879-3-code@mmayer.net>
 <4cb98266-6936-7668-fc88-199ac907b437@broadcom.com>
 <CANEuBv7pij+szVQZHZxNr4kXcCT0miTsYzG7g28zOmF9MqXKJQ@mail.gmail.com>
 <9bdd9959-da47-9adb-e550-31bf06254310@broadcom.com>
Message-ID: <9587b134-9727-d7cb-7a46-6df5ee4a0494@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2017 03:08 PM, Scott Branden wrote:
> 
> 
> On 17-09-26 02:38 PM, Markus Mayer wrote:
>> On 26 September 2017 at 14:32, Scott Branden
>> <scott.branden@broadcom.com> wrote:
>>> Hi Markus,
>>>
>>>
>>> On 17-09-26 02:27 PM, Markus Mayer wrote:
>>>> From: Brian Norris <computersforpeace@gmail.com>
>>>>
>>>> The AVS TMON core provides temperature readings, a pair of configurable
>>>> high- and low-temperature threshold interrupts, and an emergency
>>>> over-temperature chip reset. The driver utilizes the first two to
>>>> provide temperature readings and high-temperature notifications to
>>>> applications. The over-temperature reset is not exposed to
>>>> applications; this reset threshold is critical to the system and should
>>>> be set with care within the bootloader.
>>>>
>>>> Applications may choose to utilize the notification mechanism, the
>>>> temperature reading mechanism (e.g., through polling), or both.
>>>>
>>>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>>>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>>> ---
>>>>    drivers/thermal/Kconfig                    |   2 +-
>>>>    drivers/thermal/broadcom/Kconfig           |   7 +
>>>>    drivers/thermal/broadcom/Makefile          |   1 +
>>>>    drivers/thermal/broadcom/brcmstb_thermal.c | 387
>>>> +++++++++++++++++++++++++++++
>>>>    4 files changed, 396 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c
>>>>
>>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>>> index 07002df..96774a7 100644
>>>> --- a/drivers/thermal/Kconfig
>>>> +++ b/drivers/thermal/Kconfig
>>>> @@ -408,7 +408,7 @@ config MTK_THERMAL
>>>>            controller present in Mediatek SoCs
>>>>      menu "Broadcom thermal drivers"
>>>> -depends on ARCH_BCM || COMPILE_TEST
>>>> +depends on ARCH_BCM || ARCH_BRCMSTB || COMPILE_TEST
>>> No need for this additional depends.  ARCH_BCM is always defined before
>>> ARCH_BRCMSTB can be selected.
>> ARCH_BCM does not exist in arch/arm64/configs/defconfig. ARCH_BRCMSTB
>> does. So, we do need both or the driver won't be built on ARM64.
>> (After internal discussions we went with that approach rather than
>> defining ARCH_BCM on ARM64.)
> Got it.  Looking at our internal iproc tree I see we've done exactly the
> same with ARCH_BCM_IPROC needing to be added.  We haven't upstreamed
> the thermal driver needing it yet.
> 
> Perhaps we should add ARCH_BCM to ARM64....

If it is just added to satisfy dependencies, I don't see much value in
doing that. It does make sense in the ARM v7 multiplatform context, but
outside of that, not so sur.
-- 
Florian
