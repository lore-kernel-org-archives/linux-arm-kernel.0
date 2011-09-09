From: olof@lixom.net (Olof Johansson)
Date: Fri, 9 Sep 2011 09:45:48 -0700
Subject: [PATCH] arm/dt: Add SoC detection macros
In-Reply-To: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
References: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
Message-ID: <CAOesGMj7cwJ-B9cc0DbJ=ePMWeQtp6UiMQT7HCBdOxsmyJReZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2011 at 1:02 AM, Allen Martin <amartin@nvidia.com> wrote:
> These macros allow runtime query of SoC family and version via
> soc_is_*() ?If the corresponding SoC is not configured the macro will
> evaluate to 0. ?If the corresponding SoC is the only architecure
> configured, the macro will evaluate to 1. ?If multiple architecures
> are configured the macro will evaluate to a runtime call to
> soc_get_version().

> +void soc_init_version(void)
> +{
> + ? ? ? if (of_machine_is_compatible("nvidia,tegra20"))
> + ? ? ? ? ? ? ? soc_version = TEGRA_T20;
> + ? ? ? else if (of_machine_is_compatible("nvidia,tegra30"))
> + ? ? ? ? ? ? ? soc_version = TEGRA_T30;
> + ? ? ? else
> + ? ? ? ? ? ? ? panic("Unknown SoC");
> +}


The above should be enough for your local code, no need to wrap it in
layers of indirection.

Sure, doing the of_machine_is...() calls are slow, but you shouldn't
be doing runtime decisions about what SoC you are on during critical
path anyway -- it should be done at setup/probe time, much of the rest
should be possible to handle with setting appropriate function
pointers, etc.

Also, panic:ing is unacceptable.


-Olof
