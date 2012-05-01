From: paul.chavent@fnac.net (Paul Chavent)
Date: Tue, 01 May 2012 17:24:48 +0200
Subject: Running linux with mmu disabled on arm (AT91).
Message-ID: <4FA00040.8000207@fnac.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

I'd like to try linux on an AT91SAM9G20 (i have a linuxstamp board), with MMU disabled (the Hyok-Sung Choi & Hee-Chul Yun paper demonstrate that it could be possible).

All the code seems to be present in the kernel...
So i would like to share my experience.

(1) I had to make two little changes in the kernel code :
     - I'm not able to change the REMAP_VECTOR_TO_DRAM. I have submitted the problem to the kbuild mailing list (http://www.spinics.net/lists/linux-kbuild/msg06153.html).
     - The soc_detect code that init the at91_soc_initdata structure is never called. Later this structure is used unitialized.
     I'm currently using the joined patch as a workaround. Someone can review it please ?

(2) I used to run the module with a "classic system" based on linux + eglibc, and i needed only one toolchain (arm-xxx-linux-gnueabi) for the kernel and the userspace apps.
     I found that for the nommu case i wasn't able to build the kernel with the userspace toolchain.
     So I had to build 2 toolchain, based on binutils 2.22, gcc 4.7, uclibc 0.9.33.1 and linux 3.2.14 :
       - an arm-xxx-eabi toolchain for the kernel
       - an arm-xxx-uclinux-uclibceabi for the userspace apps
     Do you confirm that it is not possible to compile the kernel with arm-xxx-uclinux-uclibceabi ? Or, may i have misconfigured the toolchain (i join the toolchain build procedure) ?

(3) The arm-xxx-uclinux-uclibceabi with elf2flt seems to produce running bins only if it is build with the uClibc DOPIC not set.
     Is it required to disable DOPIC ?
     Moreover, i can't run bins produced with a arm-xxx-linux-uclibceabi toolchain and -Wl,-elf2flt (not uclinux one). Is it the expected behavior ?

(4) The elf2flt needs to be updated to be aware of the exidx section, and some reloc types. I join the patch i currently use.

Given these observations, i've been able to run a linux with an hello world as the /init process.

My next tests will be to run threaded programs, c++ programs, then busybox.


Thanks for your attention.

Paul.

-------------- next part --------------
diff -abBruN linux-3.2.14.orig/arch/arm/Kconfig-nommu linux-3.2.14.mod/arch/arm/Kconfig-nommu
--- linux-3.2.14.orig/arch/arm/Kconfig-nommu	2012-04-02 18:53:31.000000000 +0200
+++ linux-3.2.14.mod/arch/arm/Kconfig-nommu	2012-04-15 12:52:05.000000000 +0200
@@ -34,8 +34,7 @@
 	  used instead of the auto-probing which utilizes the register.
 
 config REMAP_VECTORS_TO_RAM
-	bool 'Install vectors to the beginning of RAM' if DRAM_BASE
-	depends on DRAM_BASE
+	bool 'Install vectors to the beginning of RAM'
 	help
 	  The kernel needs to change the hardware exception vectors.
 	  In nommu mode, the hardware exception vectors are normally
diff -abBruN linux-3.2.14.orig/arch/arm/mm/nommu.c linux-3.2.14.mod/arch/arm/mm/nommu.c
--- linux-3.2.14.orig/arch/arm/mm/nommu.c	2012-04-02 18:53:31.000000000 +0200
+++ linux-3.2.14.mod/arch/arm/mm/nommu.c	2012-04-16 15:50:47.000000000 +0200
@@ -31,12 +31,23 @@
 {
 }
 
+static void __init devicemaps_init(struct machine_desc *mdesc)
+{
+	/*
+	 * Ask the machine support to map in the statically mapped devices.
+	 */
+	if (mdesc->map_io)
+		mdesc->map_io();
+}
+
 /*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps, and sets up the zero page, bad page and bad page tables.
  */
 void __init paging_init(struct machine_desc *mdesc)
 {
+	devicemaps_init(mdesc);
+
 	bootmem_init();
 }
 
-------------- next part --------------
>From bd2014eb59dea812e396a5f299f53ed03629bdad Mon Sep 17 00:00:00 2001
From: Paul Chavent <pchavent@wdcsd911h.onecert.fr>
Date: Fri, 27 Apr 2012 10:09:20 +0200
Subject: [PATCH] Update arm support.

---
 .gitignore     |    1 +
 Makefile.in    |    2 +-
 arm-elf2flt.ld |  221 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 elf2flt.c      |   27 +++++++
 4 files changed, 250 insertions(+), 1 deletions(-)
 create mode 100644 arm-elf2flt.ld

diff --git a/.gitignore b/.gitignore
index 92ff5f6..e0e0bd5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -22,3 +22,4 @@ elf2flt
 elf2flt.ld
 flthdr
 ld-elf2flt
