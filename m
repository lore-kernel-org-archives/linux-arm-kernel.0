From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 17 Nov 2014 10:28:56 -0800
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
In-Reply-To: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Mon, 17 Nov 2014 16:19:10 +0100")
References: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hd28l3clz.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The amba bus, amba drivers and a vast amount of platform drivers which
> enables runtime PM, don't invoke a pm_runtime_get_sync() while probing
> their devices.
>
> Instead, once they have turned on their PM resourses during ->probe()
> and are ready to handle I/O, these invokes pm_runtime_set_active() to
> synchronize its state towards the runtime PM core.
>
> From a runtime PM point of view this behavior is perfectly acceptable,

In the context of PM domains that can be dynamically powered on/off, I'm
not so sure it's perfectly acceptable anymore.

Why doesn't the bus do a _get_sync() instead of a _get_noresume()
followed by a _set_active().  

By using the _get_noresume() you're bypassing the paths that would bring
up your PM domain.

Kevin
