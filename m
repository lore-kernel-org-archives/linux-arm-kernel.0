From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 27 Oct 2013 15:18:17 +0100
Subject: ARM/kirkwood: v3.12-rc6: kernel BUG at mm/util.c:390!
In-Reply-To: <20131027135344.GD16735@n2100.arm.linux.org.uk>
References: <20131024200730.GB17447@blackmetal.musicnaut.iki.fi>
 <20131026143617.GA14034@mudshark.cambridge.arm.com>
 <20131027195115.208f40f3@tom-ThinkPad-T410>
 <20131027125036.GJ17447@blackmetal.musicnaut.iki.fi>
 <CACVXFVP2B3=82m_+DfA_oAEW86c=oxQ52G+yj5ncTU1DzP26Bw@mail.gmail.com>
 <20131027135344.GD16735@n2100.arm.linux.org.uk>
Message-ID: <20131027141817.GA13436@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sun, Oct 27, 2013 at 01:53:44PM +0000, Russell King - ARM Linux wrote:
> On Sun, Oct 27, 2013 at 09:16:53PM +0800, Ming Lei wrote:
> > On Sun, Oct 27, 2013 at 8:50 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > >
> So...
> 
> flush_kernel_dcache_page() is expected to take a struct page pointer.
> This struct page pointer is part of the kernel's array of struct pages
> which identifies every single physical page under the control of the
> kernel.
> 
> Arguably, it should not crash if passed a page which has been allocated
> to the slab cache; as this is not a page cache page,
> flush_kernel_dcache_page() should merely ignore the call to it and
> simply return on these.  So this makes total sense:

In this respect, flush_kernel_dcache_page() is following
flush_dcache_page(). For example in crypto/scatterwalk.c:

static void scatterwalk_pagedone(struct scatter_walk *walk, int out,
                                 unsigned int more)
{
        if (out) {
                struct page *page;

                page = sg_page(walk->sg) + ((walk->offset - 1) >>
PAGE_SHIFT);
                if (!PageSlab(page))
                        flush_dcache_page(page);
        }
... 


or in drivers/ata/libata-sff.c:

...
        if (!do_write && !PageSlab(page))
                flush_dcache_page(page);
...


(Probably, both cases should have used
flush_kernel_dcache_page() in the first place). If we say that this
check belongs in flush_kernel_dcache_page() we should also put it
into flush_dcache_page(), no?

- Simon
