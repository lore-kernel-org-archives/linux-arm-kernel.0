From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Dec 2014 11:23:11 +0000
Subject: [PATCH 03/18] arm64/uaccess: fix sparse errors
In-Reply-To: <20141215111716.GG20738@arm.com>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
 <1418575877-21488-4-git-send-email-mst@redhat.com>
 <20141215111716.GG20738@arm.com>
Message-ID: <20141215112310.GG11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 11:17:16AM +0000, Will Deacon wrote:
> On Sun, Dec 14, 2014 at 04:52:09PM +0000, Michael S. Tsirkin wrote:
> > virtio wants to read bitwise types from userspace using get_user.  At the
> > moment this triggers sparse errors, since the value is passed through an
> > integer.
> > 
> > Fix that up using __force.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/arm64/include/asm/uaccess.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 3bf8f4e..8d66bcf 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -147,7 +147,7 @@ do {									\
> >  	default:							\
> >  		BUILD_BUG();						\
> >  	}								\
> > -	(x) = (__typeof__(*(ptr)))__gu_val;				\
> > +	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
> >  } while (0)
> >  
> >  #define __get_user(x, ptr)						\
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

This also means you can do stuff like:

	u32 *p;
	__le32 v;

	err = get_user(p, v);

which is not right.  Both the dereferenced pointer type and the destination
type should be compatible, and if one is a bitwise type but the other isn't,
that seems like a valid case to warn.

I don't see any use of get_user() in drivers/virtio in mainline, so I can't
check further.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
