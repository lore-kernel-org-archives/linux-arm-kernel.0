From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 20 Jan 2016 16:26:43 +0000
Subject: [RFC PATCH v3] irqchip: Add support for Tango interrupt controller
In-Reply-To: <569FB4AE.8000506@sigmadesigns.com> (Marc Gonzalez's message of
 "Wed, 20 Jan 2016 17:24:14 +0100")
References: <569CE0F2.1060507@sigmadesigns.com>
 <569D0B80.1010908@sigmadesigns.com>
 <569D165E.4060004@sigmadesigns.com> <569FAFF5.4090909@arm.com>
 <yw1xr3hcqlix.fsf@unicorn.mansr.com>
 <569FB4AE.8000506@sigmadesigns.com>
Message-ID: <yw1xio2oqksc.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> On 20/01/2016 17:10, M?ns Rullg?rd wrote:
>
>> Marc Zyngier wrote:
>> 
>>>> +	if (of_property_read_u32(node, "reg", &ctl))
>>>> +		panic("%s: failed to get reg base", node->name);
>>>> +
>>>> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
>>>> +	chip->ctl = ctl;
>>>> +	chip->base = base;
>> 
>> As I said before, this assumes the outer DT node uses a ranges
>> property.  Normally reg properties work the same whether they specify an
>> offset within an outer "ranges" or have a full address directly.  It
>> would be easy enough to make this work with either, so I don't see any
>> reason not to.
>
> IIRC, I was told very early in the review process that the ranges prop
> was mandatory. Lemme look for it... It was Arnd:
>
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/444131/focus=444207
>
>> You are missing a ranges property that describes what address
>> space these addresses are in.
>>
>> 'ranges;' would be wrong here, as the interrupt controller is
>> not a bus. If you have no ranges property, the bus is interpreted
>> as having its own address space with no relation to the parent bus
>> (e.g. an I2C bus uses addresses that are not memory mapped).
>> 
>> Just list the addresses that are actually decoded by child
>> devices here.
>
> Did I misunderstand?

It's still possible to create such a device tree, and that will fail in
very hard to debug ways.  Better to be a bit robust.

-- 
M?ns Rullg?rd
