From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 28 Jul 2016 11:43:00 +0200
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
Message-ID: <1469698980.12835.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 23.07.2016, 20:22 +0900 schrieb Masahiro Yamada:
> Hi.
> 
> 
> Now the reset subsystem provides
> a bunch of reset_control_get variants.
> 
> I am still wondering why we need to have _optional ones.
> 
> As far as I see, the difference is WARN_ON(1)
> when CONFIG_RESET_CONTROLLER is not defined.
> 
> 
> 
> [1] When the reset is mandatory,
> the code of the reset consumer is probably like follows:
> 
>   rst = devm_reset_control_get(dev, NULL);
>   if (IS_ERR(rst)) {
>           dev_err(dev, "failed to get reset\n");
>           return PTR_ERR(rst);
>   }
> 
>   ret = reset_control_deassert(rst);
>   if (ret) {
>           dev_err(dev, "failed to deassert reset\n");
>           return ret;
>   }
> 
>    ...
> 
> 
> 
> [2] When the reset is optional,
>   the code should be something like follows:
> 
>    rst = devm_reset_control_get(dev, NULL);
>    if (ERR_PTR(rst) == -EPROBE_DEFER)
>            return -EPROBE_DEFER;
> 
>    /* deassert reset if it is available */
>    if (!IS_ERR(rst)) {
>            ret = reset_control_deassert(rst);
>            if (ret) {
>                   dev_err(dev, "failed to deassert reset\n");
>                   return ret;
>            }
>     }
> 
> 
> 
> 
> What I mean is, we can write a driver in either way
> without using the _optional one.
> 
> No need to call WARN_ON(1).
> 
> 
> What does _optional buy us?

It will complain loudly with a backtrace if a driver requests a
non-optional reset on a kernel/platform with the reset framework
disabled.

> One more thing.
> WARN_ON(1) is only useful on run-time,
> but run-time test is more expensive than compile-time test.
> 
> If a driver really needs reset control,
> it should not be complied without CONFIG_RESET_CONTROLLER.
> So, the driver should have "depends on RESET_CONTROLLER" in Kconfig.

If we do that, we can't compile test those drivers anymore in
configurations without RESET_CONTROLLER enabled.

[...]
> I want to deprecate _optional variants in the following steps:
> 
> [1] Add "depends on RESET_CONTROLLER" to drivers
>     for which reset_control is mandatory.
> 
>     We can find those driver easily by grepping
>     the reference to non-optional reset_control_get().

Since we have the stubs, the RESET_CONTROLLER dependency is only at
runtime, not at build time.

I think Arnd wanted to move this in the opposite direction and remove
the configurable RESET_CONTROLLER symbol. Maybe we should let all
drivers that currently request non-optional resets have:
	depends on (ARCH_HAS_)RESET_CONTROLLER || COMPILE_TEST
?

regards
Philipp
