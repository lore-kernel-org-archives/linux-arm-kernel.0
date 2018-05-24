From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 24 May 2018 14:25:34 +0100
Subject: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
In-Reply-To: <20180523181058.GC27570@roeck-us.net>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
 <af81ea74-fb80-11e2-7bdc-d3607bdbd46b@arm.com>
 <20180523181058.GC27570@roeck-us.net>
Message-ID: <91d27df4-29d0-de7f-6805-c3e5f329caf3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/18 19:10, Guenter Roeck wrote:
> On Wed, May 23, 2018 at 11:57:25AM +0100, Robin Murphy wrote:
>> On 22/05/18 19:47, Ray Jui wrote:
>>> Update the SP805 binding document to add optional 'timeout-sec'
>>> devicetree property
>>>
>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>   Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>> index edc4f0e..f898a86 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>> +++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>> @@ -19,6 +19,8 @@ Required properties:
>>>   Optional properties:
>>>   - interrupts : Should specify WDT interrupt number.
>>> +- timeout-sec : Should specify default WDT timeout in seconds. If unset, the
>>> +                default timeout is 30 seconds
>>
>> According to the SP805 TRM, the default interval is dependent on the rate of
>> WDOGCLK, but would typically be a lot longer than that :/
>>
> Depends on the definition of "default". In the context of watchdog drivers,
> it is (or should be) a driver default, not a chip default.

DT describes hardware, not driver behaviour.

I appreciate that where a timeout *is* specified, that is effectively a 
hardware aspect even if it's something an OS consuming the binding still 
has to voluntarily program into the device. The notion of "this is the 
longest period of time for which you can reasonably expect to see no 
activity under normal operation" is indeed a property of the platform as 
a whole - a system with user-accessible PCIe slots may need to reflect 
the worst case of one CPU waiting for an ATS invalidation timeout with 
interrupts disabled, whereas a much shorter period might be appropriate 
for the same SoC in some closed-down embedded device.

The absence of the property, though, doesn't convey anything other than 
"I don't know" and/or "it doesn't really matter", and in that situation 
the default is always going to be "whatever the OS thinks is 
appropriate". The binding itself can't possibly know, whereas an OS 
might be configured for some pseudo-real-time application which it knows 
warrants a maximum of 100ms regardless of what the DT does or doesn't 
say. In the case of SP805, if the OS doesn't reconfigure it at all, 
there happens to be an actual hardware default of (2^32 / WDOGCLK), but 
since that's already implicit in the compatible it doesn't really need 
saying either.

Optional properties don't need to explicitly state what their absence 
might infer, especially when it's not directly meaningful (just imagine 
trying to do that for bindings/regulator/regulator.txt...), so I would 
suggest following the 93% of existing bindings which simply don't try to 
claim some default value for this property.

I also think the fact that, within the context of this patch series, the 
Linux driver doesn't even do what the binding claims only goes to help 
make my point ;)

Robin.
