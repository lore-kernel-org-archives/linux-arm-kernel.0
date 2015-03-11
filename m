From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Mar 2015 18:41:54 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <55008BBD.5010800@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com>
 <55007ADD.6080505@list.ru>
 <20150311174618.GE8656@n2100.arm.linux.org.uk>
 <550081E2.5030807@list.ru>
 <20150311191118.1edb2ed8@free-electrons.com>
 <55008BBD.5010800@list.ru>
Message-ID: <20150311184154.GF8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 09:38:53PM +0300, Stas Sergeev wrote:
> 11.03.2015 21:11, Thomas Petazzoni ?????:
> > Dear Stas Sergeev,
> >
> > On Wed, 11 Mar 2015 20:56:50 +0300, Stas Sergeev wrote:
> >
> >> It doesn't look like it works as intended.
> >> Got the crash below.
> >> Please note the mappings beyond 0xe0000000, so I wonder if
> >> the option worked as expected?
> > Are you sure you're not confusing virtual addresses and physical
> > addresses?
> OK, so I changed Russel's printk to the following way:
> 
> +printk("vmalloc: mapping page %p (0x%08lx000) at 0x%08lx 0x%08zx\n",
> +    page, page_to_pfn(page), addr, __pa(addr));
> 
> (added __pa(addr)) and now I hope I am seeing the physical
> addresses at the last column:

No, you don't want to do that...

> [   19.023836] vmalloc: mapping page ef7f1fa0 (0x000bfc7d000) at
                                        |          `- physical address
					`-struct page address
> 0xf04a3000 0x304a3000
    `- virtual address

__pa() doesn't work on addresses in the vmalloc region.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
