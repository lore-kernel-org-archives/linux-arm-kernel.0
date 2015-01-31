From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jan 2015 00:22:53 +0000
Subject: Continuing kallsyms failures - large kernels, XIP kernels, and
 large XIP kernels
In-Reply-To: <alpine.LFD.2.11.1501301224180.1322@knanqh.ubzr>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
 <20150130153414.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501301224180.1322@knanqh.ubzr>
Message-ID: <20150131002253.GR26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 12:29:30PM -0500, Nicolas Pitre wrote:
> On Fri, 30 Jan 2015, Russell King - ARM Linux wrote:
> > +#ifdef CONFIG_XIP_KERNEL
> > +/*
> > + * __data_loc is not only the LMA of the data section, but also the VMA of
> > + * the end of the .rodata section.  This must not overlap the VMA of the
> > + * data section.  Since the .text section starts in module space, and that
> > + * is always below the .data section, this should be sufficient.
> > + */
> > +ASSERT((_data >= __data_loc), "Text section oversize")
> > +#endif
> 
> I agree with this patch.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> This might not prevent a config leading to this from happening, but at 
> least it makes the issue much clearer.  XIP kernel was created for 
> systems where the total amount of RAM is often smaller than the imposed
> size limit here.

Yes, I expect more of Arnd's randconfigs to fail with this patch applied.

I did also notice that we still have swapper_pg_dir at _data - 0x4000
for XIP kernels - so the above check is slightly too lenient.  A better
threshold for __data_loc might be MODULES_END, since we can't allow the
XIP part to overlap into RAM.

#ifdef CONFIG_HIGHMEM
#define MODULES_END             (PAGE_OFFSET - PMD_SIZE)
#else
#define MODULES_END             (PAGE_OFFSET)
#endif


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
