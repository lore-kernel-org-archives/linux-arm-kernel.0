From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 12 Feb 2013 09:19:52 -0000
Subject: [PATCH 2/2] net: calexdaxgmac: fixup endian issues after __raw IO
 function change
In-Reply-To: <5119382F.8000809@codethink.co.uk>
References: <1360510721-17860-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360510721-17860-3-git-send-email-ben.dooks@codethink.co.uk>
 <1360606656.2701.18.camel@bwh-desktop.uk.solarflarecom.com>
 <5119382F.8000809@codethink.co.uk>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7145@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > You are using le32_to_cpu() and cpu_to_le32() the wrong way round, and
> > then putting casts on the wrong side, i.e. it should be:
> >
> > 	value = le32_to_cpu((__force __le32)__raw_readl(addr));
> > 	__raw_writel((__force u32)cpu_to_le32(value), addr);
> >
> > (I do wonder why __raw I/O functions aren't declared to take/return __le
> > types... it would avoid the need to cast altogether.)
> 
> Because they do things with the order the cpu is working in, the
> read{x} and write{x} transfer cpu to bus-endian so returning an __le
> type would not be correct.

Surely you want to arrange to use the byte-swapping memory
read/write instructions, rather than byteswapping the value.

Particularly on ppc which doesn't have a byteswap instruction
but can do byteswapping memory accesses.

	David
