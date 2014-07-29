From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 15:05:06 +0200
Subject: [PATCH v15 01/12] irq: gic: support hip04 gic
In-Reply-To: <87a97to025.fsf@approximate.cambridge.arm.com>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-2-git-send-email-haojian.zhuang@linaro.org>
 <87a97to025.fsf@approximate.cambridge.arm.com>
Message-ID: <2455679.mpY3ZEfao6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 18:38:58 Marc Zyngier wrote:
> Overall, this code should be able to sitting within a #ifdef/#endif
> block, only selected if this platform is enabled, and possibly find a
> way not to impact all the other platforms when this is not selected.
> 
> Finally, I'd like to outline how much I dislike the way the GIC
> architecture has been abused here. Yes, this solves a particular
> problem, at a given point in time, but this also feels extremely short
> sighted from whoever has put this thing together. This really feels like
> a short-term HW hack that is already addressed by GICv3. Merging support
> for non architecture compliant HW is never the best solution.

Not merging support for shipping hardware is also not a solution,
and we already support any number of irqchip drivers and have all
the logic we need to sort that out at runtime.

My feeling is that the original approach taken in the early version
of the patch set was actually better, given all the problems with
integrating this nicely into the gic driver.

Would you be happier with that? The downside of that would be
that some driver bugs would get fixed in one driver but not the
other one, which is why we normally try to avoid it. On the other
hand, it means that the normal GIC driver does not get polluted
with hacks that are only needed for the hip04 version and there
is an obvious way to disable the driver at compile time when you
build for other platforms.

	Arnd
