From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 16:00:47 +0200
Subject: [PATCH v3 0/3] Separate generic header usage from
 ARCH_MULTIPLATFORM
In-Reply-To: <51B1DC74.9090203@arm.com>
References: <1370602111-28737-1-git-send-email-jonathan.austin@arm.com>
 <3002059.2ORUa6RLPf@wuerfel> <51B1DC74.9090203@arm.com>
Message-ID: <3354049.TGIUmJXV0H@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 14:13:24 Jonathan Austin wrote:
> 
> Do you mean you want to build real !MMU multiplatform kernels that 
> validly work on multiple platforms, or are you just interested in 
> keeping the config options set?
> 
> I don't think the former makes sense - we still rely on setting 
> CONFIG_DRAM_BASE (and hence PHYS_OFFSET) and we *can't* use the high 
> exception vector on many platforms (high exception vectors is deprecated 
> for R class, too) but we need to use it on others.
> 
> In the case that you just want to keep the config option set, I don't 
> really see what you gain?

The main interest on my side is to keep the MMU and NOMMU configuration
as similar as possible, and minimize the complexity in Kconfig.
Ideally CONFIG_MMU should just be a single switch to turn on or off,
with a few options becoming visible only for one of the settings.

> The problem I see with enabling !MMU/ARCH_MULTIPLATFORM is that you end 
> up needing to change platforms that (as far as I know) people never use 
> in NOMMU configurations for NOMMU behaviour: cf imx, omap2 needing to be 
> changed in a specific way for the NOMMU case in the diff below. (I say 
> 'specific way' because, of course, this series does make a small change 
> to them, but I see it more as separating out two previously conflated 
> options than as NOMMU specific changes...)

Well, I would consider the imx and omap2 changes to be actual bugs.
We previously allowed them to be built with !MMU, and we could still
decide that we don't want them to run that way but just disable those.
I would however prefer to allow !MMU builds by default for everything
that is not know to be broken, rather than allowing it only for
code that is known to work.

> > I've spent some time recently on randconfig
> > builds and used the patch below to actually fix all build-time bugs I see
> > with that. The changes need to be split up into separate patches and reviewed
> > one by one, but I think the only one you really need is to not select
> > ARM_PATCH_PHYS_VIRT when building a NOMMU kernel.
> 
> I agree that this seems to get you to something that builds, though I'm 
> not sure it'd build something that runs... Don't we end up just making 
> life harder (I think the diff below is more complicated than the one for 
> this series...) for ourselves without a win?
> 
> Doesn't the explicit dependency of CONFIG_MMU for ARCH_MULTIPLATFORM 
> mean that randconfig builds still work, even without the changes below?
> 
> Apologies if I'm missing a use-case here!

I am somewhat annoyed by the fact that I had to disable ARCH_MULTIPLATFORM
for !MMU kernels in order to get 'make randconfig' to work and I would rather
allow it and fix the bugs.

	Arnd
