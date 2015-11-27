From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 27 Nov 2015 09:50:11 +0000
Subject: [Xen-devel] [PATCH v3 42/62] arm/acpi: Prepare FADT table for Dom0
In-Reply-To: <alpine.DEB.2.02.1511261710350.8984@kaball.uk.xensource.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-43-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511261710350.8984@kaball.uk.xensource.com>
Message-ID: <1448617811.13576.60.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-11-26 at 17:19 +0000, Stefano Stabellini wrote:
> On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> > From: Shannon Zhao <shannon.zhao@linaro.org>
> > 
> > Copy and modify FADT table before passing it to Dom0. Set
> > PSCI_COMPLIANT
> > and PSCI_USE_HVC.
> > 
> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > 
> > ?xen/arch/arm/domain_build.c | 45
> > +++++++++++++++++++++++++++++++++++++++++++++
> > ?1 file changed, 45 insertions(+)
> > 
> > diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> > index b5ed44c..5d03dc0 100644
> > --- a/xen/arch/arm/domain_build.c
> > +++ b/xen/arch/arm/domain_build.c
> > @@ -1357,6 +1357,46 @@ static int prepare_dtb(struct domain *d, struct
> > kernel_info *kinfo)
> > ?}
> > ?
> > ?#ifdef CONFIG_ACPI
> > +#define XEN_HYPERVISOR_ID 0x000058656E564D4D??/* "XenVMM" */
> 
> This needs to be documented somewhere. A new doc under docs/ might be
> enough.

Should (also?) probably be in xen/include/public/arch-arm.h in the same
"#if defined(__XEN__) || defined(__XEN_TOOLS__)" as the other guest non-ABI 
stuff[0] which is needed by both Xen and the toolstack.

We don't actually have ACPI guest support today, so the toolstack has no
current interest, but I think that is still a logical place for it do be
defined.

Ian.

[0] That is, stuff which is part of the current implementation but which is
exposed to guests through other means, e.g. DT or ACPI and not through the
use of the arch-arm.h public header.
