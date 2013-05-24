From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 May 2013 12:59:17 +0100
Subject: [PATCH v2 4/4] ARM: cacheflush: don't bother rounding to
 nearest vma
In-Reply-To: <1369395087-30972-5-git-send-email-will.deacon@arm.com>
References: <1369395087-30972-1-git-send-email-will.deacon@arm.com>
 <1369395087-30972-5-git-send-email-will.deacon@arm.com>
Message-ID: <20130524115917.GY18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 12:31:27PM +0100, Will Deacon wrote:
> do_cache_op finds the lowest VMA contained in the specified address
> range and rounds the range to cover only the mapped addresses.
> 
> Since commit 4542b6a0fa6b ("ARM: 7365/1: drop unused parameter from
> flush_cache_user_range") the VMA is not used for anything else in this
> code and seeing as the low-level cache flushing routines return -EFAULT
> if the address is not valid, there is no need for this range truncation.
> 
> This patch removes the VMA handling code from the cacheflushing syscall.

The only thing which access_ok() tells you is that the addresses are
_potentially_ valid user addresses.  That's not what the VMA check is
there for.

That check is there to make sure userspace doesn't do something idiotic,
and to keep the use of this API limited to specific actions such as self
modifying code, and not a general purpose cache flushing API covering
multiple VMAs.
