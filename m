From: dave@stgolabs.net (Davidlohr Bueso)
Date: Fri, 11 Dec 2015 06:17:47 -0800
Subject: FW: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <20151211120419.GD18828@arm.com>
References: <5669D5F2.5050004@caviumnetworks.com>
 <SN1PR07MB21577C72379C8440A208D6BC9EEA0@SN1PR07MB2157.namprd07.prod.outlook.com>
 <CA+=Sn1miWYhH5ddMmLGYWknzcw3d1k4S6QyK9O_ofdJKJDQxmg@mail.gmail.com>
 <CA+=Sn1n6e9pLDRVWT1EzDEn2XWwoK-Ep__-R6VVPzhbMvCEdNg@mail.gmail.com>
 <20151211084133.GE6356@twins.programming.kicks-ass.net>
 <20151211120419.GD18828@arm.com>
Message-ID: <20151211141747.GC5650@linux-uzut.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Dec 2015, Will Deacon wrote:

>I think Andrew meant the atomic_xchg_acquire at the start of osq_lock,
>as opposed to "compare and swap". In which case, it does look like
>there's a bug here because there is nothing to order the initialisation
>of the node fields with publishing of the node, whether that's
>indirectly as a result of setting the tail to the current CPU or
>directly as a result of the WRITE_ONCE.

Sorry I'm late to the party.

Duh yes this is obviously bogus, and worse I recall triggering a similar
tail initialization issue in osq_lock on some experimental work on x86,
so this is very much a point of failure. Ack.

>
>Andrew, David: does making that atomic_xchg_acquire and atomic_xchg
>fix things for you?
>
>I don't fully grok what 81a43adae3b9 has to do with any of this, so
>maybe there's another bug too.

I think this is mainly because mutex_optimistic_spin is where the stack
shows the lockup, which really translates to c55a6ffa62.

Thanks,
Davidlohr
