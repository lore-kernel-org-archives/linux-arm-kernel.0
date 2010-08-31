From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 31 Aug 2010 14:37:47 +0200
Subject: [PATCH 2/7] wire up sys_time_change_notify() on ARM
In-Reply-To: <1283255151-6364-2-git-send-email-virtuoso@slind.org>
References: <1283255151-6364-1-git-send-email-virtuoso@slind.org>
	<1283255151-6364-2-git-send-email-virtuoso@slind.org>
Message-ID: <19580.63387.632626.657277@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Shishkin writes:
 > sys_time_change_notify() is a new syscall with number and types of
 > parameters such that no ARM-specific processing is needed.
 > 
 > Tested with 2.6.36-rc3 using Documentation/time-change-notify-example.c.
 > 
 > Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
 > CC: Russell King <linux@arm.linux.org.uk>
 > CC: Andrew Morton <akpm@linux-foundation.org>
 > CC: David Howells <dhowells@redhat.com>
 > CC: Christoph Hellwig <hch@lst.de>
 > CC: "H. Peter Anvin" <hpa@zytor.com>
 > CC: linux-arm-kernel at lists.infradead.org
 > CC: linux-kernel at vger.kernel.org
 > ---
 >  arch/arm/include/asm/unistd.h |    1 +
 >  arch/arm/kernel/calls.S       |    1 +
 >  2 files changed, 2 insertions(+), 0 deletions(-)
 > 
 > diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
 > index d02cfb6..ce38a6f 100644
 > --- a/arch/arm/include/asm/unistd.h
 > +++ b/arch/arm/include/asm/unistd.h
 > @@ -393,6 +393,7 @@
 >  #define __NR_perf_event_open		(__NR_SYSCALL_BASE+364)
 >  #define __NR_recvmmsg			(__NR_SYSCALL_BASE+365)
 >  #define __NR_accept4			(__NR_SYSCALL_BASE+366)
 > +#define __NR_time_change_notify		(__NR_SYSCALL_BASE+367)
 >  
 >  /*
 >   * The following SWIs are ARM private.
 > diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
 > index afeb71f..f1e64ba 100644
 > --- a/arch/arm/kernel/calls.S
 > +++ b/arch/arm/kernel/calls.S
 > @@ -376,6 +376,7 @@
 >  		CALL(sys_perf_event_open)
 >  /* 365 */	CALL(sys_recvmmsg)
 >  		CALL(sys_accept4)
 > +		CALL(sys_time_change_notify)
 >  #ifndef syscalls_counted
 >  .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 >  #define syscalls_counted

No, you need to use 370 as the syscall number on ARM as 367-369
have been assigned to the fanotify and prlimit64 syscalls; see

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6343/1

/Mikael
