From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:11:47 -0700
Subject: [PATCH 03/15] kbuild: add support for clang LTO
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103171203.107569-4-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds the configuration option CONFIG_CLANG_LTO, and build
system support for clang's Link Time Optimization (LTO).

With -flto, instead of object files, clang produces LLVM bitcode,
which is compiled into a native object at link time, allowing the
final binary to be optimized globally. For more details, see:

  https://llvm.org/docs/LinkTimeOptimization.html

While the kernel normally uses GNU ld for linking, LLVM supports LTO
only with gold or lld linkers. This patch set assumes GNU gold will be
used with the LLVMgold plug-in to perform the LTO link step. Due to
potential incompatibilities with GNU ld, we also add LD_FINAL_VMLINUX
environment variable for specifying a different linker to be used for
the vmlinux_link step.

Here's an example command line for building the kernel with LTO, with
the assumption that LLVMgold.so is in LD_LIBRARY_PATH:

  $ make CC=clang LD=ld.gold LD_FINAL_VMLINUX=ld

Recommended versions are >= 5.0 for clang, and >= 2.27 for binutils.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 .gitignore               |  2 ++
 Makefile                 | 16 ++++++++-
 arch/Kconfig             | 32 +++++++++++++++++
 scripts/Makefile.build   | 69 ++++++++++++++++++++++++++++++++++--
 scripts/Makefile.modpost | 63 ++++++++++++++++++++++++++++-----
 scripts/link-vmlinux.sh  | 92 ++++++++++++++++++++++++++++++++++++++++++------
 6 files changed, 252 insertions(+), 22 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0c39aa20b6ba..7c2db278556e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,6 +13,7 @@
 *.o
 *.o.*
 *.a
+*.a.*
 *.s
 *.ko
 *.so
@@ -39,6 +40,7 @@ Module.symvers
 *.dwo
 *.su
 *.c.[012]*.*
+*.modversions
 
 #
 # Top-level generic files
diff --git a/Makefile b/Makefile
index 59980d5a03d0..01202b53b995 100644
--- a/Makefile
+++ b/Makefile
@@ -788,6 +788,17 @@ KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
 KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
 endif
 
+ifdef CONFIG_CLANG_LTO
+KBUILD_CFLAGS	+= -flto -fvisibility=hidden
+LDFLAGS_GOLD	+= -plugin LLVMgold.so
+DISABLE_LTO	:= -fno-lto
+export DISABLE_LTO LD_FINAL_VMLINUX LDFLAGS_FINAL_VMLINUX
+ifdef CONFIG_MODVERSIONS
+LLVM_DIS	:= llvm-dis
+export LLVM_DIS
+endif
+endif
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
@@ -1562,7 +1573,10 @@ clean: $(clean-dirs)
 		-o -name modules.builtin -o -name '.tmp_*.o.*' \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
-		-o -name '*.gcno' \) -type f -print | xargs rm -f
+		-o -name '*.gcno' \
+		-o -name '*.[oa].objects' \
+		-o -name '*.o.symversions' \
+		-o -name '*.modversions' \) -type f -print | xargs rm -f
 
 # Generate tags for editors
 # ---------------------------------------------------------------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 057370a0ac4e..6b0c9d4de369 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -585,6 +585,7 @@ config CC_STACKPROTECTOR_STRONG
 endchoice
 
 config THIN_ARCHIVES
+	depends on !CLANG_LTO
 	def_bool y
 	help
 	  Select this if the architecture wants to use thin archives
@@ -605,6 +606,37 @@ config LD_DEAD_CODE_DATA_ELIMINATION
 	  sections (e.g., '.text.init'). Typically '.' in section names
 	  is used to distinguish them from label names / C identifiers.
 
