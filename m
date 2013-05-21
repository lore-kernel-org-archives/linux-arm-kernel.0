From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 21 May 2013 13:18:18 +0200
Subject: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
In-Reply-To: <20130519164009.GA2434@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
 <1368966844.6828.111.camel@gandalf.local.home>
 <20130519133418.GA24381@redhat.com>
 <1368979579.6828.114.camel@gandalf.local.home>
 <20130519164009.GA2434@redhat.com>
Message-ID: <20130521111818.GI26912@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 19, 2013 at 07:40:09PM +0300, Michael S. Tsirkin wrote:
> OK I get it. So let me correct myself. The simple code
> that does something like this under a spinlock:
> >       preempt_disable
> >       pagefault_disable
> >       error = copy_to_user
> >       pagefault_enable
> >       preempt_enable
> >
> is not doing anything wrong and should not get a warning,
> as long as error is handled correctly later.
> Right?

Indeed, but I don't get the point of the preempt_{disable,enable}()
here. Why does it have to disable preemption explicitly here? I thought
all you wanted was to avoid the pagefault handler and make it do the
exception table thing; for that pagefault_disable() is sufficient.
