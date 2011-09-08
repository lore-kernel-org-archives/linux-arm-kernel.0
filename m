From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 8 Sep 2011 19:36:49 +0300
Subject: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
In-Reply-To: <201109081647.55377.arnd@arndb.de>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<4E6877A9.3090104@ti.com>
	<CAK=WgbbN-RYj2quMQOyYbEBBfV3gty4dOE7DgjvsRcoYO=F3kw@mail.gmail.com>
	<201109081647.55377.arnd@arndb.de>
Message-ID: <CAK=WgbZmFGqo2B_MO_FXDiQHUx1SoKvHEReTpVr9O6XZ2uo7Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 5:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I think a number would work here but is not optimal for the device tree
> representation. I think a better binding would be to encode it like
> interrupt numbers, where every device that uses a hwspinlock will describe
> that as a combination of phandle to the hwspinlock controller and
> identifier to be used by that controller

I'm not sure.

This implies that devices are hardwired to the specific
controller+identifier, which is true for interrupts, but not for
hwspinlocks. As a result the hardware depicted by such representation
would be imprecise and might unnecessarily limit the software.

hwspinlock devices are really just a pool of locks, which are not
inherently bound to any device: any master that can initiate
read/write bus access can use any of the locks (hardware-wise). One
just needs to make sure that ownership of the locks, even if
determined dynamically at runtime, is managed correctly.

I think the phandle+identifier approach is very elegant to achieve
static allocation of the hwspinlocks, and some boards will definitely
need it (e.g. those unlucky designs which arbiter i2c access using an
hwspinlock).

But wouldn't that limit us from providing dynamic allocation of
hwspinlocks ? I was told about teams working on complex multimedia use
cases which involves numerous object sharing and require actually more
hwspinlocks than exist (so they're planning on multiplexing several
logical locks on a single hwspinlock). They use dynamic allocation of
hwspinlocks in order to allow different hwspinlocks users to co-exist
(but naturally not run together at the same time).
