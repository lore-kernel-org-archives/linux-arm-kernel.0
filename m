From: keescook@chromium.org (Kees Cook)
Date: Mon, 22 Jan 2018 23:26:36 +1100
Subject: per-task stack canaries for arm64
In-Reply-To: <CAKv+Gu8P6OZDSMw7oA+5_RgGLkeOwoaEPb_5c510uoBAJY7MeA@mail.gmail.com>
References: <CAKv+Gu_rdDEQeBYabZCOywws96mTWF4F=JEpVNXEW76tAwo1Rw@mail.gmail.com>
 <CAGXu5j+cJoc6o8d-hmLFj08r18GhEbKhVNA94LDKM5yqo9CbSQ@mail.gmail.com>
 <CAKv+Gu9vViZUBYJWnGdnewL9h-ahP0Hs8gU+3_QH76ROdQh1yQ@mail.gmail.com>
 <CAGXu5j+PO=Ben0J-xnOztrAdsku2SUKFiz6w7cqTEfHTveFFSg@mail.gmail.com>
 <f80404f3-985f-9e3b-2ad3-f2b0fc2a8b28@arm.com>
 <CAKv+Gu-TtJ7Pxa7+qOX7MiQwPFwsNOup2Q=0TvjCO4xHxf3QQA@mail.gmail.com>
 <CAKv+Gu8P6OZDSMw7oA+5_RgGLkeOwoaEPb_5c510uoBAJY7MeA@mail.gmail.com>
Message-ID: <CAGXu5j+erd-=LqZdxEDUQnHhtsEbZ1YNch4sToKk+MWzybvQWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 9:59 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> OK, so I have done a bit of homework, and I think this shouldn't be
> too difficult after all.
>
> I realized that we don't really need per-CPU references to
> __stack_chk_guard, given that we already keep the task struct pointer
> in sp_el0. This means we should be able to do
>
> mrs   x0, sp_el0
> movz  x1, :abs_g0:__stack_chk_guard_tsk_offset
> add   x0, x0, x1
> ldr   x2, [x0]
>
> where __stack_chk_guard_tsk_offset is exposed via an ELF symbol.
> (Analogous to x86, this could be implemented at the GCC level using
> arbitrary sysreg and symbol names to remain flexible)
>
> So my next question (mainly to Ramana): would it be possible to emit
> the mrs/movz/add sequence above from targetm.stack_protect_guard() in
> a way that will allow expand_normal() to expand it in a useful manner
> (e.g., as an INDIRECT_REF that can be matched by the memory_operand in
> Aarch64's stack_protect_set)? If that is the case, we could implement
> this in a GCC plugin in the kernel rather than relying on upstream GCC
> changes (and having to commit to this ABI long term)

Though this would ultimately be implemented in core GCC, yes? (I don't
want to have GCC plugins be a dependency for stack protector...)

-Kees

-- 
Kees Cook
Pixel Security
