From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 1 Aug 2014 18:09:15 +0100
Subject: [Xen-devel] [PATCH v3 1/3] xen/arm: introduce
 XENFEAT_grant_map_identity
In-Reply-To: <53DBC613.4070506@linaro.org>
References: <alpine.DEB.2.02.1408011552460.2293@kaball.uk.xensource.com>
 <1406904984-16068-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <53DBC613.4070506@linaro.org>
Message-ID: <alpine.DEB.2.02.1408011802090.2293@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Aug 2014, Julien Grall wrote:
> Hi Stefano,
> 
> On 01/08/14 15:56, Stefano Stabellini wrote:
> > The flag tells us that the hypervisor maps a grant page to guest
> > physical address == machine address of the page in addition to the
> > normal grant mapping address. It is needed to properly issue cache
> > maintenance operation at the completion of a DMA operation involving a
> > foreign grant.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Tested-by: Denis Schneider <v1ne2go@gmail.com>
> > 
> > ---
> > Changes in v3:
> > - rename XENFEAT_grant_map_11 to XENFEAT_grant_map_identity.
> > ---
> >   arch/arm/xen/enlighten.c         |    6 ++++++
> >   include/xen/interface/features.h |    3 +++
> >   2 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index b96723e..eef324f 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -262,6 +262,12 @@ static int __init xen_guest_init(void)
> >   	xen_domain_type = XEN_HVM_DOMAIN;
> > 
> >   	xen_setup_features();
> > +
> > +	if (!xen_feature(XENFEAT_grant_map_identity)) {
> > +		pr_warn("Please upgrade your Xen.\n"
> > +				"If your platform has any non-coherent DMA
> > devices, they won't work properly.\n");
> > +	}
> 
> I know we talked about this on a previous thread but I can't find it in my
> mail :/
> 
> Does a Linux with this series will work on Xen 4.4? If not what's the plan?
 
I suggest we backport the changes to Xen 4.4.

"Still working" doesn't apply to a system without networking :-(


> I think we have to keep any OS working on top on Xen 4.4 as people may want to
> retrieve the latest kernel for drivers bug fixes...

Right, that's why we need to backport the fixes. Without the backport of
the Xen patches, with or without this Linux series, networking won't
work once the kernel is upgraded.


> For running a previous kernel on Xen 4.5, then it will still be buggy. It
> might be worse to backport thise series on LTS kernel (i.e at least 3.14).

The old thread is: http://marc.info/?l=xen-devel&m=140483414203686&w=2
