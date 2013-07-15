From: gorcunov@gmail.com (Cyrill Gorcunov)
Date: Mon, 15 Jul 2013 22:57:39 +0400
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
In-Reply-To: <20130715180846.GV24642@n2100.arm.linux.org.uk>
References: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
 <20130715173238.GJ1730@moon>
 <20130715180846.GV24642@n2100.arm.linux.org.uk>
Message-ID: <20130715185739.GK1730@moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 07:08:46PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 15, 2013 at 09:32:38PM +0400, Cyrill Gorcunov wrote:
> > On Tue, Feb 19, 2013 at 10:11:09AM +0400, Alexander Kartashov wrote:
> > > Currently IPC SHM works in a strange way on ARM:
> > > the syscall sys_shmat() requires the argument shmaddr
> > > be SHMLBA-aligned (ARM has the macro __ARCH_FORCE_SHMLBA
> > > unconditionally defined) but allocates memory that
> > > isn't SHMLBA-aligned because the value of memory alignment
> > > depends on presense of certain cache aliases.
> > 
> > Hi guys, is there some conclusion on this patch? It has been sent
> > almost 5 months back ;)
> 
> It's pointless.  The alignment is only required for CPUs which have
> aliasing caches.  What the code does in mmap() is correct.  However,
> we can't dynamically select this in the SHM code.

Hi Russell, thanks a lot for reply! I must admit I'm not that familiar
with arm hw internals, but if the behaviour is correct than we've a
problem with checkpoint/restore procedure on arm platform :( As far
as I know Alexander pointed me that he find no other way of fixing
the problem except patching the kernel. Alexander, mind to remind
where exactly we're failing in c/r procedure, thus maybe arm guys
would help us to find a way to pass it by with some user-space
trick?
