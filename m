From: opendmb@gmail.com (Doug Berger)
Date: Wed, 29 Mar 2017 10:39:11 -0700
Subject: [PATCH v2 7/8] bus: brcmstb_gisb: add notifier handling
In-Reply-To: <20170329101357.GB23442@leverpostej>
References: <20170328213431.10904-1-opendmb@gmail.com>
 <20170328213431.10904-8-opendmb@gmail.com>
 <20170329101357.GB23442@leverpostej>
Message-ID: <e6bb68fa-dd2f-7d18-6031-b709f8fd162e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2017 03:13 AM, Mark Rutland wrote:

snip

>> +/*
>> + * Dump out gisb errors on die or panic.
>> + */
>> +static int dump_gisb_error(struct notifier_block *self, unsigned long v,
>> +			   void *p)
>> +{
>> +	struct brcmstb_gisb_arb_device *gdev;
>> +
>> +	/* iterate over each GISB arb registered handlers */
>> +	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next)
>> +		brcmstb_gisb_arb_decode_addr(gdev, "async abort");
>> +
>> +	return 0;
> 
> I think this should be NOTIFY_OK.
> 
I used dump_mem_limit() as a template and didn't catch this (work to
do...).  Upon review I think I would prefer NOTIFY_DONE since this call
is opportunistic (i.e. it is taking the opportunity to check whether
additional diagnostic data is available to display) and has no interest
in affecting the overall handling of the event.

>> +}
>> +
>> +static struct notifier_block gisb_error_notifier = {
>> +	.notifier_call = dump_gisb_error,
>> +};
>> +
>>  static DEVICE_ATTR(gisb_arb_timeout, S_IWUSR | S_IRUGO,
>>  		gisb_arb_get_timeout, gisb_arb_set_timeout);
>>  
>> @@ -408,6 +429,12 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
>>  	board_be_handler = brcmstb_bus_error_handler;
>>  #endif
>>  
>> +	if (list_is_singular(&brcmstb_gisb_arb_device_list)) {
>> +		register_die_notifier(&gisb_error_notifier);
>> +		atomic_notifier_chain_register(&panic_notifier_list,
>> +					       &gisb_error_notifier);
> 
> I don't think this is quite right. A notifier_block can only be
> registered to one notifier chain at a time, and this has the potential
> to corrupt both chains.
> 
A VERY good point thanks for pointing this out.

> I also think you only need to register the panic notifier. An SError
> should always result in a panic.
> 
That was my initial thought as well.  However, testing revealed that the
bad mode Oops actually exits the user space process and doesn't reach
the panic so there was no helpful diagnostic message.  This may be in
line with your comments about insufficient fatality of failures in PATCH
v2 6/8, but it actually is more in line with our desired behavior for
the aborted write.  Setting the notify on die gave us the result we are
looking for, but as noted above I should have created a separate notifier.

I had hoped that the same approach (i.e. die notifier) would remove the
need for PATCH v2 6/8 as well, but I found that the Unhandled fault
error didn't actually die from user mode.

> Thanks,
> Mark.
> 
Thank you for your help with this,
    Doug
