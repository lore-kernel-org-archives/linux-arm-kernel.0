From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 6 Apr 2017 08:26:33 -0400
Subject: [PATCH v3 8/9] drm/rockchip: gem: Don't alloc/free gem buf when
 dev_private is invalid
In-Reply-To: <58E5AC5F.5090303@rock-chips.com>
References: <1491380967-28570-1-git-send-email-jeffy.chen@rock-chips.com>
 <1491380967-28570-9-git-send-email-jeffy.chen@rock-chips.com>
 <20170405162839.k6q4b3tpt6t2s3zm@art_vandelay>
 <58E5AC5F.5090303@rock-chips.com>
Message-ID: <20170406122633.2t5hf25ozqoohnl2@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 10:47:59AM +0800, jeffy wrote:
> Hi Sean,
> 
> On 04/06/2017 12:28 AM, Sean Paul wrote:
> > On Wed, Apr 05, 2017 at 04:29:26PM +0800, Jeffy Chen wrote:
> > > After unbinding drm, the userspace may still has a chance to access
> > > gem buf.
> > > 
> > > Add a sanity check for a NULL dev_private to prevent that from
> > > happening.
> > 
> > I still don't understand how this is happening. You're saying that these hooks
> > can be called after rockchip_drm_unbind() has finished?
> > 
> yes, tested on chromebook rk3399 kevin with kernel 4.4, if trigger unbind
> without killing display service(ui or frecon):
> 
> [   31.276889] [<ffffffc0002089e4>] dump_backtrace+0x0/0x164
> [   31.282288] [<ffffffc000208b6c>] show_stack+0x24/0x30
> [   31.287338] [<ffffffc0004be028>] dump_stack+0x98/0xb8
> [   31.292389] [<ffffffc0005c0b8c>] rockchip_gem_create_object+0x6c/0x2ec
> [   31.298910] [<ffffffc0005c0fa0>]
> rockchip_gem_create_with_handle+0x38/0x10c
> [   31.305868] [<ffffffc0005c12b8>] rockchip_gem_create_ioctl+0x38/0x50
> [   31.312221] [<ffffffc000598844>] drm_ioctl+0x2bc/0x438
> [   31.317359] [<ffffffc0005b5ee0>] drm_compat_ioctl+0x3c/0x70
> [   31.322935] [<ffffffc0003a6960>] compat_SyS_ioctl+0x134/0x1048
> [   31.328766] [<ffffffc000203e90>] __sys_trace_return+0x0/0x4

Hi Jeffy,
I'm not suggesting this doesn't happen, I believe you :-). I'd really like to
know *why* it happens.

Are you sure that unbind has completely finished before this trace occurs?
Perhaps this is results from a race between unbind and gem allocate?

Sean

> 
> > Sean
> > 
> > > 
> > > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > > ---
> > > 
> > > Changes in v3:
> > > Address Daniel Vetter <daniel@ffwll.ch>'s comments.
> > > Update commit message.
> > > 
> > > Changes in v2: None
> > > 
> > >   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > > index df9e570..205a3dc 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > > @@ -184,6 +184,9 @@ static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
> > >   	struct drm_device *drm = obj->dev;
> > >   	struct rockchip_drm_private *private = drm->dev_private;
> > > 
> > > +	if (!private)
> > > +		return -ENODEV;
> > > +
> > >   	if (private->domain)
> > >   		return rockchip_gem_alloc_iommu(rk_obj, alloc_kmap);
> > >   	else
> > > @@ -208,6 +211,11 @@ static void rockchip_gem_free_dma(struct rockchip_gem_object *rk_obj)
> > > 
> > >   static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
> > >   {
> > > +	struct drm_device *drm = rk_obj->base.dev;
> > > +
> > > +	if (!drm->dev_private)
> > > +		return;
> > > +
> > >   	if (rk_obj->pages)
> > >   		rockchip_gem_free_iommu(rk_obj);
> > >   	else
> > > --
> > > 2.1.4
> > > 
> > 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