+config ARCH_SUPPORTS_CLANG_LTO
+	bool
+	help
+	  An architecture should select this option it supports:
+	  - compiling with clang,
+	  - compiling inline assembly with clang's integrated assembler,
+	  - and linking with either lld or GNU gold w/ LLVMgold.
+
+config CLANG_LTO
+	bool "Use clang Link Time Optimization (LTO)"
+	depends on ARCH_SUPPORTS_CLANG_LTO
+	depends on !FTRACE_MCOUNT_RECORD
+	select LD_DEAD_CODE_DATA_ELIMINATION
+	help
+          This option enables clang's Link Time Optimization (LTO), which allows
+          the compiler to optimize the kernel globally at link time. If you
+          enable this option, the compiler generates LLVM IR instead of object
+          files, and the actual compilation from IR occurs at the LTO link step,
+          which may take several minutes.
+
+          If you select this option, you must compile the kernel with clang
+          (CC=clang) and use either lld, or GNU gold with the LLVMgold plug-in,
+          as the linker (e.g. LD=ld.gold). Note that if you use gold, the
+          LLVMgold plug-in must be in LD_LIBRARY_PATH. Depending on your linker
+          version, you may need to use GNU ld to link the final vmlinux by
+          setting LD_FINAL_VMLINUX=ld.
+
+          Using clang >= 5.0 and GNU gold from binutils >= 2.27 is recommended
+          for this option.
+
+
 config HAVE_ARCH_WITHIN_STACK_FRAMES
 	bool
 	help
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index bb831d49bcfd..0cff240454f8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -210,6 +210,23 @@ else
 
 cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
 
+ifdef CONFIG_CLANG_LTO
+# Generate .o.symversions files for each .o with exported symbols, and link these
+# to the kernel and/or modules@the end.
+cmd_modversions_c =								\
+	if echo '$(c_flags)' | grep -q -- '$(DISABLE_LTO)'; then		\
+		if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then	\
+			$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
+			    > $(@D)/$(@F).symversions;				\
+		fi;								\
+	else									\
+		if $(LLVM_DIS) -o=- $(@D)/.tmp_$(@F) | grep -q __ksymtab; then	\
+			$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
+			    > $(@D)/$(@F).symversions;				\
+		fi;								\
+	fi;									\
+	mv -f $(@D)/.tmp_$(@F) $@;
+else
 cmd_modversions_c =								\
 	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
 		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
@@ -222,6 +239,7 @@ cmd_modversions_c =								\
 		mv -f $(@D)/.tmp_$(@F) $@;					\
 	fi;
 endif
+endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
 ifdef BUILD_C_RECORDMCOUNT
@@ -443,6 +461,13 @@ $(obj)/%-asn1.c $(obj)/%-asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 # To build objects in subdirs, we need to descend into the directories
 $(sort $(subdir-obj-y)): $(subdir-ym) ;
 
+ifdef CONFIG_CLANG_LTO
+# If LTO is enabled, we remove all intermediate linking steps and instead
+# collect a list of all objects to be linked at the end.
+cc_lto_objects = $(foreach o,$(1),\
+			[ -f ${o}.objects ] && cat ${o}.objects || echo ${o};)
+endif
+
 #
 # Rule to compile a set of .o files into one .o file
 #
@@ -458,6 +483,17 @@ else
   quiet_cmd_link_o_target = LD      $@
 endif
 
