From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Jun 2017 13:48:06 +0100
Subject: [PATCH] arm64: ftrace: fix building without CONFIG_MODULES
In-Reply-To: <CAK8P3a10CQq3mvQzysTTk+y=WQ=zcXehjPDUXzqh8SnTZ6WkXg@mail.gmail.com>
References: <20170609102807.2992510-1-arnd@arndb.de>
 <20170609113850.GF13955@arm.com>
 <CAK8P3a10CQq3mvQzysTTk+y=WQ=zcXehjPDUXzqh8SnTZ6WkXg@mail.gmail.com>
Message-ID: <20170612124805.GA11581@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 08:57:31PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 9, 2017 at 1:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Jun 09, 2017 at 12:27:06PM +0200, Arnd Bergmann wrote:
> >> When CONFIG_MODULES is disabled, we cannot dereference a module pointer:
> >>
> >> arch/arm64/kernel/ftrace.c: In function 'ftrace_make_call':
> >> arch/arm64/kernel/ftrace.c:107:36: error: dereferencing pointer to incomplete type 'struct module'
> >>    trampoline = (unsigned long *)mod->arch.ftrace_trampoline;
> >>
> >> Also, the within_module() function is not defined:
> >>
> >> arch/arm64/kernel/ftrace.c: In function 'ftrace_make_nop':
> >> arch/arm64/kernel/ftrace.c:171:8: error: implicit declaration of function 'within_module'; did you mean 'init_module'? [-Werror=implicit-function-declaration]
> >>
> >> This addresses both by adding the appropriate stubs.
> >>
> >> Fixes: e71a4e1bebaf ("arm64: ftrace: add support for far branches to dynamic ftrace")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  arch/arm64/include/asm/module.h | 6 ++++++
> >>  arch/arm64/kernel/ftrace.c      | 2 +-
> >>  include/linux/module.h          | 5 +++++
> >>  3 files changed, 12 insertions(+), 1 deletion(-)
> >
> > I can't seem to reproduce this simply by disabling MODULES in defconfig.
> > Could you share your .config, please?
> 
> This is the randconfig I used: https://pastebin.com/SfKBY7f8

Thanks, I was forgetting to enable ftrace. I think a simpler patch (and one
that I can just apply via arm64) is switching the IS_ENABLEDs out for
#ifdefs. See below.

Will

--->8

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 8a42be0693c9..401aa27808a4 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -71,11 +71,12 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long pc = rec->ip;
-	long offset = (long)pc - (long)addr;
 	u32 old, new;
 
-	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
-	    (offset < -SZ_128M || offset >= SZ_128M)) {
+#ifdef CONFIG_ARM64_MODULE_PLTS
+	long offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
 		unsigned long *trampoline;
 		struct module *mod;
 
@@ -121,6 +122,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		}
 		addr = (unsigned long)&trampoline[1];
 	}
+#endif /* CONFIG_ARM64_MODULE_PLTS */
 
 	old = aarch64_insn_gen_nop();
 	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
@@ -135,12 +137,13 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
 	unsigned long pc = rec->ip;
-	long offset = (long)pc - (long)addr;
 	bool validate = true;
 	u32 old = 0, new;
 
-	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
-	    (offset < -SZ_128M || offset >= SZ_128M)) {
+#ifdef CONFIG_ARM64_MODULE_PLTS
+	long offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
 		u32 replaced;
 
 		/*
@@ -177,6 +180,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		old = aarch64_insn_gen_branch_imm(pc, addr,
 						  AARCH64_INSN_BRANCH_LINK);
 	}
+#endif /* CONFIG_ARM64_MODULE_PLTS */
 
 	new = aarch64_insn_gen_nop();
 
