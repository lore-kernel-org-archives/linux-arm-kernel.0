From: w@1wt.eu (Willy Tarreau)
Date: Thu, 12 Dec 2013 18:35:37 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212172049.GU4360@n2100.arm.linux.org.uk>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk>
 <20131212160426.GD31816@1wt.eu>
 <20131212164748.GS4360@n2100.arm.linux.org.uk> <20131212171108.GA2337@1wt.eu>
 <20131212172049.GU4360@n2100.arm.linux.org.uk>
Message-ID: <20131212173537.GB2337@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 05:20:49PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 12, 2013 at 06:11:08PM +0100, Willy Tarreau wrote:
> > Another thing that can be done to improve the folding of the 16-bit
> > checksum is to swap the values to be added, sum them and only keep
> > the high half integer which already contains the carry. At least on
> > x86 I save some cycles doing this :
> > 
> >               31:24  23:16  15:8  7:0
> >      sum32 =    D      C      B    A
> > 
> >      To fold this into 16-bit at a time, I just do this :
> > 
> >                    31:24     23:16          15:8  7:0
> >      sum32           D         C              B    A
> >   +  sum32swapped    B         A              D    C
> >   =                 A+B  C+A+carry(B+D/C+A)  B+D  C+A
> > 
> > so just take the upper result and you get the final 16-bit word at
> > once.
> > 
> > In C it does :
> > 
> >        fold16 = (((sum32 >> 16) | (sum32 << 16)) + sum32) >> 16
> > 
> > When the CPU has a rotate instruction, it's fast :-)
> 
> Indeed - and if your CPU can do the rotate and add at the same time,
> it's just a singe instruction, and it ends up looking remarkably
> similar to this:
> 
> static inline __sum16 csum_fold(__wsum sum)
> {
>         __asm__(
>         "add    %0, %1, %1, ror #16     @ csum_fold"
>         : "=r" (sum)
>         : "r" (sum)
>         : "cc");
>         return (__force __sum16)(~(__force u32)sum >> 16);
> }

Marvelous :-)

Willy
