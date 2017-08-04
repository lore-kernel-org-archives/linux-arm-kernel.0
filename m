From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Aug 2017 13:25:03 +0100
Subject: [PATCH 0/5] Simplify kernel-mode NEON
In-Reply-To: <20170804122225.jiceb2vbgrld2y7z@armageddon.cambridge.arm.com>
References: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
 <20170804120858.ff3772f3zzik37pp@armageddon.cambridge.arm.com>
 <20170804122225.jiceb2vbgrld2y7z@armageddon.cambridge.arm.com>
Message-ID: <CAKv+Gu-YG1EbpvaL46T0fzD=RZ7itqizrH=AkYAN1YmTupmKGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 August 2017 at 13:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Aug 04, 2017 at 01:08:58PM +0100, Catalin Marinas wrote:
>> On Thu, Aug 03, 2017 at 05:23:18PM +0100, Dave P Martin wrote:
>> > This series depends on Ard's v4.14 crypto rework [2].
> [...]
>> > [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/520664.html
> [...]
>> > Ard Biesheuvel (1):
>> >   arm64: neon: replace generic definition of may_use_simd()
>> >
>> > Dave Martin (4):
>> >   arm64: neon: Add missing header guard in <asm/neon.h>
>> >   arm64: fpsimd: Consistently use __this_cpu_ ops where appropriate
>> >   arm64: neon: Allow EFI runtime services to use FPSIMD in irq context
>> >   arm64: neon: Remove support for nested or hardirq kernel-mode NEON
>>
>> Queued for 4.14. Thanks.
>
> ... and reverted.
>
> I now realised that it doesn't build without Ard's crypto series (I had
> the wrong impression it is just a performance impact). I get errors
> like:
>
> arch/arm64/crypto/sha1-ce-glue.c|41 col 2| error: implicit declaration
> of function ?kernel_neon_begin_partial?
>

Ah yes. Apologies for failing to mention that. Apparently, there are
in fact build time cross-dependencies that I forgot about.

To avoid delaying this unnecessarily, we just alias
kernel_neon_begin_partial() to kernel_neon_begin() and ignore the
argument. We can remove that again when everything has gone upstream.
