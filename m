From: emilgoode@gmail.com (Emil Goode)
Date: Mon, 26 May 2014 20:31:55 +0200
Subject: [PATCH 1/3] driver core/platform: don't leak memory allocated
 for dma_mask
In-Reply-To: <20140526165105.GD3693@n2100.arm.linux.org.uk>
References: <1401122483-31603-1-git-send-email-emilgoode@gmail.com>
 <20140526165105.GD3693@n2100.arm.linux.org.uk>
Message-ID: <20140526183155.GA1312@lianli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Mon, May 26, 2014 at 05:51:05PM +0100, Russell King - ARM Linux wrote:
> On Mon, May 26, 2014 at 06:41:21PM +0200, Emil Goode wrote:
> > @@ -211,6 +215,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
> >  		strcpy(pa->name, name);
> >  		pa->pdev.name = pa->name;
> >  		pa->pdev.id = id;
> > +		pa->pdev.dev.dma_mask = &pa->dma_mask;
> 
> There is code in the kernel which, rightly or wrongly, checks whether
> dev->dma_mask is NULL to determine whether the device can do any kind
> of DMA.  The above results in devices allocated via this interface
> always having this member set, which is a change of core kernel behaviour.
> 
> How sure are you that this will not break anything?

Thank you for pointing this out, considering the number of calls made to
platform_device_alloc it would be easy to miss an occurrance of this problem.
I would say that the risk heavily outweighs the gain and it's better to 
not apply this series.

Best regards,

Emil Goode
