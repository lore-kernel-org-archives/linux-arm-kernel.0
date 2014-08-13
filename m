From: dyoung@redhat.com (Dave Young)
Date: Wed, 13 Aug 2014 09:29:41 +0800
Subject: [PATCH 3/5] efi arm64: do not enter virtual mode in case booting
 with efi=noruntime or noefi
In-Reply-To: <20140812104627.GI29013@arm.com>
References: <1407823822-23829-1-git-send-email-dyoung@redhat.com>
 <1407823822-23829-3-git-send-email-dyoung@redhat.com>
 <20140812104627.GI29013@arm.com>
Message-ID: <20140813012941.GA2669@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/14 at 11:46am, Will Deacon wrote:
> On Tue, Aug 12, 2014 at 07:10:20AM +0100, Dave Young wrote:
> > In case efi runtime disabled via noefi kernel cmdline arm64_enter_virtual_mode
> > should error out.
> > 
> > At the same time move early_memunmap(memmap.map, mapsize) to the beginning of
> > the function or it will leak early mem.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/arm64/kernel/efi.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > index e72f310..324cdd1 100644
> > --- a/arch/arm64/kernel/efi.c
> > +++ b/arch/arm64/kernel/efi.c
> > @@ -386,7 +386,10 @@ static int __init arm64_enter_virtual_mode(void)
> >  	int count = 0;
> >  	unsigned long flags;
> >  
> > -	if (!efi_enabled(EFI_BOOT)) {
> > +	mapsize = memmap.map_end - memmap.map;
> > +	early_memunmap(memmap.map, mapsize);
> > +
> > +	if (!efi_enabled(EFI_BOOT) || efi_runtime_disabled()) {
> 
> Hmm, is this right? We only set EFI_BOOT if we find EFI parameters in the
> DT (see efi_init -> uefi_init), so you run the risk of unmapping something
> we never mapped here.

Good catch, I missed the case. will fix it in next update

> 
> Furthermore, there seems to be a leak in uefi_init anyway, as we return
> -EINVAL if the signature of the EFI table doesn't match without unmapping it
> first.

Yes, will add a new patch to fix the error handling in uefi_init.

BTW, Matt, I forgot to cc Xen/SGI people, will send an update soon and cc them.

Thanks
Dave