+ifdef CONFIG_CLANG_LTO
+builtin-cmds = $(call cc_lto_objects,$(filter $(obj-y), $^))
+
+quiet_cmd_update_builtin = GEN     $@
+cmd_update_builtin = (cat /dev/null; $(builtin-cmds)) > $@.objects && \
+			cat /dev/null > $@
+
+$(builtin-target): $(obj-y) FORCE
+	$(call if_changed,update_builtin)
+else
+quiet_cmd_link_o_target = LD      $@
 # If the list of objects to link is empty, just create an empty built-in.o
 cmd_link_o_target = $(if $(strip $(obj-y)),\
 		      $(cmd_make_builtin) $@ $(filter $(obj-y), $^) \
@@ -466,6 +502,7 @@ cmd_link_o_target = $(if $(strip $(obj-y)),\
 
 $(builtin-target): $(obj-y) FORCE
 	$(call if_changed,link_o_target)
+endif
 
 targets += $(builtin-target)
 endif # builtin-target
@@ -487,6 +524,16 @@ $(modorder-target): $(subdir-ym) FORCE
 # Rule to compile a set of .o files into one .a file
 #
 ifdef lib-target
+ifdef CONFIG_CLANG_LTO
+lib-target-cmds = $(call cc_lto_objects,$(lib-y))
+
+quiet_cmd_update_lib_target = GEN     $@
+cmd_update_lib_target = (cat /dev/null; $(lib-target-cmds)) > $@.objects && \
+			cat /dev/null > $@
+
+$(lib-target): $(lib-y) FORCE
+	$(call if_changed,update_lib_target)
+else
 quiet_cmd_link_l_target = AR      $@
 
 ifdef CONFIG_THIN_ARCHIVES
@@ -497,6 +544,7 @@ endif
 
 $(lib-target): $(lib-y) FORCE
 	$(call if_changed,link_l_target)
+endif
 
 targets += $(lib-target)
 
@@ -552,15 +600,32 @@ endif
 quiet_cmd_link_multi-m = LD [M]  $@
 cmd_link_multi-m = $(cmd_link_multi-link)
 
+ifdef CONFIG_CLANG_LTO
+multi-deps-cmds = $(call cc_lto_objects,$(link_multi_deps))
+
+quiet_cmd_update_multi_deps = GEN     $@
+cmd_update_multi_deps = (cat /dev/null; $(multi-deps-cmds)) > $@.objects && \
+			cat /dev/null > $@
+
+$(multi-used-y): FORCE
+	$(call if_changed,update_multi_deps)
+
+$(multi-used-m): FORCE
+	$(call if_changed,update_multi_deps)
+	@{ echo $(@:.o=.ko); echo $(link_multi_deps); \
+	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
+else
 $(multi-used-y): FORCE
 	$(call if_changed,link_multi-y)
-$(call multi_depend, $(multi-used-y), .o, -objs -y)
 
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
 	@{ echo $(@:.o=.ko); echo $(link_multi_deps); \
 	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
-$(call multi_depend, $(multi-used-m), .o, -objs -y -m)
+endif
+
+$(call multi_depend, $(multi-used-y), .o, -objs -y)
+$(call multi_depend, $(multi-used-m), .o, -objs -y)
 
 targets += $(multi-used-y) $(multi-used-m)
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 991db7d6e4df..2f3b45cbbe6b 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -83,12 +83,46 @@ modpost = scripts/mod/modpost                    \
 
 MODPOST_OPT=$(subst -i,-n,$(filter -i,$(MAKEFLAGS)))
 
+# If CONFIG_CLANG_LTO is enabled, .o files are either LLVM IR, or empty, so we
+# need to link them into actual objects before passing them to modpost
+modpost-ext = $(if $(CONFIG_CLANG_LTO),.lto,)
+
+ifdef CONFIG_CLANG_LTO
+quiet_cmd_cc_lto_modversions = GEN [M]  $@
+cmd_cc_lto_modversions = 						\
+	rm -f $(@); 							\
+	if [ -f $(@:.modversions=.o).objects ]; then 			\
+		for i in `cat $(@:.modversions=.o).objects`; do 	\
+			[ -s $$i.symversions ] &&			\
+				cat $$i.symversions >> $(@);		\
+		done;							\
+	else								\
+		[ -s $(@:.modversions=.o).symversions ] &&		\
+			cat $(@:.modversions=.o).symversions >> $(@);	\
+	fi
+
+$(modules:.ko=.modversions): FORCE
+	$(call if_changed,cc_lto_modversions)
+
+quiet_cmd_cc_lto_link_modules = LD [M]  $@
+cmd_cc_lto_link_modules =						\
+	$(LD) $(ld_flags) -r -o $(@)					\
+		$(shell [ -s $(@:$(modpost-ext).o=.modversions) ] &&	\
+			echo -T $(@:$(modpost-ext).o=.modversions))	\
+		$(shell [ -f $(@:$(modpost-ext).o=.o).objects ] &&	\
+			 cat $(@:$(modpost-ext).o=.o).objects ||	\
+			echo $(@:$(modpost-ext).o=.o))
+
+$(modules:.ko=$(modpost-ext).o): %$(modpost-ext).o: %.o %.modversions FORCE
+	$(call if_changed,cc_lto_link_modules)
+endif
+
 # We can go over command line length here, so be careful.
 quiet_cmd_modpost = MODPOST $(words $(filter-out vmlinux FORCE, $^)) modules
-      cmd_modpost = $(MODLISTCMD) | sed 's/\.ko$$/.o/' | $(modpost) $(MODPOST_OPT) -s -T -
+      cmd_modpost = $(MODLISTCMD) | sed 's/\.ko$$/$(modpost-ext)\.o/' | $(modpost) $(MODPOST_OPT) -s -T -
 
 PHONY += __modpost
-__modpost: $(modules:.ko=.o) FORCE
+__modpost: $(modules:.ko=$(modpost-ext).o) FORCE
 	$(call cmd,modpost) $(wildcard vmlinux)
 
 quiet_cmd_kernel-mod = MODPOST $@
@@ -98,8 +132,7 @@ vmlinux.o: FORCE
 	$(call cmd,kernel-mod)
 
 # Declare generated files as targets for modpost
-$(modules:.ko=.mod.c): __modpost ;
-
+$(modules:.ko=$(modpost-ext).mod.c): __modpost ;
 
 # Step 5), compile all *.mod.c files
 
@@ -110,23 +143,37 @@ quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) $(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE) \
 		   -c -o $@ $<
 
-$(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE
+$(modules:.ko=.mod.o): %.mod.o: %$(modpost-ext).mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
-targets += $(modules:.ko=.mod.o)
+targets += $(modules:.ko=$(modpost-ext).mod.o)
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Step 6), final link of the modules with optional arch pass after final link
 quiet_cmd_ld_ko_o = LD [M]  $@
+
+ifdef CONFIG_CLANG_LTO
+lto_ko_objects = $(foreach o,$(1:$(modpost-ext).o=.o),			\
+			$(shell [ -f $(o).objects ] && 			\
+				 cat $(o).objects || echo $(o)))
+
+      cmd_ld_ko_o = 							\
+	$(LD) -r $(LDFLAGS)                                 		\
+		 $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE) 		\
+		 $(shell [ -s $(@:.ko=.modversions) ] &&		\
+			echo -T $(@:.ko=.modversions))  		\
+		 -o $@ $(call lto_ko_objects, $(filter-out FORCE,$^))
+else
       cmd_ld_ko_o =                                                     \
 	$(LD) -r $(LDFLAGS)                                             \
                  $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)             \
                  -o $@ $(filter-out FORCE,$^) ;                         \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
+endif
 
-$(modules): %.ko :%.o %.mod.o FORCE
-	+$(call if_changed,ld_ko_o)
+$(modules): %.ko: %$(modpost-ext).o %.mod.o FORCE
+	$(call if_changed,ld_ko_o)
 
 targets += $(modules)
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e6818b8e7141..c5c004b209ce 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -64,6 +64,53 @@ archive_builtin()
 	fi
 }
 
