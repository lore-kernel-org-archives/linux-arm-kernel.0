From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 13 Jan 2015 09:56:41 +0100
Subject: [alsa-devel] [PATCH] ASoC: wm8904: fix runtime warning
In-Reply-To: <54B4AED5.1000001@atmel.com>
References: <1420793620-2866-1-git-send-email-voice.shen@atmel.com>
 <20150109111642.GU14516@opensource.wolfsonmicro.com>
 <54B34035.60107@atmel.com> <54B3943C.4040103@metafoo.de>
 <54B4AED5.1000001@atmel.com>
Message-ID: <54B4DDC9.2000902@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2015 06:36 AM, Bo Shen wrote:
> Hi Lars-Perter Clausen,
>
> On 01/12/2015 05:30 PM, Lars-Peter Clausen wrote:
>> On 01/12/2015 04:32 AM, Bo Shen wrote:
>> [...]
>>>>> diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
>>>>> index 4d2d2b1..38582d7 100644
>>>>> --- a/sound/soc/codecs/wm8904.c
>>>>> +++ b/sound/soc/codecs/wm8904.c
>>>>> @@ -1076,10 +1076,10 @@ static const struct snd_soc_dapm_route
>>>>> adc_intercon[] = {
>>>>>       { "Right Capture PGA", NULL, "Right Capture Mux" },
>>>>>       { "Right Capture PGA", NULL, "Right Capture Inverting Mux" },
>>>>>
>>>>> -    { "AIFOUTL", "Left",  "ADCL" },
>>>>> -    { "AIFOUTL", "Right", "ADCR" },
>>>>> -    { "AIFOUTR", "Left",  "ADCL" },
>>>>> -    { "AIFOUTR", "Right", "ADCR" },
>>>>> +    { "AIFOUTL", NULL, "ADCL" },
>>>>> +    { "AIFOUTL", NULL, "ADCR" },
>>>>> +    { "AIFOUTR", NULL, "ADCL" },
>>>>> +    { "AIFOUTR", NULL, "ADCR" },
>>>>
>>>> Is this the right fix here? I am not super familiar with the
>>>> driver but it appears to contain an "AIFOUTL Mux" control which
>>>> is not connected to anything. Looks like maybe this is a mistake
>>>> the mux is indeded to be included in the path? Feels like we
>>>> should either remove the control as well or hook it into the
>>>> path.
>>>
>>> Thank for your information.
>>> I think here it should correct the path name as
>>> --->8---
>>> { "AIFOUTL Mux", "Left",  "ADCL" },
>>> { "AIFOUTL Mux", "Right", "ADCR" },
>>> { "AIFOUTR Mux", "Left",  "ADCL" },
>>> { "AIFOUTR Mux", "Right", "ADCR" },
>>> ---8<---
>>>
>>> Thanks again. I will send out the new version.
>>
>> Your probably also need to connect the mux to the output pins.
>
> Thanks for you information, after check the datasheet, I still don't know
> which the mux should connect to which output pins.

AIFOUTL Mux to AIFOUTL
AIFOUTR Mux to AIFOUTR
