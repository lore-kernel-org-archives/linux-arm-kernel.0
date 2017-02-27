From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 27 Feb 2017 14:56:26 +0100
Subject: [PATCH v2 1/2] dt-bindings: arm: hisilicon: add bindings for
 hi3798cv200 SoC and Poplar board
In-Reply-To: <14a08c7d-8e25-bb5c-d700-46a07107e52f@linaro.org>
References: <1487752716-14824-1-git-send-email-xuejiancheng@hisilicon.com>
 <1487752716-14824-2-git-send-email-xuejiancheng@hisilicon.com>
 <ef8cca92-7f1f-40bd-4023-2e64dcf69a68@suse.de>
 <798bfd0e-bd8d-a75d-e841-53d82b513f94@hisilicon.com>
 <14a08c7d-8e25-bb5c-d700-46a07107e52f@linaro.org>
Message-ID: <e9385988-27bc-b930-cbed-807beafb64bc@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 27.02.2017 um 03:48 schrieb Alex Elder:
> On 02/26/2017 07:24 PM, Jiancheng Xue wrote:
>> On 2017/2/26 9:32, Andreas F?rber wrote:
>>> Am 22.02.2017 um 09:38 schrieb Jiancheng Xue:
>>>> Add bindings for HiSilicon hi3798cv200 SoC and Poplar Board.
>>>>
>>>> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> index f1c1e21..1fd3dd7 100644
>>>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> @@ -4,6 +4,10 @@ Hi3660 SoC
>>>>  Required root node properties:
>>>>  	- compatible = "hisilicon,hi3660";
>>>>  
>>>> +Hi3798cv200 Poplar Board
>>>> +Required root node properties:
>>>> +	- compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
>>>
>>> Please remember to CC previous reviewers.
>>>
>> Sorry for that.
>>
>>> This still looks wrong: Why is this not "hisilicon,poplar" if you choose
>>> against "tocoding,poplar"? 
>>
>> I didn't think it was very important thing whether the compatbile string contained
>> a preceding SoC name or not. I just referred to the hikey board and some other
>> HiSilicon boards. I wanted to keep using the same rule with them.
> 
> The way Jiancheng defined this was consistent with the pattern
> used for all other definitions of platforms found in this
> documentation file.  Why make this one different?

I am not familiar with other HiSilicon DTs but rather with several other
vendors' DTs. This seems inconsistent with the rest. The only other one
with SoC names in the board compatible I know of is i.MX6, where there's
variations between single, dual and quad versions.

>>> Is there a second Poplar board with a different SoC? 
>>
>> I can't tell about this now.
> 
> There is not.  But there could be.  In any case, I do accept
> your point that there's no need to encode the SoC identity
> in the board compatible string.  But I don't think doing so
> causes harm.
> 
>>> Even then it would be redundant with the second
>>> compatible string.
> 
> I presume you're not arguing that the second compatible
> string should be eliminated; it seems your concern is only
> about including the SoC in the board's compatible string.
> Is that right?
> 
>> The second compatilbe string can be removed here. Thanks.
> 
> I don't think it should be.

Correct, the second one must stay, because that allows for matching
against the SoC. of_machine_is_compatible() does not do partial
comparisons afaik, so there's no value in a vendor,soc-board pattern.

> My position, for what it's worth, is that if a change is
> made to the compatible strings, it should be:
> 
>   compatible = "hisilicon,poplar", "hisilicon,hi3798cv200";
> 
> But I don't think it's necessary to make that change.  Tocoding
> has no other DT presence in the kernel right now; it seems fine
> to tag the board with "hisilicon".

Adding vendor prefixes seems a common task these days (e.g., for the
UDOO Neo we had to define a udoo prefix and couldn't just reuse nxp as
its SoC vendor; hwacom, kingnovel, ucrobotics are some other pending
Chinese vendors I'm aware of, so tocoding isn't singled out). Whether
here it should be one or the other I can't tell, but whether or not a
vendor prefix is available has definitely not been the criteria.

In the case of the HiKey the vendor changed from CircuitCo to LeMaker
and we were able to fully reuse the bootloader and DT. On the other
hand, there's no additional compatible to detect which one you are on.

Independently, hisilicon.txt should be overhauled to not give
contradicting instructions for SoC vs. board. The SoC should say "must
contain ..." about the compatible string.

Which reminds me that this patch is lacking an entry for the SoC!

I also wonder why hi3620-hi4511 comes after hi3798cv200.

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
