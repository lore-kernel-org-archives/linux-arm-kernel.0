From: keescook@chromium.org (Kees Cook)
Date: Fri, 3 Nov 2017 12:06:15 -0700
Subject: [PATCH 07/15] arm64: use -mno-implicit-float instead of
 -mgeneral-regs-only
In-Reply-To: <20171103185222.k3c5kjo5m7dqieyg@lakrids.cambridge.arm.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-9-samitolvanen@google.com>
 <20171103183156.ando3jj5pl2hfk5j@lakrids.cambridge.arm.com>
 <20171103185222.k3c5kjo5m7dqieyg@lakrids.cambridge.arm.com>
Message-ID: <CAGXu5jLAb+Jj7x8p0mizewoOHuQVqup9DxHkvgqkQFeB5cJo9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 3, 2017 at 11:52 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Nov 03, 2017 at 06:31:56PM +0000, Mark Rutland wrote:
>> On Fri, Nov 03, 2017 at 10:11:52AM -0700, Sami Tolvanen wrote:
>> > From: Greg Hackmann <ghackmann@google.com>
>> >
>> > LLVM bug 30792 causes clang's AArch64 backend to crash compiling
>> > arch/arm64/crypto/aes-ce-cipher.c.  Replacing -mgeneral-regs-only with
>> > -mno-implicit-float is the suggested workaround.
>> >
>> > Signed-off-by: Greg Hackmann <ghackmann@google.com>
>> > Cc: Matthias Kaehlcke <mka@chromium.org>
>> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>>
>> Just to check, what happens if you pass both to clang?
>
> Apparently not. However, we can do:
>
> -KBUILD_CFLAGS  += -mgeneral-regs-only $(lseinstr) $(brokengasinst)
> +KBUILD_CFLAGS  += $(lseinstr) $(brokengasinst)
> +# Clang workaround for https://bugs.llvm.org/show_bug.cgi?id=30792
> +KBUILD_CFLAGS  += $(call cc-option, -mno-implicit-float, -mgeneral-regs-only)

Should a clang version test be included, since we know at least 5.0 is
need (with this fix)? There are distros with much earlier versions of
clang, for example...

-Kees

-- 
Kees Cook
Pixel Security
