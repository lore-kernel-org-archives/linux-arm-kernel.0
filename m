From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Jan 2016 12:37:41 +0000
Subject: [PATCH 1/2] arm64: add macro to handle large immediates
In-Reply-To: <CAKv+Gu95+F2HhoirhyfoKSs7oUY_5qBdDGcKfXmZi2sS8mERNg@mail.gmail.com>
References: <1452078327-9635-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu_Oo1=Wwr9jRQBTn7bs2KVisSkwkFvJASocCS26taeo-w@mail.gmail.com>
 <20160106122104.GF563@leverpostej>
 <CAKv+Gu95+F2HhoirhyfoKSs7oUY_5qBdDGcKfXmZi2sS8mERNg@mail.gmail.com>
Message-ID: <20160106123740.GH563@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> Ack for the general idea, but for correctness, you should pair the
> >> movk instructions with the _nc relocations (i.e., keep movz first, but
> >> invert the order of the relocs)
> >
> > Ah, I hadn't spotted the restriction. I'll change that to:
> >
> >         movz    \dst, :abs_g3:\val
> >         movk    \dst, :abs_g2:\val
> >         movk    \dst, :abs_g1:\val
> >         movk    \dst, :abs_g0:\val
> >
> 
> Yes, but with the _nc suffix on the latter three.

Yup.

> > That raises a related question. Is it the linker's responsibility to
> > fill in the shift encoding in the hw field as part of the g{3,2,1}
> > relocs?
> >
> 
> This
> 
> movz x0, :abs_g3:val
> movk x0, :abs_g2_nc:val
> movk x0, :abs_g1_nc:val
> movk x0, :abs_g0_nc:val
> 
> assembles to
> 
> 0000000000000000 <.text>:
>    0: d2e00000 movz x0, #0x0, lsl #48
>    4: f2c00000 movk x0, #0x0, lsl #32
>    8: f2a00000 movk x0, #0x0, lsl #16
>    c: f2800000 movk x0, #0x0
> 
> so it is in fact the assembler that sets the hw field.

Interesting!

As I mentioned in another reply, for the moment I'm going to drop mov_l
unless we have another need for it.

Thanks,
Mark.
