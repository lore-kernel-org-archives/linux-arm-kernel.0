From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Feb 2011 17:09:59 +0000
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <AANLkTin6qEeN7XZuwePNWqS8i_aDY586V+sOqgD5pPQA@mail.gmail.com>
References: <201102021700.20683.arnd@arndb.de>
	<AANLkTin6qEeN7XZuwePNWqS8i_aDY586V+sOqgD5pPQA@mail.gmail.com>
Message-ID: <20110202170959.GA31043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 05:51:27PM +0100, Richard Guenther wrote:
> > I would suggest fixing this by:
> >
> > 1. auditing all uses of __attribute__((packed)) in the Linux USB code
> > and other drivers, removing the ones that are potentially harmful.
> >
> > 2. Changing the ARM MMIO functions to use inline assembly instead of
> > direct pointer dereference.
> >
> > 3. Documenting the gcc behavior as undefined.
> 
> The pointer conversions already invoke undefined behavior as specified by the
> C standard (6.3.2.3/7).

Just to be clear: you are not saying that the ARM implementation is
undefined.

What you're saying is that converting from a pointer with less strict
alignment requirements to a pointer with more strict alignment
requirements is undefined.

IOW:

unsigned long *blah(unsigned char *c)
{
	return (unsigned long *)c;
}

would be undefined, but:

unsigned char *blah(unsigned long *c)
{
	return (unsigned char *)c;
}

would not be.

If you're saying something else, please explain with reference to the
point in the C standard you quote above.