+ld-elf2flt.sh
\ No newline at end of file
diff --git a/Makefile.in b/Makefile.in
index 81e1afc..f98421e 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -42,7 +42,7 @@ ifneq ($(strip $(shell gcc -v 2>&1 | grep "cygwin")),)
 endif
 
 LDFILE= elf2flt.ld
-ifeq ($(strip $(CPU)),e1)
+ifeq ($(filter-out e1 arm,$(CPU)),)
 SRC_LDFILE= $(srcdir)/$(CPU)-elf2flt.ld
 else 
 SRC_LDFILE= elf2flt.ld
diff --git a/arm-elf2flt.ld b/arm-elf2flt.ld
new file mode 100644
index 0000000..b57999c
--- /dev/null
+++ b/arm-elf2flt.ld
@@ -0,0 +1,221 @@
+
+ENTRY (_start)
+
+MEMORY {
+	flatmem : ORIGIN = 0x0, LENGTH = 0x1000000
+}
+
+PHDRS {
+	text PT_LOAD ;
+	data PT_LOAD ;
+}
+
+SECTIONS {
+
+	.text 0x0 : {
+		. = ALIGN(0x4) ;
+		_stext = . ;
+		*(.text)
+		*(.text.*)
+		*(.gnu.warning)
+		*(.stub)
+		*(.gnu.linkonce.t*)
+		*(.glue_7t)
+		*(.glue_7)
+		*(.vfp11_veneer)
+		*(.jcr)
+		KEEP (*(.init))
+		KEEP (*(.fini))
+
+W_RODAT		*(.rodata)
+W_RODAT		*(.rodata1)
+W_RODAT		*(.rodata.*)
+W_RODAT		*(.gnu.linkonce.r*)
+
+                /* .ARM.extab name sections containing exception unwinding information */
+		*(.ARM.extab* .gnu.linkonce.armextab.*)
+		/* This is special code area at the end of the normal
+		   text section.  It contains a small lookup table at
+		   the start followed by the code pointed to by entries
+		   in the lookup table.  */
+		. = ALIGN (4) ;
+		PROVIDE(__ctbp = .);
+		*(.call_table_data)
+		*(.call_table_text)
+	} > flatmem :text
+
+        /* .ARM.exidx name sections containing index entries for section unwinding */
+	/* .ARM.exidx is sorted, so has to go in its own output section.  */
+	 __exidx_start = .;
+	.ARM.exidx :
+	{
+		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
+	} > flatmem
+	__exidx_end = .;
+
+	. = ALIGN(0x20) ;
+	_etext = . ;
+
+	.data : {
+                . = ALIGN(0x4) ;
+		_sdata = . ;
+		__data_start = . ;
+		data_start = . ;
+		*(.got.plt)
+		*(.got)
+		FILL(0) ;
+		. = ALIGN(0x20) ;
+		LONG(-1)
+		. = ALIGN(0x20) ;
+R_RODAT		*(.rodata)
+R_RODAT		*(.rodata1)
+R_RODAT		*(.rodata.*)
+R_RODAT		*(.gnu.linkonce.r*)
+		*(.data)
+		*(.data1)
+		*(.data.*)
+		*(.gnu.linkonce.d*)
+
+		/* Microblaze has .sdata and .sbss (small bss).  They must
+		   be contiguous, so please don't move any of this. JW */
+		_ssrw = . ;
+		*(.sdata)
+		*(.sdata.*)
+		*(.sbss)			/* Don't move this! */
+		*(.gnu.linkonce.sb*)
+		_essrw = . ;
+
+		_ssrw_size = _essrw - _ssrw;
+		PROVIDE(_SDA_BASE_ = _ssrw + (_ssrw_size / 2));
+
+		*(.gnu.linkonce.s.*)
+		*(__libc_atexit)
+		*(__libc_subinit)
+		*(__libc_subfreeres)
+
+		/* microblaze-specific read-only small data area
+		   and associated locating symbols */
+		_ssro = . ;
+		*(.sdata2)
+		_essro = . ;
+		_ssro_size = _essro - _ssro;
+		PROVIDE(_SDA2_BASE_ = _ssro + (_ssro_size / 2));
+
+		. = ALIGN(4) ;
+TOR:		__CTOR_LIST__ = .;
+TOR:		LONG((__CTOR_END__ - __CTOR_LIST__) / 4 - 2)
+SINGLE_LINK:	/* gcc uses crtbegin.o to find the start of
+SINGLE_LINK:	   the constructors, so we make sure it is
+SINGLE_LINK:	   first.  Because this is a wildcard, it
+SINGLE_LINK:	   doesn't matter if the user does not
+SINGLE_LINK:	   actually link against crtbegin.o; the
+SINGLE_LINK:	   linker won't look for a file to match a
+SINGLE_LINK:	   wildcard.  The wildcard also means that it
+SINGLE_LINK:	   doesn't matter which directory crtbegin.o
+SINGLE_LINK:	   is in.  */
+SINGLE_LINK:	KEEP (*crtbegin*.o(.ctors))
+SINGLE_LINK:	/* We don't want to include the .ctor section from
+SINGLE_LINK:	   from the crtend.o file until after the sorted ctors.
+SINGLE_LINK:	   The .ctor section from the crtend file contains the
+SINGLE_LINK:	   end of ctors marker and it must be last */
+SINGLE_LINK:	KEEP (*(EXCLUDE_FILE (*crtend*.o ) .ctors))
+SINGLE_LINK:	KEEP (*(SORT(.ctors.*)))
+		KEEP (*(.ctors))
+TOR:		LONG(0)
+TOR:		__CTOR_END__ = .;
+TOR:		__DTOR_LIST__ = .;
+TOR:		LONG((__DTOR_END__ - __DTOR_LIST__) / 4 - 2)
+SINGLE_LINK:	KEEP (*crtbegin*.o(.dtors))
+SINGLE_LINK:	KEEP (*(EXCLUDE_FILE (*crtend*.o ) .dtors))
+SINGLE_LINK:	KEEP (*(SORT(.dtors.*)))
+		KEEP (*(.dtors))
+TOR:		LONG(0)
+TOR:		__DTOR_END__ = .;
+
+		PROVIDE (__preinit_array_start = .);
+		KEEP (*(.preinit_array))
+		PROVIDE (__preinit_array_end = .);
+
+		PROVIDE (__init_array_start = .);
+		KEEP (*(SORT(.init_array.*)))
+		KEEP (*(.init_array))
+		PROVIDE (__init_array_end = .);
+
+		PROVIDE (__fini_array_start = .);
+		KEEP (*(.fini_array))
+		KEEP (*(SORT(.fini_array.*)))
+		PROVIDE (__fini_array_end = .);
+	} > flatmem :data
+
+	.note.ABI-tag : { *(.note.ABI-tag) } > flatmem
+	.eh_frame_hdr : { *(.eh_frame_hdr) } > flatmem
+	.eh_frame : { KEEP(*(.eh_frame)) } > flatmem
+	.gcc_except_table : {
+		KEEP(*(.gcc_except_table))
+		KEEP(*(.gcc_except_table.*))
+	} >flatmem
+
+	. = ALIGN(0x10) ;
+	_edata = . ;
+
+	.bss : {
+		. = ALIGN(0x4) ;
+		_sbss = ALIGN(0x4) ;
+		__bss_start = . ;
+		*(.dynsbss)
+		*(.sbss)
+		*(.sbss.*)
+		*(.scommon)
+		*(.dynbss)
+		*(.bss)
+		*(.bss.*)
+		*(.bss*)
+		*(.gnu.linkonce.b*)
+		*(COMMON)
+		. = ALIGN(0x10) ;
+		_ebss = . ;
+		_end = . ;
+		end = . ;
+	} > flatmem
+
+	.stack : {
+		. = ALIGN(0x4);
+		_stack_start = .;
+	}
+
+	.junk 0 : { *(.rel*) *(.rela*) }
+	/DISCARD/ : { *(.note.GNU-stack) }
+	/* Stabs debugging sections.    */
+	.stab 0 : { *(.stab) }
+	.stabstr 0 : { *(.stabstr) }
+	.stab.excl 0 : { *(.stab.excl) }
+	.stab.exclstr 0 : { *(.stab.exclstr) }
+	.stab.index 0 : { *(.stab.index) }
+	.stab.indexstr 0 : { *(.stab.indexstr) }
+	.comment 0 : { *(.comment) }
+	/* DWARF debug sections.
+	   Symbols in the DWARF debugging sections are relative to the beginning
+	   of the section so we begin them at 0.  */
+	/* DWARF 1 */
+	.debug          0 : { *(.debug) }
+	.line           0 : { *(.line) }
+	/* GNU DWARF 1 extensions */
+	.debug_srcinfo  0 : { *(.debug_srcinfo) }
+	.debug_sfnames  0 : { *(.debug_sfnames) }
+	/* DWARF 1.1 and DWARF 2 */
+	.debug_aranges  0 : { *(.debug_aranges) }
+	.debug_pubnames 0 : { *(.debug_pubnames) }
+	/* DWARF 2 */
+	.debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
+	.debug_abbrev   0 : { *(.debug_abbrev) }
+	.debug_line     0 : { *(.debug_line) }
+	.debug_frame    0 : { *(.debug_frame) }
+	.debug_str      0 : { *(.debug_str) }
+	.debug_loc      0 : { *(.debug_loc) }
+	.debug_macinfo  0 : { *(.debug_macinfo) }
+	/* SGI/MIPS DWARF 2 extensions */
+	.debug_weaknames 0 : { *(.debug_weaknames) }
+	.debug_funcnames 0 : { *(.debug_funcnames) }
+	.debug_typenames 0 : { *(.debug_typenames) }
+	.debug_varnames  0 : { *(.debug_varnames) }
+}
diff --git a/elf2flt.c b/elf2flt.c
index 2fea9b5..1a7ef88 100644
--- a/elf2flt.c
+++ b/elf2flt.c
@@ -54,6 +54,8 @@ const char *elf2flt_progname;
 
 #if defined(TARGET_h8300)
 #include <elf/h8.h>      /* TARGET_* ELF support for the BFD library            */
