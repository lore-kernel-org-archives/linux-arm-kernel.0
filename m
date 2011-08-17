From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 19:52:48 +0100
Subject: [PATCH 4/6] ARM: highbank: add SMP support
In-Reply-To: <4E4BC9D2.9090908@gmail.com>
References: <4E4BC9D2.9090908@gmail.com>
Message-ID: <20110817185248.GB11221@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 09:01:54AM -0500, Rob Herring wrote:
> On 08/17/2011 02:37 AM, Russell King - ARM Linux wrote:
> > On Tue, Aug 16, 2011 at 03:34:56PM -0500, Rob Herring wrote:
> >> +void __init smp_init_cpus(void)
> >> +{
> >> +	void __iomem *scu_base = a9_base_addr;
> >> +	unsigned int i, ncores;
> >> +
> >> +	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> > 
> > Is scu_base ever NULL?
> 
> Only if something is wrong and the mapping did not get setup. The system
> should still boot with 1 core without accessing the the SCU in this case.

However,  in a previous patch, a9_base_addr is statically initialized
and never written to, so that doesn't work.  Not only that but its
also used for poweroff and cpu suspend...

> This BTW is the only reason we need a static mapping of the SCU. So I
> could just hard code it or use device tree to get the number of cores
> and eliminate the static mapping.

this statement isn't accurate.

I can see no way for scu_base to ever be NULL here.
