From: panand@redhat.com (Pratyush Anand)
Date: Wed, 2 Nov 2016 15:44:36 +0530
Subject: [PATCH V3 2/6] arm64: kgdb_step_brk_fn: ignore other's exception
In-Reply-To: <CAMNZz5Bjr1f-uzgCx-svFXV_u8xfKudChURVULAqFzu158cxfg@mail.gmail.com>
References: <cover.1478068479.git.panand@redhat.com>
 <9d2c9444762f1623e75b7de9e5783a94a257a00d.1478068479.git.panand@redhat.com>
 <CAMNZz5Bjr1f-uzgCx-svFXV_u8xfKudChURVULAqFzu158cxfg@mail.gmail.com>
Message-ID: <2afdd880-86a0-4029-6c2f-091c5939fa95@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 02 November 2016 03:30 PM, Sandeepa Prabhu wrote:
>
>
> On Wed, Nov 2, 2016 at 2:40 PM, Pratyush Anand <panand@redhat.com
> <mailto:panand@redhat.com>> wrote:
>
>     ARM64 step exception does not have any syndrome information. So, it is
>     responsibility of exception handler to take care that they handle it
>     only if exception was raised for them.
>
>     Since kgdb_step_brk_fn() always returns 0, therefore we might have
>     problem
>     when we will have other step handler registered as well.
>
>     This patch fixes kgdb_step_brk_fn() to return error in case of step
>     handler
>     was not meant for kgdb.
>
>     Signed-off-by: Pratyush Anand <panand@redhat.com
>     <mailto:panand@redhat.com>>
>     ---
>      arch/arm64/kernel/kgdb.c | 3 +++
>      1 file changed, 3 insertions(+)
>
>     diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
>     index e017a9493b92..d217c9e95b06 100644
>     --- a/arch/arm64/kernel/kgdb.c
>     +++ b/arch/arm64/kernel/kgdb.c
>     @@ -247,6 +247,9 @@ NOKPROBE_SYMBOL(kgdb_compiled_brk_fn);
>
>      static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
>      {
>     +       if (!kgdb_single_step)
>     +               return DBG_HOOK_ERROR;
>     +
>
> ?This is needed. So, single stepping in kprobes working all these days
> because kprobes handler was registered earlier to kgdb handler!?

Actually kprobe_single_step_handler() is not called through 
call_step_hook(), so it is always safe.

We had discussed here (https://lkml.org/lkml/2016/9/7/6) that why we can 
not register kprobe_single_step_handler() via register_set_hook()
and only invoke call_step_hook().

~Pratyush
