From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 20 Nov 2017 15:25:31 +0000
Subject: [PATCH v2 16/18] arm64: crypto: disable LTO for aes-ce-cipher.c
In-Reply-To: <20171120152014.hftuded4zxwn2r7m@lakrids.cambridge.arm.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-17-samitolvanen@google.com>
 <20171120152014.hftuded4zxwn2r7m@lakrids.cambridge.arm.com>
Message-ID: <CAKv+Gu-hnoeLqNsHbrLXv3xu7qsYB6REiwMtQYW_0CPwZ7jF4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2017 at 15:20, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 15, 2017 at 01:34:26PM -0800, Sami Tolvanen wrote:
>> CONFIG_LTO_CLANG requires the use of clang's integrated assembler, which
>> doesn't understand the inline assembly in aes-ce-cipher.c. Disable LTO for
>> the file to work around the issue.
>
> Could you elaborate on what the integrated asembler doesn't like?
>
> It's not entirely clear at a glance, as the asm in that file doesn't
> seem to do anything that obscure.
>

Actually, it just occurred to me that this code does not adhere 100%
to the kernel mode neon rules, by putting kernel_neon_begin/end and
the code itself into the same source file. At the time, it seemed
harmless, given that these functions are only exposed via function
pointers and never called locally, and the compiler cannot really
reorder the function calls with the asm block. However, under LTO this
all changes, and it is no longer guaranteed that the NEON registers
are only touched between the kernel mode neon begin/end calls.

So the correct way to fix this would be to move the asm into its own
.S file, and call it from between the kernel_mode_neon_begin/end
calls. That should also fix your compat issue.
