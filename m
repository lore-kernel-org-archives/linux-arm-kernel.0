From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 5 Oct 2018 16:59:59 +0000
Subject: [RFC PATCH] skb: Define NET_IP_ALIGN based on
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
In-Reply-To: <20181004173631.3nchegr6rm3jgz24@xylophone.i.decadent.org.uk>
References: <20181004173631.3nchegr6rm3jgz24@xylophone.i.decadent.org.uk>
Message-ID: <a291a6b17cc04eac8ccd9febe7152d9e@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Hutchings
> Sent: 04 October 2018 18:37
> 
> NET_IP_ALIGN is supposed to be defined as 0 if DMA writes to an
> unaligned buffer would be more expensive than CPU access to unaligned
> header fields, and otherwise defined as 2.
> 
> Currently only ppc64 and x86 configurations define it to be 0.
> However several other architectures (conditionally) define
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, which seems to imply that
> NET_IP_ALIGN should be 0.
> 
> Remove the overriding definitions for ppc64 and x86 and define
> NET_IP_ALIGN solely based on CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

Even if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set unaligned
accesses are likely to be slightly slower than aligned ones.
So having NET_IP_ALIGN set to 2 might make sense even on x86.
(ISTR DM saying why this isn't done.)

I've also met systems when misaligned DMA transfers (for ethernet receive)
were so bad that is was necessary to DMA to a 4n aligned buffer and
then do a misaligned copy to the real rx buffer (skb equiv) for the
network stack - which required the buffer be 4n+2 aligned.
(sparc sbus with the original DMA part.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
