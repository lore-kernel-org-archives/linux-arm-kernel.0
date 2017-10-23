From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 23 Oct 2017 23:12:39 +0200
Subject: [PATCH v5] atmel_flexcom: Support backup mode
In-Reply-To: <CAGkQfmMK_a5+zyyoHZsnfvNuxmNLeM0t40MrbPMMwKcNXDZTFA@mail.gmail.com>
References: <20171019164443.487-1-romain.izard.pro@gmail.com>
 <20171023160600.kcjy4ejdllllu62y@dell> <20171023160726.ufs37iyuicirwk4f@dell>
 <CAGkQfmMK_a5+zyyoHZsnfvNuxmNLeM0t40MrbPMMwKcNXDZTFA@mail.gmail.com>
Message-ID: <eb14f0e6-b3c5-dbd2-ccc9-066045896a55@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/2017 at 19:03, Romain Izard wrote:
> 2017-10-23 18:07 GMT+02:00 Lee Jones <lee.jones@linaro.org>:
>> On Mon, 23 Oct 2017, Lee Jones wrote:
>>> On Thu, 19 Oct 2017, Romain Izard wrote:
>>>
>>>> The controller used by a flexcom module is configured at boot, and left
>>>> alone after this. As the configuration will be lost after backup mode,
>>>> restore the state of the flexcom driver on resume.
>>>>
>>>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>> Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>> ---
>>>> Changes in v5:
>>>> * extract from the patch series, and send as a standalone patch
>>>>
>>>>  drivers/mfd/atmel-flexcom.c | 65 ++++++++++++++++++++++++++++++++++-----------
>>>>  1 file changed, 50 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
>>>> index 064bde9cff5a..ef1235c4a179 100644
>>>> --- a/drivers/mfd/atmel-flexcom.c
>>>> +++ b/drivers/mfd/atmel-flexcom.c
>>>> @@ -39,34 +39,44 @@
>>>>  #define FLEX_MR_OPMODE(opmode)     (((opmode) << FLEX_MR_OPMODE_OFFSET) &  \
>>>>                              FLEX_MR_OPMODE_MASK)
>>>>
>>>> +struct atmel_flexcom {
>>>> +   void __iomem *base;
>>>> +   u32 opmode;
>>>> +   struct clk *clk;
>>>> +};
>>>>
>>>>  static int atmel_flexcom_probe(struct platform_device *pdev)
>>>>  {
>>>>     struct device_node *np = pdev->dev.of_node;
>>>> -   struct clk *clk;
>>>>     struct resource *res;
>>>> -   void __iomem *base;
>>>> -   u32 opmode;
>>>> +   struct atmel_flexcom *afc;
>>>
>>> Nit: I'd prefer if you call this 'ddata'.
>>>
>>> But the concept and implementation is fine, so if you're going to
>>> change it please do so and apply my:
>>>
>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>
>> Also, 'back-up mode' isn't really a thing is it?
>>
>> How about "Reinstall state on resume" or similar?
>>
> 
> The expression comes from the SAMA5D2's datasheet.
> 
> Other Atmel chips use a different single suspend mode with Linux, where
> the SoC remains completely powered with a slow clock. The registers are
> preserved in this mode, so there is no need for a specific suspend and
> resume code.
> 
> The SoC can also be powered down, but the CPU is reset and only a small
> part is powered with a backup battery to maintain a valid RTC and a
> small internal SRAM.
> 
> In the SAMA5D2, the mode with only the backup power supply has been
> extended to isolate the memory I/O lines, making it possible to keep the
> external SDRAM memory in self-refresh. This mode has a lower consumption
> compared to the slow clock mode, but it has a higher wakeup latency, and
> needs specific software support in the bootloader and the kernel.
> 
> As a result, the "backup mode" expression is used to contrast with the
> "slow clock" expression when describing the different suspend modes
> supported by the chip.

aka: Ultra Low Power modes (ULP0 and ULP1).

> But if you think that it is necessary, I can reword the commit.

Thanks for the whole explanation Romain.

Yes we have such a wording in our documents and we used some kind of
"Backup mode", "Backup+Self-Refresh (B+SR or B+S-R)", "Backup and DDR in
Self-refresh" or "suspend-to-mem" wording for our patches. I take
advantage of this discussion to list all them here, for the record ;-)

So, I have the feeling that together with the commit message itself, we
can go with this wording.

Best regards,
-- 
Nicolas Ferre
