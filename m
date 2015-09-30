From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 30 Sep 2015 09:54:13 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable WiFi-Ex as a module instead
 built-in
In-Reply-To: <560B9145.6070606@samsung.com>
References: <1443530546-3066-1-git-send-email-javier@osg.samsung.com>
 <560B2EA4.8050406@samsung.com> <560B8DA3.6060507@osg.samsung.com>
 <560B9145.6070606@samsung.com>
Message-ID: <560B9525.8020808@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/30/2015 09:37 AM, Krzysztof Kozlowski wrote:
> On 30.09.2015 16:22, Javier Martinez Canillas wrote:
>> Hello Krzysztof,
>>
>> On 09/30/2015 02:36 AM, Krzysztof Kozlowski wrote:
>>> On 29.09.2015 21:42, Javier Martinez Canillas wrote:
>>>> The Marvell WiFi-Ex driver tries to load a firmware on probe. So if the
>>>> driver is built-in and probed before a firmware is available, this is
>>>> not loaded and the chip does not work.
>>>>
>>>> This happens for example if an initramfs isn't used since the driver is
>>>> probed before the root filesystem is mounted.
>>>>
>>>> Change the default config since the driver isn't needed for machines to
>>>> boot and is more convenient to have it enabled as a module to avoid
>>>> requiring an initramfs or to have the firmware built into the kernel.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>
>>>> ---
>>>>
>>>>  arch/arm/configs/exynos_defconfig | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> The user-space can always initiate re-probing of device - just re-bind
>>
>> It is true that you can force a re-probing from user-space by doing:
>>
>> $ echo "mmc2:0001:1" > /sys/bus/sdio/drivers/mwifiex_sdio/unbind
>> $ echo "mmc2:0001:1" > /sys/bus/sdio/drivers/mwifiex_sdio/bind
> 
> I suppose the unbind won't be needed, because device aborted the
> probe... so only one another bind.
>

Right, only the bind is needed indeed since the device is unbind
after the firmware loading fails. I just wanted to confirm that
I understood what you said before correctly.
 
>>
>> but:
>>
>> a) This is not obvious. In fact, I didn't think that possibility
>> before you mentioned and I've been using Linux for many years :)
> 
> Eh, questionable. Obvious for me :)
>

Fair enough, maybe is just me then :)
 
>>
>> b) This is not something that isn't done automatically by init systems.
>
> Right.

err, I wanted to say "is not something that is done automatically" but
fortunately you understood what I meant.

> 
>>
>> So what users will see is that the driver was probed successfully but
>> the firmware fails to load later (since the driver users the async
>> request_firmware_nowait function to request the firmware).
> 
> Okay.
> 
>>
>>> it. However I assume that driver cannot work without firmware?
>>>
>>
>> Yes, it doesn't. I explained this in the commit message. Do you
>> think it should be made more clear?
> 
> No, its OK, I agree.
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Great, thanks a lot for your feedback and review!
 
> Best regards,
> Krzysztof

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
