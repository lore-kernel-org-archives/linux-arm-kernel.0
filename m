From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 07 Apr 2017 09:02:01 +0100
Subject: [RFC kvm-unit-tests PATCH 9/8] Makefiles: Fix up the powerpc
 build include and link paths
In-Reply-To: <1491548290-11401-1-git-send-email-thuth@redhat.com>
References: <20170406190727.5624-9-alex.bennee@linaro.org>
 <1491548290-11401-1-git-send-email-thuth@redhat.com>
Message-ID: <87o9w8abnq.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thomas Huth <thuth@redhat.com> writes:

> The changes for out-of-tree builds are here pretty much the same
> as for the ARM Makefile.common.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

It was only when I posted I realised that there was only one
architecture left (too used to QEMUs multitude). I didn't intend for
PowerPC to be the last puppy in the shop!

Thanks for you patch. Applied ;-)

> ---
>  powerpc/Makefile.common | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/powerpc/Makefile.common b/powerpc/Makefile.common
> index e536ffe..1fbcafb 100644
> --- a/powerpc/Makefile.common
> +++ b/powerpc/Makefile.common
> @@ -12,7 +12,10 @@ tests-common = \
>  	$(TEST_DIR)/tm.elf \
>  	$(TEST_DIR)/sprs.elf
>
> -tests-all = $(tests-common) $(tests)
> +scripts-common += $(TEST_DIR)/run
> +scripts-common += $(TEST_DIR)/unittests.cfg
> +
> +tests-all = $(tests-common) $(tests) $(scripts_common)
>  all: $(TEST_DIR)/boot_rom.bin $(tests-all)
>
>  ##################################################################
> @@ -21,14 +24,14 @@ CFLAGS += -std=gnu99
>  CFLAGS += -ffreestanding
>  CFLAGS += -Wextra
>  CFLAGS += -O2
> -CFLAGS += -I lib -I lib/libfdt
> +CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/libfdt -I lib
>  CFLAGS += -Wa,-mregnames
>
>  # We want to keep intermediate files
>  .PRECIOUS: %.o
>
>  asm-offsets = lib/$(ARCH)/asm-offsets.h
> -include scripts/asm-offsets.mak
> +include $(SRCDIR)/scripts/asm-offsets.mak
>
>  cflatobjs += lib/util.o
>  cflatobjs += lib/alloc.o
> @@ -44,10 +47,11 @@ cflatobjs += lib/powerpc/smp.o
>  FLATLIBS = $(libcflat) $(LIBFDT_archive)
>  %.elf: CFLAGS += $(arch_CFLAGS)
>  %.elf: LDFLAGS = $(arch_LDFLAGS) -nostdlib -pie -n
> -%.elf: %.o $(FLATLIBS) powerpc/flat.lds $(cstart.o) $(reloc.o)
> -	$(CC) $(CFLAGS) -c -o $(@:.elf=.aux.o) lib/auxinfo.c -DPROGNAME=\"$@\"
> +%.elf: %.o $(FLATLIBS) $(SRCDIR)/powerpc/flat.lds $(cstart.o) $(reloc.o)
> +	$(CC) $(CFLAGS) -c -o $(@:.elf=.aux.o) $(SRCDIR)/lib/auxinfo.c \
> +		-DPROGNAME=\"$@\"
>  	$(LD) $(LDFLAGS) -o $@ \
> -		-T powerpc/flat.lds --build-id=none \
> +		-T $(SRCDIR)/powerpc/flat.lds --build-id=none \
>  		$(filter %.o, $^) $(FLATLIBS) $(@:.elf=.aux.o)
>  	$(RM) $(@:.elf=.aux.o)
>  	@echo -n Checking $@ for unsupported reloc types...


--
Alex Benn?e
