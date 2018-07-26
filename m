From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jul 2018 15:02:31 +0100
Subject: [PATCH 2/6] ARM: vfp: use __copy_from_user() when restoring VFP
 state
In-Reply-To: <20180726123244.x7klflacdykdtjbj@lakrids.cambridge.arm.com>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctOq-0005us-Ar@rmk-PC.armlinux.org.uk>
 <20180726123244.x7klflacdykdtjbj@lakrids.cambridge.arm.com>
Message-ID: <20180726140231.GA17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:32:44PM +0100, Mark Rutland wrote:
> On Tue, Jul 10, 2018 at 03:13:52PM +0100, Russell King wrote:
> > Use __copy_from_user() rather than __get_user_err() for individual
> > members when restoring VFP state.
> 
> Same comment as for patch 1: I assume this is to amortize the cost of
> the __user pointer santiziation, and if so it'd be good to mention that
> in the commit message.

It's also to do with the software PAN stuff as well.

> 
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  arch/arm/include/asm/thread_info.h |  2 +-
> >  arch/arm/kernel/signal.c           | 20 ++++++++------------
> >  arch/arm/vfp/vfpmodule.c           | 16 +++++++---------
> >  3 files changed, 16 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> > index e71cc35de163..341f6eb9b8be 100644
> > --- a/arch/arm/include/asm/thread_info.h
> > +++ b/arch/arm/include/asm/thread_info.h
> > @@ -123,7 +123,7 @@ struct user_vfp_exc;
> >  
> >  extern int vfp_preserve_user_clear_hwstate(struct user_vfp __user *,
> >  					   struct user_vfp_exc __user *);
> > -extern int vfp_restore_user_hwstate(struct user_vfp __user *,
> > +extern int vfp_restore_user_hwstate(struct user_vfp *,
> >  				    struct user_vfp_exc __user *);
> >  #endif
> >  
> > diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> > index 0ae74207e43e..db62c51250ad 100644
> > --- a/arch/arm/kernel/signal.c
> > +++ b/arch/arm/kernel/signal.c
> > @@ -150,22 +150,18 @@ static int preserve_vfp_context(struct vfp_sigframe __user *frame)
> >  
> >  static int restore_vfp_context(char __user **auxp)
> >  {
> > -	struct vfp_sigframe __user *frame =
> > -		(struct vfp_sigframe __user *)*auxp;
> > -	unsigned long magic;
> > -	unsigned long size;
> > -	int err = 0;
> > -
> > -	__get_user_error(magic, &frame->magic, err);
> > -	__get_user_error(size, &frame->size, err);
> > +	struct vfp_sigframe frame;
> > +	int err;
> >  
> > +	err = __copy_from_user(&frame, *auxp, sizeof(frame));
> >  	if (err)
> > -		return -EFAULT;
> > -	if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
> > +		return err;
> > +
> > +	if (frame.magic != VFP_MAGIC || frame.size != VFP_STORAGE_SIZE)
> >  		return -EINVAL;
> 
> I think that in a few cases, trying to load the whole vfp_sigframe size
> first means that we can now fault and return -EFAULT when previously
> we'd have returned -EINVAL.
> 
> However, as the return value is only consumed as a boolean by all
> callers, I think that's ok. Might be worth calling that out in the
> commit message.

The signal stack is created by the kernel in a certain format - the
tagged nature of it is to deal with all the combinations of different
hardwares that we have, so that userspace can parse the stack
irrespective of the configuration of the kernel or hardwares present.

The layout is ultimately defined by struct aux_sigframe, and the
entire frame as defined by that structure must be present and valid
when restoring.

Hence, if we expect there to be a VFP structure present, then it
quite simply must be present.

Since this is one of the basics of the signal handling code, it
doesn't warrant commenting in the commit message.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
