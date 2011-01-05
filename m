From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 05 Jan 2011 16:39:47 +0100
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <1294241369.3014.15.camel@heimdal.trondhjem.org>
References: <20101230171453.GA5787@pengutronix.de>	
	<1293731992.4919.5.camel@heimdal.trondhjem.org>	
	<20101230191846.GB14221@pengutronix.de>	
	<20110103213850.GC25121@pengutronix.de>	
	<1294100558.25100.8.camel@heimdal.trondhjem.org>	
	<20110105084014.GN25121@pengutronix.de>	
	<20110105110517.GQ25121@pengutronix.de>	
	<20110105112701.GA8638@n2100.arm.linux.org.uk>	
	<20110105134045.GS25121@pengutronix.de>	
	<1294239193.3014.9.camel@heimdal.trondhjem.org>	
	<4D2487CA.5040501@pengutronix.de>	
	<1294240457.3014.13.camel@heimdal.trondhjem.org>
	<1294241369.3014.15.camel@heimdal.trondhjem.org>
Message-ID: <4D2490C3.4000407@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2011 04:29 PM, Trond Myklebust wrote:
> On Wed, 2011-01-05 at 10:14 -0500, Trond Myklebust wrote: 
>> OK. So,the new behaviour in 2.6.37 is that we're writing to a series of
>> pages via the usual kmap_atomic()/kunmap_atomic() and kmap()/kunmap()
>> interfaces, but we can end up reading them via a virtual address range
>> that gets set up via vm_map_ram() (that range gets set up before the
>> write occurs).
>>
>> Do we perhaps need an invalidate_kernel_vmap_range() before we can read
>> the data on ARM in this kind of scenario?
> 
> IOW: Does something like the following patch fix the problem?
> 
> ------------------------------------------------------------------------------- 
> From: Trond Myklebust <Trond.Myklebust@netapp.com>
> NFS: Ensure we clean the TLB cache in nfs_readdir_xdr_to_array
>     
> After calling nfs_readdir_xdr_filler(), we need a call to
> invalidate_kernel_vmap_range() before we can proceed to read
> the data back through the virtual address range.
>     
> Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> ---
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 996dd89..4640470 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -587,6 +587,9 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
>  		if (status < 0)
>  			break;
>  		pglen = status;
> +
> +		invalidate_kernel_vmap_range(pages_ptr, pglen);
> +
>  		status = nfs_readdir_page_filler(desc, &entry, pages_ptr, page, pglen);
>  		if (status < 0) {
>  			if (status == -ENOSPC)

\o/ - Works for me (at91, armv5)

Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

This is a candidate for stable (Cc'd).

Regards,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110105/2804eb32/attachment.sig>
