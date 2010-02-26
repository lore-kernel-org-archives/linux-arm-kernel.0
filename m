From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 27 Feb 2010 08:51:22 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <Pine.LNX.4.44L0.1002261150370.2029-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1002261150370.2029-100000@iolanthe.rowland.org>
Message-ID: <1267221082.23523.1822.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-02-26 at 11:52 -0500, Alan Stern wrote:
> > For mmap'ed pages (and present in the page cache), is it guaranteed that
> > the HCD driver won't write to it once it has been mapped into user
> > space? If that's the case, it may solve the problem by just reversing
> > the meaning of PG_arch_1 on ARM and assume that a newly allocated page
> > has dirty D-cache by default.
> 
> Nothing is guaranteed.  The HCD will write to wherever it is asked.  If 
> a driver does input to an mmap'ed page, the HCD won't even know that 
> the page is mmap'ed.

Right but that won't happen unless somebody explicitely caused that
input to happen, typically, a userspace read(). I$/D$ coherency isn't
implicit in that case.

The question is more when the kernel itself moves a page in/out from
underneath the application (mmap'ed executable pages). One it's mapped
in, it won't be written to by the HCD unless something explicitely does
something to cause that write. If it's swapped out and back in, it will
have been unmapped. 

Cheers,
Ben.
