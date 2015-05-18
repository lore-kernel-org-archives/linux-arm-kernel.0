From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 18:49:31 +0100
Subject: [PATCHv2 10/12] drivers: psci: support native SMC{32,64} calls
In-Reply-To: <20150518174338.GQ21251@e104818-lin.cambridge.arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-11-git-send-email-mark.rutland@arm.com>
 <20150518174338.GQ21251@e104818-lin.cambridge.arm.com>
Message-ID: <20150518174930.GB7064@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 06:43:38PM +0100, Catalin Marinas wrote:
> On Mon, May 18, 2015 at 11:38:21AM +0100, Mark Rutland wrote:
> > A 32-bit OS cannot make calls with SMC64 IDs, while a 64-bit OS must
> > invoke some PSCI functions with SMC64 IDs.
> > 
> > This patch introduces and makes use of a new macro to choose the
> > appropriate IDs based on the register width of the OS, which will allow
> > 32-bit callers to use the PSCI client code.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  drivers/firmware/psci.c | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > index 792f4a7..e071ada 100644
> > --- a/drivers/firmware/psci.c
> > +++ b/drivers/firmware/psci.c
> > @@ -27,6 +27,18 @@
> >  #include <asm/smp_plat.h>
> >  
> >  /*
> > + * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> > + * calls it is necessary to use SMC64 to pass or return 64-bit values. For such
> > + * calls PSCI_0_2_FN_NATIVE(x) will choose the appropriate (native-width)
> > + * function ID.
> > + */
> > +#ifdef CONFIG_64BIT
> > +#define PSCI_0_2_FN_NATIVE(name)	PSCI_0_2_FN_##name
> > +#else
> > +#define PSCI_0_2_FN_NATIVE(name)	PSCI_0_2_FN64_##name
> > +#endif
> > +
> > +/*
> >   * The CPU any Trusted OS is resident on. The trusted OS may reject CPU_OFF
> >   * calls to its resident CPU, so we must avoid issuing those. We never migrate
> >   * a Trusted OS even if it claims to be capable of migration -- doing so will
> > @@ -121,8 +133,8 @@ static int psci_migrate(unsigned long cpuid)
> >  static int psci_affinity_info(unsigned long target_affinity,
> >  		unsigned long lowest_affinity_level)
> >  {
> > -	return invoke_psci_fn(PSCI_0_2_FN64_AFFINITY_INFO, target_affinity,
> > -			      lowest_affinity_level, 0);
> > +	return invoke_psci_fn(PSCI_0_2_FN_NATIVE(AFFINITY_INFO),
> > +			      target_affinity, lowest_affinity_level, 0);
> 
> That's wrong ;).

Horrifically so, in fact!

The firmware on Juno seems to accept SMC32 calls with 64-bit argument
for some reason, which explains how my local testing passed.

I've flipped the ifdef locally.

Mark.
