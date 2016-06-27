From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Jun 2016 23:10:38 +0200
Subject: next build: 142 builds: 6 failed, 136 passed, 17 errors,
 111 warnings (next-20160624)
In-Reply-To: <m2ziq6s7c6.fsf@baylibre.com>
References: <576da61b.4d9a1c0a.d5671.1807@mx.google.com>
 <6046594.ORRxUGPcVO@wuerfel> <m2ziq6s7c6.fsf@baylibre.com>
Message-ID: <3959952.E4k8LWTObD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 27, 2016 1:30:17 PM CEST Kevin Hilman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Friday, June 24, 2016 2:28:59 PM CEST kernelci. org bot wrote:
> 
> [...]
> 
> >>       1  .config:972:warning: override: NOHIGHMEM changes choice state
> >>       1  .config:971:warning: override: SLOB changes choice state
> >>       1  .config:969:warning: override: KERNEL_XZ changes choice state
> >>       1  .config:968:warning: override: CC_OPTIMIZE_FOR_SIZE changes choice state
> >>       1  .config:944:warning: override: SLOB changes choice state
> >>       1  .config:941:warning: override: CC_OPTIMIZE_FOR_SIZE changes choice state
> >>       1  .config:877:warning: override: SLOB changes choice state
> >>       1  .config:875:warning: override: KERNEL_XZ changes choice state
> >>       1  .config:874:warning: override: CC_OPTIMIZE_FOR_SIZE changes choice state
> >
> > The tinyconfig warnings are really annoying 
> >
> 
> Hmm, yeah.  We should probably just filter out all the kconfig warnings
> that happen when we use config fragments, since the point of the
> fragment is to override things and change state.
> 
> Right now, our check for warnings is a rather simple grep, but I'll add
> this to the TODO list.

I've looked at this before and sadly, the scripts/kconfig tool can do it
right if you pass in both the base config file (defconfig, or flag for
allnoconfig/allmod/...) *and* the fragment, but the way that the Makefile
works for minconfig is that we first generate a .config file and
then add the fragment for minconfig to that, and this causes the
warnings above.

This should be fixable by patching the kernel Makefiles, but I have
not come up with a nice way to do that.

	Arnd
