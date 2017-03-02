From: jerome.forissier@linaro.org (Jerome Forissier)
Date: Thu, 2 Mar 2017 15:18:34 +0100
Subject: [PATCH] Documentation: dt: Add binding for
 /secure-chosen/stdout-path
In-Reply-To: <456c743d-5963-3169-be1b-568c9012a993@arm.com>
References: <55a2f3cbe477bc876a7547eeb4693218698b87fe.1488387801.git.jerome.forissier@linaro.org>
 <CAFEAcA9AX5kSMs-PBQWDeDo=PTLoBHPMKc6ctYvR4LVni3rWAA@mail.gmail.com>
 <456c743d-5963-3169-be1b-568c9012a993@arm.com>
Message-ID: <6c233107-c6dc-3930-d5cb-53692da5cf6b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/01/2017 07:42 PM, Robin Murphy wrote:
> On 01/03/17 17:43, Peter Maydell wrote:
>> On 1 March 2017 at 17:08, Jerome Forissier <jerome.forissier@linaro.org> wrote:
>>> Some platforms may use a single device tree to describe two address
>>> spaces, as described in d9f43babb998 ("Documentation: dt: Add bindings
>>> for Secure-only devices"). For these platforms it makes sense to define
>>> a secure counterpart of /chosen, namely: /secure-chosen. This new node
>>> is meant to be used by the secure firmware to pass data to the secure
>>> OS. Only the stdout-path property is supported for now.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/arm/secure.txt | 15 ++++++++++++++-
>>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
>>> index e31303f..e7c596a 100644
>>> --- a/Documentation/devicetree/bindings/arm/secure.txt
>>> +++ b/Documentation/devicetree/bindings/arm/secure.txt
>>> @@ -32,7 +32,8 @@ describe the view of Secure world using the standard bindings. These
>>>  secure- bindings only need to be used where both the Secure and Normal
>>>  world views need to be described in a single device tree.
>>>
>>> -Valid Secure world properties:
>>> +Valid Secure world properties
>>> +-----------------------------
>>>
>>>  - secure-status : specifies whether the device is present and usable
>>>    in the secure world. The combination of this with "status" allows
>>> @@ -51,3 +52,15 @@ Valid Secure world properties:
>>>     status = "disabled"; secure-status = "okay";     /* S-only */
>>>     status = "disabled";                             /* disabled in both */
>>>     status = "disabled"; secure-status = "disabled"; /* disabled in both */
>>> +
>>> +The secure-chosen node
>>> +----------------------
>>> +
>>> +Similar to the /chosen node which serves as a place for passing data
>>> +between firmware and the operating system, the /secure-chosen node may
>>> +be used to pass data to the secure OS. Only the properties defined
>>> +below may appear in the /secure-chosen node. They have the same
>>> +definition as when used under /chosen, unless explicitely stated
>>
>> typo: "explicitly".
>>
>>> +otherwise.
>>> +
>>> +- stdout-path
>>
>> What's the default for the Secure world if (a) the secure-chosen
>> node doesn't exist at all or (b) it does exist but doesn't
>> define stdout-path? Presumably it should be "fall back to
>> using the chosen node's stdout-path", to match the way we
>> do fallback for other secure world properties, but it would
>> be good to say so explicitly I think.
> 
> I'd agree that it would be reasonable for the secure OS to fall back to
> parsing /chosen in the absence of /secure-chosen,

I don't think that "fall back to using stuff from /chosen" is generally
useful. Indeed, of all the properties I can see mentioned for /chosen
("stdout-path", "linux,syrq-reset-seq", "linux,pci-probe-only",
"bootargs", "initrd_start" and "initrd_end"), only stdout-path is likely
to be usable by the Secure OS as a fall back. So I'd rather make this an
exception rather than the rule.

> but if the latter is
> present I would (at least naively) expect it to be authoritative.

Agreed.

> I can
> imagine the case of a cut-down version of some system implementing only
> one UART, where you might want to tell the Normal world OS to use that
> and the Secure OS to keep its output to itself - allowing fallbacks at
> the individual property level would make that harder than it needs to
> be, and in general seems like it might be more confusing than useful.

Yup.

> Maintaining the principal that "secure-X" takes complete precedence over
> "X" seems to me to be the least surprising; it's just that in this one
> case X gets to be an entire node rather than a property because /chosen
> is special.

OK, can we agree on the following?

- The secure OS is supposed to get its boot data from /secure-chosen
- Only the stdout-path path property is defined currently. Its
definition is the same as for /chosen. If not present but /secure-chosen
is present, it takes no default value. If /secure-chosen does not exist
however, it defaults to the value of /chosen/stdout-path.
- As we add properties to /secure-chosen we'll see if it makes sense to
allow fall back to their counterparts in /chosen (which I don't expect
to happen too often).

If that sounds good to you I'll send a V2.

Thanks,
-- 
Jerome

> 
> Robin.
> 
>>
>> thanks
>> -- PMM
>>
> 
