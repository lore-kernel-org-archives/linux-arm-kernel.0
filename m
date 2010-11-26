From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Nov 2010 22:53:39 +0000
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <AANLkTi=h3gPN63NKKJ4wjumKNx9qDtxCKvOSbtRkr1wx@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
	<1290526740-27624-2-git-send-email-ohad@wizery.com>
	<20101126045912.GC6598@lixom.net>
	<AANLkTin5Tfcuy0WcHJ22rWC8niwZCj8SZAMKLz0p9jwc@mail.gmail.com>
	<20101126091832.GE9310@n2100.arm.linux.org.uk>
	<AANLkTimS-cSi1B5LdtwhJWhKDuFKOYG1j_p-iQiH=zRe@mail.gmail.com>
	<20101126104548.GG9310@n2100.arm.linux.org.uk>
	<AANLkTi=h3gPN63NKKJ4wjumKNx9qDtxCKvOSbtRkr1wx@mail.gmail.com>
Message-ID: <20101126225339.GA26864@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 27, 2010 at 12:18:55AM +0200, Ohad Ben-Cohen wrote:
> But then there's the other (quite reasonable) claim that says we
> shouldn't crash the machine because of a non fatal bug: if a crappy
> driver messes up, the user (not the developer) will most probably
> prefer the machine to keep running with degraded functionality rather
> than boot.

There's also the quite reasonable expectation that we shouldn't corrupt
user data.  With locking interfaces, if someone abuses them and they
fail to work, then the risk is data corruption due to races.  The safe
thing in that case is to panic - terminate that thread before it does
anything unsafe, thereby preventing data corruption.

Yes, it may mean that something becomes unavailable, but that's better
than corrupting data.

Take a look at the kernel's own spinlock implementation.  Do we do lots
of checks in there for things like someone passing a NULL pointer to
the spinlock, or do we get an oops instead?

Also look at the list implementation.  Do we check for NULL pointers
there, or do we get an oops instead?

Same for mutex.  The same goes for lots of other infrastructure interfaces.
