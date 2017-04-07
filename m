From: drjones@redhat.com (Andrew Jones)
Date: Fri, 7 Apr 2017 14:20:10 +0200
Subject: [RFC kvm-unit-tests PATCH 4/8] Makefiles: use explicit path for
 including sub-Makefiles
In-Reply-To: <20170406190727.5624-5-alex.bennee@linaro.org>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
 <20170406190727.5624-5-alex.bennee@linaro.org>
Message-ID: <20170407122010.umftrqr2qqd6g3q4@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 08:07:23PM +0100, Alex Benn?e wrote:
> I would of thought VPATH took care of this but apparently not.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---
>  Makefile               | 8 ++++----
>  arm/Makefile           | 2 +-
>  arm/Makefile.arm       | 2 +-
>  arm/Makefile.arm64     | 2 +-
>  powerpc/Makefile       | 2 +-
>  powerpc/Makefile.ppc64 | 2 +-
>  x86/Makefile           | 2 +-
>  x86/Makefile.i386      | 2 +-
>  x86/Makefile.x86_64    | 2 +-
>  9 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 80bc57e..781186e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -32,14 +32,14 @@ cflatobjs := \
>  	lib/stack.o
>  
>  # libfdt paths
> -LIBFDT_objdir = lib/libfdt
> -LIBFDT_srcdir = lib/libfdt
> +LIBFDT_objdir = $(SRCDIR)/lib/libfdt
> +LIBFDT_srcdir = $(SRCDIR)/lib/libfdt
>  LIBFDT_archive = $(LIBFDT_objdir)/libfdt.a
>  LIBFDT_include = $(addprefix $(LIBFDT_srcdir)/,$(LIBFDT_INCLUDES))
>  LIBFDT_version = $(addprefix $(LIBFDT_srcdir)/,$(LIBFDT_VERSION))

Can't we just do VPATH += $LIBFDT_srcdir instead?

>  
> -#include architecure specific make rules
> -include $(TEST_DIR)/Makefile
> +#include architecture specific make rules
> +include $(SRCDIR)/$(TEST_DIR)/Makefile

Yeah, it appears VPATH doesn't apply to 'include', and I don't see any
variable that does...  The only way to get make to look elsewhere is
by adding '-I dir' to the make invocation, which we don't want to require.
I guess adding SRCDIR to all include lines, like this patch does, is the
only way to go.

>  
>  # cc-option
>  # Usage: OP_CFLAGS+=$(call cc-option, -falign-functions=0, -malign-functions=0)
> diff --git a/arm/Makefile b/arm/Makefile
> index 369a38b..8a007ab 100644
> --- a/arm/Makefile
> +++ b/arm/Makefile
> @@ -1 +1 @@
> -include $(TEST_DIR)/Makefile.$(ARCH)
> +include $(SRCDIR)/$(TEST_DIR)/Makefile.$(ARCH)
> diff --git a/arm/Makefile.arm b/arm/Makefile.arm
> index 92f3757..6b57284 100644
> --- a/arm/Makefile.arm
> +++ b/arm/Makefile.arm
> @@ -22,6 +22,6 @@ cflatobjs += lib/arm/stack.o
>  # arm specific tests
>  tests =
>  
> -include $(TEST_DIR)/Makefile.common
> +include $(SRCDIR)/$(TEST_DIR)/Makefile.common
>  
>  arch_clean: arm_clean
> diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
> index 0b0761c..b5fc1ec 100644
> --- a/arm/Makefile.arm64
> +++ b/arm/Makefile.arm64
> @@ -14,7 +14,7 @@ cflatobjs += lib/arm64/spinlock.o
>  # arm64 specific tests
>  tests =
>  
> -include $(TEST_DIR)/Makefile.common
> +include $(SRCDIR)/$(TEST_DIR)/Makefile.common
>  
>  arch_clean: arm_clean
>  	$(RM) lib/arm64/.*.d
> diff --git a/powerpc/Makefile b/powerpc/Makefile
> index 369a38b..8a007ab 100644
> --- a/powerpc/Makefile
> +++ b/powerpc/Makefile
> @@ -1 +1 @@
> -include $(TEST_DIR)/Makefile.$(ARCH)
> +include $(SRCDIR)/$(TEST_DIR)/Makefile.$(ARCH)
> diff --git a/powerpc/Makefile.ppc64 b/powerpc/Makefile.ppc64
> index 3da3a83..3c0294a 100644
> --- a/powerpc/Makefile.ppc64
> +++ b/powerpc/Makefile.ppc64
> @@ -20,7 +20,7 @@ cflatobjs += lib/ppc64/spinlock.o
>  # ppc64 specific tests
>  tests =
>  
> -include $(TEST_DIR)/Makefile.common
> +include $(SRCDIR)/$(TEST_DIR)/Makefile.common
>  
>  arch_clean: powerpc_clean
>  	$(RM) lib/ppc64/.*.d
> diff --git a/x86/Makefile b/x86/Makefile
> index 369a38b..8a007ab 100644
> --- a/x86/Makefile
> +++ b/x86/Makefile
> @@ -1 +1 @@
> -include $(TEST_DIR)/Makefile.$(ARCH)
> +include $(SRCDIR)/$(TEST_DIR)/Makefile.$(ARCH)
> diff --git a/x86/Makefile.i386 b/x86/Makefile.i386
> index 284b9e5..d801b80 100644
> --- a/x86/Makefile.i386
> +++ b/x86/Makefile.i386
> @@ -7,4 +7,4 @@ cflatobjs += lib/x86/setjmp32.o
>  tests = $(TEST_DIR)/taskswitch.flat $(TEST_DIR)/taskswitch2.flat \
>  	$(TEST_DIR)/cmpxchg8b.flat
>  
> -include $(TEST_DIR)/Makefile.common
> +include $(SRCDIR)/$(TEST_DIR)/Makefile.common
> diff --git a/x86/Makefile.x86_64 b/x86/Makefile.x86_64
> index 3e2821e..30f82a6 100644
> --- a/x86/Makefile.x86_64
> +++ b/x86/Makefile.x86_64
> @@ -17,7 +17,7 @@ tests += $(TEST_DIR)/vmx.flat
>  tests += $(TEST_DIR)/tscdeadline_latency.flat
>  tests += $(TEST_DIR)/intel-iommu.flat
>  
> -include $(TEST_DIR)/Makefile.common
> +include $(SRCDIR)/$(TEST_DIR)/Makefile.common
>  
>  $(TEST_DIR)/hyperv_clock.elf: $(TEST_DIR)/hyperv_clock.o
>  
> -- 
> 2.11.0
>

Thanks,
drew
