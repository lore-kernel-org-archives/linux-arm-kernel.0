From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 15 Dec 2014 13:29:32 +0200
Subject: [PATCH 03/18] arm64/uaccess: fix sparse errors
In-Reply-To: <20141215112310.GG11285@n2100.arm.linux.org.uk>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
 <1418575877-21488-4-git-send-email-mst@redhat.com>
 <20141215111716.GG20738@arm.com>
 <20141215112310.GG11285@n2100.arm.linux.org.uk>
Message-ID: <20141215112932.GA27136@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 11:23:11AM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 15, 2014 at 11:17:16AM +0000, Will Deacon wrote:
> > On Sun, Dec 14, 2014 at 04:52:09PM +0000, Michael S. Tsirkin wrote:
> > > virtio wants to read bitwise types from userspace using get_user.  At the
> > > moment this triggers sparse errors, since the value is passed through an
> > > integer.
> > > 
> > > Fix that up using __force.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  arch/arm64/include/asm/uaccess.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > > index 3bf8f4e..8d66bcf 100644
> > > --- a/arch/arm64/include/asm/uaccess.h
> > > +++ b/arch/arm64/include/asm/uaccess.h
> > > @@ -147,7 +147,7 @@ do {									\
> > >  	default:							\
> > >  		BUILD_BUG();						\
> > >  	}								\
> > > -	(x) = (__typeof__(*(ptr)))__gu_val;				\
> > > +	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
> > >  } while (0)
> > >  
> > >  #define __get_user(x, ptr)						\
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> This also means you can do stuff like:
> 
> 	u32 *p;
> 	__le32 v;
> 
> 	err = get_user(p, v);
> 
> which is not right.

Are you sure?  We are casting to __typeof__(*(ptr))),
then assigning to x. So if *p and v are different sparse will
still warn.

>  Both the dereferenced pointer type and the destination
> type should be compatible, and if one is a bitwise type but the other isn't,
> that seems like a valid case to warn.
> 
> I don't see any use of get_user() in drivers/virtio in mainline, so I can't
> check further.



It's not in drivers/virtio.
We have a work around upstream (uses __get_user + access_ok).
Try this patch reverting the work-around, you will see the sparse
warning:

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ed71b53..4c83be8 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1047,9 +1047,7 @@ int vhost_init_used(struct vhost_virtqueue *vq)
 	if (r)
 		return r;
 	vq->signalled_used_valid = false;
-	if (!access_ok(VERIFY_READ, &vq->used->idx, sizeof vq->used->idx))
-		return -EFAULT;
-	r = __get_user(last_used_idx, &vq->used->idx);
+	r = get_user(last_used_idx, &vq->used->idx);
 	if (r)
 		return r;
 	vq->last_used_idx = vhost16_to_cpu(vq, last_used_idx);

> -- 
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
