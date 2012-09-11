From: matthew@mattleach.net (Matthew Leach)
Date: Tue, 11 Sep 2012 11:33:20 +0100
Subject: GCC 4.6.x miscompiling arm-linux?
In-Reply-To: <20120911102905.GC14994@pengutronix.de> (Michael Olbrich's
 message of "Tue, 11 Sep 2012 12:29:05 +0200")
References: <20120910171654.1d4972b2@archvile>
 <w51bohddcqw.fsf@mail.mattleach.net>
 <20120911092753.7b8315d4@archvile>
 <20120911084853.GT24458@pengutronix.de>
 <20120911113139.3b7b879f@archvile>
 <20120911102905.GC14994@pengutronix.de>
Message-ID: <w51mx0wdf2n.fsf@mail.mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Michael Olbrich <mol@pengutronix.de> writes:
>> Btw, Here's what I get from it:
>> 
>> flexcan_chip_start:
>>         @ args = 0, pretend = 0, frame = 0
>>         @ frame_needed = 0, uses_anonymous_args = 0
>>         @ link register save eliminated.
>>         mov     r3, #0
>>         cmp     r0, #9
>>         str     r3, [r1, #0]
>>         ldrle   r3, [r1, #4]
>>         mov     r0, #0
>>         str     r3, [r1, #4]
>>         bx      lr
>>         .size   flexcan_chip_start, .-flexcan_chip_start
>>         .ident  "GCC: (OSELAS.Toolchain-2011.11.1) 4.6.3"
>>         .section        .note.GNU-stack,"",%progbits
>
> How can I reproduce this output? I'd like to test this with different
> toolchain versions.

You can use this code fragment to produce the error:

/* Structure of the hardware registers */
struct flexcan_regs {
	unsigned int mcr;
	unsigned int rxfgmask;
};

#define flexcan_read(a) (*(volatile unsigned int *)(a))
#define flexcan_write(v,a)      (*(volatile unsigned int *)(a) = (v))

int flexcan_chip_start(int ver, struct flexcan_regs *regs)
{
	flexcan_write(0, &regs->mcr);

	if (ver >= 10)
		flexcan_write(0, &regs->rxfgmask);

	return 0;
}

Matt
