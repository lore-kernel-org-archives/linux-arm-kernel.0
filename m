From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 12 Dec 2013 14:47:54 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386859242.22947.88.camel@sakura.staff.proxad.net> (Maxime
 Bizon's message of "Thu, 12 Dec 2013 15:40:42 +0100")
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
 <20131212141926.GA31816@1wt.eu> <yw1xhaaejfso.fsf@unicorn.mansr.com>
 <1386859242.22947.88.camel@sakura.staff.proxad.net>
Message-ID: <yw1x8uvqjfc5.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Bizon <mbizon@freebox.fr> writes:

> On Thu, 2013-12-12 at 14:37 +0000, M?ns Rullg?rd wrote:
>
>> There is no such thing as a 16-bit register on ARM.  What this code does
>> is ask the compiler to take the 16-bit value 'len' and put it in a register
>> for use in the asm code.  All registers are 32-bit, so there is no ambiguity.
>
> which strictly speaking the compiler did ;)
>
> it took the 16 bits value and put it inside the lower 16 bits of the 32
> bits register, it just didn't touch the higher ones

That's not where things went wrong.  The entire computation is done in
registers, and the swab16 macro casts the result to uint16_t.  This cast
should clear the high half of the register (that's the lsl/lsr pair you
saw), but for some reason this isn't happening.

Now please file a gcc bug report.  That's the proper place to be
discussing this.

-- 
M?ns Rullg?rd
mans at mansr.com
