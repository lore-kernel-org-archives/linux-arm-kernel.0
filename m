From: rostedt@goodmis.org (Steven Rostedt)
Date: Sun, 19 May 2013 12:06:19 -0400
Subject: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
In-Reply-To: <20130519133418.GA24381@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
 <1368966844.6828.111.camel@gandalf.local.home>
 <20130519133418.GA24381@redhat.com>
Message-ID: <1368979579.6828.114.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-05-19 at 16:34 +0300, Michael S. Tsirkin wrote:

> Right but we need to keep it working on upstream as well.
> If I do preempt_enable under a spinlock upstream won't it
> try to sleep under spinlock?

No it wont. A spinlock calls preempt_disable implicitly, and a
preempt_enable() will not schedule unless preempt_count is zero, which
it wont be under a spinlock.

If it did, there would be lots of bugs all over the place because this
is done throughout the kernel (a preempt_enable() under a spinlock).

In other words, don't ever use preempt_enable_no_resched().

-- Steve
