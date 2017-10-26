From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 26 Oct 2017 13:55:47 -0700
Subject: [PATCH] arm64: prevent regressions in compressed kernel image
 size when upgrading to binutils 2.27
In-Reply-To: <CAKv+Gu80ub1PnibzBtjPSOusHD-6oj4A=7ZeuW5VTv3aDQrdnQ@mail.gmail.com>
References: <20171026202907.91852-1-ndesaulniers@google.com>
 <CAKv+Gu80ub1PnibzBtjPSOusHD-6oj4A=7ZeuW5VTv3aDQrdnQ@mail.gmail.com>
Message-ID: <CAKwvOd=4=GOPUSYUzwkXHV2xhTzUnEpbw4c_PmFiqZBjbV80jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 26, 2017 at 1:41 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Since we will need to support bfd ld < 2.27 for a while to come, and
> given that we cannot test in the code whether the relocation targets
> are seeded with the correct values, I propose we simply drop the outer
> ifeq here, and  stick with the old behavior unconditionally. Once
> we're ready to drop support for <2.27 binutils, we can revisit this if
> desired.

Ard, thanks for the quick review!

--no-apply-dynamic-relocs was added in binutils 2.27, so ld-option
should support 2.27 and prior:

$ aarch64-linux-android/bin/ld -v
GNU ld (binutils-2.27-53dd00a1) 2.27.0.20170315
$ aarch64-linux-android/bin/ld -E --no-apply-dynamic-relocs temp.o
$ echo $?
0

$ aarch64-linux-android/bin/ld -v
GNU ld (binutils-2.25-f3d35cf6) 2.25.51.20141117
$ aarch64-linux-android/bin/ld -E --no-apply-dynamic-relocs temp.o
./prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/aarch64-linux-android/bin/ld:
unrecognized option '--no-apply-dynamic-relocs'
$ echo $?
1

ld-option will catch that.

> are seeded with the correct values, I propose we simply drop the outer

I haven't verified this with other compression schemes, but my
teammate Wei just reported this benefits gzip as well.  What do you
think?

> Also, you should be using CONFIG_RELOCATABLE not CONFIG_RANDOMIZE_BASE,.

Sure thing, will send v2 once you clarify the outer conditional and if
ld-option helps us take this patch now.

-- 
Thanks,
~Nick Desaulniers
