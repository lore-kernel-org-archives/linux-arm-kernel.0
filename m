From: mst@redhat.com (Michael S. Tsirkin)
Date: Fri, 24 May 2013 16:00:32 +0300
Subject: [PATCH v2 07/10] powerpc: uaccess s/might_sleep/might_fault/
In-Reply-To: <201305221559.01806.arnd@arndb.de>
References: <cover.1368702323.git.mst@redhat.com>
 <2aa6c3da21a28120126732b5e0b4ecd6cba8ca3b.1368702323.git.mst@redhat.com>
 <201305221559.01806.arnd@arndb.de>
Message-ID: <20130524130032.GA10167@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 03:59:01PM +0200, Arnd Bergmann wrote:
> On Thursday 16 May 2013, Michael S. Tsirkin wrote:
> > @@ -178,7 +178,7 @@ do {                                                                \
> >         long __pu_err;                                          \
> >         __typeof__(*(ptr)) __user *__pu_addr = (ptr);           \
> >         if (!is_kernel_addr((unsigned long)__pu_addr))          \
> > -               might_sleep();                                  \
> > +               might_fault();                                  \
> >         __chk_user_ptr(ptr);                                    \
> >         __put_user_size((x), __pu_addr, (size), __pu_err);      \
> >         __pu_err;                                               \
> > 
> 
> Another observation:
> 
> 	if (!is_kernel_addr((unsigned long)__pu_addr))
> 		might_sleep();
> 
> is almost the same as
> 
> 	might_fault();
> 
> except that it does not call might_lock_read().
> 
> The version above may have been put there intentionally and correctly, but
> if you want to replace it with might_fault(), you should remove the
> "if ()" condition.
> 
> 	Arnd

Well not exactly. The non-inline might_fault checks the
current segment, not the address.
I'm guessing this is trying to do the same just without
pulling in segment_eq, but I'd like a confirmation
from more PPC maintainers.

Guys would you ack

- 	if (!is_kernel_addr((unsigned long)__pu_addr))
- 		might_fault();
+ 	might_fault();

on top of this patch?

Also, any volunteer to test this (not just test-build)?

-- 
MST
