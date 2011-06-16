From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jun 2011 19:55:50 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <Pine.LNX.4.44L0.1106161308310.2204-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1106161308310.2204-100000@iolanthe.rowland.org>
Message-ID: <201106161955.50972.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 June 2011, Alan Stern wrote:
> 
> On Thu, 16 Jun 2011, Alexander Holler wrote:
> 
> > In commit 139540170d9d9b7ead3caaf540f161756b356d56 the attribute
> > packed is removed from the structs which are used to access the EHCI-registers.
> > 
> > This is done to circumvent a problem with gcc 4.6, which might access members of
> > packed structs on a byte by byte basis. But using packed, aligned(4) fixes that
> > too and is imho the better solution. Otherwise (without packed) the compiler would be free
> > to choose whatever alignment he thinks fits best, which might be e.g. 8-byte on 64-bit machines.
> 
> Is that really true?

No.

> I thought the compiler was not allowed to insert 
> padding if the natural alignment of the data types didn't require any.

It's architecture dependent. The alignment of the structure is the maximum alignment
of its members, so it gets to be 8 bytes if there is a 64 bit member in the struct
on most architectures, but 4 bytes on x86.

	Arnd
