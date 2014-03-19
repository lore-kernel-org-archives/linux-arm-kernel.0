From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 18 Mar 2014 20:03:42 -0700
Subject: [PATCH v2 1/7] ARM: KVM: switch hypervisor into BE mode in case
 of BE host
In-Reply-To: <20140318222335.GG1297@cbox>
References: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
 <1392183693-21238-2-git-send-email-victor.kamensky@linaro.org>
 <20140318222335.GG1297@cbox>
Message-ID: <20140319030342.GA8883@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 03:23:35PM -0700, Christoffer Dall wrote:
> On Tue, Feb 11, 2014 at 09:41:27PM -0800, Victor Kamensky wrote:
> > Switch hypervisor to run in BE mode if image is compiled
> > with CONFIG_CPU_BIG_ENDIAN.
> > 
> > Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> > ---
> >  arch/arm/kvm/init.S | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> > index 1b9844d..74f0718 100644
> > --- a/arch/arm/kvm/init.S
> > +++ b/arch/arm/kvm/init.S
> > @@ -22,6 +22,7 @@
> >  #include <asm/kvm_asm.h>
> >  #include <asm/kvm_arm.h>
> >  #include <asm/kvm_mmu.h>
> > +#include <asm/assembler.h>
> >  
> >  /********************************************************************
> >   * Hypervisor initialization
> > @@ -70,6 +71,8 @@ __do_hyp_init:
> >  	cmp	r0, #0			@ We have a SP?
> >  	bne	phase2			@ Yes, second stage init
> >  
> > +ARM_BE8(setend	be) @ Switch to Big Endian mode if needed
> > +
> >  	@ Set the HTTBR to point to the hypervisor PGD pointer passed
> >  	mcrr	p15, 4, r2, r3, c2
> >  
> > -- 
> > 1.8.1.4
> > 
> 
> Won't splitting up the patches this way break bisectability?
> 
Second thought, scratch that, because BE support is not supposed to work
before applying these patches anyhow I guess.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

-Christoffer
