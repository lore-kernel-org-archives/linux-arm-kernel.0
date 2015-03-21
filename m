From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 20 Mar 2015 17:14:34 -0700
Subject: [PATCH V2] PM / Domains: Sync runtime PM status with genpd after
 probe
In-Reply-To: <1426863312-31132-1-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Fri, 20 Mar 2015 15:55:12 +0100")
References: <1426863312-31132-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hvbhvi4ut.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> From: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Buses which currently supports attaching devices to their PM domains,
> will invoke the dev_pm_domain_attach() API from their ->probe()
> callbacks. During the attach procedure, genpd power up the PM domain.
>
> In those scenarios where the bus/driver don't need to access its device
> during probe, it may leave it in runtime PM suspended state since
> that's also the default state. In that way, no notifications through
> the runtime PM callbacks will reach the PM domain during probe.
>
> For genpd, the consequence from the above scenario means the PM domain
> will remain powered. Therefore, implement the struct dev_pm_domain's
> ->sync() callback, which is invoked from driver core after the
> bus/driver has probed the device. It allows genpd to power off the PM
> domain if it's unused.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> [Ulf: Updated patch according to updates in driver core]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
> 	- I picked up Russell's earlier patch [1] and updated it to fit the
> 	changes [2] proposed to be done to the driver core.
>
> 	[1]: [PATCH 3/9] pm: domains: sync runtime PM status with PM domains
> 	after probe
>
> 	[2]: [PATCH v3] driver core / PM: Add PM domain callbacks for device
> 	setup/cleanup
> 	http://www.spinics.net/lists/arm-kernel/msg407394.html

Ah, I hadn't seen this when I reviewed Rafael's v3 and suggested
Russell's patch be reworked.  This is just what I had in mind.

Acked-by: Kevin Hilman <khilman@linaro.org>
