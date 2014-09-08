From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Sep 2014 12:03:14 +0100
Subject: [PATCH 06/11] KVM: vgic: declare probe function pointer as const
In-Reply-To: <CAKv+Gu8vAuHfnq5BfV=wac8SP3VYMizxg_7K4Baitj0TbWfYaw@mail.gmail.com>
References: <540C32A8.1000409@linaro.org>
 <CAKv+Gu8vAuHfnq5BfV=wac8SP3VYMizxg_7K4Baitj0TbWfYaw@mail.gmail.com>
Message-ID: <20140908110314.GG26030@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 07, 2014 at 11:34:57AM +0100, Ard Biesheuvel wrote:
> > We extract the vgic probe function from the of_device_id data pointer,
> > which is const. Kill the sparse warning by ensuring that the local
> > function pointer is also marked as const.
> >
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  virt/kvm/arm/vgic.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> > index d1cfe672b9d7..efe6eee2e7eb 100644
> > --- a/virt/kvm/arm/vgic.c
> > +++ b/virt/kvm/arm/vgic.c
> > @@ -1557,8 +1557,8 @@ static const struct of_device_id vgic_ids[] = {
> >  int kvm_vgic_hyp_init(void)
> >  {
> >         const struct of_device_id *matched_id;
> > -       int (*vgic_probe)(struct device_node *,const struct vgic_ops **,
> > -                         const struct vgic_params **);
> > +       const int (*vgic_probe)(struct device_node *,const struct vgic_ops **,
> > +                               const struct vgic_params **);
> >         struct device_node *vgic_node;
> >         int ret;
> >
> 
> Hi all,

Hi Ard,

> I noticed this patch in kvmarm/next, and I think it is wrong.
> 
> Sparse complains about the fact that you are assigning the value of a
> pointer to const data to a pointer to non-const data, and this is not
> what is happening. Dereferencing a function pointer does not give you
> an lvalue, so a function pointer points to const data by definition,
> and the assignment is fine and sparse is wrong. The fact that you can
> squelch the warning by typing the function pointer as returning a
> by-value const result only emphasizes how confused sparse gets about
> this.

Great, if you're fixing sparse (looks like you are) then we can drop this
patch from -next.

Cheers,

Will
