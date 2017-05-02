From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 2 May 2017 10:25:18 +0200
Subject: linux-next: build failure after merge of the drm-misc tree
In-Reply-To: <20170424112512.582d04da@canb.auug.org.au>
References: <20170421121014.3ee14a83@canb.auug.org.au>
 <20170424112512.582d04da@canb.auug.org.au>
Message-ID: <20170502082518.jdk5tqjhvlsqntny@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 11:25:12AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Fri, 21 Apr 2017 12:10:14 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the drm-misc tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > drivers/tee/tee_shm.c:87:2: error: unknown field 'kmap_atomic' specified in initializer
> >   .kmap_atomic = tee_shm_op_kmap_atomic,
> >   ^
> > drivers/tee/tee_shm.c:87:17: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >   .kmap_atomic = tee_shm_op_kmap_atomic,
> >                  ^
> > drivers/tee/tee_shm.c:87:17: note: (near initialization for 'tee_shm_dma_buf_ops.begin_cpu_access')
> > drivers/tee/tee_shm.c:88:2: error: unknown field 'kmap' specified in initializer
> >   .kmap = tee_shm_op_kmap,
> >   ^
> > drivers/tee/tee_shm.c:88:10: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >   .kmap = tee_shm_op_kmap,
> >           ^
> > drivers/tee/tee_shm.c:88:10: note: (near initialization for 'tee_shm_dma_buf_ops.end_cpu_access')
> > 
> > Caused by commit
> > 
> >   f9b67f0014cb ("dma-buf: Rename dma-ops to prevent conflict with kunmap_atomic macro")
> > 
> > interacting with commit
> > 
> >   967c9cca2cc5 ("tee: generic TEE subsystem")
> > 
> > from the arm-soc tree.
> > 
> > I applied the following merge fix patch for today:
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Fri, 21 Apr 2017 12:06:32 +1000
> > Subject: [PATCH] tee: merge fix for dma-ops field name changes
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/tee/tee_shm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 0be1e3e93bee..4e14c9c9cb1c 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -84,8 +84,8 @@ static struct dma_buf_ops tee_shm_dma_buf_ops = {
> >  	.map_dma_buf = tee_shm_op_map_dma_buf,
> >  	.unmap_dma_buf = tee_shm_op_unmap_dma_buf,
> >  	.release = tee_shm_op_release,
> > -	.kmap_atomic = tee_shm_op_kmap_atomic,
> > -	.kmap = tee_shm_op_kmap,
> > +	.map_atomic = tee_shm_op_kmap_atomic,
> > +	.map = tee_shm_op_kmap,
> >  	.mmap = tee_shm_op_mmap,
> >  };

Since this is an all-new driver it might be best to stagger the pull
requests and merge the new tee subsystem (or whatever it is) after drm?

Not sure what to best do here ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
