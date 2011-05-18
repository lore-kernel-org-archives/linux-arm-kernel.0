From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2011 13:14:20 +0100
Subject: [PATCH 2/9] davinci: sram: ioremap the davinci_soc_info
	specified sram regions
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CFDC9E6@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
	<80c0c2ff5a39baf6140c08460c2691b178c038c0.1305668470.git.bengardiner@nanometrics.ca>
	<20110518045140.GE18699@game.jcrosoft.org>
	<B85A65D85D7EB246BE421B3FB0FBB593024CFDC9E6@dbde02.ent.ti.com>
Message-ID: <20110518121420.GI5913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 05:41:56PM +0530, Nori, Sekhar wrote:
> Hi Russell,
> 
> On Wed, May 18, 2011 at 10:21:40, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > On 17:41 Tue 17 May     , Ben Gardiner wrote:
> 
> > > diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
> > > index 219d4c5..96026df 100644
> > > --- a/arch/arm/mach-davinci/sram.c
> > > +++ b/arch/arm/mach-davinci/sram.c
> > > @@ -8,6 +8,7 @@
> > >   * the Free Software Foundation; either version 2 of the License, or
> > >   * (at your option) any later version.
> > >   */
> > > +#include <linux/io.h>
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > >  #include <asm/pv-pool.h>
> > > @@ -26,16 +27,23 @@ EXPORT_SYMBOL_GPL(davinci_pv_pool);
> > >   */
> > >  static int __init sram_init(void)
> > >  {
> > > +	void *addr;
> > >  	unsigned len = davinci_soc_info.sram_len;
> > >  	int status = 0;
> > >  
> > >  	if (len) {
> > >  		len = min_t(unsigned, len, SRAM_SIZE);
> > > -		davinci_pv_pool = pv_pool_create((void *)SRAM_VIRT,
> > > +		addr = ioremap(davinci_soc_info.sram_phys, len);
> > > +		if (!addr)
> > > +			return -EIO;
> > > +
> > > +		davinci_pv_pool = pv_pool_create(addr,
> > >  					davinci_soc_info.sram_phys, len,
> > >  					ilog2(SRAM_GRANULARITY));
> > please use the gennalloc directly as discuss with Andrew and Russell my patch
> > will present in the .40
> 
> With Jean-Christophe's patch getting merged, would you be dropping
> your PV pool patch?

I'll make that decision once JC's patch has actually been merged.  JC's
patch doesn't do any of the consolidation work, so that needs addressing
still.
