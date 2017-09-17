From: vkilari@codeaurora.org (vkilari at codeaurora.org)
Date: Sun, 17 Sep 2017 13:40:56 +0530
Subject: [PATCH] KVM: arm64: vgic-its: Fix wrong return value check in
 vgic_its_restore_device_tables
In-Reply-To: <65a66715-4f22-07d4-879a-1181c8dad889@redhat.com>
References: <1504675565-13641-1-git-send-email-vkilari@codeaurora.org>
 <65a66715-4f22-07d4-879a-1181c8dad889@redhat.com>
Message-ID: <000401d32f8c$828f4270$87adc750$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

 Sorry for delayed reply.

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger at redhat.com]
> Sent: Wednesday, September 6, 2017 12:53 PM
> To: Vijaya Kumar K <vkilari@codeaurora.org>;
> kvmarm at lists.cs.columbia.edu; marc.zyngier at arm.com; cdall at linaro.org;
> andre.przywara at arm.com
> Cc: vvenkat at codeaurora.org; shankerd at codeaurora.org;
> kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] KVM: arm64: vgic-its: Fix wrong return value check in
> vgic_its_restore_device_tables
> 
> Hi Vijaya,
> 
> On 06/09/2017 07:26, Vijaya Kumar K wrote:
> > scan_its_table() return 1 on success.
> 
> As mentioned in the kernel-doc comment of scan_its_table, this latter
> returns 1 if the last element is not found. Than can happen while scanning
an
> L2 table but shouldn't happen if we scan an L1 table.
> 
>  * Return: < 0 on error, 0 if last element was identified, 1 otherwise
>  * (the last element may not be found on second level tables)

OK. I will  fix this comment

> 
> 
>  In the function vgic_its_restore_device_tables()
> > the return value of scan_its_table() is checked against success value
> > and returns -EINVAL. Hence migration fails for VM with ITS.
> >
> > With this patch the failure return value is checked while returning
> > -EINVAL.
> >
> > Signed-off-by: Vijaya Kumar K <vkilari@codeaurora.org>
> >
> > diff --git a/virt/kvm/arm/vgic/vgic-its.c
> > b/virt/kvm/arm/vgic/vgic-its.c index aa6b68d..63f8ac3 100644
> > --- a/virt/kvm/arm/vgic/vgic-its.c
> > +++ b/virt/kvm/arm/vgic/vgic-its.c
> > @@ -2142,7 +2142,7 @@ static int vgic_its_restore_device_tables(struct
> vgic_its *its)
> >  				     vgic_its_restore_dte, NULL);
> >  	}
> >
> > -	if (ret > 0)
> > +	if (ret <= 0)
> >  		ret = -EINVAL;
> your modification would return -EINVAL for whatever error encountered
> during the scan table or if last element is found. I don't think this is
what we
> want.

IIUC, ret 0 indicates last entry of the table. So in this case return value
0 is also success.
with the assumption that table might be smaller than size.

So only check for < 0 and return -EINVAL. For all other return values 0 and
> 0  return 0.
as below. Please correct me if I wrong.

           If (ret < 0)
                          ret = -EINVAL;
           else
                          ret = 0;
