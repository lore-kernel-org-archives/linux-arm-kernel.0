From: filip.zyzniewski@gmail.com (Filip Zyzniewski)
Date: Sat, 26 Dec 2009 15:18:31 +0100
Subject: DMA/cache problems on SA1110/SA1111 (Was: Re: USB Host on a
	SA1111)
In-Reply-To: <20091222165904.GE17191@n2100.arm.linux.org.uk>
References: <de2dcbb80912220833mdc1788cq6f60dd5522e7ab0@mail.gmail.com>
	<20091222165904.GE17191@n2100.arm.linux.org.uk>
Message-ID: <de2dcbb80912260618w3d3978c9pc8362ce9f2458459@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 5:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Make sure that the DMA mask is correctly set - SA1111's have a bug in them
> which means that certain address bits must have a certain value for all
> DMA activities.

I know this bug from SA1111 errata. I know that sound DMA is ok on 2.4
kernels on the Jornada 720s, so I am trying to find what they were
doing to have it working.

There is a function in 2.6 (arch/arm/common/sa1111.c):
int dma_needs_bounce(struct device *dev, dma_addr_t addr, size_t size)
{
        return ((machine_is_assabet() || machine_is_pfs168()) &&
                (addr >= 0xc8000000 || (addr + size) >= 0xc8000000));
}

in 2.4.36.7 patched with Michael Gernoth's Jornada 720 support patch
(http://wwwcip.informatik.uni-erlangen.de/~simigern/jornada-7xx/linux-2.4.36.7-j720-1/patch-2.4.36.7-j720-1.bz2)
it looks like this (arch/arm/mach-sa1100/dma-sa1111.c):

int sa1111_check_dma_bug(dma_addr_t addr){
        unsigned int physaddr=SA1111_DMA_ADDR((unsigned int)addr);

        if((machine_is_assabet() || machine_is_pfs168() ||
            machine_is_graphicsmaster() || machine_is_adsagc()) &&
addr >= 0xc8000000)
                return -1;

        switch(FExtr(SBI_SMCR, SMCR_DRAC)){
        case 01: /* 10 row + bank address bits, A<20> must not be set */
                if(physaddr & (1<<20))
                        return -1;
                break;
        case 02: /* 11 row + bank address bits, A<23> must not be set */
                if(physaddr & (1<<23))
                        return -1;
                break;
        case 03: /* 12 row + bank address bits, A<24> must not be set */
                if(physaddr & (1<<24))
                        return -1;
                break;
        case 04: /* 13 row + bank address bits, A<25> must not be set */
                if(physaddr & (1<<25))
                        return -1;
                break;
        case 05: /* 14 row + bank address bits, A<20> must not be set */
                if(physaddr & (1<<20))
                        return -1;
                break;
        case 06: /* 15 row + bank address bits, A<20> must not be set */
                if(physaddr & (1<<20))
                        return -1;
                break;
[...]

Should I try to port the remaining part of the 2.4 function to the 2.6 one?

As I've written before it seems that USB device interaction goes
further with d-cache disabled, although the kernel tends to freeze
very much then.
I would like to try something in the meantime (while working on the
DMA bug) - flush caches in _ohci_readl (before return readl (regs))
and in _ohci_writel (after writel (val, regs)) defined in
drivers/usb/host/ohci.h. I hope that flushing d-cache will allow me to
check whether register access is problematic and avoid kernel lockup.
I don't know how to flush it correctly though. Should I use a function
from arch/arm/mm/flush.c? void flush_dcache_page(struct page *page)
maybe? How should I translate address passed to ohci_readl/ohci_writel
to struct page?

Thanks for help :).

regards,
Filip Zyzniewski
