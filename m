From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 17 Feb 2017 18:45:19 +0100
Subject: [PATCH v2 4/6] spi: davinci: flush caches when performing DMA
In-Reply-To: <20170217120749.GF21222@n2100.armlinux.org.uk>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-5-git-send-email-fisaksen@baylibre.com>
 <5fab0c33-6e1d-c63a-8758-6672236045a7@ti.com>
 <20170217112247.GE21222@n2100.armlinux.org.uk>
 <eaf93c6c-52a7-826b-9c53-2b13c0b280ca@baylibre.com>
 <20170217120749.GF21222@n2100.armlinux.org.uk>
Message-ID: <d7a6d1a1-5860-8788-be2e-7b68cebfaca0@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/02/2017 13:07, Russell King - ARM Linux wrote:
> On Fri, Feb 17, 2017 at 12:36:17PM +0100, Frode Isaksen wrote:
>> On 17/02/2017 12:22, Russell King - ARM Linux wrote:
>>> The DMA API deals with the _kernel_ lowmem mapping.  It has no knowledge
>>> of any other aliases in the system.  When you have a VIVT cache (as all
>>> old ARM CPUs have) then if you access the memory through a different
>>> alias from the kernel lowmem mapping (iow, vmalloc) then the DMA API
>>> can't help you.
>>>
>>> However, the correct place to use flush_kernel_vmap_range() etc is not
>>> in drivers - it's supposed to be done in the callers that know that
>>> the memory is aliased.
>> OK, so this should be done in the ubifs layer instead ? xfs already does
>> this, but no other fs.
> These APIs were created when XFS was being used on older ARMs and people
> experienced corruption.  XFS was the only filesystem driver which wanted
> to do this (horrid, imho) DMA to memory that it accessed via a vmalloc
> area mapping.
>
> If ubifs is also doing this, it's followed XFS down the same route, but
> ignored the need for additional flushing.
>
> The down-side to adding this at the filesystem layer is that you get the
> impact whether or not the driver does DMA.  However, for XFS that's
> absolutely necessary, as block devices will transfer to the kernel lowmem
> mapping, which itself will alias with the vmalloc area mapping.
>
> SPI is rather another special case - rather than SPI following the
> established mechanism of passing data references via scatterlists or
> similar, it also passes them via virtual addresses, which means SPI
> can directly access the vmalloc area when performing PIO.  This
> really makes the problem more complex, because it means that if you
> do have a SPI driver that does that, it's going to be reading/writing
> direct from vmalloc space.
>
> That's not a problem as long as the data is only accessed via vmalloc
> space, but it will definitely go totally wrong if the data is
> subsequently mapped into userspace.
Thanks a lot for explaining...
It often(2/5) goes wrong within this simple function called when mounting the UBIFS filesystem w/o a priori any userspace interaction:
fs/ubifs/lpt.c:
static int read_ltab(struct ubifs_info *c)
{
    int err;
    void *buf;
    int retry=1;

    buf = vmalloc(c->ltab_sz);
    if (!buf)
        return -ENOMEM;
    err = ubifs_leb_read(c, c->ltab_lnum, buf, c->ltab_offs, c->ltab_sz, 1);
    if (err)
        goto out;
retry:
    err = unpack_ltab(c, buf);
    if (err && retry--) {
        pr_err("%s: flush cache %p[%d] and retry\n", __func__, buf, c->ltab_sz);
        invalidate_kernel_vmap_range(buf, c->ltab_sz);
        goto retry;
    }
out:
    vfree(buf);
    return err;
}
The retry code is added by me and with this code there is no error when retrying after flushing the cache. As you can see, the vmalloc'es buffer is allocated and freed within this function.
read_ltab: flush cache c9543000[11] and retry
Ok after this !!

Thanks again,
Frode
>
> The other important thing to realise is that the interfaces in
> cachetlb.txt assume that it's the lowmem mapping that will be accessed,
> and the IO device will push that data out to physical memory (either via
> the DMA API, or flush_kernel_dcache_page()).  That's not true of SPI,
> as it passes virtual addresses around.
>
> So... overall, I'm not sure that this problem is properly solvable given
> SPIs insistance on passing virtual addresses and the differences in this
> area between SPI and block.
>
> What I'm quite sure about is that adding yet more cache flushing
> interfaces for legacy cache types really isn't the way forward.
>
