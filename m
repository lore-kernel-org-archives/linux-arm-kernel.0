From: jan.glauber@gmail.com (Jan Glauber)
Date: Fri, 27 Jun 2014 10:51:27 +0200
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140627085125.GA7088@hal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 22, 2014 at 10:11:49PM -0500, Nathan Lynch wrote:
> Provide fast userspace implementations of gettimeofday and
> clock_gettime on systems that implement the generic timers extension
> defined in ARMv7.  This follows the example of arm64 in conception but
> significantly differs in some aspects of the implementation (C vs
> assembly, mainly).

Hi Nathan,

applying your patches I get the following compile error under Ubuntu 12.04:

  CC      arch/arm/kernel/vdso.o
  LDS     arch/arm/kernel/vdso/vdso.lds
  CC      arch/arm/kernel/vdso/vgettimeofday.o
  AS      arch/arm/kernel/vdso/datapage.o
  VDSOL   arch/arm/kernel/vdso/vdso.so.raw
  HOSTCC  arch/arm/kernel/vdso/vdsomunge
arch/arm/kernel/vdso/vdsomunge.c: In function ?main?:
arch/arm/kernel/vdso/vdsomunge.c:152:16: error: ?EF_ARM_ABI_FLOAT_HARD? undeclared (first use in this function)
arch/arm/kernel/vdso/vdsomunge.c:152:16: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/kernel/vdso/vdsomunge.c:156:34: error: ?EF_ARM_ABI_FLOAT_SOFT? undeclared (first use in this function)
make[2]: *** [arch/arm/kernel/vdso/vdsomunge] Error 1
make[1]: *** [arch/arm/kernel/vdso] Error 2
make: *** [arch/arm/kernel] Error 2

Looks like the libc dev is too old (EF_ARM_ABI_FLOAT_* not in /usr/include/elf.h).
On a more recent Ubuntu it compiles fine. Not sure how to solve this, maybe disable
vdso if the libc is too old?

Regards, Jan
