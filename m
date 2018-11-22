From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 22 Nov 2018 09:55:18 +0100
Subject: [PATCH] arm64: crc: accelerated-crc32-by-64bytes
In-Reply-To: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D7FFCC@dggemi508-mbx.china.huawei.com>
References: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D7FFCC@dggemi508-mbx.china.huawei.com>
Message-ID: <CAKv+Gu_fvcmAKMdj9RyR43ZWC7KQdqo4m=fwAHfN+7u-KXyEWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Nov 2018 at 02:50, sunrui <sunrui26@huawei.com> wrote:
>
>
>
> On Sun, 18 Nov 2018 at 23:30, Rui Sun <sunrui26@huawei.com> wrote:
>
> >
>
> > add 64 bytes loop to acceleration calculation
>
> >
>
>
>
> Can you share some performance numbers please?
>
>
>
> Also, we don't need 64 byte, 32 byte and 16 byte code paths: just make the 8 byte one a loop as well, and drop the 32 byte and 16 byte ones.
>
>
>
> --
>
>
>
> Consider of some processor has instruction N-way parallel function, with the increase of the data buf?s size, 64B loop will performance better than 16B loop.
>
>
>
> On the other hand, in the same environment I tested the 8B loop, which is worse than the 16-byte loop.
>
>
>
> The test result is shown in the fellow excel(crc test result.xlsx) sheet1(64B loop) and sheet2(8B loop)
>

Maybe I phrased that wrong: if we add the 64-byte loop, there is no
need for a 32-byte block, a 16 byte block and a 8 byte block, since
they all use the same crc32x instruction. After the 64-byte loop, just
loop in the 8-byte sequence until the remaining data is less than 8
bytes.


>
>
> --
>
>
>
> > Signed-off-by: Rui Sun <sunrui26@huawei.com>
>
> > ---
>
> >  arch/arm64/lib/crc32.S | 54
>
> > ++++++++++++++++++++++++++++++++++++++++++++++----
>
> >  1 file changed, 50 insertions(+), 4 deletions(-)
>
> >
>
> > diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S index
>
> > 5bc1e85..2b37009 100644
>
> > --- a/arch/arm64/lib/crc32.S
>
> > +++ b/arch/arm64/lib/crc32.S
>
> > @@ -15,15 +15,61 @@
>
> >         .cpu            generic+crc
>
> >
>
> >         .macro          __crc32, c
>
> > -0:     subs            x2, x2, #16
>
> > -       b.mi            8f
>
> > +
>
> > +64: cmp     x2, #64
>
> > +    b.lt    32f
>
> > +
>
> > +    adds    x11, x1, #16
>
> > +    adds    x12, x1, #32
>
> > +    adds    x13, x1, #48
>
> > +
>
> > +0 : subs    x2, x2, #64
>
> > +    b.mi    32f
>
> > +
>
> > +    ldp     x3, x4, [x1], #64
>
> > +    ldp     x5, x6, [x11], #64
>
> > +    ldp     x7, x8, [x12], #64
>
> > +    ldp     x9, x10,[x13], #64
>
> > +
>
>
>
> Can we do this instead, and get rid of the temp variables?
>
>
>
>     ldp     x3, x4, [x1], #64
>
>     ldp     x5, x6, [x1, #-48]
>
>     ldp     x7, x8, [x1, #-32]
>
>     ldp     x9, x10,[x1, #-16]
>
>
>
> > + CPU_BE( rev     x3, x3      )
>
> > + CPU_BE( rev     x4, x4      )
>
> > + CPU_BE( rev     x5, x5      )
>
> > + CPU_BE( rev     x6, x6      )
>
> > + CPU_BE( rev     x7, x7      )
>
> > + CPU_BE( rev     x8, x8      )
>
> > + CPU_BE( rev     x9, x9      )
>
> > + CPU_BE( rev     x10,x10     )
>
> > +
>
> > +    crc32\c\()x w0, w0, x3
>
> > +    crc32\c\()x w0, w0, x4
>
> > +    crc32\c\()x w0, w0, x5
>
> > +    crc32\c\()x w0, w0, x6
>
> > +    crc32\c\()x w0, w0, x7
>
> > +    crc32\c\()x w0, w0, x8
>
> > +    crc32\c\()x w0, w0, x9
>
> > +    crc32\c\()x w0, w0, x10
>
> > +
>
> > +    b.ne       0b
>
> > +    ret
>
> > +
>
> > +32: tbz     x2, #5, 16f
>
> > +    ldp     x3, x4, [x1], #16
>
> > +    ldp     x5, x6, [x1], #16
>
> > +CPU_BE( rev     x3, x3      )
>
> > +CPU_BE( rev     x4, x4      )
>
> > +CPU_BE( rev     x5, x5      )
>
> > +CPU_BE( rev     x6, x6      )
>
> > +    crc32\c\()x w0, w0, x3
>
> > +    crc32\c\()x w0, w0, x4
>
> > +    crc32\c\()x w0, w0, x5
>
> > +    crc32\c\()x w0, w0, x6
>
> > +
>
> > +16: tbz     x2, #4, 8f
>
> >         ldp             x3, x4, [x1], #16
>
> >  CPU_BE(        rev             x3, x3          )
>
> >  CPU_BE(        rev             x4, x4          )
>
> >         crc32\c\()x     w0, w0, x3
>
> >         crc32\c\()x     w0, w0, x4
>
> > -       b.ne            0b
>
> > -       ret
>
> >
>
> >  8:     tbz             x2, #3, 4f
>
> >         ldr             x3, [x1], #8
>
> > --
>
> > 1.8.3.1
>
> >
>
>
