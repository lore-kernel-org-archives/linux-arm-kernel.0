From: zdevai@gmail.com (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:47:18 +0200
Subject: [PATCH v2 1/5] ARM: SPMP8000: Add machine base files
In-Reply-To: <20111021225405.GK21648@n2100.arm.linux.org.uk>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1319040118-29773-1-git-send-email-zoss@devai.org>
	<1319040118-29773-2-git-send-email-zoss@devai.org>
	<1409922.Ostx0EbfK3@wuerfel>
	<20111021225405.GK21648@n2100.arm.linux.org.uk>
Message-ID: <CAGVye5OR=ngW5Dv4HEuxWOAxTU9-u1-8RBb+wg+DqKNfmCfF9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/22 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Oct 19, 2011 at 09:15:35PM +0200, Arnd Bergmann wrote:
>> > +#define SERIAL_BASE ? ? ? ?((volatile unsigned char *)SPMP8000_UARTC0_BASE)
>>
>> drop this, then
>>
>> > +static void putc(const char c)
>> > +{
>> > + ? volatile unsigned char *base = SERIAL_BASE;
>>
>> make this a "unsigned char __iomem *".
>>
>> > + ? int i;
>> > +
>> > + ? for (i = 0; i < 0x1000; i++) {
>> > + ? ? ? ? ? if (base[UART_LSR << 2] & UART_LSR_THRE)
>> > + ? ? ? ? ? ? ? ? ? break;
>> > + ? ? ? ? ? barrier();
>> > + ? }
>> > +
>> > + ? base[UART_TX << 2] = c;
>> > +}
>>
>> and use readb_relaxed/writeb_relaxed to do the access. You should
>> never just dereference volatile pointers to do an MMIO access.
>
> Note that uncompress.h isn't part of the kernel proper, and so the
> MMIO accessors may not work (depends whether the arch out-of-lines
> them.) ?Moreover, as the MMU is setup with 1:1 mappings, arguably
> it's not IOMEM anyway.
What's the preferred method then ?
The current uncompress.h files use all possible methods.
This is certainly also a question for the uncompress.h cleanup series.

Z
