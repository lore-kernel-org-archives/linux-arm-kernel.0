From: Dave.Martin@arm.com (Dave P Martin)
Date: Wed, 18 Sep 2013 14:32:25 +0100
Subject: [PATCH] ARM: fix Thumb-2 bug in AES assembler code
In-Reply-To: <CAKv+Gu9z32WHi88di0ar0C-=Se-ni_0KqQsqvon9FmVr91PQvQ@mail.gmail.com>
References: <1379434519-23299-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.03.1309171234120.20709@syhkavp.arg>
 <CAKv+Gu9z32WHi88di0ar0C-=Se-ni_0KqQsqvon9FmVr91PQvQ@mail.gmail.com>
Message-ID: <20130918133225.GA779@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 05:41:04PM +0100, Ard Biesheuvel wrote:
> On 17 September 2013 18:35, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 17 Sep 2013, Ard Biesheuvel wrote:
> >
> >> Patch 638591c enabled building the AES assembler code in Thumb2 mode.
> >> However, this code uses arithmetic involving PC rather than adr{l}
> >> instructions to generate PC-relative references to the lookup tables,
> >> and this needs to take into account the different PC offset when
> >> running in Thumb mode.
> >
> > Wouldn't it be better to fix this using adr instead?
> >
> 
> Excellent point. I am just being overly cautious perhaps, but my idea
> was to stay as close as possible to the original.
> Let me check if it builds with adr (no adrl in thumb), if so I will respin.

Explicit references to PC are often wrong (or at least, unless you Know
What You're Doing)

<shameless plug>

There's discussion of some of these issues here:

https://wiki.ubuntu.com/ARM/Thumb2PortingHowto

</shameless plug>

Cheers
---Dave

> 
> -- 
> Ard.
> 
> 
> >
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>
> >> This needs cc to stable for 3.10/3.11 as well.
> >>
> >>
> >>  arch/arm/crypto/aes-armv4.S | 11 +++++++----
> >>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/crypto/aes-armv4.S b/arch/arm/crypto/aes-armv4.S
> >> index 19d6cd6..33c30ab 100644
> >> --- a/arch/arm/crypto/aes-armv4.S
> >> +++ b/arch/arm/crypto/aes-armv4.S
> >> @@ -148,7 +148,8 @@ AES_Te:
> >>  @             const AES_KEY *key) {
> >>  .align       5
> >>  ENTRY(AES_encrypt)
> >> -     sub     r3,pc,#8                @ AES_encrypt
> >> +ARM( sub     r3,pc,#8        )       @ AES_encrypt
> >> +THUMB(       sub     r3,pc,#4        )
> >>       stmdb   sp!,{r1,r4-r12,lr}
> >>       mov     r12,r0          @ inp
> >>       mov     r11,r2
> >> @@ -381,7 +382,8 @@ _armv4_AES_encrypt:
> >>  .align       5
> >>  ENTRY(private_AES_set_encrypt_key)
> >>  _armv4_AES_set_encrypt_key:
> >> -     sub     r3,pc,#8                @ AES_set_encrypt_key
> >> +ARM( sub     r3,pc,#8        )       @ AES_set_encrypt_key
> >> +THUMB(       sub     r3,pc,#4        )
> >>       teq     r0,#0
> >>       moveq   r0,#-1
> >>       beq     .Labrt
> >> @@ -843,8 +845,9 @@ AES_Td:
> >>  @             const AES_KEY *key) {
> >>  .align       5
> >>  ENTRY(AES_decrypt)
> >> -     sub     r3,pc,#8                @ AES_decrypt
> >> -     stmdb   sp!,{r1,r4-r12,lr}
> >> +ARM( sub     r3,pc,#8        )       @ AES_decrypt
> >> +THUMB(       sub     r3,pc,#4        )
> >> +             stmdb   sp!,{r1,r4-r12,lr}
> >>       mov     r12,r0          @ inp
> >>       mov     r11,r2
> >>       sub     r10,r3,#AES_decrypt-AES_Td              @ Td
> >> --
> >> 1.8.1.2
> >>
> 
