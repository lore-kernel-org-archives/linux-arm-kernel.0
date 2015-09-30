From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 30 Sep 2015 18:18:41 +0100
Subject: [PATCH 1/4] of: Add of_parse_phandle_with_opt_args() helper
 function
In-Reply-To: <560C0232.2010100@arm.com>
References: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
 <1442944336-11754-2-git-send-email-marc.zyngier@arm.com>
 <560C0232.2010100@arm.com>
Message-ID: <560C1971.9030001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/15 16:39, Robin Murphy wrote:
> Hi Marc,
> 
> On 22/09/15 18:52, Marc Zyngier wrote:
>> of_parse_phandle_with_args() is slightly inflexible as it doesn't
>> allow the (unusual) case where the #*-cells property is not defined.
>> In order to support this, introduce of_parse_phandle_with_opt_args()
>> which assumes that #*-cells is zero when it is not defined,
>> as required by the msi-parent binding
>>
>> This is done by turning __of_parse_phandle_with_args into an even
>> bigger monster, which is a bit frightening.
> 
> A monster indeed; I can't quite figure out the exact effect this change 
> has on of_count_phandle_with_args(), but I have a lingering doubt it may 
> be something undesirable, since AFAICS that's now going to proceed from 
> where it would have errored out before, with a count of -2.
> 
> I think it might be nicer to implement this by passing an extra "assume 
> zero if #cells not found" boolean to __of_parse_phandle_with_args().
> 
> Alternatively, what's the actual likelihood of legacy bindings being 
> mixed in with new ones? Could we not simply mandate that anyone adding 
> an MSI controller with #msi-cells to a DT must ensure any existing nodes 
> are also updated with #msi-cells = 0, and keep the legacy workaround 
> self-contained in the MSI layer? e.g. paraphrasing from patch 2/2:
> 
> msi_np = of_parse_phandle(np, "msi-parent", 0);
> if (!of_property_read_bool(msi_np, "#msi-cells"))
> 	return parse_this_thing(...);
> else
> 	while (!of_parse_phandle_with_opt_args(np, "msi-parent"...
> 		if (parse_this_thing(...))
> 			return;

Having tried this, it doesn't look too bad. Specially turned into some
kind of library function. that can be shared between platform and PCI.

So I'll drop this patch altogether and repost an updated series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
