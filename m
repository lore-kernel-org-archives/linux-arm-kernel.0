From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 20 May 2012 16:28:08 +0530
Subject: [PATCH v3 1/7] ARM: davinci, intc: Add OF support for TI interrupt
 controller
In-Reply-To: <20120519061628.663F53E046E@localhost>
References: <1330945804-3379-1-git-send-email-hs@denx.de>
 <1330945804-3379-2-git-send-email-hs@denx.de>
 <20120519061628.663F53E046E@localhost>
Message-ID: <4FB8CE40.4030404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/19/2012 11:46 AM, Grant Likely wrote:
> On Mon,  5 Mar 2012 12:09:58 +0100, Heiko Schocher <hs@denx.de> wrote:
>> Add a function to initialize the Common Platform Interrupt Controller
>> (cp_intc) from TI used on OMAP-L1x SoCs using a device tree node.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Wolfgang Denk <wd@denx.de>
>> Cc: Sergei Shtylyov <sshtylyov@mvista.com>
>>
>> ---

>> @@ -165,13 +197,48 @@ void __init cp_intc_init(void)
>>  		for (i = 0; host_map[i] != -1; i++)
>>  			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
>>  
>> -	/* Set up genirq dispatching for cp_intc */
>> -	for (i = 0; i < num_irq; i++) {
>> -		irq_set_chip(i, &cp_intc_irq_chip);
>> -		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
>> -		irq_set_handler(i, handle_edge_irq);
>> +	if (node) {
>> +		irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
>> +		if (irq_base < 0) {
>> +			pr_warn("Couldn't allocate IRQ numbers\n");
>> +			irq_base = 0;
>> +		}
>> +
>> +		/* create a legacy host */
>> +		cp_intc_domain = irq_domain_add_legacy(node, num_irq,
>> +					irq_base, 0, &cp_intc_host_ops, NULL);
>> +		if (cp_intc_domain == NULL) {
>> +			pr_err("CP INTC: failed to allocate irq host!\n");
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		/* Set up genirq dispatching for cp_intc */
>> +		for (i = 0; i < num_irq; i++) {
>> +			irq_set_chip(i, &cp_intc_irq_chip);
>> +			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
>> +			irq_set_handler(i, handle_edge_irq);
>> +		}
> 
> No need for the if/else clause here.  irq_domain should be used for
> both DT and non-DT.  It makes the code a lot simpler that way.  The
> only difference I would suggest is to call irq_domain_add_linear() in
> the DT case instead of irq_domain_add_legacy()...  and this is
> temporary too until I fix up the irq_domain code to better handle both
> static and dynamic mapping.

It will also help to do the irq_domain conversion in a separate patch.
That way irq_domain conversion can be reviewed separately from DT
conversion.

Thanks,
Sekhar
