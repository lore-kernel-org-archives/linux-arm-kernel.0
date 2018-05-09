From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Wed, 9 May 2018 09:32:27 -0500
Subject: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A69EF9AF9@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A69EECF90@G01JPEXMBKW03>
 <ce2c6191-1f74-4cec-9009-0a770d32673a@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69EF9AF9@G01JPEXMBKW03>
Message-ID: <78df845d-0788-3cbd-e435-5a3a8221fdc8@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2018 02:53 AM, Zhang, Lei wrote:
> Hi Marc
> 
> thanks for your opinions.
> 
>> How many is many? Are they PCI? Or something else?
>   
>> As it is, this patch will break Multi-MSI and some other platforms that
>> do require a higher allocation granule.
>>
>> Depending on whether you're using PCI or some other bus, we can probably
>> come up with a solution that works for everyone. But I need more
>> information on this.
> 
> Actually it is our original interconnect device not on PCI but on our original bus.
> This device has many sub devices around one thousand, and each sub device requires only a few LPIs.
> 
> As I explained in point1, each Device ID can still allocate enough LPIs more than IRQS_PER_CHUNK by increasing chunks.
> So I couldn't understand why this patch will break Multi-MSI.
> 
> By the way, 32 seems a good default value for IRQS_PER_CHUNK.
> So, I want to write another patch to make IRQ_PER_CHUNK a variable which can be changed by kernel parameter.
> What do you think of this idea?

If you intend your devices to be supported by server distributions,  
instead of embedded kernels, having IRQ_PER_CHUNK as a kernel parameter  
is not a good idea. The server distributions are going to compile, test,  
and support a single kernel for all server systems, and are not going to  
have a special kernel to support one vendor's systems that has a  
different IRQ_PER_CHUNK parameter.

So even if you wrote that patch and it was accepted into the kernel, the  
server distribution kernels are still going to set IRQ_PER_CHUNK to 32.

Marc's suggestion of implementing a glue layer, and then changing the  
glue layer interface to pass the allocation requirements up to this  
driver is the best solution that can be supported for server products.

--Mark Langsdorf
