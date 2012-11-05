From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 5 Nov 2012 09:10:31 +0000
Subject: [PATCH 08/15] ARM: OMAP2+: hwmod: Fix the omap_hwmod_addr_space
 for CPGMAC0
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-9-git-send-email-vaibhav.bedia@ti.com>
 <509543E8.60209@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC00B9B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 04, 2012 at 20:54:17, Bedia, Vaibhav wrote:
> On Sat, Nov 03, 2012 at 21:48:48, Shilimkar, Santosh wrote:
> > On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> > > The first entry for CPGMAC0 should be ADDR_MAP_ON_INIT
> > > instead of ADDR_TYPE_RT to ensure the omap hwmod code
> > > maps the memory space at init and writes to the SYSCONFIG
> > > registers.
> > >
> > > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > > ---
> > Sorry again similar question.
> > 
> > Why CPGMAC0 should be mapped and sysconfig updated early ?
> > 
> 
> Hmm I need to revisit this one. CPGMAC0 was not going to standby
> without this. Maybe something else is wrong in the hwmod data and
> needs fixing.
> 

Ok I checked this one. The change I made was indirectly fixing another
issue with the AM33xx hwmod data. am33xx_cpgmac0_addr_space[] has two
entries and the SYSC register is part of the second entry. The function
_find_mpu_rt_addr_space in omap_hwmod.c looks for the first entry with
the flag ADDR_TYPE_RT flag. The change I made indirectly made the second
entry in am33xx_cpgmac0_addr_space[] become the first memory space with
the ADDR_TYPE_RT flag. Due to this the hwmod code wrote to the correct
SYSC address of CPGMAC0 and the IP went to standby during bootup. 
After changing the order of the entries in am33xx_cpgmac0_addr_space[]
things work fine.

I'll make the changes in the next version.

Regards,
Vaibhav
