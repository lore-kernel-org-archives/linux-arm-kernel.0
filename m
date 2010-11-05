From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 5 Nov 2010 19:51:14 +0100
Subject: [PATCH] ARM: fix build error with GCC 4.5.0
In-Reply-To: <AANLkTimkSxWNL+aCALGsf5prBM_RHz0BMHCeNwKrTnfA@mail.gmail.com>
References: <1288897002-24073-1-git-send-email-rabin@rab.in>
	<yw1xy698ygbx.fsf@unicorn.mansr.com>
	<19667.9199.798932.405415@pilspetsen.it.uu.se>
	<AANLkTinUcS3v57bMLXcHaqC+OGoAqgoK2td-ce3B6FOM@mail.gmail.com>
	<19667.52998.909668.596635@pilspetsen.it.uu.se>
	<AANLkTimkSxWNL+aCALGsf5prBM_RHz0BMHCeNwKrTnfA@mail.gmail.com>
Message-ID: <19668.21026.5416.610777@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin Vincent writes:
 > 2010/11/5 Mikael Pettersson <mikpe@it.uu.se>:
 > > Rabin Vincent writes:
 > > ?> 2010/11/5 Mikael Pettersson <mikpe@it.uu.se>:
 > > ?> > Indeed. I suspect an improperly patched or configured gcc-4.5.0,
 > > ?> > or broken kernel sources. Especially considering that the kernel
 > > ?> > passes -msoft-float to gcc (see above).
 > > ?> >
 > > ?> > I know gcc-4.5.0 configured for arm-linux-gnueabi built working EABI
 > > ?> > kernels a few months ago.
 > > ?>
 > > ?> The kernel sources are clean Linus' tree, so I guess it must be the
 > > ?> compiler configuration then. ?Indeed, running the above mentioned cross
 > > ?> compiler with -msoft-float -mabi=aapcs-linux even on an empty source
 > > ?> file yields the same error. ?I've cc'd Tony here who I believe builds
 > > ?> these prebuilt compilers at http://kernel.org/pub/tools/crosstool/.
 > >
 > > How was that gcc configured? You can find out by running `arm-linux-gcc -v'.
 > 
 > $ arm-linux-gcc -v
 > Using built-in specs.
 > COLLECT_GCC=arm-linux-gcc
 > COLLECT_LTO_WRAPPER=[path
 > removed]/gcc-4.5.0-nolibc/arm-linux/bin/../libexec/gcc/arm-linux/4.5.0/lto-wrapper
 > Target: arm-linux
 > Configured with: /home/tony/buildall/src/gcc/configure
 > --target=arm-linux --enable-targets=all
 > --prefix=/opt/cross/gcc-4.5.0-nolibc/arm-linux/ --enable-languages=c
 > --with-newlib --without-headers --enable-sjlj-exceptions

That's an OABI compiler. You want a compiler configured for

	--target=arm-unknown-linux-gnueabi

and without that --enable-sjlj-exceptions as well.

OABI is super-legacy and essentially unsupported by current gcc.
