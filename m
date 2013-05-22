From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 May 2013 14:41:24 +0100
Subject: [PATCH v2 00/10] uaccess: better might_sleep/might_fault behavior
In-Reply-To: <201305221125.36284.arnd@arndb.de>
References: <cover.1368702323.git.mst@redhat.com>
 <201305221125.36284.arnd@arndb.de>
Message-ID: <20130522134124.GD18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 11:25:36AM +0200, Arnd Bergmann wrote:
> Given the most commonly used functions and a couple of architectures
> I'm familiar with, these are the ones that currently call might_fault()
> 
> 			x86-32	x86-64	arm	arm64	powerpc	s390	generic
> copy_to_user		-	x	-	-	-	x	x
> copy_from_user		-	x	-	-	-	x	x
> put_user		x	x	x	x	x	x	x
> get_user		x	x	x	x	x	x	x
> __copy_to_user		x	x	-	-	x	-	-
> __copy_from_user	x	x	-	-	x	-	-
> __put_user		-	-	x	-	x	-	-
> __get_user		-	-	x	-	x	-	-
> 
> WTF?

I think your table is rather screwed - especially on ARM.  Tell me -
how can __copy_to_user() use might_fault() but copy_to_user() not when
copy_to_user() is implemented using __copy_to_user() ?  Same for
copy_from_user() but the reverse argument - there's nothing special
in our copy_from_user() which would make it do might_fault() when
__copy_from_user() wouldn't.

The correct position for ARM is: our (__)?(pu|ge)t_user all use
might_fault(), but (__)?copy_(to|from)_user do not.  Neither does
(__)?clear_user.  We might want to fix those to use might_fault().
