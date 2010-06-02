From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 2 Jun 2010 14:08:44 +0200
Subject: [PATCH] Add kto and kfrom to input operands list.
In-Reply-To: <1275379600-23498-1-git-send-email-raj.khem@gmail.com>
References: <1275379600-23498-1-git-send-email-raj.khem@gmail.com>
Message-ID: <19462.18892.533099.360440@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Khem Raj writes:
 > When functions incoming parameters are not in input operands list gcc 4.5 does not
 > load the parameters into registers before calling this function but the
 > inline assembly assumes valid addresses inside this function. This
 > breaks the code because r0 and r1 are invalid when execution enters
 > v4wb_copy_user_page ()
 > 
 > Also the constant needs to be used as third input operand so account for that
 > as well.
 > 
 > Tested on qemu arm.
 > 
 > Signed-off-by: Khem Raj <raj.khem@gmail.com>
 > ---
 >  arch/arm/mm/copypage-feroceon.c |    4 ++--

I've tested and verified that this bit enables a gcc-4.5 compiled kernel
to boot on TS-119 (Kirkwood) when combined with my fix for __naked.
With neither or only one of the patches applied, the kernel oopses hard
in copy_user_page() as it tries to start /sbin/init.

So for the copypage-feroceon.c change:
Tested-by: Mikael Pettersson <mikpe@it.uu.se>

To elaborate, the copy_user_page() functions in these copypage-*.c files
break in two ways with gcc-4.5:
- they are static __naked functions, and gcc-4.5 erroneously clones
  them and changes their calling conventions in ways that don't match
  the expectations of their asm() bodies, causing runtime crashes;
  my patch to make __naked imply noinline and noclone fixes that
- the asm() bodies of these __naked functions have inadequate input
  parameter constraints, in particular they fail to declare any
  dependencies on the functions' formal parameters; gcc-4.5 sees this
  and skips the parameter setup before calling these functions, causing
  runtime crashes; Khem's patch (this one) fixes that
  (copypage-xscale.c already had correct asm() constraints so it works
  with only the __naked fix, these other copypage-*.c files need both
  patches to work)

These patches are no-ops for earlier compilers since they merely
formalise the parameter passing behaviour that the kernel has been
expecting all along.

/Mikael
