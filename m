From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 Oct 2013 11:41:40 +0100
Subject: [PATCH 22/23] ARM: cci: driver need big endian fixes in asm code
In-Reply-To: <20131015092637.GA2312@localhost.localdomain>
References: <20131015092637.GA2312@localhost.localdomain>
Message-ID: <525D1BE4.20104@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/13 10:27, Dave Martin wrote:
> On Mon, Oct 14, 2013 at 09:40:54PM -0400, Nicolas Pitre wrote:
>> On Mon, 14 Oct 2013, Ben Dooks wrote:
>>
>>> On 08/10/13 23:34, Ben Dooks wrote:
>>>> From: Victor Kamensky<victor.kamensky@linaro.org>
>>>>
>>>> cci_enable_port_for_self written in asm and it works with h/w
>>>> registers that are in little endian format. When run in big
>>>> endian mode it needs byte swap before/after it writes/reads
>>>> to/from such registers
>>>>
>>>> CC: Lorenzon Pieralisi<lorenzo.pieralisi@arm.com>
>>>> Signed-off-by: Victor Kamensky<victor.kamensky@linaro.org>
>>>> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
>>>> ---
>>>>    drivers/bus/arm-cci.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
>>>> index 2009266..6db173e 100644
>>>> --- a/drivers/bus/arm-cci.c
>>>> +++ b/drivers/bus/arm-cci.c
>>>> @@ -281,6 +281,9 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>>>>    	/* Enable the CCI port */
>>>>    "	ldr	r0, [r0, %[offsetof_port_phys]] \n"
>>>>    "	mov	r3, #"__stringify(CCI_ENABLE_REQ)" \n"
>>>> +#ifdef __ARMEB__
>>>> +"	rev	r3, r3 \n"
>>>> +#endif /* __ARMEB__ */
>>>>    "	str	r3, [r0, #"__stringify(CCI_PORT_CTRL)"] \n"
>>>>
>>>>    	/* poll the status reg for completion */
>>>> @@ -288,6 +291,9 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>>>>    "	ldr	r0, [r1] \n"
>>>>    "	ldr	r0, [r0, r1]		@ cci_ctrl_base \n"
>>>>    "4:	ldr	r1, [r0, #"__stringify(CCI_CTRL_STATUS)"] \n"
>>>> +#ifdef __ARMEB__
>>>> +"	rev	r1, r1 \n"
>>>> +#endif /* __ARMEB__ */
>>>>    "	tst	r1, #1 \n"
>>>>    "	bne	4b \n"
>>>
>>> I was just thinking if this would be a better way to change
>>> the code:
>>>
>>> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
>>> index 6db173e..2ad2511 100644
>>> --- a/drivers/bus/arm-cci.c
>>> +++ b/drivers/bus/arm-cci.c
>>> @@ -280,10 +280,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>>>
>>>          /* Enable the CCI port */
>>>   "      ldr     r0, [r0, %[offsetof_port_phys]] \n"
>>> -"      mov     r3, #"__stringify(CCI_ENABLE_REQ)" \n"
>>> -#ifdef __ARMEB__
>>> -"      rev     r3, r3 \n"
>>> -#endif /* __ARMEB__ */
>>> +"      mov     r3, %[cci_enable_req]\n"
>>>   "      str     r3, [r0, #"__stringify(CCI_PORT_CTRL)"] \n"
>>>
>>>          /* poll the status reg for completion */
>>> @@ -291,10 +288,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>>>   "      ldr     r0, [r1] \n"
>>>   "      ldr     r0, [r0, r1]            @ cci_ctrl_base \n"
>>>   "4:    ldr     r1, [r0, #"__stringify(CCI_CTRL_STATUS)"] \n"
>>> -#ifdef __ARMEB__
>>> -"      rev     r1, r1 \n"
>>> -#endif /* __ARMEB__ */
>>> -"      tst     r1, #1 \n"
>>> +"      tst     r1, %[cci_control_status_bits] \n"
>>>   "      bne     4b \n"
>>>
>>>   "      mov     r0, #0 \n"
>>> @@ -307,6 +301,8 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>>>   "7:    .word   cci_ctrl_phys - . \n"
>>>          : :
>>>          [sizeof_cpu_port] "i" (sizeof(cpu_port)),
>>> +       [cci_enable_req] "i" cpu_to_le32(CCI_ENABLE_REQ),
>>> +       [cci_control_status_bits] "i" cpu_to_le32(1),
>>>
>>> so swap the data bits before passing them into the code
>>> which could also remove some of the use of the __stringify()
>>> calls in there too.
>> That certainly looks nicer to me.
>>
>>> It seems to compile ok, but is not complete.
>>
>> What do you mean?
>
> Ditto -- this does look better that the other suggestions.  I forget that
> there are something situations where the "i" constraint is actually
> useful.

Well, it was a quick idea late last night, whilst not-sleeping from
a nasty cold that hasn't quite gone away. In that state I'm not going
to guarantee anything.

If Victor could re-work and test, then that'd be great and I can swap
out the last patch of the BE series.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