+#elif defined(TARGET_arm)
+#include "elf/arm.h"
 #elif defined(__CYGWIN__) || defined(__MINGW32__) || defined(TARGET_nios) || defined(TARGET_nios2)
 #include "cygwin-elf.h"	/* Cygwin uses a local copy */
 #elif defined(TARGET_microblaze)
@@ -639,12 +641,16 @@ dump_symbols(symbols, number_of_symbols);
 					relocation_needed = 1;
 					break;
 				case R_ARM_REL32:
+				case R_ARM_JUMP24:
+				case R_ARM_CALL:
 				case R_ARM_THM_PC11:
 				case R_ARM_THM_PC22:
 				case R_ARM_PC24:
 				case R_ARM_PLT32:
 				case R_ARM_GOTPC:
 				case R_ARM_GOT32:
+				case R_ARM_PREL31:
+				case R_ARM_NONE:
 					relocation_needed = 0;
 					break;
 				default:
@@ -1702,6 +1708,27 @@ int main(int argc, char *argv[])
     }
   }
   
+  if (verbose) {
+    printf("  verbose      = %d\n"
+           "  load_to_ram  = %d\n"
+           "  ktrace       = %d\n"
+           "  docompress   = %d\n"
+           "  pfile        = \"%s\"\n"
+           "  ofile        = \"%s\"\n"
+           "  use_resolved = %d\n"
+           "  stack        = %d\n"
+           "  rel_file     = \"%s\\n",
+           verbose     ,
+           load_to_ram ,
+           ktrace      ,
+           docompress  ,
+           pfile       ,
+           ofile       ,
+           use_resolved,
+           stack       ,
+           rel_file    );
+  }
+
   /*
    * if neither the -r or -p options was given,  default to
    * a RAM load as that is the only option that makes sense.
-- 
1.6.4

-------------- next part --------------
#!/bin/bash

################################################################################
# Setup framework                                                              #
################################################################################

source env_pkg.sh

################################################################################
# Set configuration variables                                                  #
################################################################################

GMP_NAME=gmp
GMP_VERSION=5.0.4
GMP_EXTENSION=.tar.bz2
GMP_LOCATIONS=http://ftp.gnu.org/gnu/gmp

MPFR_NAME=mpfr
MPFR_VERSION=3.1.0
MPFR_EXTENSION=.tar.bz2
MPFR_LOCATIONS=http://www.mpfr.org/mpfr-current

MPC_NAME=mpc
MPC_VERSION=0.9
MPC_EXTENSION=.tar.gz
MPC_LOCATIONS=http://www.multiprecision.org/mpc/download

BINUTILS_NAME=binutils
BINUTILS_VERSION=2.22
BINUTILS_EXTENSION=.tar.bz2
BINUTILS_LOCATIONS=http://ftp.gnu.org/gnu/binutils
BINUTILS_CONFIGURE_OPTIONS=${BINUTILS_CONFIGURE_OPTIONS:-""}

ELF2FLT_NAME=elf2flt
ELF2FLT_VERSION=git
ELF2FLT_EXTENSION=.tar.bz2
ELF2FLT_LOCATIONS=git://sources.blackfin.uclinux.org/git/users/vapier/elf2flt.git
ELF2FLT_PATCHES=${ELF2FLT_PATCHES:-"arm"}

GCC_NAME=gcc
GCC_VERSION=${GCC_VERSION:-4.7.0}
GCC_EXTENSION=.tar.bz2
GCC_LOCATIONS=http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}
GCC_STAGE_1_CONFIGURE_OPTIONS=${GCC_STAGE_1_CONFIGURE_OPTIONS:-""}
GCC_CONFIGURE_OPTIONS=${GCC_CONFIGURE_OPTIONS:-""}

UCLIBC_NAME=uClibc
UCLIBC_VERSION=${UCLIBC_VERSION:-0.9.33.1}
UCLIBC_EXTENSION=.tar.xz
UCLIBC_LOCATIONS=http://www.uclibc.org/downloads
UCLIBC_CONFIG=${UCLIBC_CONFIG:-"def.config"}

LINUX_NAME=linux
LINUX_VERSION=${LINUX_VERSION:-3.2.14}
LINUX_EXTENSION=.tar.bz2
LINUX_LOCATIONS=http://www.kernel.org/pub/linux/kernel/v3.x
LINUX_PATCHES=${LINUX_PATCHES:-""}
LINUX_CONFIG=${LINUX_CONFIG:-"def.config"}

LINUXRT_VERSION=${LINUXRT_VERSION:-""}
LINUXRT_EXTENSION=.patch.bz2
LINUXRT_LOCATIONS=http://www.kernel.org//pub/linux/kernel/projects/rt/${LINUX_VERSION%.*}{,/older}

################################################################################
# binutils                                                                     #
################################################################################
toolchain_build_binutils()
{
    # download
    pkg_source_get ${BINUTILS_NAME} ${BINUTILS_VERSION} ${BINUTILS_EXTENSION} ${BINUTILS_LOCATIONS}

    # extract
    pkg_source_extract ${BINUTILS_NAME} ${BINUTILS_VERSION} ${BINUTILS_EXTENSION}

    # build
    pkg_build_enter ${BINUTILS_NAME} ${BINUTILS_VERSION}

    CFLAGS="${CFLAGS} ${HOST_CFLAGS}" \
    ${PKG_SOURCES}/binutils-${BINUTILS_VERSION}/configure \
	--prefix=${PKG_TOOLCHAIN_PREFIX} \
	--with-sysroot=${PKG_TOOLCHAIN_SYSROOT} \
	--build=${BUILD} \
	--host=${HOST} \
	--target=${TARGET} \
        ${GCC_TARGET_CPU} \
	--disable-nls \
	--disable-multilib \
	--enable-shared \
        \
	${BINUTILS_CONFIGURE_OPTIONS} \
	\
	-v

    $MAKE configure-host

    $MAKE

    $MAKE install

    pkg_build_leave ${BINUTILS_NAME} ${BINUTILS_VERSION}
}

################################################################################
#                                                                              #
################################################################################
toolchain_build_elf2flt()
{
    # download
    pkg_source_get ${ELF2FLT_NAME} ${ELF2FLT_VERSION} ${ELF2FLT_EXTENSION} ${ELF2FLT_LOCATIONS}

    # extract
    pkg_source_extract ${ELF2FLT_NAME} ${ELF2FLT_VERSION} ${ELF2FLT_EXTENSION}

    # patch
    pkg_source_patch ${ELF2FLT_NAME} ${ELF2FLT_VERSION} ${ELF2FLT_PATCHES}

    # build for host
    pkg_build_enter ${ELF2FLT_NAME} ${ELF2FLT_VERSION}

    local binutils_src_dir=${PKG_SOURCES}/binutils-${BINUTILS_VERSION}
    local binutils_bld_dir=${PKG_BUILDS}/binutils-${BINUTILS_VERSION}

    CFLAGS="${CFLAGS} ${HOST_CFLAGS}" \
    ${PKG_SOURCES}/elf2flt-${ELF2FLT_VERSION}/configure \
	--prefix=${PKG_TOOLCHAIN_PREFIX} \
	--build=${BUILD} \
	--host=${HOST} \
	--target=${TARGET} \
        --with-binutils-include-dir=${binutils_src_dir}/include \
        --with-bfd-include-dir=${binutils_bld_dir}/bfd \
        --with-libbfd=${binutils_bld_dir}/bfd/libbfd.a \
        --with-libiberty=${binutils_bld_dir}/libiberty/libiberty.a

    $MAKE

    $MAKE install

    pkg_build_leave ${ELF2FLT_NAME} ${ELF2FLT_VERSION}
}

################################################################################
# gcc stage 1 (static without libc headers)                                    #
################################################################################
toolchain_build_gcc_stage_1()
{
    # download
    pkg_source_get ${GMP_NAME} ${GMP_VERSION} ${GMP_EXTENSION} ${GMP_LOCATIONS}
    pkg_source_get ${MPFR_NAME} ${MPFR_VERSION} ${MPFR_EXTENSION} ${MPFR_LOCATIONS}
    pkg_source_get ${MPC_NAME} ${MPC_VERSION} ${MPC_EXTENSION} ${MPC_LOCATIONS}
    #pkg_source_get ${GCC_NAME}-core ${GCC_VERSION} ${GCC_EXTENSION} ${GCC_LOCATIONS}
    pkg_source_get ${GCC_NAME} ${GCC_VERSION} ${GCC_EXTENSION} ${GCC_LOCATIONS}

    # extract
    pkg_source_extract ${GMP_NAME} ${GMP_VERSION} ${GMP_EXTENSION}
    pkg_source_extract ${MPFR_NAME} ${MPFR_VERSION} ${MPFR_EXTENSION}
    pkg_source_extract ${MPC_NAME} ${MPC_VERSION} ${MPC_EXTENSION}
    #pkg_source_extract ${GCC_NAME}-core ${GCC_VERSION} ${GCC_EXTENSION}
    pkg_source_extract ${GCC_NAME} ${GCC_VERSION} ${GCC_EXTENSION}

    # hack hack hack
    if [ ! -L ${PKG_SOURCES}/gcc-${GCC_VERSION}/gmp ]
    then
	ln -s ${PKG_SOURCES}/gmp-${GMP_VERSION} ${PKG_SOURCES}/gcc-${GCC_VERSION}/gmp
    fi
    if [ ! -L ${PKG_SOURCES}/gcc-${GCC_VERSION}/mpfr ]
    then
	ln -s ${PKG_SOURCES}/mpfr-${MPFR_VERSION} ${PKG_SOURCES}/gcc-${GCC_VERSION}/mpfr
    fi
    if [ ! -L ${PKG_SOURCES}/gcc-${GCC_VERSION}/mpc ]
    then
	ln -s ${PKG_SOURCES}/mpc-${MPC_VERSION} ${PKG_SOURCES}/gcc-${GCC_VERSION}/mpc
    fi

    # build
    pkg_build_enter ${GCC_NAME} ${GCC_VERSION}

    ASFLAGS="${ASFLAGS} ${HOST_ASFLAGS}" \
    CFLAGS="${CFLAGS} ${HOST_CFLAGS}" \
    ${PKG_SOURCES}/gcc-${GCC_VERSION}/configure \
        --prefix=${PKG_TOOLCHAIN_PREFIX} \
        --with-sysroot=${PKG_TOOLCHAIN_SYSROOT} \
	--build=${BUILD} \
	--host=${HOST} \
        --target=${TARGET} \
        ${GCC_TARGET_CPU} \
	${GCC_TARGET_TUNE} \
	${GCC_TARGET_ARCH} \
	${GCC_TARGET_FLOAT} \
        ${GCC_TARGET_ABI} \
        \
        --without-ppl \
        --without-cloog \
        --with-mpfr-include=${PKG_SOURCES}/gcc-${GCC_VERSION}/mpfr/src \
        --with-mpfr-lib=${PKG_BUILDS}/gcc-${GCC_VERSION}/mpfr/src/.libs \
	--disable-nls \
        --enable-clocale=generic \
        --enable-languages=c \
        \
	--disable-multilib \
	--disable-decimal-float \
	--disable-libquadmath \
	--disable-libmudflap \
	--disable-libssp \
	--disable-libgomp \
	\
	--disable-shared \
	--disable-threads \
	\
        --without-headers \
	--with-newlib \
        \
	${GCC_STAGE_1_CONFIGURE_OPTIONS} \
	\
	-v
    # --without-headers and --with-newlib make gcc believe that there
    # is no c library available (yet)

    $MAKE all-gcc \
	ASFLAGS_FOR_TARGET="${ASFLAGS_FOR_TARGET} ${TARGET_ASFLAGS}" \
	CFLAGS_FOR_TARGET="${CFLAGS_FOR_TARGET} ${TARGET_CFLAGS}"
    
    $MAKE install-gcc

    $MAKE all-target-libgcc \
	ASFLAGS_FOR_TARGET="${ASFLAGS_FOR_TARGET} ${TARGET_ASFLAGS}" \
	CFLAGS_FOR_TARGET="${CFLAGS_FOR_TARGET} ${TARGET_CFLAGS}"
    
    $MAKE install-target-libgcc

    PKG_BUILD_LEAVE_CLEAN="yes_follow_links" \
    pkg_build_leave ${GCC_NAME} ${GCC_VERSION}
}

################################################################################
# kernel headers                                                               #
################################################################################
toolchain_build_kernel_headers()
{
    # download
    pkg_source_get ${LINUX_NAME} ${LINUX_VERSION} ${LINUX_EXTENSION} ${LINUX_LOCATIONS}

    # extract
    pkg_source_extract ${LINUX_NAME} ${LINUX_VERSION} ${LINUX_EXTENSION}

    # patch
    pkg_source_patch ${LINUX_NAME} ${LINUX_VERSION} "${LINUX_PATCHES}"

    # build
    PKG_BUILD_ENTER_SRC_DIR="yes" \
    pkg_build_enter ${LINUX_NAME} ${LINUX_VERSION}

    # patch for rt
    if [ -n "${LINUXRT_VERSION}" ]
    then
        pkg_source_get patch ${LINUX_VERSION}${LINUXRT_VERSION} ${LINUXRT_EXTENSION} ${LINUXRT_LOCATIONS}
        cat=cat
        if [ ${LINUXRT_EXTENSION} = ".patch.bz2" ]
        then
            cat=bunzip2
        elif [ ${LINUXRT_EXTENSION} = ".patch.gz" ]
        then
            cat=gunzip
        fi
        $cat < ${PKG_DOWNLOADS}/patch-${LINUX_VERSION}${LINUXRT_VERSION}${LINUXRT_EXTENSION} | patch --dry-run -p1
 	if [ $? -eq 0 ]
        then
           $cat < ${PKG_DOWNLOADS}/patch-${LINUX_VERSION}${LINUXRT_VERSION}${LINUXRT_EXTENSION} | patch -p1
        fi
    fi

    # build headers
    $MAKE headers_check \
	ARCH=${LINUX_TARGET_ARCH} \
	CROSS_COMPILE=${TARGET}- 

    $MAKE headers_install \
	ARCH=${LINUX_TARGET_ARCH} \
	CROSS_COMPILE=${TARGET}- \
	INSTALL_HDR_PATH=${PKG_TOOLCHAIN_SYSROOT}/usr 

    #PKG_BUILD_LEAVE_CLEAN="yes" \
    pkg_build_leave ${LINUX_NAME} ${LINUX_VERSION}
}

################################################################################
# libc                                                                         #
################################################################################
toolchain_build_libc()
{
   # download
    pkg_source_get ${UCLIBC_NAME} ${UCLIBC_VERSION} ${UCLIBC_EXTENSION} ${UCLIBC_LOCATIONS}

    # extract
    pkg_source_extract ${UCLIBC_NAME} ${UCLIBC_VERSION} ${UCLIBC_EXTENSION}

    # build
    PKG_BUILD_ENTER_SRC_DIR="yes" \
    pkg_build_enter ${UCLIBC_NAME} ${UCLIBC_VERSION}

    # configure
    if [ -f ${FWK_SYSTEM_PACKAGES}/uClibc/${UCLIBC_CONFIG} ]
    then
	cp ${FWK_SYSTEM_PACKAGES}/uClibc/${UCLIBC_CONFIG} ./.config
	$MAKE ARCH=${LINUX_TARGET_ARCH} CROSS_COMPILE=${TARGET}- oldconfig
    else
        echo "${FWK_SYSTEM_PACKAGES}/uClibc/${UCLIBC_CONFIG} not found"
        exit 1
    fi

    # uclibc don't take the good kernel header 
    # and fail with, e.g., '__ARM_NR_set_tls' undeclared
    # we need to give the kernel path, see
    # http://www.linuxfromscratch.org/clfs/view/clfs-3.0/mips/cross-tools/uclibc.html
    # buildroot-yyyy.mm/toolchain/uClibc/uclibc.mk
    # http://www.avrfreaks.net/wiki/index.php/Documentation:AVR32_Linux_Toolchain_HowTo#Building_the_C_library
    #
    # SHARED_LIB_LOADER_PREFIX has been replaced by MULTILIB_DIR in uclibc >= 0.9.33
    #
    sed -i.bak \
        -e "/^CROSS_COMPILER_PREFIX/s:=.*:=\"${TARGET}-\":" \
        -e "/^TARGET_ARCH/s:=.*:=\"${LINUX_TARGET_ARCH}\":" \
	-e "/^KERNEL_HEADERS/s:=.*:=\"${PKG_TOOLCHAIN_SYSROOT}/usr/include\":" \
        -e "/^DEVEL_PREFIX/s:=.*:=\"/usr\":" \
        -e "/^RUNTIME_PREFIX/s:=.*:=\"/\":" \
        -e "/^SHARED_LIB_LOADER_PREFIX/s:=.*:=\"/lib${LIBDIRSUFFIX}\":" \
        -e "/^MULTILIB_DIR/s:=.*:=\"/lib${LIBDIRSUFFIX}\":" \
        -e "/^UCLIBC_EXTRA_CFLAGS/s:=.*:=\"${TARGET_CFLAGS} -O2\":" \
        .config
    
    $MAKE all utils \
        install install_utils \
        ARCH=${LINUX_TARGET_ARCH} \
	CROSS_COMPILE=${TARGET}- \
        PREFIX=${PKG_TOOLCHAIN_SYSROOT}

    # install host stuff 
    $MAKE hostutils \
        install_hostutils \
        ARCH=${LINUX_TARGET_ARCH} \
	CROSS_COMPILE=${TARGET}- \
        PREFIX=${PKG_TOOLCHAIN_PREFIX}

    # ${PREFIX}${DEVEL_PREFIX}bin/ldd
    if [ -f ${PKG_TOOLCHAIN_PREFIX}/usr/bin/ldd ]
    then
	ln -sf ../usr/bin/ldd ${PKG_TOOLCHAIN_PREFIX}/bin/${TARGET}-ldd
    fi
    # ${PREFIX}${RUNTIME_PREFIX}sbin/ldconfig
    if [ -f ${PKG_TOOLCHAIN_PREFIX}/sbin/ldconfig ]
    then
	ln -sf ../sbin/ldconfig ${PKG_TOOLCHAIN_PREFIX}/bin/${TARGET}-ldconfig
    fi

    pkg_build_leave ${UCLIBC_NAME} ${UCLIBC_VERSION}
}

################################################################################
# gcc                                                                          #
################################################################################
toolchain_build_gcc()
{
    # download
    pkg_source_get ${GMP_NAME} ${GMP_VERSION} ${GMP_EXTENSION} ${GMP_LOCATIONS}
    pkg_source_get ${MPFR_NAME} ${MPFR_VERSION} ${MPFR_EXTENSION} ${MPFR_LOCATIONS}
    pkg_source_get ${MPC_NAME} ${MPC_VERSION} ${MPC_EXTENSION} ${MPC_LOCATIONS}
    #pkg_source_get ${GCC_NAME}-core ${GCC_VERSION} ${GCC_EXTENSION} ${GCC_LOCATIONS}
    #pkg_source_get ${GCC_NAME}-g++ ${GCC_VERSION} ${GCC_EXTENSION} ${GCC_LOCATIONS}
    pkg_source_get ${GCC_NAME} ${GCC_VERSION} ${GCC_EXTENSION} ${GCC_LOCATIONS}

    # extract
    pkg_source_extract ${GMP_NAME} ${GMP_VERSION} ${GMP_EXTENSION}
    pkg_source_extract ${MPFR_NAME} ${MPFR_VERSION} ${MPFR_EXTENSION}
    pkg_source_extract ${MPC_NAME} ${MPC_VERSION} ${MPC_EXTENSION}
    #pkg_source_extract ${GCC_NAME}-core ${GCC_VERSION} ${GCC_EXTENSION}
    #pkg_source_extract ${GCC_NAME}-g++ ${GCC_VERSION} ${GCC_EXTENSION}
    pkg_source_extract ${GCC_NAME} ${GCC_VERSION} ${GCC_EXTENSION}

    # hack hack hack
    if [ ! -L ${PKG_SOURCES}/gcc-${GCC_VERSION}/gmp ]
    then
	ln -s ${PKG_SOURCES}/gmp-${GMP_VERSION} ${PKG_SOURCES}/gcc-${GCC_VERSION}/gmp
    fi
    if [ ! -L ${PKG_SOURCES}/gcc-${GCC_VERSION}/mpfr ]
    then
	ln -s ${PKG_SOURCES}/mpfr-${MPFR_VERSION} ${PKG_SOURCES}/gcc-${GCC_VERSION}/mpfr
    fi
    if [ ! -L ${PKG_SOURCES}/gcc-${GCC_VERSION}/mpc ]
    then
	ln -s ${PKG_SOURCES}/mpc-${MPC_VERSION} ${PKG_SOURCES}/gcc-${GCC_VERSION}/mpc
    fi

    # build
    pkg_build_enter ${GCC_NAME} ${GCC_VERSION}

    ASFLAGS="${ASFLAGS} ${HOST_ASFLAGS}" \
    CFLAGS="${CFLAGS} ${HOST_CFLAGS}" \
    ${PKG_SOURCES}/gcc-${GCC_VERSION}/configure \
        --prefix=${PKG_TOOLCHAIN_PREFIX} \
        --with-sysroot=${PKG_TOOLCHAIN_SYSROOT} \
	--build=${BUILD} \
	--host=${HOST} \
        --target=${TARGET} \
        ${GCC_TARGET_CPU} \
	${GCC_TARGET_TUNE} \
	${GCC_TARGET_ARCH} \
	${GCC_TARGET_FLOAT} \
        ${GCC_TARGET_ABI} \
        \
        --without-ppl \
        --without-cloog \
        --with-mpfr-include=${PKG_SOURCES}/gcc-${GCC_VERSION}/mpfr/src \
        --with-mpfr-lib=${PKG_BUILDS}/gcc-${GCC_VERSION}/mpfr/src/.libs \
        --disable-nls \
	--enable-clocale=generic \
        --enable-languages=c,c++ \
        \
        --enable-shared \
        --enable-threads=posix \
	--enable-tls \
	--disable-__cxa_atexit \
	\
	${GCC_CONFIGURE_OPTIONS} \
        \
	-v
       # now with shared libs and threads
       # now with c++
       # the cxa_atexit is special for eglibc

    $MAKE \
	ASFLAGS_FOR_TARGET="${ASFLAGS_FOR_TARGET} ${TARGET_ASFLAGS}" \
	CFLAGS_FOR_TARGET="${CFLAGS_FOR_TARGET} ${TARGET_CFLAGS}"

    $MAKE install

    pkg_build_leave ${GCC_NAME} ${GCC_VERSION}
}

################################################################################
#                                                                              #
################################################################################

toolchain_build_binutils
toolchain_build_elf2flt
toolchain_build_gcc_stage_1
toolchain_build_kernel_headers
toolchain_build_libc
toolchain_build_gcc
