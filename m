From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 May 2013 16:33:36 -0700
Subject: [PATCH v2 1/3] ARM: allow platforms to use generic headers
 without ARCH_MULTIPLATFORM
In-Reply-To: <5192532B.1070705@gmail.com>
References: <1368530845-7415-1-git-send-email-jonathan.austin@arm.com>
 <1368530845-7415-2-git-send-email-jonathan.austin@arm.com>
 <5192532B.1070705@gmail.com>
Message-ID: <20130515233335.GO5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [130514 08:12]:
> On 05/14/2013 06:27 AM, Jonathan Austin wrote:
> > Currently the use of generic mach headers is only is controlled by the same
> > config option as selection of a multiplatform kernel (i.e.
> > ARCH_MULTIPLATFORM). However, there are cases where it is valid to use the
> > generic headers but still build a single platform kernel.
> > 
> > One such example is when using the vexpress platform with a core that does
> > not have an MMU; a multiplatform kernel does not make sense, but use of the
> > generic headers is required by the vexpress platform since 617276307cd4c
> > ("ARM: vexpress: convert to multi-platform").
> > 
> > This patch untangles these two options by introducing a new
> > ARM_GENERIC_HEADERS config option that ARCH_MULTIPLATFORM selects. Other
> > platforms can now select ARM_GENERIC_HEADERS independently.
> 
> I find this name confusing. It is no headers you are selecting and
> generic is a bit overused IMHO. So how about something like
> NEED_NO_MACH_HEADERS to somewhat align to the other header related
> config options (e.g. NEED_MACH_GPIO_H).

Hmm it _looks_ like this won't allow the drivers again to
#include <plat/*.h> and <mach/*.h>. Have you checked that?

It might be worth checking as we really don't want to go back there
again.. Currently arch/arm/Makefile has:

ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
ifeq ($(KBUILD_SRC),)
KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
else
KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
endif
endif

So you may need to do something there to prevent drivers from again
including machdirs and platdirs.

Regards,

Tony
