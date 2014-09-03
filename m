From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 3 Sep 2014 09:14:04 +0530
Subject: [PATCH v2] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <1409668935-10667-1-git-send-email-pankaj.dubey@samsung.com>
References: <1409668935-10667-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAFp+6iEzux2WgV5DcexQB6=gb8tt-FSM9jW7aBM_o6+U4JWwFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 2, 2014 at 8:12 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> Currently a syscon entity can only be registered directly through a
> platform device that binds to a dedicated syscon driver. However in
> certain cases it is required to bind a device with it's dedicated
> driver rather than binding with syscon driver.
>
> For example, certain SoCs (e.g. Exynos) contain system controller
> blocks which perform various functions such as power domain control,
> CPU power management, low power mode control, but in addition contain
> certain IP integration glue, such as various signal masks,
> coprocessor power control, etc. In such case, there is a need to have
> a dedicated driver for such system controller but also share registers
> with other drivers. The latter is where the syscon interface is helpful.
>
> This patch decouples syscon object from syscon platform driver, and
> allows to create syscon objects first time when it is required by
> calling of syscon_regmap_lookup_by APIs and keeps a list of such syscon
> objects along with syscon provider device_nodes and regmap handles.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
> V1 of this patchset [1] and related discussion can be found here [1].
>
> Changes since v1:
>  - Removed of_syscon_unregister function.
>  - Modified of_syscon_register function and it will be used by syscon.c
>    to create syscon objects whenever required.
>  - Removed platform device support from syscon.
>  - Removed syscon_regmap_lookup_by_pdevname API support.
>  - As there are significant changes w.r.t patchset v1, I am taking over
>    author for this patchset from Tomasz Figa.
>
> Note: Current kernel has clps711x user of syscon_regmap_lookup_by_pdevname and
> will be broken after this patch. As per discussion over here [1], patches
> for making these drivers DT based are ready and once that is done they can use
> syscon_regmap_lookup_by_phandle or syscon_regmap_lookup_by_compatible.
>
> [1]: https://lkml.org/lkml/2014/8/22/81

[snip]

Tested on smdk5250 board with 3.17-rc3 for USB 2.0 and USB 3.0, since USB takes
syscon phandle for handling some of the pmu registers.
Things work fine with all the dt side changes in this patch.

Tested-by: Vivek Gautam <gautam.vivek@samsung.com>



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
