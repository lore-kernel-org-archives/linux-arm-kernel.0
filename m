From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 13 Jul 2016 15:18:47 -0600
Subject: [PATCH V8 7/9] vfio, platform: make reset driver a requirement
 by default
In-Reply-To: <eeb13445-a4bb-9230-527c-d85ab4da4c3e@codeaurora.org>
References: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
 <1466437879-32182-8-git-send-email-okaya@codeaurora.org>
 <20160623125955.647008cb@t450s.home>
 <eeb13445-a4bb-9230-527c-d85ab4da4c3e@codeaurora.org>
Message-ID: <20160713151847.0f131dd1@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jul 2016 16:48:32 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> On 6/23/2016 2:59 PM, Alex Williamson wrote:
> >> -static void vfio_platform_get_reset(struct vfio_platform_device *vdev)  
> >> > +static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
> >> >  {
> >> >  	if (vdev->acpihid)
> >> > -		return;
> >> > +		return vfio_platform_acpi_has_reset(vdev) ? 0 : -ENOENT;
> >> >  
> >> >  	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
> >> >  						    &vdev->reset_module);
> >> > @@ -140,6 +140,8 @@ static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
> >> >  		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
> >> >  							&vdev->reset_module);
> >> >  	}
> >> > +
> >> > +	return vdev->of_reset ? 0 : -ENOENT;
> >> >  }  
> > nit, this looks more like a:
> > 
> > static bool vfio_platform_has_reset(...)
> > 	...
> > 		return vfio_platform_acpi_has_reset() == 0;
> > 
> > 	...
> > 
> > 	return vdev->of_reset != NULL
> >   
> 
> Sorry, I didn't understand this comment. The code has get and put functions for DT.
> These functions are not useful for ACPI. This is the reason for the above change. 
> 
> Can you be more specific?


It was sort of cryptic, I'm not entirely sure I can make sense of it
either.  It think I was mainly suggesting that it looked more like a
bool function so we could just return true/false, but we are actually
setting the of_reset function as part of this, so there is a 'get'
aspect.  Feel free to ignore this comment.  Thanks,

Alex
