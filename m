From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 8 Feb 2011 16:56:38 +0000
Subject: [PATCH] ARM: Correct WFE() in asm/spinlock.h for Thumb-2
In-Reply-To: <20110208164009.GD27521@n2100.arm.linux.org.uk>
References: <1297178414-20983-1-git-send-email-dave.martin@linaro.org>
	<20110208164009.GD27521@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=XfBjite-xtR8z_+5ATxSb4a9XDNAXdLBowWKY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 8, 2011 at 4:40 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 08, 2011 at 03:20:14PM +0000, Dave Martin wrote:
>> The content for ALT_SMP() in the definition of WFE() expands to 6
>> bytes (IT cc ; WFEcc.W), which breaks the assumptions of the fixup
>> code, leading to lockups when the affected code gets run.
>
> Why does it? ?My understanding is that the .w suffix forces the assembler
> to use the ARM encoding for the instruction.

The .w suffix forces a 32-bit encoding of Thumb-2 instructions for
which a 16-bit encoding is available.  Unfortunately, the 32-bit
Thumb-2 encodings are different from the ARM encodings (though there
are some odd similarities ... for example, all MCR and MRC encodings
are the same ... but with the halfwords swapped (!))

Like the 16-bit forms, most 32-bit Thumb-2 instructions don't contain
a condition field, so the assembler -mimplicit-it feature will need
insert an IT instruction if you write something conditional.  This
applies to everything except branches.

wfe: wfene.w becomes:

00000000 <wfe>:
   0:	bf18      	it	ne
   2:	f3af 8002 	wfene.w

Fortunately, wfe also has a 16-bit form, so we can squeeze the IT and
the WFE into the 4 bytes expected by ALT_SMP().  For safety, I write
it out explicitly: ALT_SMP("wfene", ...) would work sometimes but
might not work as expected if the previous instruction has an EQ or NE
condition, because then the assembler wouldn't need to insert an extra
IT when it generates its output...

> Thumb2 is just far too weird to understand. ?I think I'll just stick to
> writing good ARM code and let people sort out the Thumb2 weirdnesses.

Certainly life is much easier in ARM-land :)

I'm hoping that getting this working for OMAP will allow more people
to play with it though.

Cheers
---Dave
