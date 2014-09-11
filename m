From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 11 Sep 2014 12:14:10 -0600
Subject: [RFC v2 8/9] KVM: KVM-VFIO: generic KVM_DEV_VFIO_DEVICE command
 and IRQ forwarding control
In-Reply-To: <20140911171033.GD5535@lvm>
References: <1409575968-5329-1-git-send-email-eric.auger@linaro.org>
 <1409575968-5329-9-git-send-email-eric.auger@linaro.org>
 <20140911031026.GI2784@lvm> <1410411949.2982.284.camel@ul30vt.home>
 <20140911171033.GD5535@lvm>
Message-ID: <1410459250.2982.325.camel@ul30vt.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-09-11 at 19:10 +0200, Christoffer Dall wrote:
> On Wed, Sep 10, 2014 at 11:05:49PM -0600, Alex Williamson wrote:
> > On Thu, 2014-09-11 at 05:10 +0200, Christoffer Dall wrote:
> > > On Mon, Sep 01, 2014 at 02:52:47PM +0200, Eric Auger wrote:
> 
> [...]
> 
> > > >  
> > > > +#ifdef __KVM_HAVE_ARCH_KVM_VFIO_FORWARD
> > > > +int kvm_arch_set_fwd_state(struct kvm_fwd_irq *pfwd,
> > > 
> > > what's the 'p' in pfwd?
> > 
> > p is for pointer?
> > 
> 
> shouldn't the type declation spell out quite clearly to me that I'm
> dealing with a pointer?

Sure.  In the cases where I've done similar things it's more a matter of
not needing to come up with another variable, for instance if I need
both a struct and a struct* I might call them foo and pfoo if I can't
come up with anything more meaningful.


> [...]
> 
> > > 
> > > need some spaceing here, also, I would turn this around, first check if
> > > the strcmp fails, and then error out, then do you next check etc., to
> > > avoid so many nested statements.
> > > 
> > > > +	/* is a ref to this device already owned by the KVM-VFIO device? */
> > > 
> > > this comment is not particularly helpful in its current form, it would
> > > be helpful if you specified that we're checking whether that particular
> > > device/irq combo is already registered.
> > > 
> > > > +	*kvm_vdev = kvm_vfio_find_device(kv, vdev);
> > > > +	if (*kvm_vdev) {
> > > > +		if (kvm_vfio_find_irq(*kvm_vdev, fwd_irq->index)) {
> > > > +			kvm_err("%s irq %d already forwarded\n",
> > > > +				__func__, *hwirq);
> > 
> > Why didn't we do this first?
> > 
> huh?

The code is doing:

1. can the arch forward this irq
2. are we already forwarding this irq

It's backwards, test for duplicates locally before calling out into arch
code.  Besides, I think the arch code here should go away and just be
another error condition for the call-out.  Thanks,

Alex
