From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 08 Jun 2010 09:21:25 +0300
Subject: pxa300 - DDRAM base value
In-Reply-To: <201006072143.16136.marek.vasut@gmail.com>
References: <1275371058.7001.35.camel@balakrishnan-desktop>	<1275892191.3501.17.camel@balakrishnan-desktop>	<AANLkTinKc9Uc6QeKYogK3h1kHsOU1p6Qp1kWgn0J8cMA@mail.gmail.com>
	<201006072143.16136.marek.vasut@gmail.com>
Message-ID: <4C0DE165.5010206@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut wrote:
> Dne Po 7. ?ervna 2010 21:37:16 Mike Rapoport napsal(a):
>>> hi,
>>>       Now, I can able to boot after editing following files
>>> arch/arm/mach-pxa/Makefile.boot and
>>> arch/arm/mach/pxa/include/mach/memory.h (0x80000000 changed to
>>> 0xa0000000). My doubt is
>>> 1.why 0x80000000 (DDR phy address) is aliased to 0xa0000000 in pxa
>>> architecture?
>>> 2.In my development board two DDRAMs mapped at 0x80000000-0x88000000 and
>>> 0xc0000000-0xc8000000, how can I inform to kernel about this different
>>> bank and size?.
>> enable CONFIG_HIGHMEM
> 
> Mike, that wont help him as he has PHYS_OFFSET=0xa0000000 . Selecting 
> CONFIG_HIGHMEM will only cause the pages for RAM below 0xa0000000 to have 
> incorrectly computated descriptor addresses (or maybe will be ignored).
> 
> The page descriptors for RAM at PA 0xa0000000 are at VA 0xc0000000 + some offset 
> (there's an easy linear formula to compute their offset). Now if you feed that 
> formula with 0x80000000, the page descriptors will end below 0xc0000000, which 
> isn't a valid VA, therefore the descriptors will not be valid either (in the 
> better case, but it will hang the kernel at early stage anyway).
> 
> Therefore there are two ways -- either use what I suggested earlier or wait 
> until the PHYS_OFFSET is dynamically computated (check Eric's patchset).

Not quite. I have it working with CONFIG_HIGHMEM, I've just forgotten 
about cm_x300_fixup:

static void __init cm_x300_fixup(struct machine_desc *mdesc, struct tag 
*tags,
                                  char **cmdline, struct meminfo *mi)
{
         /* Make sure that mi->bank[0].start = PHYS_ADDR */
         for (; tags->hdr.size; tags = tag_next(tags))
                 if (tags->hdr.tag == ATAG_MEM &&
                         tags->u.mem.start == 0x80000000) {
                         tags->u.mem.start = 0xa0000000;
                         break;
                 }
}


> Cheers
>>> My Boot loader details,
>>> ------------------------------
>>> =>bdi
>>> arch_number = 0x00000B04
>>> env_t       = 0x00000000
>>> boot_params = 0x80000100
>>> DRAM bank   = 0x00000000
>>> -> start    = 0x80000000
>>> -> size     = 0x08000000
>>> DRAM bank   = 0x00000001
>>> -> start    = 0xC0000000
>>> -> size     = 0x08000000
>>> ethaddr     = 08:00:3e:26:0a:5b
>>> ip_addr     = 192.168.0.21
>>> baudrate    = 115200 bps
>>> =>ver
>>> U-Boot 2010.03 (Jun 01 2010 - 14:27:43)
>>>
>>>
>>> With Thanks
>>> J.Balakrishnan
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Sincerely yours,
Mike.
