From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 24 Feb 2015 09:56:14 +0000
Subject: [PATCH 1/7] Add die_spin_lock_{irqsave,irqrestore}
In-Reply-To: <20150224064107.GB15387@gmail.com>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
 <1424748634-9153-2-git-send-email-anton@samba.org>
 <20150224064107.GB15387@gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CAE9BD3@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ingo Molnar
...
> So why not trylock and time out here after a few seconds,
> instead of indefinitely supressing some potentially vital
> output due to some other CPU crashing/locking with the lock
> held?

I've used that for status requests that usually lock a table
to get a consistent view.
If trylock times out assume that the data is actually stable
and access it anyway. Remember the pid doing the access and
next time it tries to acquire the same lock do a trylock with
no timeout.
That way if (when) there is a locking fubar (or a driver oops
with a lock held) at least some of the relevant status commands
will work.

	David
