From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jun 2010 20:44:57 +0100
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
In-Reply-To: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
References: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
Message-ID: <20100607194457.GC7220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 07, 2010 at 09:36:30PM +0400, Anton Vorontsov wrote:
> To support PI or robust mutexes, the kernel needs to perform some
> operations atomically on userspace addresses, and yet ARM lacked
> the support for the SMP case.
> 
> ARMv6 adds exclusive access variants of ldr and str instructions,
> which means that support for PI/robust mutexes should now be
> relatively straightforward.

It isn't this straight forward.  You're now bypassing the MMU protections
in that 'strex' can bypass the read-only protection of the user page.
This can result in the zero BSS page being corrupted, or worse corruption
to page cache pages.
