From: dpoole@marvell.com (David Poole)
Date: Thu, 10 Jul 2014 07:10:52 -0700
Subject: iotable_init() with device at 0xfffff000 
Message-ID: <2FFEEF382AE80F408D11318E2F2EB199397FA8A51C@sc-vexch3.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

I'm porting a working kernel 3.2 to 3.14 on a Marvell PJ4 (ARMv7) based SOC.  Have run into a problem with iotable_init().

We have a VIC at 0xfffff000 (last 32-bit addressible 4096).

static struct map_desc gogin_io_desc[] __initdata = {
   { MV31X0_VIC_VIRT_BASE, __phys_to_pfn(MV31X0_VIC_PHYS_BASE), SZ_4K, MT_DEVICE},
   ...
};

Newer kernels' iotable_init() have new calls that the 3.2 series didn't have:

add_static_vm_early() -> vm_area_add_early()

The vm_area_add_early() adds the vm area to global 'vmlist'.  The vmlist is traversed in vmalloc_init() and the entries are passed to __insert_vmap_area() which adds the entry to a red/black tree.  The red/black tree add is hitting a BUG().

        if (va->va_start < tmp_va->va_end)
            p = &(*p)->rb_left;
        else if (va->va_end > tmp_va->va_start)
            p = &(*p)->rb_right;
        else
            BUG();

For me, the 0xfffff000 is wrapping around to va_end==0. The tree add logic in __insert_vmap_area() is failing (BUG()).

vmalloc_init() sets va_start and va_end
        va->va_start = (unsigned long)tmp->addr;
        va->va_end = va->va_start + tmp->size;

va_start==0xfffff000 tmp->size=0x1000 => va_end=0

I tried shrinking the area to SZ_1K or less (there are only a few registers in the VIC) but iotable_init() aligns everything up to page size (4k).

Is there any way to use iotable_init() with addresses that wrap around like this? Or should I punt and move this to the devicetree?

If I comment out this entry, iotable_init() succeeds but I die later:
Unable to handle kernel paging request at virtual address ffffffe0
PC is at __vic_init+0x3c/0x128
LR is at vic_init+0x1c/0x24

Thanks!

David Poole