+# If CONFIG_CLANG_LTO is selected, the compiler produces LLVM IR files instead
+# of ELF object files. This function expands individual IR files from a list of
+# objects that would have otherwise been linked already.
+expand()
+{
+	if [ -z "${CONFIG_CLANG_LTO}" ]; then
+		echo $*
+	fi
+
+	local objs
+
+	for o in $*; do
+		if [ -f ${o}.objects ]; then
+			objs="${objs} $(xargs < ${o}.objects)"
+		else
+			objs="${objs} ${o}"
+		fi
+	done
+
+	echo "${objs}"
+}
+
+# If CONFIG_CLANG_LTO is selected, collect generated symbol versions into
+# .tmp_symversions
+modversions()
+{
+	if [ -z "${CONFIG_CLANG_LTO}" ]; then
+		return
+	fi
+
+	if [ -z "${CONFIG_MODVERSIONS}" ]; then
+		return
+	fi
+
+	rm -f .tmp_symversions
+
+	for o in $(expand ${KBUILD_VMLINUX_INIT}) \
+		 $(expand ${KBUILD_VMLINUX_MAIN}) \
+		 $(expand ${KBUILD_VMLINUX_LIBS}); do
+		if [ -f ${o}.symversions ]; then
+			cat ${o}.symversions >> .tmp_symversions
+		fi
+	done
+
+	echo "-T .tmp_symversions"
+}
+
 # Link of vmlinux.o used for section mismatch analysis
 # ${1} output file
 modpost_link()
