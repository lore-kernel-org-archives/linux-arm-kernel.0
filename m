From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 01 May 2014 23:10:50 +0900
Subject: [PATCH v12 18/31] iommu/exynos: allow having multiple System MMUs
 for a master H/W
In-Reply-To: <535E2F96.908@linaro.org>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <1398584283-22846-19-git-send-email-shaik.ameer@samsung.com>
 <535E2F96.908@linaro.org>
Message-ID: <20140501231050.81390a28ca44f97499a5e22e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Apr 2014 16:08:14 +0530, Tushar Behera wrote:
> On 04/27/2014 01:07 PM, Shaik Ameer Basha wrote:
> > From: Cho KyongHo <pullip.cho@samsung.com>
> > 
> > Some master device descriptor like fimc-is which is an abstraction
> > of very complex H/W may have multiple System MMUs. For those devices,
> > the design of the link between System MMU and its master H/W is needed
> > to be reconsidered.
> > 
> > A link structure, sysmmu_list_data is introduced that provides a link
> > to master H/W and that has a pointer to the device descriptor of a
> > System MMU. Given a device descriptor of a master H/W, it is possible
> > to traverse all System MMUs that must be controlled along with the
> > master H/W.
> > 
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> 
> Since you are posting the patches, you should also add your
> Signed-of-by.
>
> > ---
> >  drivers/iommu/exynos-iommu.c |  545 ++++++++++++++++++++++++++----------------
> >  1 file changed, 335 insertions(+), 210 deletions(-)
> > 
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index fefedec3..c2e6365 100755
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> 
> [ ... ]
> 
> >  static int sysmmu_pm_genpd_save_state(struct device *dev)
> > @@ -1215,7 +1349,7 @@ static int sysmmu_pm_genpd_save_state(struct device *dev)
> >  		ret = cb(dev);
> >  
> >  	if (ret == 0)
> > -		sysmmu_save_state(client->sysmmu);
> > +		sysmmu_save_state(dev);
> >  
> 
> client is now unused, remove the variable.
> 
> >  	return ret;
> >  }
> > @@ -1238,13 +1372,13 @@ static int sysmmu_pm_genpd_restore_state(struct device *dev)
> >  	if (!cb && dev->driver && dev->driver->pm)
> >  		cb = dev->driver->pm->runtime_resume;
> >  
> > -	sysmmu_restore_state(client->sysmmu);
> > +	sysmmu_restore_state(dev);
> >  
> >  	if (cb)
> >  		ret = cb(dev);
> >  
> >  	if (ret)
> > -		sysmmu_save_state(client->sysmmu);
> > +		sysmmu_restore_state(dev);
> >  
> 
> client is now unused, remove the variable.
> 

Ok.

Thanks.

KyongHo
