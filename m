From: alex.popov@linux.com (Alexander Popov)
Date: Wed, 21 Nov 2018 02:08:29 +0300
Subject: Investigating a stack state mismatch in Linux kernel
In-Reply-To: <2a2b1181-2175-7e4e-189c-12630f43d10d@linux.com>
References: <b7aad232-76e1-241f-00e2-77783ce30f87@linux.com>
 <875zwyabac.fsf@oldenburg.str.redhat.com>
 <2a2b1181-2175-7e4e-189c-12630f43d10d@linux.com>
Message-ID: <57225f38-3f6d-4029-8f89-4b6eba97c3c1@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone!

At irc.freenode.org/#gcc people told me that I should CC gcc at gcc.gnu.org to get
some attention of gcc developers.

Link to previous discussion:
 https://www.openwall.com/lists/kernel-hardening/2018/11/14/1


On 15.11.2018 23:51, Alexander Popov wrote:
> In the original grsecurity code the stackleak RTL pass was registered just
> before the 'rtl-final' pass. Some time ago Richard Sandiford noted that:
> 
>>>> This might be too late, since it happens e.g. after addresses have
>>>> been calculated for branch ranges, and after machine-specific passes
>>>> (e.g. bundling on ia64).
>>>>
>>>> The stack size is final after reload, so inserting the pass after that
>>>> might be better.
> 
> https://lore.kernel.org/patchwork/patch/879912/
> 
> So what is the best moment when we know the stack frame size and can safely
> delete the CALL insn using delete_insn_and_edges()?

At irc.oftc.net/#gcc Segher (kudos to him!) confirmed that 'final' pass is too
late for this and proposed registering 'stackleak_cleanup' pass before
'machine_reorg' pass. It's the moment when the stack frame size is already final
and function prologues and epilogues are generated. That would also fit
Richard's concerns.

It looks reasonable -- that's what gcc/target.def says about
machine_dependent_reorg() hook, which is called during 'machine_reorg' pass:

"If non-null, this hook performs a target-specific pass over the
instruction stream. The compiler will run it at all optimization levels,
just before the point at which it normally does delayed-branch scheduling.
The exact purpose of the hook varies from target to target.  Some use
it to do transformations that are necessary for correctness, such as
laying out in-function constant pools or avoiding hardware hazards.
Others use it as an opportunity to do some machine-dependent optimizations".


So I would appreciate any comments on the following solution:

diff --git a/scripts/gcc-plugins/stackleak_plugin.c
b/scripts/gcc-plugins/stackleak_plugin.c
index 2f48da9..6f41b32 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args
*plugin_info,
                                                PASS_POS_INSERT_BEFORE);

        /*
-        * The stackleak_cleanup pass should be executed after the
-        * "reload" pass, when the stack frame size is final.
+        * The stackleak_cleanup pass should be executed before the "mach"
+        * pass, which performs the machine dependent code transformations.
+        * It's the moment when the stack frame size is already final and
+        * function prologues and epilogues are generated.
         */
-       PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER);
+       PASS_INFO(stackleak_cleanup, "mach", 1, PASS_POS_INSERT_BEFORE);

        if (!plugin_default_version_check(version, &gcc_version)) {
                error(G_("incompatible gcc/plugin versions"));
