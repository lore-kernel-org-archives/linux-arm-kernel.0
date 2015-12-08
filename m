From: james.morse@arm.com (James Morse)
Date: Tue, 08 Dec 2015 16:00:17 +0000
Subject: [PATCH] kexec: Add --lite option
In-Reply-To: <20151207140755.GG16406@dhcppc13.redhat.com>
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <20151022125012.GB20847@redhat.com>
 <1445540891.30908.144.camel@infradead.org>
 <1446703011.12676.83.camel@freescale.com>
 <20151207114547.GE16406@dhcppc13.redhat.com>
 <20151207114839.GF16406@dhcppc13.redhat.com> <56658696.6070103@arm.com>
 <20151207140755.GG16406@dhcppc13.redhat.com>
Message-ID: <5666FE91.5010302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 07/12/15 14:07, Pratyush Anand wrote:
> On 07/12/2015:01:16:06 PM, James Morse wrote:
>> I haven't benchmarked this, but:
>>
>> util_lib/sha256.c contains calls out to memcpy().
>> In your case 1, this will use the glibc version. In case 2, it will use
>> the version implemented in purgatory/string.c, which is a byte-by-byte copy.
>>
> 
> Yes, I agree that byte copy is too slow. But, memcpy() in sha256_update() will
> copy only few bytes (I think max 126 bytes). Most of the data will be processed
> using loop while( length >= 64 ){}, where we do not have any memcpy.So, I do not
> think that this would be causing such a difference.

You're right, I benchmarked the two sha256.o files checksumming a 10MB
buffer - one takes 0.6s, the other 1.7s, we can probably expect a couple
of seconds to do this.

Is the sha256 really useful? Purgatory can't print out an error message,
if it fails...


> Could it be the case that I am not using perfect memory attributes while setting
> up identity mapping and enabling D-cache. My implementation is here:
> https://github.com/pratyushanand/kexec-tools/commit/8efdbc56b52f99a8a074edd0ddc519d7b68be82f

I'm no expert, but that looks like you're setting it up as 'normal'
memory. You're missing some isb-s and tlbi-s: depending on how long the
changes to system state take, you may be using old memory-attributes or
page-tables. If you depend on a change to system state, (like turning
the mmu on), you need explicit synchronisation, see section 12.3.2 of
the 'Architecture Programmers Guide' (arm den0024a), and D7.1.2 of the
ARM ARM.

I haven't managed to get your kexec-tools branch to work with v10 of
Geoff's series. It looks like you save registers to the stack, which
give stale values once you turn the mmu off. You also do the opposite,
saving registers with the mmu off, then cleaning cache lines over the
top, corrupting the saved registers.

The page size of 64K is hard coded. Kexec-ing from a 4K kernel, to a 4K
kernel will work, but only if the hardware also supports 64K, this will
be surprising to debug.



Thanks,


James
