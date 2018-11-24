From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 24 Nov 2018 10:56:41 +0100
Subject: [PATCH] arm64: crc: accelerated-crc32-by-64bytes
In-Reply-To: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D82974@dggemi508-mbx.china.huawei.com>
References: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D82974@dggemi508-mbx.china.huawei.com>
Message-ID: <CAKv+Gu-ffSgS-ZH58u5mNYnqR0++osS-PHn8oHW72o2kRfDYCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 24 Nov 2018 at 07:42, sunrui <sunrui26@huawei.com> wrote:
>
>
> On Thu, 22 Nov 2018 at 02:50, sunrui <sunrui26@huawei.com> wrote:
> >
> >
> >
> > On Sun, 18 Nov 2018 at 23:30, Rui Sun <sunrui26@huawei.com> wrote:
> >
> > >
> >
> > > add 64 bytes loop to acceleration calculation
> >
> > >
> >
> >
> >
> > Can you share some performance numbers please?
> >
> >
> >
> > Also, we don't need 64 byte, 32 byte and 16 byte code paths: just make the 8 byte one a loop as well, and drop the 32 byte and 16 byte ones.
> >
> >
> >
> > --
> >
> >
> >
> > Consider of some processor has instruction N-way parallel function, with the increase of the data buf?s size, 64B loop will performance better than 16B loop.
> >
> >
> >
> > On the other hand, in the same environment I tested the 8B loop, which is worse than the 16-byte loop.
> >
> >
> >
> > The test result is shown in the fellow excel(crc test result.xlsx)
> > sheet1(64B loop) and sheet2(8B loop)
> >
> >
> >Maybe I phrased that wrong: if we add the 64-byte loop, there is no need for a 32-byte block, a 16 byte block and a 8 byte block, since they all use the same crc32x instruction. After the 64-byte loop, just loop in the 8-byte sequence until the remaining data is less than 8 bytes.
> >
> >
> >
> I think we should not use 8-byte loop after 64-byte loop. Although the number of code lines is reduced, but it will run more subs and b.cond instruction. I test it and shown the result in the fellow excel.
>

OK

> Why I used three temp variables to do the ldp below is because our processor have two load/store unit, if we use the registers which are independent, it can processed in parallel.
>

Yes, but you are adding three instructions to a tight loop, which will
be noticeable on in-order cores.

Just use something like

ldp x3, x4, [x0]
ldp x5, x6, [x0, #16]
ldp x7, x8, [x0, #32]
ldp x9, x10, [x0, #48]
add x0, x0, #64

Those are completely independent as well

> By the way,  In most cases, crc short XOR 0xffffffff before and after the calculation, if we add 'mvn w0, w0' at the beginning and before the return will bring some benefits. What do you think about it?

The C code will take care of that.

> >
> >
> > --
> >
> >
> >
> > > Signed-off-by: Rui Sun <sunrui26@huawei.com>
> >
> > > ---
> >
> > >  arch/arm64/lib/crc32.S | 54
> >
> > > ++++++++++++++++++++++++++++++++++++++++++++++----
> >
> > >  1 file changed, 50 insertions(+), 4 deletions(-)
> >
> > >
> >
> > > diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S index
> >
> > > 5bc1e85..2b37009 100644
> >
> > > --- a/arch/arm64/lib/crc32.S
> >
> > > +++ b/arch/arm64/lib/crc32.S
> >
> > > @@ -15,15 +15,61 @@
> >
> > >         .cpu            generic+crc
> >
> > >
> >
> > >         .macro          __crc32, c
> >
> > > -0:     subs            x2, x2, #16
> >
> > > -       b.mi            8f
> >
> > > +
> >
> > > +64: cmp     x2, #64
> >
> > > +    b.lt    32f
> >
> > > +
> >
> > > +    adds    x11, x1, #16
> >
> > > +    adds    x12, x1, #32
> >
> > > +    adds    x13, x1, #48
> >
> > > +
> >
> > > +0 : subs    x2, x2, #64
> >
> > > +    b.mi    32f
> >
> > > +
> >
> > > +    ldp     x3, x4, [x1], #64
> >
> > > +    ldp     x5, x6, [x11], #64
> >
> > > +    ldp     x7, x8, [x12], #64
> >
> > > +    ldp     x9, x10,[x13], #64
> >
> > > +
> >
> >
> >
> > Can we do this instead, and get rid of the temp variables?
> >
> >
> >
> >     ldp     x3, x4, [x1], #64
> >
> >     ldp     x5, x6, [x1, #-48]
> >
> >     ldp     x7, x8, [x1, #-32]
> >
> >     ldp     x9, x10,[x1, #-16]
> >
> >
> >
> > > + CPU_BE( rev     x3, x3      )
> >
> > > + CPU_BE( rev     x4, x4      )
> >
> > > + CPU_BE( rev     x5, x5      )
> >
> > > + CPU_BE( rev     x6, x6      )
> >
> > > + CPU_BE( rev     x7, x7      )
> >
> > > + CPU_BE( rev     x8, x8      )
> >
> > > + CPU_BE( rev     x9, x9      )
> >
> > > + CPU_BE( rev     x10,x10     )
> >
> > > +
> >
> > > +    crc32\c\()x w0, w0, x3
> >
> > > +    crc32\c\()x w0, w0, x4
> >
> > > +    crc32\c\()x w0, w0, x5
> >
> > > +    crc32\c\()x w0, w0, x6
> >
> > > +    crc32\c\()x w0, w0, x7
> >
> > > +    crc32\c\()x w0, w0, x8
> >
> > > +    crc32\c\()x w0, w0, x9
> >
> > > +    crc32\c\()x w0, w0, x10
> >
> > > +
> >
> > > +    b.ne       0b
> >
> > > +    ret
> >
> > > +
> >
> > > +32: tbz     x2, #5, 16f
> >
> > > +    ldp     x3, x4, [x1], #16
> >
> > > +    ldp     x5, x6, [x1], #16
> >
> > > +CPU_BE( rev     x3, x3      )
> >
> > > +CPU_BE( rev     x4, x4      )
> >
> > > +CPU_BE( rev     x5, x5      )
> >
> > > +CPU_BE( rev     x6, x6      )
> >
> > > +    crc32\c\()x w0, w0, x3
> >
> > > +    crc32\c\()x w0, w0, x4
> >
> > > +    crc32\c\()x w0, w0, x5
> >
> > > +    crc32\c\()x w0, w0, x6
> >
> > > +
> >
> > > +16: tbz     x2, #4, 8f
> >
> > >         ldp             x3, x4, [x1], #16
> >
> > >  CPU_BE(        rev             x3, x3          )
> >
> > >  CPU_BE(        rev             x4, x4          )
> >
> > >         crc32\c\()x     w0, w0, x3
> >
> > >         crc32\c\()x     w0, w0, x4
> >
> > > -       b.ne            0b
> >
> > > -       ret
> >
> > >
> >
> > >  8:     tbz             x2, #3, 4f
> >
> > >         ldr             x3, [x1], #8
> >
> > > --
> >
> > > 1.8.3.1
> >
> > >
> >
> >
