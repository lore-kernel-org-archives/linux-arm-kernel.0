From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 28 Aug 2017 09:29:35 +0100
Subject: [PATCH 3/3] ARM: XIP kernel: store .data compressed in ROM
In-Reply-To: <alpine.LFD.2.20.1708261129170.14288@knanqh.ubzr>
References: <20170825162600.15709-1-nicolas.pitre@linaro.org>
 <20170825162600.15709-4-nicolas.pitre@linaro.org>
 <CAKv+Gu-5W-bDrMKRctV=muZgN3D9YWThCqP7bqY00zo2AnrA1w@mail.gmail.com>
 <alpine.LFD.2.20.1708261129170.14288@knanqh.ubzr>
Message-ID: <CAKv+Gu-PtmjH0Jq=eJ+gg7wo-EC38vTGNR1hb1ZgP1y2emCiYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 August 2017 at 16:41, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sat, 26 Aug 2017, Ard Biesheuvel wrote:
>
>> On 25 August 2017 at 17:26, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > The .data segment stored in ROM is only copied to RAM once at boot time
>> > and never referenced afterwards. This is arguably a suboptimal usage of
>> > ROM resources.
>> >
>> > This patch allows for compressing the .data segment before storing it
>> > into ROM and decompressing it to RAM rather than simply copying it,
>> > saving on precious ROM space.
>> >
>> > Because global data is not available yet (obviously) we must allocate
>> > decompressor workspace memory on the stack. The .bss area is used as a
>> > stack area for that purpose before it is cleared. The required stack
>> > frame is 9568 bytes for __inflate_kernel_data() alone, so make sure
>> > the .bss is large enough to cope with that plus extra room for called
>> > functions or fail the build.
>> >
>> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
>> > ---
> [...]
>> > +#ifdef CONFIG_XIP_DEFLATED_DATA
>> > +/*
>> > + * The .bss is used as a stack area for __inflate_kernel_data() whose stack
>> > + * frame is 9568 bytes. Make sure it has extra room left.
>> > + */
>> > +ASSERT((_end - __bss_start) >= 12288, ".bss too small for CONFIG_XIP_DEFLATED_DATA")
>>
>> The open coded numbers are a bit confusing here: the stack check uses
>> 10240, the code actually needs >9568 bytes and here, you assert that
>> there is at least 12288 space between _end and __bss_start.
>
> The 9568 bytes is what my particular gcc version actually uses for
> __inflate_kernel_data(). That is not a tail function so some more space
> is needed. I imagine this may vary a bit from compiler versions.
>
> The 10240 is 2.5x page size and 12288 is 3x page size. Those numbers are
> arbitrary but I had to pick something.
>

OK, fair enough.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

BTW, I know this is unrelated but I don't think _end is guaranteed to
be suitably aligned.
