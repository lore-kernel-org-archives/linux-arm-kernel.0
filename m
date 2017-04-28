From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Apr 2017 15:47:45 +0100
Subject: [PATCH v2] arm64: Add ASM modifier for xN register operands
In-Reply-To: <CAKv+Gu8h46WS4dq9ge4VnmBTvo5L9RJYUSYXnVpJf+G+av6+dg@mail.gmail.com>
References: <20170426214616.142580-1-mka@chromium.org>
 <20170427110256.GC31337@leverpostej>
 <20170427225221.GS128305@google.com>
 <CAKv+Gu9s2t+Nt7JCcTxkr5BYSN05f_zxYkKzfrD-4owWQLvF_Q@mail.gmail.com>
 <20170428143333.GA5292@leverpostej>
 <CAKv+Gu8h46WS4dq9ge4VnmBTvo5L9RJYUSYXnVpJf+G+av6+dg@mail.gmail.com>
Message-ID: <20170428144745.GR13675@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 03:43:56PM +0100, Ard Biesheuvel wrote:
> On 28 April 2017 at 15:33, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Apr 28, 2017 at 08:18:52AM +0100, Ard Biesheuvel wrote:
> OK, good. That is a departure from previous behavior of Clang, which
> was causing build errors before due to the fact that msr/mrs
> instructions involving 32-bit values must still use x registers.
> 
> > * If an operand type is 64 bits in size, clang will not produce a warning
> >   regarding the operand size.
> >
> > * If an x or w modifier is used, clang will not produce a warning
> >   regarding the operand size, regardless of whether it matches the
> >   register size. Clang is happy for %wN to be used on a pointer type.
> >
> > * If an operand type is less than 64 bits in size, and neither an x or
> >   w modifier is used, clang will produce a warning as above.
> >
> > * If an operand type is greater than 64 bits in size, clang encounters
> >   an internal error.
> >
> > Given that, I think we *should not* use the x modifier to suppress this
> > warning, as I think for those cases we have a potential bug as outlined
> > in my prior reply.
> >
> > Instead, we should use a temporary 64-bit variable (or cast input
> > operands to 64-bit), which avoids that and makes clang happy.
> >
> 
> Yes, I think that makes sense.

Likewise, we could even raise a feature request against GCC because these
warnings actually sound useful. Thanks for getting to the bottom of this.

Will
