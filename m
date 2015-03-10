From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 10:11:17 +0000
Subject: [PATCH v2] ARM: advertise availability of v8 Crypto instructions
In-Reply-To: <CAKv+Gu8yDK_U_J-yeA4QRypNT=TKjxNtkyiKnJaogacDt5_jrw@mail.gmail.com>
References: <1425556302-3370-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150309180645.GD8656@n2100.arm.linux.org.uk>
 <CAKv+Gu8yDK_U_J-yeA4QRypNT=TKjxNtkyiKnJaogacDt5_jrw@mail.gmail.com>
Message-ID: <20150310101117.GH8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 07:12:46PM +0100, Ard Biesheuvel wrote:
> On 9 March 2015 at 19:06, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Mar 05, 2015 at 12:51:42PM +0100, Ard Biesheuvel wrote:
> >> @@ -393,6 +393,20 @@ static void __init cpuid_init_hwcaps(void)
> >>       vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
> >>       if (vmsa >= 5)
> >>               elf_hwcap |= HWCAP_LPAE;
> >> +
> >> +     /* check for supported v8 Crypto instructions */
> >> +     isar5 = read_cpuid_ext(CPUID_EXT_ISAR5);
> >> +
> >> +     switch ((isar5 >> 4) & 0xf) {
> >> +     case 2: elf_hwcap2 |= HWCAP2_PMULL;     /* pmull implies aes */
> >> +     case 1: elf_hwcap2 |= HWCAP2_AES;
> >> +     }
> >> +     if (((isar5 >> 8) & 0xf) == 1)
> >> +             elf_hwcap2 |= HWCAP2_SHA1;
> >> +     if (((isar5 >> 12) & 0xf) == 1)
> >> +             elf_hwcap2 |= HWCAP2_SHA2;
> >> +     if (((isar5 >> 16) & 0xf) == 1)
> >> +             elf_hwcap2 |= HWCAP2_CRC32;
> >
> > Reading through the ARMv7 ARM, the ISAR registers seem to work in a way
> > that "feature >= N" is sufficient to test for something (in other words,
> > the feature revision bits build on previous instructions added by older
> > revisions of that feature.)
> >
> 
> There was quite some discussion about that when we implemented this
> for arm64. Perhaps Steve wants to elaborate on the details, because I
> don't remember them exactly.
> 
> > Hence why PMULL implies AES - that follows the same pattern.  So, I wonder
> > if those == should all be >=, and there should be a "default:" before
> > "case 2:" with the zero case handled separately.
> >
> 
> Quoting from my version of the ARM ARM (DDI0487A_d):
> 
> AES, bits [7:4]
> Indicates whether AES instructions are implemented in AArch32.
> 0000 No AES instructions implemented.
> 0001 AESE, AESD, AESMC, and AESIMC implemented.
> 0010 As for 0001 , plus PMULL/PMULL2 instructions operating on 64-bit
> data quantities.
> All other values are reserved.
> 
> Even though they are obviously not bitfields, 'reserved' to me
> suggests that it is still incorrect to assume both PMULL and AES
> capability for values not listed yet > 0b0010.
> The same applies to the other blocks: all other values are reserved.

The use of "reserved" in this manner isn't actually detailed in the
glossary, which makes it a little hard to work out exactly what is
meant here (that's a documentation bug).

Is it "ARM Ltd reserves the right to add further values which augment
the previous values" or is it "ARM Ltd reserve the right to add
further values with completely different behaviours."

Really, the ARM ARM needs to be improved in this area.  It needs to
contain a clear statement about how the bitfields are intended to work.
The purpose of the CPUID stuff is to allow software to adapt to the
features of the CPU, but without a clearly defined behaviour for the
"unknown values", moving a piece of software to a newer CPU which
implements a superset of the features of a previous CPU will lead it
to fail (because the CPUID fields could now be in the reserved ranges)
if strict tests were applied for exact field values.

I'm not talking about moving a piece of binary software: I'm talking
there more about the maintanence burden of having to go through the
entire program checking for any references to CPUID fields, and checking
and updating every single one.

The current CPUID situation is which encourages exact precise tests is,
IMHO, not well thought out.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
