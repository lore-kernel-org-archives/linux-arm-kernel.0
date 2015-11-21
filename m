From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 17:23:16 -0800
Subject: [RFC/PATCH 2/3] recordmcount: Record locations of __aeabi_{u}idiv()
 calls on ARM
In-Reply-To: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448068997-26631-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM compiler inserts calls to __aeabi_uidiv() and
__aeabi_idiv() when it needs to perform division on signed and
unsigned integers. If a processor has support for the udiv and
sdiv division instructions the calls to these support routines
can be replaced with those instructions. Therefore, record the
location of calls to these library functions into two sections
(one for udiv and one for sdiv) similar to how we trace calls to
mcount. When the kernel boots up it will check to see if the
processor supports the instructions and then patch the call sites
with the instruction.

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: M?ns Rullg?rd <mans@mansr.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 scripts/recordmcount.h | 335 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 269 insertions(+), 66 deletions(-)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 6e196dba748d..cab91ffc82a6 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -18,11 +18,13 @@
  *
  * Licensed under the GNU General Public License, version 2 (GPLv2).
  */
+#undef append_section
 #undef append_func
 #undef is_fake_mcount
 #undef fn_is_fake_mcount
 #undef MIPS_is_fake_mcount
 #undef mcount_adjust
+#undef add_relocation
 #undef sift_rel_mcount
 #undef nop_mcount
 #undef find_secsym_ndx
@@ -30,6 +32,7 @@
 #undef has_rel_mcount
 #undef tot_relsize
 #undef get_mcountsym
+#undef get_arm_sym
 #undef get_sym_str_and_relp
 #undef do_func
 #undef Elf_Addr
@@ -52,7 +55,9 @@
 #undef _size
 
 #ifdef RECORD_MCOUNT_64
+# define append_section		append_section64
 # define append_func		append64
+# define add_relocation		add_relocation_64
 # define sift_rel_mcount	sift64_rel_mcount
 # define nop_mcount		nop_mcount_64
 # define find_secsym_ndx	find64_secsym_ndx
@@ -62,6 +67,7 @@
 # define get_sym_str_and_relp	get_sym_str_and_relp_64
 # define do_func		do64
 # define get_mcountsym		get_mcountsym_64
+# define get_arm_sym		get_arm_sym_64
 # define is_fake_mcount		is_fake_mcount64
 # define fn_is_fake_mcount	fn_is_fake_mcount64
 # define MIPS_is_fake_mcount	MIPS64_is_fake_mcount
@@ -85,7 +91,9 @@
 # define _align			7u
 # define _size			8
 #else
+# define append_section		append_section32
 # define append_func		append32
+# define add_relocation		add_relocation_32
 # define sift_rel_mcount	sift32_rel_mcount
 # define nop_mcount		nop_mcount_32
 # define find_secsym_ndx	find32_secsym_ndx
@@ -95,6 +103,7 @@
 # define get_sym_str_and_relp	get_sym_str_and_relp_32
 # define do_func		do32
 # define get_mcountsym		get_mcountsym_32
+# define get_arm_sym		get_arm_sym_32
 # define is_fake_mcount		is_fake_mcount32
 # define fn_is_fake_mcount	fn_is_fake_mcount32
 # define MIPS_is_fake_mcount	MIPS32_is_fake_mcount
@@ -174,6 +183,62 @@ static int MIPS_is_fake_mcount(Elf_Rel const *rp)
 	return is_fake;
 }
 
