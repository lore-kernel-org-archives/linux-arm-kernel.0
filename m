From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 6 Nov 2017 16:55:15 +0000
Subject: [PATCH v4] arm64: support __int128 on gcc 5+
In-Reply-To: <CAHmME9p+ef-+fmdiO15LU7X3Sr-CDyngpPwKZN2FqOQmZNjLtg@mail.gmail.com>
References: <20171103141858.13149-1-Jason@zx2c4.com>
 <20171106093151.8312-1-Jason@zx2c4.com>
 <20171106155917.glgjgipppzsdpp6h@armageddon.cambridge.arm.com>
 <20171106161459.bm4b2c7ahljluuda@armageddon.cambridge.arm.com>
 <CAHmME9p+ef-+fmdiO15LU7X3Sr-CDyngpPwKZN2FqOQmZNjLtg@mail.gmail.com>
Message-ID: <CAKv+Gu94w3f0n4qDeR3uC5nVaKwjTUYf8W4cs5L3nE1HxoDG9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2017 at 16:51, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Wait, please don't jump to that decision so quickly.
>
> Are you sure the fail is for v4? Will mentioned this with v1, which is whay
> this current v4 is supposed to fix up.
>

It appears your v4 adds __ashlti3() and __ashrti3, whereas the error
is about __lshrti3() being undefined.


> On Nov 7, 2017 01:15, "Catalin Marinas" <catalin.marinas@arm.com> wrote:
>
> On Mon, Nov 06, 2017 at 03:59:18PM +0000, Catalin Marinas wrote:
>> On Mon, Nov 06, 2017 at 10:31:51AM +0100, Jason A. Donenfeld wrote:
>> > Versions of gcc prior to gcc 5 emitted a __multi3 function call when
>> > dealing with TI types, resulting in failures when trying to link to
>> > libgcc, and more generally, bad performance. However, since gcc 5,
>> > the compiler supports actually emitting fast instructions, which means
>> > we can at long last enable this option and receive the speedups.
>> >
>> > The gcc commit that added proper Aarch64 support is:
>> >
>> > https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=d1ae7bb994f49316f6f63e6173f2931e837a351d
>> > This commit appears to be part of the gcc 5 release.
>> >
>> > There are still a few instructions, __ashlti3 and __ashrti3, which
>> > require libgcc, which is fine. Rather than linking to libgcc, we
>> > simply provide them ourselves, since they're not that complicated.
>> >
>> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>
>> According to Arnd, linux-next (with this patch included) fails to build
>> with gcc-7 (config: https://pastebin.com/raw/sgvPe96e).
>
> Actually, it fails with gcc-6 as well (gcc (Debian 6.3.0-18) 6.3.0
> 20170516) with this error:
>
> kernel/sched/fair.o: In function `__calc_delta':
> fair.c:(.text+0x84c): undefined reference to `__lshrti3'
> kernel/time/timekeeping.o: In function `timekeeping_resume':
> timekeeping.c:(.text+0x2cac): undefined reference to `__lshrti3'
>
> So I'm for reverting the commit and we should allow more randconfig
> tests for the 4.16 merging window.
>
> --
> Catalin
>
>
