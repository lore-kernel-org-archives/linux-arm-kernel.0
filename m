From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Feb 2015 09:35:47 -0700
Subject: [PATCH v3 01/10] ARM: tegra: Set the sound card model that alsaucm
 expects
In-Reply-To: <CAAObsKCm-9GOvis=MZ-nyA0N+g_ZuWYUfDSdEcVy5p5ykCmkcQ@mail.gmail.com>
References: <1422442278-10405-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422442278-10405-2-git-send-email-tomeu.vizoso@collabora.com>
 <54CFE754.7000500@wwwdotorg.org>
 <CAAObsKCm-9GOvis=MZ-nyA0N+g_ZuWYUfDSdEcVy5p5ykCmkcQ@mail.gmail.com>
Message-ID: <54D0F8E3.3020902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2015 06:13 AM, Tomeu Vizoso wrote:
> On 2 February 2015 at 22:08, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 01/28/2015 03:50 AM, Tomeu Vizoso wrote:
>>>
>>> Patches are on its way to add a config file to alsaucm for the Nyan
>>> boards. Use the same card ID that alsaucm will expect.
>>
>>
>>> diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts
>>> b/arch/arm/boot/dts/tegra124-nyan-big.dts
>>
>>
>>>          sound {
>>> -               compatible = "nvidia,tegra-audio-max98090-nyan-big",
>>> +               compatible = "nvidia,tegra-audio-max98090-nyan",
>>>                               "nvidia,tegra-audio-max98090";
>>
>>
>> I'm not convinced that removing the board-specific compatible value is a
>> great idea. What if we find we need to distinguish between different boards
>> that use this same binding in the future. That situation is exactly why we
>> have board-/SoC-specific values in compatible even if we don't immediately
>> use them.
>
> I understand the need of naming each component variant so they can be
> distinguished in the future, but in this case it's the exact same hw.

That's not true. These are two different boards that are derived from 
the same base design. The intent may be that they are the same, but the 
whole point of board-specific compatible values is to cover the case 
where mistakes and exceptions appear later.

>>> -               nvidia,model = "Acer Chromebook 13";
>>> +               nvidia,model = "GoogleNyan";
>>
>>
>> I believe this also technically breaks ABI, since some user-space tools use
>> the model to look up saved state. Can we not leave this as is, and just have
>> the UCM files know about both names?
>
> Well, "A13" isn't a great card id. Given that there's no users yet, I
> would prefer to take this chance to put a sane value in there. Btw,
> alsa-lib has now a UCM config for this and it uses the GoogleNyan card
> id (has been picked up already by OpenSUSE).

"A13" didn't appear anywhere, did it? Perhaps that was a shorthand for 
"Acer Chromebook 13". Yes, I agree we should use the user-visible model 
number here; "Acer CB5" or perhaps "Acer CB5-xxx" whatever xxx actually is.

> So in this case, I think it would be good to change the card id now
> before people start to actually use it.
