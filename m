From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jun 2012 19:57:38 +0000
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <4FE0EFBB.6090206@firmworks.com>
References: <4FD84133.4060401@firmworks.com>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
Message-ID: <201206201957.39343.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 June 2012, Mitch Bradley wrote:

> Version A - 3 address cells:  In this version, the intermediate address 
> space has 3 cells:  port#, address type, offset.  Address type is
>    0 : root port
>    1 : config space
>    2 : extended config space
>    3 : I/O
>    4 : non-prefetchable memory
>    5 : prefetchable memory.
> 
> The third cell "offset" is necessary so that the size field has a number 
> space that can include it.

I agree with Stephen that this is a clever way to encode all the address spaces,
very nice!

> Version B - 2 address cells:  In this first version, the intermediate
> address space has 2 cells:  port#, offset.  The address type (I/O, mem,
> etc) is the high digit of in the offset:
>     Offset 0....... : Root port
>     Offset 1....... : config
>     Offset 2....... : extended config
>     Offset 3....... : I/O
>     Offset 4....... : non-prefetchable memory
>     Offset 5....... : prefetchable memory.

This is similar to how the PCI binding works internally, but I find that
a bit confusing as well, so given those two choices, I'd prefer the first
one.
   
> Version C - 2 address cells, 0 size cells (!) : In this version we hide the size component in 
> the intermediate space.  I don't know if that will actually work, but my guess is that it
> probably would.  The intermediate address space is like version A with the omission of the
> offset field.  The intermediate address just specifies the port number and the address type.

My guess is that it doesn't work with the current Linux code that transforms
the addresses. I've just recently seen the code complain about any platform
device whose parent has #size-cells=0.

	Arnd