+static void append_section(uint_t const *const mloc0,
+			   uint_t const *const mlocp,
+			   Elf_Rel const *const mrel0,
+			   Elf_Rel const *const mrelp,
+			   char const *name,
+			   unsigned int const rel_entsize,
+			   unsigned int const symsec_sh_link,
+			   uint_t *name_offp,
+			   uint_t *tp,
+			   unsigned *shnump
+		)
+{
+	Elf_Shdr mcsec;
+	uint_t name_off = *name_offp;
+	uint_t t = *tp;
+	uint_t loc_diff = (void *)mlocp - (void *)mloc0;
+	uint_t rel_diff = (void *)mrelp - (void *)mrel0;
+	unsigned shnum = *shnump;
+
+	mcsec.sh_name = w((sizeof(Elf_Rela) == rel_entsize) + strlen(".rel")
+		+ name_off);
+	mcsec.sh_type = w(SHT_PROGBITS);
+	mcsec.sh_flags = _w(SHF_ALLOC);
+	mcsec.sh_addr = 0;
+	mcsec.sh_offset = _w(t);
+	mcsec.sh_size = _w(loc_diff);
+	mcsec.sh_link = 0;
+	mcsec.sh_info = 0;
+	mcsec.sh_addralign = _w(_size);
+	mcsec.sh_entsize = _w(_size);
+	uwrite(fd_map, &mcsec, sizeof(mcsec));
+	t += loc_diff;
+
+	mcsec.sh_name = w(name_off);
+	mcsec.sh_type = (sizeof(Elf_Rela) == rel_entsize)
+		? w(SHT_RELA)
+		: w(SHT_REL);
+	mcsec.sh_flags = 0;
+	mcsec.sh_addr = 0;
+	mcsec.sh_offset = _w(t);
+	mcsec.sh_size   = _w(rel_diff);
+	mcsec.sh_link = w(symsec_sh_link);
+	mcsec.sh_info = w(shnum);
+	mcsec.sh_addralign = _w(_size);
+	mcsec.sh_entsize = _w(rel_entsize);
+	uwrite(fd_map, &mcsec, sizeof(mcsec));
+	t += rel_diff;
+
+	shnum += 2;
+	name_off += strlen(name) + 1;
+
+	*tp = t;
+	*shnump = shnum;
+	*name_offp = name_off;
+}
+
 /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
 static void append_func(Elf_Ehdr *const ehdr,
 			Elf_Shdr *const shstr,
@@ -181,20 +246,50 @@ static void append_func(Elf_Ehdr *const ehdr,
 			uint_t const *const mlocp,
 			Elf_Rel const *const mrel0,
 			Elf_Rel const *const mrelp,
+			uint_t const *const mloc0_u,
+			uint_t const *const mlocp_u,
+			Elf_Rel const *const mrel0_u,
+			Elf_Rel const *const mrelp_u,
+			uint_t const *const mloc0_i,
+			uint_t const *const mlocp_i,
+			Elf_Rel const *const mrel0_i,
+			Elf_Rel const *const mrelp_i,
 			unsigned int const rel_entsize,
 			unsigned int const symsec_sh_link)
 {
 	/* Begin constructing output file */
-	Elf_Shdr mcsec;
 	char const *mc_name = (sizeof(Elf_Rela) == rel_entsize)
 		? ".rela__mcount_loc"
 		:  ".rel__mcount_loc";
-	unsigned const old_shnum = w2(ehdr->e_shnum);
+	char const *udiv_name = (sizeof(Elf_Rela) == rel_entsize)
+		? ".rela__udiv_loc"
+		:  ".rel__udiv_loc";
+	char const *idiv_name = (sizeof(Elf_Rela) == rel_entsize)
+		? ".rela__idiv_loc"
+		:  ".rel__idiv_loc";
+	unsigned old_shnum = w2(ehdr->e_shnum);
 	uint_t const old_shoff = _w(ehdr->e_shoff);
 	uint_t const old_shstr_sh_size   = _w(shstr->sh_size);
 	uint_t const old_shstr_sh_offset = _w(shstr->sh_offset);
-	uint_t t = 1 + strlen(mc_name) + _w(shstr->sh_size);
 	uint_t new_e_shoff;
+	uint_t t = _w(shstr->sh_size);
+	uint_t name_off = old_shstr_sh_size;
+	int mc = 0, udiv = 0, idiv = 0;
+	int num_sections;
+
+	if (mlocp != mloc0) {
+		t += 1 + strlen(mc_name);
+		mc = 1;
+	}
+	if (mlocp_u != mloc0_u) {
+		t += 1 + strlen(udiv_name);
+		udiv = 1;
+	}
+	if (mlocp_i != mloc0_i) {
+		t += 1 + strlen(idiv_name);
+		idiv = 1;
+	}
+	num_sections = (mc * 2) + (udiv * 2) + (idiv * 2);
 
 	shstr->sh_size = _w(t);
 	shstr->sh_offset = _w(sb.st_size);
@@ -204,8 +299,13 @@ static void append_func(Elf_Ehdr *const ehdr,
 
 	/* body for new shstrtab */
 	ulseek(fd_map, sb.st_size, SEEK_SET);
-	uwrite(fd_map, old_shstr_sh_offset + (void *)ehdr, old_shstr_sh_size);
-	uwrite(fd_map, mc_name, 1 + strlen(mc_name));
+	uwrite(fd_map, old_shstr_sh_offset + (void *)ehdr, name_off);
+	if (mc)
+		uwrite(fd_map, mc_name, 1 + strlen(mc_name));
+	if (udiv)
+		uwrite(fd_map, udiv_name, 1 + strlen(udiv_name));
+	if (idiv)
+		uwrite(fd_map, idiv_name, 1 + strlen(idiv_name));
 
 	/* old(modified) Elf_Shdr table, word-byte aligned */
 	ulseek(fd_map, t, SEEK_SET);
@@ -214,39 +314,38 @@ static void append_func(Elf_Ehdr *const ehdr,
 	       sizeof(Elf_Shdr) * old_shnum);
 
 	/* new sections __mcount_loc and .rel__mcount_loc */
-	t += 2*sizeof(mcsec);
-	mcsec.sh_name = w((sizeof(Elf_Rela) == rel_entsize) + strlen(".rel")
-		+ old_shstr_sh_size);
-	mcsec.sh_type = w(SHT_PROGBITS);
-	mcsec.sh_flags = _w(SHF_ALLOC);
-	mcsec.sh_addr = 0;
-	mcsec.sh_offset = _w(t);
-	mcsec.sh_size = _w((void *)mlocp - (void *)mloc0);
-	mcsec.sh_link = 0;
-	mcsec.sh_info = 0;
-	mcsec.sh_addralign = _w(_size);
-	mcsec.sh_entsize = _w(_size);
-	uwrite(fd_map, &mcsec, sizeof(mcsec));
-
-	mcsec.sh_name = w(old_shstr_sh_size);
-	mcsec.sh_type = (sizeof(Elf_Rela) == rel_entsize)
-		? w(SHT_RELA)
-		: w(SHT_REL);
-	mcsec.sh_flags = 0;
-	mcsec.sh_addr = 0;
-	mcsec.sh_offset = _w((void *)mlocp - (void *)mloc0 + t);
-	mcsec.sh_size   = _w((void *)mrelp - (void *)mrel0);
-	mcsec.sh_link = w(symsec_sh_link);
-	mcsec.sh_info = w(old_shnum);
-	mcsec.sh_addralign = _w(_size);
-	mcsec.sh_entsize = _w(rel_entsize);
-	uwrite(fd_map, &mcsec, sizeof(mcsec));
-
-	uwrite(fd_map, mloc0, (void *)mlocp - (void *)mloc0);
-	uwrite(fd_map, mrel0, (void *)mrelp - (void *)mrel0);
+	t += num_sections * sizeof(Elf_Shdr);
+	if (mc)
+		append_section(mloc0, mlocp, mrel0, mrelp, mc_name, rel_entsize,
+			       symsec_sh_link, &name_off, &t, &old_shnum);
+
+	/* new sections __udiv_loc and .rel__udiv_loc */
+	if (udiv)
+		append_section(mloc0_u, mlocp_u, mrel0_u, mrelp_u, udiv_name,
+			       rel_entsize, symsec_sh_link, &name_off, &t,
+			       &old_shnum);
+
+	/* new sections __idiv_loc and .rel__idiv_loc */
+	if (idiv)
+		append_section(mloc0_i, mlocp_i, mrel0_i, mrelp_i, idiv_name,
+			       rel_entsize, symsec_sh_link, &name_off, &t,
+			       &old_shnum);
+
+	if (mc) {
+		uwrite(fd_map, mloc0, (void *)mlocp - (void *)mloc0);
+		uwrite(fd_map, mrel0, (void *)mrelp - (void *)mrel0);
+	}
+	if (udiv) {
+		uwrite(fd_map, mloc0_u, (void *)mlocp_u - (void *)mloc0_u);
+		uwrite(fd_map, mrel0_u, (void *)mrelp_u - (void *)mrel0_u);
+	}
+	if (idiv) {
+		uwrite(fd_map, mloc0_i, (void *)mlocp_i - (void *)mloc0_i);
+		uwrite(fd_map, mrel0_i, (void *)mrelp_i - (void *)mrel0_i);
+	}
 
 	ehdr->e_shoff = _w(new_e_shoff);
-	ehdr->e_shnum = w2(2 + w2(ehdr->e_shnum));  /* {.rel,}__mcount_loc */
+	ehdr->e_shnum = w2(num_sections + w2(ehdr->e_shnum));
 	ulseek(fd_map, 0, SEEK_SET);
 	uwrite(fd_map, ehdr, sizeof(*ehdr));
 }
@@ -273,6 +372,20 @@ static unsigned get_mcountsym(Elf_Sym const *const sym0,
 	return mcountsym;
 }
 
+static unsigned get_arm_sym(Elf_Sym const *const sym0,
+			      Elf_Rel const *relp,
+			      char const *const str0, const char *find)
+{
+	unsigned sym = 0;
+	Elf_Sym const *const symp = &sym0[Elf_r_sym(relp)];
+	char const *symname = &str0[w(symp->st_name)];
+
+	if (strcmp(find, symname) == 0)
+		sym = Elf_r_sym(relp);
+
+	return sym;
+}
+
 static void get_sym_str_and_relp(Elf_Shdr const *const relhdr,
 				 Elf_Ehdr const *const ehdr,
 				 Elf_Sym const **sym0,
@@ -296,28 +409,65 @@ static void get_sym_str_and_relp(Elf_Shdr const *const relhdr,
 	*relp = rel0;
 }
 
+static void add_relocation(Elf_Rel const *relp, uint_t *mloc0, uint_t **mlocpp,
+			   uint_t const recval, unsigned const recsym,
+			   Elf_Rel **const mrelpp, unsigned offbase,
+			   unsigned rel_entsize, unsigned const reltype)
+{
+	uint_t *mlocp = *mlocpp;
+	Elf_Rel *mrelp = *mrelpp;
+	uint_t const addend = _w(_w(relp->r_offset) - recval + mcount_adjust);
+	mrelp->r_offset = _w(offbase + ((void *)mlocp - (void *)mloc0));
+	Elf_r_info(mrelp, recsym, reltype);
+	if (rel_entsize == sizeof(Elf_Rela)) {
+		((Elf_Rela *)mrelp)->r_addend = addend;
+		*mlocp++ = 0;
+	} else
+		*mlocp++ = addend;
+
+	*mlocpp = mlocp;
+	*mrelpp = (Elf_Rel *)(rel_entsize + (void *)mrelp);
+}
+
 /*
  * Look at the relocations in order to find the calls to mcount.
  * Accumulate the section offsets that are found, and their relocation info,
  * onto the end of the existing arrays.
  */
-static uint_t *sift_rel_mcount(uint_t *mlocp,
-			       unsigned const offbase,
+static void sift_rel_mcount(uint_t **mlocpp,
+			       uint_t *mloc_base,
 			       Elf_Rel **const mrelpp,
+			       uint_t **mlocpp_u,
+			       uint_t *mloc_base_u,
+			       Elf_Rel **const mrelpp_u,
+			       uint_t **mlocpp_i,
+			       uint_t *mloc_base_i,
+			       Elf_Rel **const mrelpp_i,
 			       Elf_Shdr const *const relhdr,
 			       Elf_Ehdr const *const ehdr,
 			       unsigned const recsym,
 			       uint_t const recval,
 			       unsigned const reltype)
 {
+	uint_t *mlocp = *mlocpp;
+	unsigned const offbase = (void *)mlocp - (void *)mloc_base;
 	uint_t *const mloc0 = mlocp;
 	Elf_Rel *mrelp = *mrelpp;
+	uint_t *mlocp_u = *mlocpp_u;
+	unsigned const offbase_u = (void *)mlocp_u - (void *)mloc_base_u;
+	uint_t *const mloc0_u = mlocp_u;
+	Elf_Rel *mrelp_u = *mrelpp_u;
+	uint_t *mlocp_i = *mlocpp_i;
+	unsigned const offbase_i = (void *)mlocp_i - (void *)mloc_base_i;
+	uint_t *const mloc0_i = mlocp_i;
+	Elf_Rel *mrelp_i = *mrelpp_i;
 	Elf_Sym const *sym0;
 	char const *str0;
 	Elf_Rel const *relp;
 	unsigned rel_entsize = _w(relhdr->sh_entsize);
 	unsigned const nrel = _w(relhdr->sh_size) / rel_entsize;
-	unsigned mcountsym = 0;
+	int arm = w2(ehdr->e_machine) == EM_ARM;
+	unsigned mcountsym = 0, udiv_sym = 0, idiv_sym =0;
 	unsigned t;
 
 	get_sym_str_and_relp(relhdr, ehdr, &sym0, &str0, &relp);
@@ -326,24 +476,53 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 		if (trace_mcount && !mcountsym)
 			mcountsym = get_mcountsym(sym0, relp, str0);
 
-		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
-			uint_t const addend =
-				_w(_w(relp->r_offset) - recval + mcount_adjust);
-			mrelp->r_offset = _w(offbase
-				+ ((void *)mlocp - (void *)mloc0));
-			Elf_r_info(mrelp, recsym, reltype);
-			if (rel_entsize == sizeof(Elf_Rela)) {
-				((Elf_Rela *)mrelp)->r_addend = addend;
-				*mlocp++ = 0;
-			} else
-				*mlocp++ = addend;
-
-			mrelp = (Elf_Rel *)(rel_entsize + (void *)mrelp);
+		if (arm && !udiv_sym)
+			udiv_sym = get_arm_sym(sym0, relp, str0,
+					       "__aeabi_uidiv");
+		if (arm && !idiv_sym)
+			idiv_sym = get_arm_sym(sym0, relp, str0,
+						 "__aeabi_idiv");
+
+		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp))
+			add_relocation(relp, mloc0, &mlocp, recval, recsym,
+				       &mrelp, offbase, rel_entsize, reltype);
+
+		if (udiv_sym == Elf_r_sym(relp)) {
+			switch (relp->r_info & 0xff) {
+			case R_ARM_PC24:
+			case 28:
+			case 29:
+				add_relocation(relp, mloc0_u, &mlocp_u, recval,
+						recsym, &mrelp_u, offbase_u,
+						rel_entsize, reltype);
+				break;
+			default:
+				break;
+			}
 		}
+
+		if (idiv_sym == Elf_r_sym(relp)) {
+			switch (relp->r_info & 0xff) {
+			case R_ARM_PC24:
+			case 28:
+			case 29:
+				add_relocation(relp, mloc0_i, &mlocp_i, recval,
+						recsym, &mrelp_i, offbase_i,
+						rel_entsize, reltype);
+				break;
+			default:
+				break;
+			}
+		}
+
 		relp = (Elf_Rel const *)(rel_entsize + (void *)relp);
 	}
+	*mrelpp_i = mrelp_i;
+	*mrelpp_u = mrelp_u;
 	*mrelpp = mrelp;
-	return mlocp;
+	*mlocpp_i = mlocp_i;
+	*mlocpp_u = mlocp_u;
+	*mlocpp = mlocp;
 }
 
 /*
@@ -452,14 +631,14 @@ static char const *
 __has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
 		 Elf_Shdr const *const shdr0,
 		 char const *const shstrtab,
-		 char const *const fname)
+		 char const *const fname, const char *find)
 {
 	/* .sh_info depends on .sh_type == SHT_REL[,A] */
 	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
 	char const *const txtname = &shstrtab[w(txthdr->sh_name)];
 
-	if (strcmp("__mcount_loc", txtname) == 0) {
-		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
+	if (strcmp(find, txtname) == 0) {
+		fprintf(stderr, "warning: %s already exists: %s\n", find,
 			fname);
 		succeed_file();
 	}
@@ -472,25 +651,25 @@ __has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
 static char const *has_rel_mcount(Elf_Shdr const *const relhdr,
 				  Elf_Shdr const *const shdr0,
 				  char const *const shstrtab,
-				  char const *const fname)
+				  char const *const fname, const char *find)
 {
 	if (w(relhdr->sh_type) != SHT_REL && w(relhdr->sh_type) != SHT_RELA)
 		return NULL;
-	return __has_rel_mcount(relhdr, shdr0, shstrtab, fname);
+	return __has_rel_mcount(relhdr, shdr0, shstrtab, fname, find);
 }
 
 
 static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 			    unsigned nhdr,
 			    const char *const shstrtab,
-			    const char *const fname)
+			    const char *const fname, const char *find)
 {
 	unsigned totrelsz = 0;
 	Elf_Shdr const *shdrp = shdr0;
 	char const *txtname;
 
 	for (; nhdr; --nhdr, ++shdrp) {
-		txtname = has_rel_mcount(shdrp, shdr0, shstrtab, fname);
+		txtname = has_rel_mcount(shdrp, shdr0, shstrtab, fname, find);
 		if (txtname && is_mcounted_section_name(txtname))
 			totrelsz += _w(shdrp->sh_size);
 	}
@@ -513,7 +692,8 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 	unsigned k;
 
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
-	unsigned const totrelsz = tot_relsize(shdr0, nhdr, shstrtab, fname);
+	unsigned const totrelsz = tot_relsize(shdr0, nhdr, shstrtab, fname,
+					      "__mcount_loc");
 	Elf_Rel *const mrel0 = umalloc(totrelsz);
 	Elf_Rel *      mrelp = mrel0;
 
@@ -521,12 +701,28 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 	uint_t *const mloc0 = umalloc(totrelsz>>1);
 	uint_t *      mlocp = mloc0;
 
+	/* Allocate for arm too */
+	Elf_Rel *const mrel0_u = umalloc(totrelsz);
+	Elf_Rel *      mrelp_u = mrel0_u;
+
+	/* 2*sizeof(address) <= sizeof(Elf_Rel) */
+	uint_t *const mloc0_u = umalloc(totrelsz>>1);
+	uint_t *      mlocp_u = mloc0_u;
+
+	/* Allocate for arm too */
+	Elf_Rel *const mrel0_i = umalloc(totrelsz);
+	Elf_Rel *      mrelp_i = mrel0_i;
+
+	/* 2*sizeof(address) <= sizeof(Elf_Rel) */
+	uint_t *const mloc0_i = umalloc(totrelsz>>1);
+	uint_t *      mlocp_i = mloc0_i;
+
 	unsigned rel_entsize = 0;
 	unsigned symsec_sh_link = 0;
 
 	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
 		char const *const txtname = has_rel_mcount(relhdr, shdr0,
-			shstrtab, fname);
+			shstrtab, fname, "__mcount_loc");
 		if (txtname && is_mcounted_section_name(txtname)) {
 			uint_t recval = 0;
 			unsigned const recsym = find_secsym_ndx(
@@ -535,9 +731,10 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 				ehdr);
 
 			rel_entsize = _w(relhdr->sh_entsize);
-			mlocp = sift_rel_mcount(mlocp,
-				(void *)mlocp - (void *)mloc0, &mrelp,
-				relhdr, ehdr, recsym, recval, reltype);
+			sift_rel_mcount(&mlocp, mloc0, &mrelp,
+				&mlocp_u, mloc0_u, &mrelp_u, &mlocp_i, mloc0_i,
+				&mrelp_i, relhdr, ehdr, recsym, recval,
+				reltype);
 		} else if (txtname && (warn_on_notrace_sect || make_nop)) {
 			/*
 			 * This section is ignored by ftrace, but still
@@ -546,10 +743,16 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 			nop_mcount(relhdr, ehdr, txtname);
 		}
 	}
-	if (mloc0 != mlocp) {
+	if (mloc0 != mlocp || mloc0_u != mlocp_u || mloc0_i != mlocp_i) {
 		append_func(ehdr, shstr, mloc0, mlocp, mrel0, mrelp,
+			    mloc0_u, mlocp_u, mrel0_u, mrelp_u,
+			    mloc0_i, mlocp_i, mrel0_i, mrelp_i,
 			    rel_entsize, symsec_sh_link);
 	}
 	free(mrel0);
 	free(mloc0);
+	free(mrel0_u);
+	free(mloc0_u);
+	free(mrel0_i);
+	free(mloc0_i);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
