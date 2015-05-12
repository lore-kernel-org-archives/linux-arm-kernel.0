From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 12 May 2015 16:39:43 +0200
Subject: [PATCH v5 05/12] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <555128F0.30702@vanguardiasur.com.ar>
References: <1431356341-31640-1-git-send-email-antoine.tenart@free-electrons.com>
 <1431356341-31640-6-git-send-email-antoine.tenart@free-electrons.com>
 <555128F0.30702@vanguardiasur.com.ar>
Message-ID: <20150512143943.GC32171@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

On Mon, May 11, 2015 at 07:10:56PM -0300, Ezequiel Garcia wrote:
> 
> On 05/11/2015 11:58 AM, Antoine Tenart wrote:
> [..]
> > -
> > -	/* calculate flash information */
> > -	host->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
> > -
> 
> [..]
> > @@ -1732,6 +1669,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
> >  		host->mtd = mtd;
> >  		host->cs = cs;
> >  		host->info_data = info;
> > +		host->read_id_bytes = 4;
> 
> Are you sure this is correct? The value is set according to the page
> size before this patch.

Before reading the ID, the pxa3xx driver uses a default configuration,
builtin_flash_types[0], which defines a page size of 2048 leading to set
host->read_id_bytes to 4.

I'm using this default value here.

There might be an issue, as host->read_id_bytes isn't updated after
reading the ID (and getting the actual page size). I don't know if this
can be a problem. I can modify pxa3xx_nand_config_flash() to update
host->read_id_bytes if needed. What do you think?

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
