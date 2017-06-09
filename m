From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Jun 2017 11:59:43 +0100
Subject: [PATCH 05/20] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <20170608224059.fi4a5urcjoxhbgwb@yury-thinkpad>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-6-ynorov@caviumnetworks.com>
 <20170608140912.56rww67adolr4ytr@localhost>
 <20170608224059.fi4a5urcjoxhbgwb@yury-thinkpad>
Message-ID: <20170609105942.GJ2186@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 01:40:59AM +0300, Yury Norov wrote:
> On Thu, Jun 08, 2017 at 03:09:12PM +0100, Catalin Marinas wrote:
> > On Sun, Jun 04, 2017 at 02:59:54PM +0300, Yury Norov wrote:
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -402,7 +402,7 @@ config ARM64_ERRATUM_834220
> > >  
> > >  config ARM64_ERRATUM_845719
> > >  	bool "Cortex-A53: 845719: a load might read incorrect data"
> > > -	depends on COMPAT
> > > +	depends on AARCH32_EL0
> > >  	default y
> > >  	help
> > >  	  This option adds an alternative code sequence to work around ARM
> > > @@ -784,7 +784,7 @@ config FORCE_MAX_ZONEORDER
> > >  
> > >  menuconfig ARMV8_DEPRECATED
> > >  	bool "Emulate deprecated/obsolete ARMv8 instructions"
> > > -	depends on COMPAT
> > > +	depends on AARCH32_EL0
> > >  	help
> > >  	  Legacy software support may require certain instructions
> > >  	  that have been deprecated or obsoleted in the architecture.
> > > @@ -1062,9 +1062,15 @@ menu "Userspace binary formats"
> > >  source "fs/Kconfig.binfmt"
> > >  
> > >  config COMPAT
> > > +	bool
> > > +	depends on AARCH32_EL0
> > 
> > You could just use "def_bool y" here
> > 
> > > +
> > > +config AARCH32_EL0
> > >  	bool "Kernel support for 32-bit EL0"
> > > +	def_bool y
> > >  	depends on ARM64_4K_PAGES || EXPERT
> > >  	select COMPAT_BINFMT_ELF if BINFMT_ELF
> > > +	select COMPAT
> > 
> > and avoid the explicit select.
> 
> in patch 20 COMPAT becomes depending also on ARM64_ILP32, like this:
> -       depends on AARCH32_EL0
> +       depends on AARCH32_EL0 || ARM64_ILP32
> 
> So this is a preparation for it. If it looks confusing, I think it's
> better to underline it in the description to the patch in addition to
> this:
> 
> > From now, AARCH32_EL0 (former COMPAT) config option means the support of
> > AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
> > and COMPAT indicates that one of them, or both, is enabled.
> 
> But if you prefer, I can do like you suggested here and make COMPAT
> depend on AARCH32_EL0 in the last patch.

What I meant is that if you define COMPAT as "def_bool y", you no longer
need the explicit "select COMPAT". When AARCH32_EL0 is disabled, COMPAT
would automatically be disabled because of the "depends on AARCH32_EL0"
line.

-- 
Catalin
