From: mst@redhat.com (Michael S. Tsirkin)
Date: Wed, 22 May 2013 14:07:29 +0300
Subject: [PATCH v2 00/10] uaccess: better might_sleep/might_fault behavior
In-Reply-To: <20130522101916.GM18810@twins.programming.kicks-ass.net>
References: <cover.1368702323.git.mst@redhat.com>
 <201305221125.36284.arnd@arndb.de>
 <20130522101916.GM18810@twins.programming.kicks-ass.net>
Message-ID: <20130522110729.GB5643@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 12:19:16PM +0200, Peter Zijlstra wrote:
> On Wed, May 22, 2013 at 11:25:36AM +0200, Arnd Bergmann wrote:
> > Calling might_fault() for every __get_user/__put_user is rather expensive
> > because it turns what should be a single instruction (plus fixup) into an
> > external function call.
> 
> We could hide it all behind CONFIG_DEBUG_ATOMIC_SLEEP just like
> might_sleep() is. I'm not sure there's a point to might_fault() when
> might_sleep() is a NOP.

The patch that you posted gets pretty close.
E.g. I'm testing this now:
+#define might_fault() do { \
+       if (_might_fault()) \
+               __might_sleep(__FILE__, __LINE__, 0); \
+       might_resched(); \
+} while(0)

So if might_sleep is a NOP, __might_sleep and might_resched are NOPs
so compiler will optimize this all out.

However, in a related thread, you pointed out that might_sleep is not a NOP if
CONFIG_PREEMPT_VOLUNTARY is set, even without CONFIG_DEBUG_ATOMIC_SLEEP.

Do you think we should drop the preemption point in might_fault?
Only copy_XX_user?
Only __copy_XXX_user ?

-- 
MST
