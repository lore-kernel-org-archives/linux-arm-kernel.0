From: monstr@monstr.eu (Michal Simek)
Date: Thu, 26 Jan 2012 11:44:46 +0100
Subject: remoteproc: Load coprocessor code to the specific main memory
 location
In-Reply-To: <CAK=WgbZDADRf1OF=uWbbsF+t2dx36tqj=kRftn5nd4RA7DtEnA@mail.gmail.com>
References: <4F1EE861.4030405@monstr.eu>
 <CAK=Wgba5kT8AwLtuHyosucYnWf-EA+xpE1kzmssfhSC7ZXQA=g@mail.gmail.com>
 <4F1FF870.3000105@monstr.eu>
 <CAK=WgbZwaxMPsMiNcq5yFvBLrcODqGgDT6b=mmQ91JBVtTEyXA@mail.gmail.com>
 <4F200F64.9060203@monstr.eu>
 <CAK=WgbZDADRf1OF=uWbbsF+t2dx36tqj=kRftn5nd4RA7DtEnA@mail.gmail.com>
Message-ID: <4F212E9E.9060807@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ohad Ben-Cohen wrote:
> On Wed, Jan 25, 2012 at 4:19 PM, Michal Simek <monstr@monstr.eu> wrote:
>> I started with pur vanilla kernel and patches from your tree
>> git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
>> for-next branch
>> but then I had to moved to for-next-acked-merged because in the origin
>> one were some problems.
> 
> Unlike for-next-acked-merged, the other branches aren't rebased and
> therefore have merge conflicts with 3.3 material; that's intentional.
> 
>> Do you have any kernel tree with CMA just for sure?
> 
> Not a 3.3-based one, so I recommend you to just merge Marek's branch directly.
> 
> I'll soon create a full-fledged 3.3 branch though, so you may want to
> wait a bit until I get to it.

I have done it and tested. It works as expected. Thanks.
I have created region at phys addr 0x10000000 with selected size.
I had to move carveout in resource table to be first in this area.
Also removed that copying from kick function.



I have one small problem which is that physical address is 0x10000000
which means that firmware entry point is the same.
In rproc_load_segments is da composed from phdr->p_paddr which is 0x10000000.
And code is designed that this load addr is offset.

Here is the code:
	/* go through the available ELF segments */
	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
		u32 da = phdr->p_paddr; // OFFSET 0x10000000
		u32 memsz = phdr->p_memsz;

But for my case is physical address correct and it is not offset 0x10000000.
I have created temporary fix which substract virtual address to get correct da.

u32 da = phdr->p_paddr - phdr->p_vaddr;

What should be correct solution?

> 
>> What do you use for firmware replacing?
>> Just remove kernel module and load different one?
> 
> If your driver boots the remote core on its ->probe() handler, then
> yes, you need to unbind and bind the device.
> 
> One way is to unload and load the driver, but you can also use the
> bind/unbind sysfs files of your driver (echo -n device-name >
> /sys/..../{un}bind).

ok. It also works.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
