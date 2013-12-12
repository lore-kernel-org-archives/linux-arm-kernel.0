From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Dec 2013 12:40:15 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386850444.22947.46.camel@sakura.staff.proxad.net>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
Message-ID: <20131212124015.GL4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 01:14:04PM +0100, Maxime Bizon wrote:
> 
> Hello,
> 
> I tried using csum_tcpudp_magic() like this:
> 
> csum_tcpudp_magic(src, dst, ntohs(udph->len), IPPROTO_UDP, csum);
> 
> instead of the more common:
> 
> len = ntohs(udhp->len);
> [...]
> csum_tcpudp_magic(src, dst, len, IPPROTO_UDP, csum);
> 
> the first one gives a bad checksum while the second one is ok.
> 
> 
> I've tracked down the problem to csum_tcpudp_nofold(), which uses inline
> asm and an unsigned short for len.
> 
> If the len value is say 0x3412, and I pass ntohs(len), then the assigned
> register for len contains 0x00341234 instead of the expected 0x1234.
> 
> The ntohs() expand to a dumb swab16 on my arch, and gcc does the swap
> but does not clear the high nibble, I guess it expects the assembly code
> to only use the low 16 bits.
> 
> Is there a missing constraint or gcc is doing something wrong here ?

Depends which swab16 you mean by "dumb swab16".  If it is a gcc bug then
you need to submit a bug report to gcc people.
