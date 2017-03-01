From: jerome.forissier@linaro.org (Jerome Forissier)
Date: Wed, 1 Mar 2017 17:23:23 +0100
Subject: [PATCH] Documentation: dt: Add binding for
 /chosen/secure-stdout-path
In-Reply-To: <1a3382c5-57d5-9d99-1569-3211a1844192@arm.com>
References: <06154a2280a8423af80405825d7201c7aa927696.1488374335.git.jerome.forissier@linaro.org>
 <CAL_JsqKrUCCvGD_LKvOx+s8zh30GC_v=HAyqozgRm=7mcfSZzw@mail.gmail.com>
 <4847a1ee-caa7-509f-c540-ee3e1967ef7f@linaro.org>
 <1a3382c5-57d5-9d99-1569-3211a1844192@arm.com>
Message-ID: <a1ca0933-5ca9-6bb9-5141-e9337e960735@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/01/2017 04:20 PM, Robin Murphy wrote:
> On 01/03/17 15:04, Jerome Forissier wrote:
>>
>>
>> On 03/01/2017 03:50 PM, Rob Herring wrote:
>>> On Wed, Mar 1, 2017 at 7:29 AM, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>> Some platforms may use a single device tree to describe two address
>>>> spaces, as described in d9f43babb998 ("Documentation: dt: Add bindings
>>>> for Secure-only devices"). We extend the use of the secure- prefix to
>>>> the stdout-path property, so that the Secure firmware may use a
>>>> different console device than the one used by the kernel.
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/secure.txt | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
>>>> index e31303f..558c9a1 100644
>>>> --- a/Documentation/devicetree/bindings/arm/secure.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/secure.txt
>>>> @@ -51,3 +51,8 @@ Valid Secure world properties:
>>>>     status = "disabled"; secure-status = "okay";     /* S-only */
>>>>     status = "disabled";                             /* disabled in both */
>>>>     status = "disabled"; secure-status = "disabled"; /* disabled in both */
>>>> +
>>>> +- secure-stdout-path (/chosen node): specifies the device to be used
>>>> +for console output by Secure firmware. The syntax is the same as for
>>>> +"stdout-path". If "secure-stdout-path" is not specified it defaults to
>>>> +the same value as "stdout-path".
>>>
>>> I'm not all that enthusiastic about this. This alone is okay, but
>>> continued additions of secure-* properties doesn't seem very scalable.
>>> Is this it or do you have other needs? What happens when we have 3
>>> modes/address spaces?
>>
>> How is this different from status/secure-status?
>> I have no other needs for the moment. I'm experimenting with the
>> introduction of DT in OP-TEE. The secure-status property (or lack
>> thereof) already allows me to know if a device can be used by the secure
>> OS and how it should be mapped (secure vs. non-secure). This extension
>> allows me to reuse the same TEE binary and change the console, which is
>> a simple use case to demonstrate the advantage of using the DT in the
>> secure FW.
> 
> Once you start using DT in the secure OS, it doesn't seem too big a leap
> for folks to want to start passing arguments, so I'd consider
> secure-bootargs to be almost inevitable at *some* point down this road.
> 
> Perhaps we should consider a /secure-chosen node containing standard
> properties instead...

Fine with me. I'll send a new patch.

>>> Maybe we should allow stdout-path to have multiple strings and secure
>>> fw grabs the first one and updates the DT removing it (perhaps only if
>>> the device is secure only). Might be nice to have multiple ones
>>> supported anyway (like we can do on the kernel command line:
>>> "console=ttyS0 console=ttyS1").
>>
>> The problem I see with removing entries is that the secure firmware may
>> have multiple stages (say, ARM Trusted Firmware plus a secure OS such as
>> OP-TEE).
> 
> ...which different elements of firmware would in theory have a lot more
> freedom to mangle between boot stages without the risk of disrupting the
> regular /chosen properties.
