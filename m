From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 27 Nov 2013 21:42:10 +0100
Subject: [PATCH 0/5] PM: Enable option of re-use runtime PM callbacks at
 system suspend
In-Reply-To: <1385566500-7666-1-git-send-email-ulf.hansson@linaro.org>
References: <1385566500-7666-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1619468.NHTb5ylADI@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 27, 2013 04:34:55 PM Ulf Hansson wrote:
> To put devices into low power state during system suspend, it may be convenient
> for runtime PM supported subsystems, power domains and drivers to have the
> option of re-using the runtime PM callbacks.
> 
> At the moment, quite complex solutions exist for power domains that tries to
> handle the above, like for OMAP2. The idea here, is to make it possible for
> drivers, who should know best, how to easiest put their devices into low power
> state. The intent is thus not only to simplify drivers but also power domains.

So this is not entirely correct and stems from the fact that you are only
considering one platform.

On some other platforms, like x86 PC for one example, device drivers have no
idea how to put their devices into low power states at all, because that
depends on what's there in the ACPI tables.

This becomes clearly visible when you try to use the same driver on two
different platforms that have different board layouts and power configurations.
And if one of them uses ACPI by chance, the driver shouldn't really fiddle with
its little knobs for clocks and power rails directly.

> Additionally, some drivers seems to have messed up things when combining
> runtime PM with system PM. While we enable the option of re-using the runtime
> PM callbacks during system PM, we also intend to clarify the way forward for
> how these scenarios could be resolved.
> 
> Some new helper macros for defining PM callbacks and two new pm_generic*
> functions has been implemented in this patch set. These are provided to make it
> easier for those who wants to enable the option of re-using the runtime PM
> callbacks during system suspend.

I'm generally opposed to re-using callbacks like this, because it adds confusion
to the picture.  It may seem to be clever, but in fact it leads to bad design
choices in the drivers in my opinion.

Let's talk about specific examples, though.

Why exactly do you need what patch [5/5] does in the exynos_drm_fimc driver?

Rafael
