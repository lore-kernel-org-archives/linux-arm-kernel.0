From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Jun 2010 10:43:08 -0600
Subject: [PATCH 05/12] phylib: Allow reading and writing a mii bus from
	atomic context.
In-Reply-To: <1b8219e7d7993d0e8204b94e959477e3007534ce.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<1b8219e7d7993d0e8204b94e959477e3007534ce.1276615626.git.richard.cochran@omicron.at>
Message-ID: <AANLkTikeae2t4KmnawOCo2LqfSI57BKjNnUayY09DfEC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 10:08 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> In order to support hardware time stamping from a PHY, it is necessary to
> read from the PHY while running in_interrupt(). This patch allows a mii
> bus to operate in an atomic context. An mii_bus driver may declare itself
> capable for this mode. Drivers which do not do this will remain with the
> default that bus operations may sleep.
>
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Last I checked, the MDIO bus is very slow.  Is this really a good
idea?  How much latency does MDIO access have on the hardware you are
working with?

I also don't like the idea of taking a spin lock during MDIO
operations, and the dual locking mode in the core code.

I'd rather see separate atomic context hooks that doesn't obtain the
mutex under the assumption that the caller has already done so.  If
the bus doesn't support atomic access, then it won't implement the
hooks and the core code should return an error.

I've cc'd Thomas Gleixner.  He might have a better idea about how to
implement what you're trying to do.

g.

> ---
> ?drivers/net/phy/mdio_bus.c | ? 35 ++++++++++++++++++++++++++++-------
> ?include/linux/phy.h ? ? ? ?| ? 13 +++++++++++--
> ?2 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 6a6b819..441be7d 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -36,6 +36,22 @@
> ?#include <asm/irq.h>
> ?#include <asm/uaccess.h>
>
> +static inline void mdiobus_lock(struct mii_bus *bus)
> +{
> + ? ? ? if (MDIOBUS_SLEEPS_RW == bus->locktype)
> + ? ? ? ? ? ? ? mutex_lock(&bus->mdio_lock.m);
> + ? ? ? else
> + ? ? ? ? ? ? ? spin_lock(&bus->mdio_lock.s);
> +}
> +
> +static inline void mdiobus_unlock(struct mii_bus *bus)
> +{
> + ? ? ? if (MDIOBUS_SLEEPS_RW == bus->locktype)
> + ? ? ? ? ? ? ? mutex_unlock(&bus->mdio_lock.m);
> + ? ? ? else
> + ? ? ? ? ? ? ? spin_unlock(&bus->mdio_lock.s);
> +}
> +
> ?/**
> ?* mdiobus_alloc - allocate a mii_bus structure
> ?*
> @@ -107,7 +123,10 @@ int mdiobus_register(struct mii_bus *bus)
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?}
>
> - ? ? ? mutex_init(&bus->mdio_lock);
> + ? ? ? if (MDIOBUS_SLEEPS_RW == bus->locktype)
> + ? ? ? ? ? ? ? mutex_init(&bus->mdio_lock.m);
> + ? ? ? else
> + ? ? ? ? ? ? ? spin_lock_init(&bus->mdio_lock.s);
>
> ? ? ? ?if (bus->reset)
> ? ? ? ? ? ? ? ?bus->reset(bus);
> @@ -212,11 +231,12 @@ int mdiobus_read(struct mii_bus *bus, int addr, u32 regnum)
> ?{
> ? ? ? ?int retval;
>
> - ? ? ? BUG_ON(in_interrupt());
> + ? ? ? if (MDIOBUS_SLEEPS_RW == bus->locktype)
> + ? ? ? ? ? ? ? BUG_ON(in_interrupt());
>
> - ? ? ? mutex_lock(&bus->mdio_lock);
> + ? ? ? mdiobus_lock(bus);
> ? ? ? ?retval = bus->read(bus, addr, regnum);
> - ? ? ? mutex_unlock(&bus->mdio_lock);
> + ? ? ? mdiobus_unlock(bus);
>
> ? ? ? ?return retval;
> ?}
> @@ -237,11 +257,12 @@ int mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val)
> ?{
> ? ? ? ?int err;
>
> - ? ? ? BUG_ON(in_interrupt());
> + ? ? ? if (MDIOBUS_SLEEPS_RW == bus->locktype)
> + ? ? ? ? ? ? ? BUG_ON(in_interrupt());
>
> - ? ? ? mutex_lock(&bus->mdio_lock);
> + ? ? ? mdiobus_lock(bus);
> ? ? ? ?err = bus->write(bus, addr, regnum, val);
> - ? ? ? mutex_unlock(&bus->mdio_lock);
> + ? ? ? mdiobus_unlock(bus);
>
> ? ? ? ?return err;
> ?}
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 7a8caac..352b030 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -98,11 +98,20 @@ struct mii_bus {
> ? ? ? ?int (*write)(struct mii_bus *bus, int phy_id, int regnum, u16 val);
> ? ? ? ?int (*reset)(struct mii_bus *bus);
>
> + ? ? ? /* Indicates whether bus may be used from an atomic context. */
> + ? ? ? enum {
> + ? ? ? ? ? ? ? MDIOBUS_SLEEPS_RW,
> + ? ? ? ? ? ? ? MDIOBUS_ATOMIC_RW
> + ? ? ? } locktype;
> +
> ? ? ? ?/*
> - ? ? ? ?* A lock to ensure that only one thing can read/write
> + ? ? ? ?* A lock or mutex to ensure that only one thing can read/write
> ? ? ? ? * the MDIO bus at a time
> ? ? ? ? */
> - ? ? ? struct mutex mdio_lock;
> + ? ? ? union {
> + ? ? ? ? ? ? ? struct mutex m;
> + ? ? ? ? ? ? ? spinlock_t s;
> + ? ? ? } mdio_lock;
>
> ? ? ? ?struct device *parent;
> ? ? ? ?enum {
> --
> 1.6.3.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
