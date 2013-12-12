From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 12 Dec 2013 13:14:04 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
Message-ID: <1386850444.22947.46.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,

I tried using csum_tcpudp_magic() like this:

csum_tcpudp_magic(src, dst, ntohs(udph->len), IPPROTO_UDP, csum);

instead of the more common:

len = ntohs(udhp->len);
[...]
csum_tcpudp_magic(src, dst, len, IPPROTO_UDP, csum);

the first one gives a bad checksum while the second one is ok.


I've tracked down the problem to csum_tcpudp_nofold(), which uses inline
asm and an unsigned short for len.

If the len value is say 0x3412, and I pass ntohs(len), then the assigned
register for len contains 0x00341234 instead of the expected 0x1234.

The ntohs() expand to a dumb swab16 on my arch, and gcc does the swap
but does not clear the high nibble, I guess it expects the assembly code
to only use the low 16 bits.

Is there a missing constraint or gcc is doing something wrong here ?

-- 
Maxime
