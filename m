From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 22 Jan 2016 16:39:30 +0000
Subject: [RFC PATCH v3] irqchip: Add support for Tango interrupt controller
In-Reply-To: <56A25ACF.5040205@sigmadesigns.com> (Marc Gonzalez's message of
 "Fri, 22 Jan 2016 17:37:35 +0100")
References: <569CE0F2.1060507@sigmadesigns.com>
 <569D0B80.1010908@sigmadesigns.com>
 <569D165E.4060004@sigmadesigns.com> <569FAFF5.4090909@arm.com>
 <yw1xr3hcqlix.fsf@unicorn.mansr.com> <569FB471.8000909@arm.com>
 <yw1xmvs0qkue.fsf@unicorn.mansr.com>
 <569FB7A9.9080309@sigmadesigns.com>
 <yw1xegdcqk8n.fsf@unicorn.mansr.com>
 <569FB91D.9030704@sigmadesigns.com>
 <yw1x1t9cqg18.fsf@unicorn.mansr.com>
 <56A2518F.6060808@sigmadesigns.com>
 <yw1xfuxpmv2f.fsf@unicorn.mansr.com>
 <56A25ACF.5040205@sigmadesigns.com>
Message-ID: <yw1x7fj1muv1.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> On 22/01/2016 17:35, M?ns Rullg?rd wrote:
>> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
>> 
>>> On 20/01/2016 19:09, M?ns Rullg?rd wrote:
>>>
>>>> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
>>>>
>>>>> On 20/01/2016 17:38, M?ns Rullg?rd wrote:
>>>>>
>>>>>> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
>>>>>>
>>>>>>> On 20/01/2016 17:25, M?ns Rullg?rd wrote:
>>>>>>>
>>>>>>>> Marc Zyngier <marc.zyngier@arm.com> writes:
>>>>>>>>
>>>>>>>>> On 20/01/16 16:10, M?ns Rullg?rd wrote:
>>>>>>>>>
>>>>>>>>>> Marc Zyngier <marc.zyngier@arm.com> writes:
>>>>>>>>>>
>>>>>>>>>>>> +	if (of_property_read_u32(node, "reg", &ctl))
>>>>>>>>>>>> +		panic("%s: failed to get reg base", node->name);
>>>>>>>>>>>> +
>>>>>>>>>>>> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
>>>>>>>>>>>> +	chip->ctl = ctl;
>>>>>>>>>>>> +	chip->base = base;
>>>>>>>>>>
>>>>>>>>>> As I said before, this assumes the outer DT node uses a ranges
>>>>>>>>>> property.  Normally reg properties work the same whether they specify an
>>>>>>>>>> offset within an outer "ranges" or have a full address directly.  It
>>>>>>>>>> would be easy enough to make this work with either, so I don't see any
>>>>>>>>>> reason not to.
>>>>>>>>>
>>>>>>>>> Yup, that is a good point. I guess Marc can address this in the next
>>>>>>>>> round, since we need a DT binding anyway.
>>>>>>>>
>>>>>>>> I'd suggest using of_address_to_resource() on both nodes and subtracting
>>>>>>>> the start addresses returned.
>>>>>>>
>>>>>>> For my own reference, Marc Zyngier suggested:
>>>>>>> "you should use of_iomap to map the child nodes, and not mess with
>>>>>>> the parent one."
>>>>>>
>>>>>> That's going to get very messy since the generic irqchip code needs all
>>>>>> the registers as offsets from a common base address.
>>>>>
>>>>> The two suggestions are over my head at the moment.
>>>>>
>>>>> Do you want to submit v4 and have Marc Z take a look?
>>>>
>>>> Done.  If this isn't acceptable either, I'm out of ideas that don't end
>>>> up being far uglier than anything suggested so far.
>>>
>>> With your latest patch, can I drop the ranges property?
>> 
>> Why would you want to do that?
>
> <confused> I thought that was the whole point of the v4 improvement?

The point was to make it work right *if* someone were to do that even
though having it there better reflects what the hardware actually looks
like.

-- 
M?ns Rullg?rd
