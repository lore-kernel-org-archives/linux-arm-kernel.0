From: vikas.manocha@st.com (Vikas MANOCHA)
Date: Tue, 23 May 2017 01:06:28 +0000
Subject: [PATCH 1/1] ARM: compressed/head.S: fix __nop macro rept number
 for ARMv7M
In-Reply-To: <058263e4-458a-7939-1c1c-7bcd100cf2c5@st.com>
References: <1493110893-21857-1-git-send-email-patrice.chotard@st.com>
 <ee014785-f025-8b16-14a7-7f1d86403421@st.com>
 <CAKv+Gu-_q-SQn3WKDObOW3_OMd2B_UbcdD+PHkzk7Q6nZbZTfA@mail.gmail.com>
 <058263e4-458a-7939-1c1c-7bcd100cf2c5@st.com>
Message-ID: <489cca7ec7564ed4b6698c3da4010b2b@SFHDAG7NODE3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice,

> -----Original Message-----
> From: Patrice CHOTARD
> Sent: Friday, May 19, 2017 6:41 AM
> To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux at armlinux.org.uk; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Christophe PRIOUZEAU
> <christophe.priouzeau@st.com>; Christophe KERELLO <christophe.kerello@st.com>; Vikas MANOCHA <vikas.manocha@st.com>;
> Patrick DELAUNAY <patrick.delaunay@st.com>
> Subject: Re: [PATCH 1/1] ARM: compressed/head.S: fix __nop macro rept number for ARMv7M
> 
> Hi Ard
> 
> On 05/18/2017 01:16 PM, Ard Biesheuvel wrote:
> > On 12 May 2017 at 08:22, Patrice CHOTARD <patrice.chotard@st.com> wrote:
> >> Hi all
> >>
> >> It's a gentle reminder to not forgot this patch.
> >>
> >> Thanks
> >>
> >> Patrice
> >>
> >> On 04/25/2017 11:01 AM, patrice.chotard at st.com wrote:
> >>> From: Patrice Chotard <patrice.chotard@st.com>
> >>>
> >>> In zImage, _magic_sig is located at offset 0x24.
> >>> But for ARMv7M architecture which enable CPU_THUMBONLY and !EFI_STUB
> >>> kernel flag, _magic_sig is located at offset 0x14
> >>>
> >>> 00000000  00 46 00 46 00 46 00 46  00 46 00 46 00 46 0f f2
> >>> |.F.F.F.F.F.F.F.?|
> >>> 00000010  15 0c 60 47 18 28 6f 01  00 00 00 00 28 5c 0e 00
> >>> |..`G.(o.....(\..|
> >>> 00000020  01 02 03 04 0f 46 90 46  00 00 00 00 00 00 00 00
> >>> |.....F.F........|
> >>>
> >>> Reproduced with stm32_defconfig with XIP_KERNEL flag disabled.
> >>>
> >>> To restore correct _magic_sig offset at 0x24, we add 8 additional
> >>> "mov r0, r0" instruction.
> >>>
> >>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> >>> ---
> >>>   arch/arm/boot/compressed/head.S | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm/boot/compressed/head.S
> >>> b/arch/arm/boot/compressed/head.S index 9150f97..5d9cda3 100644
> >>> --- a/arch/arm/boot/compressed/head.S
> >>> +++ b/arch/arm/boot/compressed/head.S
> >>> @@ -127,7 +127,8 @@
> >>>    AR_CLASS(   .arm    )
> >>>   start:
> >>>                .type   start,#function
> >>> -             .rept   7
> >>> +   ARM(              .rept   7)
> >>> + THUMB(              .rept   15)
> >>>
> >
> > Could you try using W(mov) instead of mov in the definition of __nop ?
> 
> If i use W(mov) instead of mov in __nop macro, i need to add one additional "mov r0,r0" in THUMB case as following :
> 
> 
>   start:
>   		.type	start,#function
>   		.rept	7
>   		__nop
>   		.endr
>      ARM(		mov	r0, r0		)
>      ARM(		b	1f		)
> + THUMB(		mov	r0, r0		)

No need of extra THUMB instruction, compiling previous mov r0,r0 should be good for both arm & thumb :

   		__nop
   		.endr
      			mov	r0, r0		/* 32 bit for arm & 16 bit for thumb */
      ARM(		b	1f		)
     THUMB(		badr	r12, 1f		)

Cheers,
Vikas

>    THUMB(		badr	r12, 1f		)
>    THUMB(		bx	r12		)
> 
>   		.word	_magic_sig	@ Magic numbers to help the loader
>   		.word	_magic_start	@ absolute load/run zImage address
>   		.word	_magic_end	@ zImage end address
>   		.word	0x04030201	@ endianness flag
> 
> 
> Which implementation do you prefer ?
> 
> Thanks
> 
> Patrice
