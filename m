From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 2 Oct 2018 15:10:17 +0200
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on
 CPU32v3
In-Reply-To: <CAHmME9pFnuRx2F=xeyK8d3bwv3bJY+WvE1KZn__+2oFWS0RCnA@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com>
 <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
 <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
 <CAHmME9pFnuRx2F=xeyK8d3bwv3bJY+WvE1KZn__+2oFWS0RCnA@mail.gmail.com>
Message-ID: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2018 at 14:30, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Arnd,
>
> On Tue, Oct 2, 2018 at 9:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> > I think we're going to wind up playing whack-a-mole in silly ways. The
>> > fact of the matter is that the ARM assembly I'm adding to the tree is
>> > for ARMv4 and up, and not for ARMv3.
>>
>> I don't see what issues remain. The 'reteq lr' that Ard mentioned
>> is definitely the correct way to return from assembly (you also need
>> that for plain armv4, as 'bx' was added in armv4t), and Russell
>> confirmed that using -march=armv3m is something we want
>> anyway for mach-rpc.
>
> I'll do that. I can confirm that after changing it to `reteq lr`,
> everything works well with armv3m.
>
>> > I think there are three options to work around this issue:
>> >
>> > 1) Not build my assembly when CONFIG_CPU_32v3 via a Kconfig "depends".
>> > 2) Set asflags-$(CONFIG_CPU_32v3) inside my module locally to select
>> > -march=armv4.
>> > 3) This patch.
>> >
>> > My initial plan was (1). ArdB recommended I do (2) instead. I thought
>> > that was a bit too nuanced and submitted (3).
>>
>> I suspect all three of the above fail to work for armv4.
>
> Armv4 does actually work in this configuration, in fact.

It builds but it doesn't run, at least not when built into the kernel
proper (which will be the case after random.c moves to this library)

Your toolchain is implicitly passing --fix-v4bx to the assembler,
which causes it to permit bx instructions in ARMv4 object code, but
tag them with special R_ARM_V4BX ELF relocations. The ARM module
loader does take these into account, so built as a module, it works.
However, when built into the core kernel, we have to rely on the
linker to patch this instruction into the ARMv4 equivalent, and a
quick check reveals that that is currently not the case.

Bottom line: let's not go there.

> But anyway,
> I'll go with your primary suggestion and we therefore can move ahead
> with changing the global cflag to march=armv3m. Would you like me to
> submit the patch for this, or would yo like to handle it?
>

Yes please go ahead.
