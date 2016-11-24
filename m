From: Andrei.Pistirica@microchip.com (Andrei.Pistirica at microchip.com)
Date: Thu, 24 Nov 2016 09:36:10 +0000
Subject: [RFC PATCH v2 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <20161123210318.GB2845@localhost.localdomain>
References: <1479478912-14067-1-git-send-email-andrei.pistirica@microchip.com>
 <20161120191823.GA6950@localhost.localdomain>
 <e592169a-6287-7f3c-b4fd-23c4c79198b0@microchip.com>
 <20161123210318.GB2845@localhost.localdomain>
Message-ID: <07C910AB6AC6C345A093D5A08F5AF568CB7324AA@CHN-SV-EXMX03.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: Wednesday, November 23, 2016 11:03 PM
> To: Andrei Pistirica - M16132
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; davem at davemloft.net;
> nicolas.ferre at atmel.com; harinikatakamlinux at gmail.com;
> harini.katakam at xilinx.com; punnaia at xilinx.com; michals at xilinx.com;
> anirudh at xilinx.com; boris.brezillon at free-electrons.com;
> alexandre.belloni at free-electrons.com; tbultel at pixelsurmer.com
> Subject: Re: [RFC PATCH v2 1/2] macb: Add 1588 support in Cadence GEM.
> 
> On Wed, Nov 23, 2016 at 02:34:03PM +0100, Andrei Pistirica wrote:
> > From what I understand, your suggestion is:
> > (ns | frac) * ppb = (total_ns | total_frac) (total_ns | total_frac) /
> > 10^9 = (adj_ns | adj_frac) This is correct iff total_ns/10^9 >= 1, but
> > the problem is that there are missed fractions due to the following
> > approximation:
> > frac*ppb =~
> > (ns*ppb+frac*ppb*2^16)*2^16-10^9*2^16*flor(ns*ppb+frac*ppb*2^16,
> > 10^9).
> 
> -ENOPARSE;
> 
> > An example which uses values from a real test:
> > let ppb=4891, ns=12 and frac=3158
> 
> That is a very strange example for nominal frequency.  The clock period is
> 12.048187255859375 nanoseconds, and so the frequency is
> 83000037.99 Hz.
> 
> But hey, let's go with it...
> 
> > - using suggested algorithm, yields: adj_ns = 0 and adj_frac = 0
> > - using in-place algorithm, yields: adj_ns = 0, adj_frac = 4 You can
> > check the calculus.
> 
> The test program, below, shows you what I meant.  (Of course, you should
> adjust this to fit the adjfine() method.)
> 
> Unfortunately, this device has a very coarse frequency resolution.
> Using a nominal period of ns=12 as an example, the resolution is
> 2^-16 / 12 or 1.27 ppm.  The 24 bit device is much better in this repect.
> 
> The output using your example numbers is:
> 
>    $ ./a.out 12 3158 4891
>    ns=12 frac=3158
>    ns=12 frac=3162
> 
>    $ ./a.out 12 3158 -4891
>    ns=12 frac=3158
>    ns=12 frac=3154
> 
> See how you get a result of +/- 4 with just one division?
> 
> Thanks,
> Richard
> 
> ---
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> 
> static void adjfreq(uint32_t ns, uint32_t frac, int32_t ppb) {
> 	uint64_t adj;
> 	uint32_t diff, word;
> 	int neg_adj = 0;
> 
> 	printf("ns=%u frac=%u\n", ns, frac);
> 
> 	if (ppb < 0) {
> 		neg_adj = 1;
> 		ppb = -ppb;
> 	}
> 	word = (ns << 16) + frac;
> 	adj = word;
> 	adj *= ppb;
> 	adj += 500000000UL;
> 	diff = adj / 1000000000UL;
> 
> 	word = neg_adj ? word - diff : word + diff;
> 	printf("ns=%u frac=%u\n", word >> 16, word & 0xffff); }
> 
> int main(int argc, char *argv[])
> {
> 	uint32_t ns, frac;
> 	int32_t ppb;
> 
> 	if (argc != 4) {
> 		puts("need ns, frac, and ppb");
> 		return -1;
> 	}
> 	ns = atoi(argv[1]);
> 	frac = atoi(argv[2]);
> 	ppb = atoi(argv[3]);
> 	adjfreq(ns, frac, ppb);
> 	return 0;
> }

Ok, thanks.
I will use this one then.

Regards,
Andrei
