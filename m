From: trond.myklebust@primarydata.com (Trond Myklebust)
Date: Thu, 12 Mar 2015 11:58:38 -0400
Subject: [PATCH] nfs: do not export discarded symbols
In-Reply-To: <3173686.FPJdK9jLbA@wuerfel>
References: <3173686.FPJdK9jLbA@wuerfel>
Message-ID: <1426175918.15787.3.camel@primarydata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-03-11 at 14:37 +0100, Arnd Bergmann wrote:
> The function nfs4_pnfs_v3_ds_connect_unload is exported so it can be
> used by other modules, but is also marked '__exit' and will be
> discarded when built into the kernel, as pointed out by this
> linker error:
> 
> `nfs4_pnfs_v3_ds_connect_unload' referenced in section `___ksymtab_gpl+nfs4_pnfs_v3_ds_connect_unload' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o
> 
> This removes the __exit annotation to make it safe to call this function.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5f01d9539496 ("nfs41: create NFSv3 DS connection if specified")
> 
> diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> index 54e36b38fb5f..8582dae5ae99 100644
> --- a/fs/nfs/pnfs_nfs.c
> +++ b/fs/nfs/pnfs_nfs.c
> @@ -561,7 +561,7 @@ static bool load_v3_ds_connect(void)
>  	return(get_v3_ds_connect != NULL);
>  }
>  
> -void __exit nfs4_pnfs_v3_ds_connect_unload(void)
> +void nfs4_pnfs_v3_ds_connect_unload(void)
>  {
>  	if (get_v3_ds_connect) {
>  		symbol_put(nfs3_set_ds_client);
> 

Thanks! Applied...
-- 
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust at primarydata.com
