From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Jul 2013 19:08:46 +0100
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
In-Reply-To: <20130715173238.GJ1730@moon>
References: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
 <20130715173238.GJ1730@moon>
Message-ID: <20130715180846.GV24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 09:32:38PM +0400, Cyrill Gorcunov wrote:
> On Tue, Feb 19, 2013 at 10:11:09AM +0400, Alexander Kartashov wrote:
> > Currently IPC SHM works in a strange way on ARM:
> > the syscall sys_shmat() requires the argument shmaddr
> > be SHMLBA-aligned (ARM has the macro __ARCH_FORCE_SHMLBA
> > unconditionally defined) but allocates memory that
> > isn't SHMLBA-aligned because the value of memory alignment
> > depends on presense of certain cache aliases.
> 
> Hi guys, is there some conclusion on this patch? It has been sent
> almost 5 months back ;)

It's pointless.  The alignment is only required for CPUs which have
aliasing caches.  What the code does in mmap() is correct.  However,
we can't dynamically select this in the SHM code.
