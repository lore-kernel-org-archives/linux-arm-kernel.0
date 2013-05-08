From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Wed, 8 May 2013 14:14:40 +0200
Subject: [RFC] Bug in ARM v6+ implementation of cmpxchg64() ?
Message-ID: <CAGzjT4cikbZ4rRJxzMM4P0MZYpWumYC15qVW3OaPd7GESS5mwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The ARM implementation of cmpxchg64() for ARM arch v6 and v7 casts
parameter 2 and 3 (the old and new 64 values) to an unsigned long
before calling the atomic_cmpxchg64() function:

#define cmpxchg64(ptr, o, n) \
((__typeof__(*(ptr)))atomic64_cmpxchg(container_of((ptr), \
atomic64_t, \
counter), \
     (unsigned long)(o), \
     (unsigned long)(n)))


To me it seems that now the top 32 bits of the old and new value are
stripped before calling atomic64_cmpxchg(), causing incorrect value to
be "compare-exchanged". Is this correct?

Browsing in the git history, I found commit

3e0f5a15f5003f4576c35498814f0f1567860449

which changed
-#define cmpxchg64(ptr,o,n)                                             \
-       ((__typeof__(*(ptr)))__cmpxchg64_mb((ptr),                      \
-                                           (unsigned long long)(o),    \
-                                           (unsigned long long)(n)))


into

+#define cmpxchg64(ptr, o, n)                                           \
+       ((__typeof__(*(ptr)))atomic64_cmpxchg(container_of((ptr),       \
+                                               atomic64_t,             \
+                                               counter),               \
+                                             (unsigned long)(o),       \
+                                             (unsigned long)(n)))



Regards,
  Jaccon
