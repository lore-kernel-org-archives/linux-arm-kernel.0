From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 17 Jul 2015 12:41:55 +0200
Subject: [PATCH V3 10/19] drm/tegra: dc: Prepare for generic PM domains
In-Reply-To: <1436791197-32358-11-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-11-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150717104154.GM3057@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:39:48PM +0100, Jon Hunter wrote:
> Add support to the tegra dc driver for generic PM domains. However,
> to ensure backward compatibility with older device tree blobs ensure
> that the driver can work with or without generic PM domains. In order
> to migrate to generic PM domain infrastructure the necessary changes
> are:
> 
> 1. If the "power-domains" property is present in the DT device node then
>    generic PM domains is supported and pm_runtime_enable() should be
>    called for the device. Furthermore, the enabling and disabling of the
>    power-domain is handled via calling pm_runtime_get/put, respectively.

The device could be PM runtime enabled even if no power-domains property
is set. Couldn't we check something more direct, like for example if the
dev->pm_domain is non-NULL?

Perhaps it'd be worth converting the driver to use runtime PM first, and
move all the powergate and clock handling into suspend/resume functions,
and then we can conditionalize whether or not we call the legacy API iff
dev->pm_domain == NULL?

> 2. To ensure that clocks are managed consistently when generic PM domains
>    are used and are not used, drivers should be migrated to use the
>    tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy()
>    functions instead of the current tegra_powergate_sequence_power_up()
>    and tegra_powergate_power_off(). The purpose of the
>    tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy()
>    APIs is to mimick the behaviour of the tegra generic power-domain code,
>    such that if generic power domains are not supported the functionality
>    is the same.
> 
> 3. The main difference between the tegra_powergate_sequence_power_up() API
>    and the tegra_powergate_power_on_legacy() is that the clock used to
>    enable the powergate is not kept enabled when using the
>    tegra_powergate_power_on_legacy() API. Therefore, drivers must enable
>    the clocks they need after calling tegra_powergate_power_on_legacy()
>    and disable these clocks before calling
>    tegra_powergate_power_off_legacy().

This seems like it should go into the previous patch. I'm not sure I
understand why this is necessary. Wouldn't it be easier to update the
drivers to properly cope with this? We'll need to move them to runtime
PM at some point anyway, so if we do that first, we should be able to
hide all these details within the driver's suspend/resume functions
but without the need for the API churn here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/0275a247/attachment.sig>
