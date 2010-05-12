From: hancockrwd@gmail.com (Robert Hancock)
Date: Tue, 11 May 2010 20:41:29 -0600
Subject: [BUG] bug when enabling VM DEBUG
In-Reply-To: <AANLkTikoNc6oAY5JthYX1jWx1w2KeJ1fGab72Z-OvIVG@mail.gmail.com>
References: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com>
	<AANLkTikoNc6oAY5JthYX1jWx1w2KeJ1fGab72Z-OvIVG@mail.gmail.com>
Message-ID: <4BEA1559.9000107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2010 09:27 AM, saeed bishara wrote:
> Jeff,
> seems that the libata do pio to buffer which was allocated with
> kmalloc, and under arm arch, the flush_dcache_page() is needed to
> prevent cache aliasing, the later function calls the page_mapping
> which falls on PageSlab(page)
>
> as the flush_dcache_page() is needed to prevent aliasing, it can be
> skipped if the page is Slab as such pages are used only by the kernel.
> here a suggested patch:
>
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -894,7 +894,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>                                         do_write);
>          }
>
> -       if (!do_write)
> +       if (!do_write&&  !PageSlab(page))
>                  flush_dcache_page(page);
>
> saeed

I would think that check belongs inside flush_dcache_page itself, rather 
than forcing every driver to include it..
