From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 13 Mar 2015 10:33:41 -0700
Subject: [PATCH 04/10] pm: domains: sync runtime PM status with PM domains
 after probe
In-Reply-To: <E1YWSN5-0006G5-Ld@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Fri, 13 Mar 2015 16:23:35 +0000")
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YWSN5-0006G5-Ld@rmk-PC.arm.linux.org.uk>
Message-ID: <7hzj7gpzt6.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> Synchronise the PM domain status with runtime PM's status after a
> platform device has been probed.  This augments the solution in commit
> 2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach
> completes").
>
> The above commit added a call to power up the PM domain when a device
> attaches to the domain in order to match the behaviour required by
> drivers that make no use of runtime PM.  The assumption is that the
> device driver will cause a runtime PM transition, which will synchronise
> the PM domain state with the runtime PM state.
>
> However, by default, runtime PM will assume that the device is initially
> suspended, and some drivers may make use of this should they not need to
> touch the hardware during probe.
>
> In order to allow such drivers, trigger the PM domain code to check
> whether the PM domain can be suspended after the probe function, undoing
> the effect of the power-on prior to the probe.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

[ Since I hadn't seen this version yet, repeating comment from the
  previous version so it doesn't get lost. ]

I think this is a good fix to the existing problem.  One minor nit on a
comment below, otherwise:

Acked-by: Kevin Hilman <khilman@linaro.org>

> +/**
> + * dev_pm_domain_sync - synchronise the PM domain state with its devices
> + * @dev: device corresponding with domain
> + *
> + * Synchronise the PM domain state with the recently probed device, which
> + * may be in a variety of PM states.  This ensures that a device which
> + * enables runtime PM in suspended state, and never transitions to active
> + * in its probe handler is properly suspended after the probe.
> + */

It's not the *device* tha needs to be properly suspended after the probe
(since it's already/still runtime suspended), but the pm_domain that
would be potentially powered down.  Hence, I'd reword the last sentence
slightly:

   This ensures that a device which enables runtime PM in suspended
   state, and never transitions to active in its probe handler gives an
   opportunity for the PM domain to be powered down after the probe.

Kevin
