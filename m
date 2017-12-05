From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 5 Dec 2017 13:12:23 +0300
Subject: [PATCH 4/7 v2] net: ethernet: i825xx: Fix platform_get_irq's
 error checking
In-Reply-To: <20171204.132556.1601454745789376393.davem@davemloft.net>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1512409703-20881-5-git-send-email-arvind.yadav.cs@gmail.com>
 <20171204.132556.1601454745789376393.davem@davemloft.net>
Message-ID: <791fdb7d-e0ec-eefb-c703-205c039eddc3@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/4/2017 9:25 PM, David Miller wrote:

>> @@ -120,9 +120,10 @@ static int sni_82596_probe(struct platform_device *dev)
>>   	netdevice->dev_addr[5] = readb(eth_addr + 0x06);
>>   	iounmap(eth_addr);
>>   
>> -	if (!netdevice->irq) {
>> +	if (netdevice->irq <= 0) {
>>   		printk(KERN_ERR "%s: IRQ not found for i82596 at 0x%lx\n",
>>   			__FILE__, netdevice->base_addr);
>> +		retval = netdevice->irq ? netdevice->irq : -ENODEV;
>>   		goto probe_failed;
>>   	}
> 
> Ok, thinking about this some more...
> 
> It is impossible to use platform_get_irq() without every single call
> site having this funny:
> 
> 	ret = val ? val : -ENODEV;
> 
> sequence.
> 
> This is unnecessary duplication and it is also error prone, so I
> really think this logic belongs in platform_get_irq() itself.  It can
> convert '0' to -ENODEV and that way we need no special logic in the
> callers at all.

    Well, we can have:

	return r && r->start ? r->start : -ENXIO;

instead of:

	return r ? r->start : -ENXIO;

at the end of platform_get_irq(). But I don't really think it's worth doing -- 
request_irq() doesn't filter out IRQ0 anyway, IIRC...

MBR, Sergei
