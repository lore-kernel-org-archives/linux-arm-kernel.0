From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Jun 2010 22:33:32 +0800
Subject: Platform data with function pointers
In-Reply-To: <-8400781325900388878@unknownmsgid>
References: <-71663801230973480@unknownmsgid>
	<AANLkTikqONUs722_ev6hqfpJiehUq2qAGWGhmxg6WkTs@mail.gmail.com>
	<20100618131301.GA21333@n2100.arm.linux.org.uk>
	<-8400781325900388878@unknownmsgid>
Message-ID: <AANLkTik4B8yyxWDbN4J7aWXb7v3HGkAabaRdyIAzmnGC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 10:25 PM, Lorenzo Pieralisi
<Lorenzo.Pieralisi@arm.com> wrote:
> Concerning platform_devices ids, sorry I wasn't meant to report an amba primecell binding snippet, I wanted to report here just a
> binding for a simple memory mapped platform device (not a primecell one). I was asking that question about platform_device
> statically defined structs that use the id for enumeration, and going with FDT the id has to be initialized somehow from the tree
> because the struct is allocated dynamically.
>
> Wrt map_desc point taken, I was looking into possible ways of getting rid of platform specific statically defined data, that array
> in particular.
>

That's actually quite challenging. And as DT is used to 'describe' the hardware
as is, instead of directing the software how to do a mapping, I doubt
this should
be done with DT.

> Thanks a lot for your feedback,
>
> Lorenzo
>
> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, June 18, 2010 2:13 PM
> To: Lorenzo Pieralisi
> Cc: 'Grant Likely'; devicetree-discuss; linux-arm-kernel at lists.infradead.org; Jeremy Kerr; Nicolas Pitre
> Subject: Re: Platform data with function pointers
>
> On Fri, Jun 18, 2010 at 01:47:28PM +0100, Lorenzo Pieralisi wrote:
>> I think chip-select addressing should be used if that is the way HW handles it. If the device is described through a
> memory-mapping,
>> ex. snippet follows:
>>
>> serial at 101f2000 {
>> ? ? ? ? compatible = "arm,pl011";
>> ? ? ? ? reg = <0x101f2000 0x1000 >;
>> };
>
> Primecell devices aren't platform devices. ?They have no 'id' field as
> such. ?Instead, modern implementations have PCI-like IDs.
>
>> struct map_desc {
>> ? ? ? unsigned long virtual;
>> ? ? ? unsigned long pfn;
>> ? ? ? unsigned long length;
>> ? ? ? unsigned int type;
>> };
>>
>> static struct map_desc realview_eb_io_desc[] __initdata = {
>> ? ? ? {
>> ? ? ? ? ? ? ? .virtual ? ? ? ?= IO_ADDRESS(REALVIEW_SYS_BASE),
>> ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(REALVIEW_SYS_BASE),
>> ? ? ? ? ? ? ? .length ? ? ? ? = SZ_4K,
>> ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> ? ? ? }, ...
>
> These mappings are entirely arbitary, and change according to the
> implementation of the platform.
>
> Some platforms want to avoid using ioremap() to create 4K page mappings
> for their devices, so instead they statically map them and arrange for
> ioremap() to know about that static mapping.
>
> Given that PAGE_OFFSET can be changed, it would be absolutely silly to
> put this into the device tree.
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
