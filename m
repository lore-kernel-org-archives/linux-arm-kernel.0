From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Apr 2015 11:33:09 +0200
Subject: [PATCH] nfs: do not export discarded symbols
In-Reply-To: <1426175918.15787.3.camel@primarydata.com>
References: <3173686.FPJdK9jLbA@wuerfel>
 <1426175918.15787.3.camel@primarydata.com>
Message-ID: <2350360.PssyUvDc2B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 March 2015 11:58:38 Trond Myklebust wrote:
> On Wed, 2015-03-11 at 14:37 +0100, Arnd Bergmann wrote:
> > The function nfs4_pnfs_v3_ds_connect_unload is exported so it can be
> > used by other modules, but is also marked '__exit' and will be
> > discarded when built into the kernel, as pointed out by this
> > linker error:
> > 
> > `nfs4_pnfs_v3_ds_connect_unload' referenced in section `___ksymtab_gpl+nfs4_pnfs_v3_ds_connect_unload' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o
> > 
> > This removes the __exit annotation to make it safe to call this function.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 5f01d9539496 ("nfs41: create NFSv3 DS connection if specified")
> > 
> > diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> > index 54e36b38fb5f..8582dae5ae99 100644
> > --- a/fs/nfs/pnfs_nfs.c
> > +++ b/fs/nfs/pnfs_nfs.c
> > @@ -561,7 +561,7 @@ static bool load_v3_ds_connect(void)
> >       return(get_v3_ds_connect != NULL);
> >  }
> >  
> > -void __exit nfs4_pnfs_v3_ds_connect_unload(void)
> > +void nfs4_pnfs_v3_ds_connect_unload(void)
> >  {
> >       if (get_v3_ds_connect) {
> >               symbol_put(nfs3_set_ds_client);
> > 
> 
> Thanks! Applied...
> 

I don't see the patch in linux-next, did something go wrong here?

	Arnd
