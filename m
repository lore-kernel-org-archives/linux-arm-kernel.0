From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 07 Sep 2010 15:14:08 -0400 (EDT)
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to, from}_user?
In-Reply-To: <20100907161156.GA3625@debian-wegner1.datadisplay.de>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
	<20100906140347.GA24522@n2100.arm.linux.org.uk>
	<20100906141444.GD6897@debian-wegner1.datadisplay.de>
	<AANLkTimqiAuv9XiU55VBxfPO6HZXCs5d9pshS3XDwsFc@mail.gmail.com>
	<AANLkTi=Mgzw9m+KiyzG7sHqD=mv1Q6WZXqMn_s_+p6Oq@mail.gmail.com>
	<20100907161156.GA3625@debian-wegner1.datadisplay.de>
Message-ID: <alpine.LFD.2.00.1009071443360.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Sep 2010, Wolfgang Wegner wrote:

> However, I am not getting the writes to use the stm instruction,
> so maybe this is the real limitation.
> Here is my very basic test program:
> 
> #define MEMSIZE 0x800000
> 
> int main() {
>   int fbfd;
>   unsigned long *fbp, *sfbp;
>   unsigned long i;
>   unsigned long fill_val = 0x12345678;
> 
>   fbfd = open("/dev/fb0", O_RDWR);
>   if (!fbfd) {
>     printf("Error: cannot open framebuffer device.\n");
>     exit(1);
>   }
>   fbp = (unsigned long *)mmap(0, MEMSIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
>                               fbfd, 0);
>   sfbp = fbp;
>   if(!fbp) {
>     printf("Error: cannot mmap framebuffer\n");
>     exit(1);
>   }
> #if 0
>   for (i = 0; i < (MEMSIZE / 4); i += 8) {
>     *(fbp + i) = fill_val;
>     *(fbp + i + 1) = fill_val;
>     *(fbp + i + 2) = fill_val;
>     *(fbp + i + 3) = fill_val;
>     *(fbp + i + 4) = fill_val;
>     *(fbp + i + 5) = fill_val;
>     *(fbp + i + 6) = fill_val;
>     *(fbp + i + 7) = fill_val;
>   }
> #else
>   for (i = MEMSIZE/32; i; i--) {
>     *(fbp++) = fill_val;
>     *(fbp++) = fill_val;
>     *(fbp++) = fill_val;
>     *(fbp++) = fill_val;
>     *(fbp++) = fill_val;
>     *(fbp++) = fill_val;
>     *(fbp++) = fill_val;
>     *(fbp++) = fill_val;
>   }
> #endif
>   munmap(sfbp, MEMSIZE);
>   close(fbfd);
>   return 0;
> }
> 
> Neither of the cases results in stm being used, all use
> str.
> (I am not so deep into assembler, let alone ARM assembler,
> so please bear with my ignorance about what stm is or does
> for now...)

The STM instruction means store-multiple i.e. it takes a set of 
registers and write them to memory in one go.  You could try using 
memset() which should be optimized to use STM in that case:

	memset(fbp, fill_val, MEMSIZE);

(although memset() works with chars, so only the LSBs of fill_val will 
be stored.)

Otherwise you could open code this test like this:


	register long __r0 asm("r0") = fill_val;
	register long __r1 asm("r1") = fill_val;
	register long __r2 asm("r2") = fill_val;
	register long __r3 asm("r3") = fill_val;
	register long __r4 asm("r4") = fill_val;
	register long __r5 asm("r5") = fill_val;
	register long __r6 asm("r6") = fill_val;
	register long __r7 asm("r7") = fill_val;
	for (i = 0; i < MEMSIZE/4; i += 8) {
		asm volatile(
			"stmia %0!, {r0 - r7}"
			: "+r" (fbp)
			: "r" (__r0), "r" (__r1), "r" (__r2), "r" (__r3),
			  "r" (__r4), "r" (__r5), "r" (__r6), "r" (__r7));
	}


Nicolas
