From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 21 Oct 2016 15:28:57 +0200
Subject: [PATCH v2 0/4] ARM: K2G: Add support for TI-SCI Generic PM Domains
In-Reply-To: <20161019203347.17893-1-d-gerlach@ti.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
Message-ID: <CAJZ5v0jvyZGw9ZohRGLzJ+en2XpgWc4OTnaVK5hvpTvWsCovDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 10:33 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Hi,
> This is v2 of the series to add support for TI SCI PM Domains. v1 of
> the series can be found here [1]. Several things have changed since v1:
>
> - New patch to add a void *data to struct generic_pm_domain_data to
>   allow to store per device data associated with a genpd
> - From v1, squash patch 1 and 2 to introduce docs and dt-bindings in
>   one patch based on comment from Ulf
> - Fix some grammar errors in Documentation
> - Based on comments from Ulf, rework actual genpd implementation to
>   avoid creating one genpd per device and instead use device start/stop
>   hooks provided as part of genpd to control device state based on pm_runtime
>   implementation. Also make use of new of_genpd_add_provider_simple API
>   introduced by Jon Hunter and do not provide custom of_xlate to genpd core,
>   instead registering devices as they probe through attach_dev hook provided
>   by genpd framework.
>
> Most of the changes were motivated by the comments from Ulf Hannson on v1 that we
> should not use a 1-to-1 genpd to device mapping. The new approach allows us to
> create a single genpd and store information about each device as they attach to
> the genpd. Then the device start/stop hooks for that genpd leverage the
> per-device data to control power states over the TI SCI protocol.
>
> This driver makes use of the ti_sci driver sent here [2] by Nishanth Menon and
> applies on top of his series on v4.9-rc1.
>
> Regards,
> Dave
>
> [1] http://www.spinics.net/lists/arm-kernel/msg525204.html
> [2] http://www.spinics.net/lists/arm-kernel/msg536851.html
>
> Dave Gerlach (4):
>   PM / Domains: Add generic data pointer to genpd data struct
>   dt-bindings: Add TI SCI PM Domains
>   soc: ti: Add ti_sci_pm_domains driver
>   ARM: keystone: Drop PM domain support for k2g

If I'm to apply this at one point, ACKs are required from Ulf/Kevin,
the appropriate platform maintainers, and the DT bindings people.
Also it should be applicable on top of the LInus' tree for me to apply
it.

Thanks,
Rafael
