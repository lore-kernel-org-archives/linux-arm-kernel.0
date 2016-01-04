From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jan 2016 15:12:33 +0000
Subject: [Xen-devel] [PATCH v3 20/62] arm/acpi: Add ACPI support for SMP
 initialization
In-Reply-To: <56834B4C.40409@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-21-git-send-email-shannon.zhao@linaro.org>
 <565C63F1.5070303@citrix.com> <56834B4C.40409@huawei.com>
Message-ID: <20160104151233.GD7050@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2015 at 11:11:08AM +0800, Shannon Zhao wrote:
> 
> 
> On 2015/11/30 22:57, Julien Grall wrote:
> > Hi Shannon,
> > 
> > On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> >> > diff --git a/xen/arch/arm/psci.c b/xen/arch/arm/psci.c
> >> > index d800cb6..dede0e1 100644
> >> > --- a/xen/arch/arm/psci.c
> >> > +++ b/xen/arch/arm/psci.c
> >> > @@ -22,6 +22,7 @@
> >> >  #include <xen/mm.h>
> >> >  #include <xen/smp.h>
> >> >  #include <asm/psci.h>
> >> > +#include <asm/acpi.h>
> >> >  
> >> >  /*
> >> >   * While a 64-bit OS can make calls with SMC32 calling conventions, for
> >> > @@ -86,6 +87,9 @@ int __init psci_init_0_1(void)
> >> >      int ret;
> >> >      const struct dt_device_node *psci;
> >> >  
> >> > +    if ( !acpi_disabled )
> >> > +        return -EINVAL;
> > Please explain in the commit message why PSCI 0.1 is not supported on ACPI.
> 
> Hi,
> 
> I check this again. There are not limitations of supporting PSCI version
> in ACPI SPEC. It should support PSCI 0.1 as well.

I believe that's an oversight in the ACPI documentation, which should
state 0.2+.

There was a deliberate decision that the FADT PSCI flag implied PSCI
0.2+, since prior to PSCI 0.2 function IDs were not well-defined, and
functions crticial for some uses cases did not exist (e.g. AFFINITY_INFO
for kexec-type things).

I don't know why that did not make it into the documentation.

Charles, thoughts?

Mark.
