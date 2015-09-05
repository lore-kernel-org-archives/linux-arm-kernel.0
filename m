From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 06 Sep 2015 00:12:59 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <20150905203818.GO21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Sat, 5 Sep 2015 21:38:18 +0100")
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
 <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
 <20150905142519.GN21084@n2100.arm.linux.org.uk>
 <87y4gkx04m.fsf@belgarion.home>
 <20150905203818.GO21084@n2100.arm.linux.org.uk>
Message-ID: <87pp1wwm50.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> Moreover, this is consistent with the fact that this commit is in linux-next but
>> not in v4.1 :
>>     a5e090acbf54 ("ARM: software-based priviledged-no-access support")
>> 
>> So the issue is around this SW_DOMAIN_PAN, at least on PXA.
>
> Is it only PXA which seems to be affected?
Sorry I don't know, I only own pxa platforms.

> If so, you may need to add:
>
> 	mrc p15, 0, \rd, c2, c0, 0
> 	mov \rd, \rd
> 	sub pc, pc, #4
>
> to the places we update the domain access register to ensure that the
> Xscale pipeline stalls to allow the CP15 DACR update to hit.
Okay, I'll try that.

By the way, the ARMv5 manual states in chapter "B4.5.1 MMU Fault" that for a
DACR update, a "PrefetchFlush" operation has to be done (chapter B2.6.3
PrefetchFlush CP15 register 7), quoting :
    Changes to the Domain Access Control register are synchronized by performing
    a PrefetchFlush operation (or as result of an exception or exception
    return). See Changes to CP15 registers and the memory order model on page
    B2-24 for details.

Cheers.

-- 
Robert