@@ -78,13 +125,22 @@ modpost_link()
 			${KBUILD_VMLINUX_LIBS}				\
 			--end-group"
 	else
-		objects="${KBUILD_VMLINUX_INIT}				\
+		objects="$(expand ${KBUILD_VMLINUX_INIT})		\
 			--start-group					\
-			${KBUILD_VMLINUX_MAIN}				\
-			${KBUILD_VMLINUX_LIBS}				\
+			$(expand ${KBUILD_VMLINUX_MAIN})		\
+			$(expand ${KBUILD_VMLINUX_LIBS})		\
 			--end-group"
 	fi
-	${LD} ${LDFLAGS} -r -o ${1} ${objects}
+
+	if [ -n "${CONFIG_CLANG_LTO}" ]; then
+		# This might take a while, so indicate that we're doing
+		# an LTO link
+		info LTO vmlinux.o
+	else
+		info LD vmlinux.o
+	fi
+
+	${LD} ${LDFLAGS} -r -o ${1} $(modversions) ${objects}
 }
 
 # Link of vmlinux
@@ -96,6 +152,14 @@ vmlinux_link()
 	local objects
 
 	if [ "${SRCARCH}" != "um" ]; then
+		local ld=${LD}
+		local ldflags="${LDFLAGS} ${LDFLAGS_vmlinux}"
+
+		if [ -n "${LD_FINAL_VMLINUX}" ]; then
+			ld=${LD_FINAL_VMLINUX}
+			ldflags="${LDFLAGS_FINAL_VMLINUX} ${LDFLAGS_vmlinux}"
+		fi
+
 		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
 			objects="--whole-archive			\
 				built-in.o				\
@@ -105,16 +169,15 @@ vmlinux_link()
 				--end-group				\
 				${1}"
 		else
-			objects="${KBUILD_VMLINUX_INIT}			\
+			objects="$(expand ${KBUILD_VMLINUX_INIT})	\
 				--start-group				\
-				${KBUILD_VMLINUX_MAIN}			\
-				${KBUILD_VMLINUX_LIBS}			\
+				$(expand ${KBUILD_VMLINUX_MAIN})	\
+				$(expand ${KBUILD_VMLINUX_LIBS})	\
 				--end-group				\
 				${1}"
 		fi
 
-		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}		\
-			-T ${lds} ${objects}
+		${ld} ${ldflags} -o ${2} -T ${lds} ${objects}
 	else
 		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
 			objects="-Wl,--whole-archive			\
@@ -141,7 +204,6 @@ vmlinux_link()
 	fi
 }
 
-
 # Create ${2} .o file with all symbols from the ${1} object file
 kallsyms()
 {
@@ -192,6 +254,7 @@ cleanup()
 	rm -f .tmp_System.map
 	rm -f .tmp_kallsyms*
 	rm -f .tmp_version
+	rm -f .tmp_symversions
 	rm -f .tmp_vmlinux*
 	rm -f built-in.o
 	rm -f System.map
@@ -253,12 +316,19 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init GCC_PLUGINS_CFLAGS="${GC
 archive_builtin
 
 #link vmlinux.o
-info LD vmlinux.o
 modpost_link vmlinux.o
 
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
 
+if [ -n "${CONFIG_CLANG_LTO}" ]; then
+	# Re-use vmlinux.o, so we can avoid the slow LTO link step in
+	# vmlinux_link
+	KBUILD_VMLINUX_INIT=
+	KBUILD_VMLINUX_MAIN=vmlinux.o
+	KBUILD_VMLINUX_LIBS=
+fi
+
 kallsymso=""
 kallsyms_vmlinux=""
 if [ -n "${CONFIG_KALLSYMS}" ]; then
-- 
2.15.0.403.gc27cc4dac6-goog
