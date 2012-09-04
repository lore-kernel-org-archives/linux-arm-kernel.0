From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Sep 2012 06:56:23 +0000
Subject: [PATCH v2] ARM: initial multiplatform support
In-Reply-To: <5045280C.6060103@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <201209031634.19301.arnd@arndb.de> <5045280C.6060103@gmail.com>
Message-ID: <201209040656.23536.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 September 2012, Rob Herring wrote:
> On 09/03/2012 11:34 AM, Arnd Bergmann wrote:
> >> @@ -254,27 +254,9 @@ config MMU
> >>  #
> >>  choice
> >>         prompt "ARM system type"
> >> +       depends on !ARCH_MULTIPLATFORM
> >>         default ARCH_VERSATILE
> > 
> > Why did you move ARCH_MULTIPLATFORM out of the "choice" statement?
> > If we leave it in there, and make it the default, then we don't
> > even have to change the defconfigs any more (except the versatile
> > one, which is no longer the default), which I think is quite clever
> > and helps git-bisecting across this commit.
> 
> We don't have to change and of the defconfigs or .config in this patch.

How does ARCH_MULTIPLATFORM get set then when building the existing
defconfig files for the converted platforms?

> > For instance, we could enable one platform to be used in
> > multiplatform kernels with the subset of its board files and
> > device drivers that are possible, while leaving board files
> > that cannot work with sparse-irq and drivers that rely on
> > platform specific headers as "depends on !ARCH_MULTIPLATFORM".
> 
> Individual platforms can still do that. I just happened to convert all
> platforms which have no need to be in both. While you can do that, I
> don't think we should encourage it. I don't think we want to see
> platforms partially converted to common clk or sparse irq. The latter is
> certainly not hard to do.

I was thinking of other cases actually:

* device drivers that we don't really care about much but that rely
  on a mach/* header file. In some cases it can be hard to clean up
  those headers, so as an intermediate step, we can just disable the
  drivers when building multiplatform.

* At least the Samsung platforms have files that are built for separate
  platforms in a way that does not work across platforms: 
  arch/arm/plat-samsung/devs.c depends heavily on constants defined
  in mach/*.h header files. When building for DT-only, we can decide to
  just not build this file.

	Arnd
