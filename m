From: yalin.wang2010@gmail.com (yalin wang)
Date: Sat, 1 Aug 2015 18:00:23 +0800
Subject: [RFC] arm64:change jump_label to use branch instruction,
 not use NOP instr
In-Reply-To: <20150731101432.GA29497@arm.com>
References: <94E2034B-9DE4-4ADF-8B2F-197D38A363CF@gmail.com>
 <20150731075259.GR25159@twins.programming.kicks-ass.net>
 <8F6A71B0-C7DB-4505-BEE2-79967FC91A8F@gmail.com>
 <20150731093355.GU25159@twins.programming.kicks-ass.net>
 <20150731101432.GA29497@arm.com>
Message-ID: <33D3C3BF-C8E7-4423-8062-DA83EF826872@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> ? 2015?7?31??18:14?Will Deacon <will.deacon@arm.com> ???
> 
> On Fri, Jul 31, 2015 at 10:33:55AM +0100, Peter Zijlstra wrote:
>> On Fri, Jul 31, 2015 at 05:25:02PM +0800, yalin wang wrote:
>>>> On Jul 31, 2015, at 15:52, Peter Zijlstra <peterz@infradead.org> wrote:
>>>> On Fri, Jul 31, 2015 at 03:41:37PM +0800, yalin wang wrote:
>>>>> This change a little arch_static_branch(), use b . + 4 for false
>>>>> return, why? According to aarch64 TRM, if both source and dest
>>>>> instr are branch instr, can patch the instr directly, don't need
>>>>> all cpu to do ISB for sync, this means we can call
>>>>> aarch64_insn_patch_text_nosync() during patch_text(),
>>>>> will improve the performance when change a static_key.
>>>> 
>>>> This doesn't parse.. What?
>>>> 
>>>> Also, this conflicts with the jump label patches I've got.
>>> 
>>> this is arch depend , you can see aarch64_insn_patch_text( ) for more info,
>>> if aarch64_insn_hotpatch_safe() is true, will patch the text directly.
>> 
>> So I patched all arches, including aargh64.
>> 
>>> what is your git branch base? i make the patch based on linux-next branch,
>>> maybe a little delay than yours , could you share your branch git address?
>>> i can make a new based on yours .
>> 
>> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git/log/?h=locking/jump_label
>> 
>> Don't actually use that branch for anything permanent, this is throw-away
>> git stuff.
>> 
>> But you're replacing a NOP with an unconditional branch to the next
>> instruction? I suppose I'll leave that to Will and co.. I just had
>> trouble understanding your Changelog -- also I was very much not awake
>> yet.
> 
> Optimising the (hopefully rare) patching operation but having a potential
> impact on the runtime code (assumedly a hotpath) seems completely backwards
> to me.
> 
> Yalin, do you have a reason for this change or did you just notice that
> paragraph in the architecture and decide to apply it here?
> 
in fact, i don?t have any special reason to must change like this, just found we can do this when i read
AARCH64 TRM,  then i make this patch :)


> Even then, I think there are technical issues with the proposal, since
> we could get spurious execution of the old code without explicitsynchronisation (see the kick_all_cpus_sync() call in
> aarch64_insn_patch_text).
i think jump_label code don?t have responsibility to make sure the sync with other cores,
if it is not safe to execute old and new patch code on different cores, the caller should 
do this sync, he can cancel  a work_struct  /  cu_sync()  or some thing like this,
i have a look at the software implementation (!HAVE_JUMP_LABEL) ,
it also doesn?t do any sync, just atomic_inc()  and return directly .

if the ARCH technology concern is not a matter, i think we can apply it  :) 

in fact , i have another solution for jump_label, i see we calculate the jump instruction every time ,
why  not let the compiler do this during compile time , during run time , we just need swap it with NOP 
instruction,  and by this method, we don?t need store target address in struct jump_entry ,
it can save some space ,

this is my patch for this method :
?
yalin at ubuntu:~/linux-next$ git diff
diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 1b5e0e8..c040cd3 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -28,16 +28,17 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-       asm goto("1: nop\n\t"
+       asm goto("1: b %l[l_no]\n\t"
                 ".pushsection __jump_table,  \"aw\"\n\t"
                 ".align 3\n\t"
-                ".quad 1b, %l[l_yes], %c0\n\t"
+                ".word %c0 - 1b\n\t"
+                "nop\n\t"
+                ".quad %c0\n\t"
                 ".popsection\n\t"
-                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
-
-       return false;
-l_yes:
+                :  :  "i"(&((char *)key)[branch]) :  : l_no);
        return true;
+l_no:
+       return false;
 }
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
@@ -45,10 +46,11 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
        asm goto("1: b %l[l_yes]\n\t"
                 ".pushsection __jump_table,  \"aw\"\n\t"
                 ".align 3\n\t"
-                ".quad 1b, %l[l_yes], %c0\n\t"
+                ".word %c0 - 1b\n\t"
+                "nop\n\t"
+                ".quad %c0\n\t"
                 ".popsection\n\t"
                 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
-
        return false;
 l_yes:
        return true;
@@ -57,8 +59,8 @@ l_yes:
 typedef u64 jump_label_t;
 
 struct jump_entry {
-       jump_label_t code;
-       jump_label_t target;
+       s32 offset;
+       u32 insn;
        jump_label_t key;
...skipping...
@@ -45,10 +46,11 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
        asm goto("1: b %l[l_yes]\n\t"
                 ".pushsection __jump_table,  \"aw\"\n\t"
                 ".align 3\n\t"
-                ".quad 1b, %l[l_yes], %c0\n\t"
+                ".word %c0 - 1b\n\t"
+                "nop\n\t"
+                ".quad %c0\n\t"
                 ".popsection\n\t"
                 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
-
        return false;
 l_yes:
        return true;
@@ -57,8 +59,8 @@ l_yes:
 typedef u64 jump_label_t;
 
 struct jump_entry {
-       jump_label_t code;
-       jump_label_t target;
+       s32 offset;
+       u32 insn;
        jump_label_t key;
 };
 
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index c2dd1ad..2e0e7bc 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -25,17 +25,10 @@
 void arch_jump_label_transform(struct jump_entry *entry,
                               enum jump_label_type type)
 {
-       void *addr = (void *)entry->code;
-       u32 insn;
-
-       if (type == JUMP_LABEL_JMP) {
-               insn = aarch64_insn_gen_branch_imm(entry->code,
-                                                  entry->target,
-                                                  AARCH64_INSN_BRANCH_NOLINK);
-       } else {
-               insn = aarch64_insn_gen_nop();
-       }
-
+       void *addr = (void *)entry->key - entry->offset;
+       u32 old = *(u32*)addr;
+       u32 insn = entry->insn;
+       entry->insn = old;
        aarch64_insn_patch_text(&addr, &insn, 1);
 }
 --- 
i  just store a offset relative *key address and store a NOP in jump_entry,
when need change a static_key,  we just need swap the jump insert and NOP instr .
the jump_entry is shrieked to u64[2]   , save some space .

Thanks
