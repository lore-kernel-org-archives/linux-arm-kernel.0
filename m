From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 30 Jun 2018 01:25:36 +0300
Subject: [PATCH v3 1/6] driver core: allow stopping deferred probe after
 init
In-Reply-To: <20180628204344.13973-2-robh@kernel.org>
References: <20180628204344.13973-1-robh@kernel.org>
 <20180628204344.13973-2-robh@kernel.org>
Message-ID: <CAHp75Vf+o7aA8M6T+zM5r8i_YCzWkP=rO8sTHY0qtz-YjVRibA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 11:43 PM, Rob Herring <robh@kernel.org> wrote:
> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version. Deferred
> probe issues can be difficult to debug especially if the console has
> dependencies or userspace fails to boot to a shell.
>
> There are also cases like IOMMUs where only built-in drivers are
> supported, so deferring probe after initcalls is not needed. The IOMMU
> subsystem implemented its own mechanism to handle this using OF_DECLARE
> linker sections.
>
> This commit adds makes ending deferred probe conditional on initcalls
> being completed or a debug timeout. Subsystems or drivers may opt-in by
> calling driver_deferred_probe_check_init_done() instead of
> unconditionally returning -EPROBE_DEFER. They may use additional
> information from DT or kernel's config to decide whether to continue to
> defer probe or not.
>
> The timeout mechanism is intended for debug purposes and WARNs loudly.

> The remaining deferred probe pending list will also be dumped after the
> timeout. Not that this timeout won't work for the console which needs
> to be enabled before userspace starts. However, if the console's
> dependencies are resolved, then the kernel log will be printed (as
> opposed to no output).

There is another patch flying around with debugfs node to dump a list
of deferred probe queue.
I dunno if it makes sense to dump it here and there and if yes, some
unification in output, perhaps?

> +       deferred_probe_timeout = simple_strtol(str, NULL, 0);

Hmm... I don't think 16-base or 8-base values are useful to support.
One subtle difference that people usually consider timeout values as
10-base and if at some point someone makes it as 0100 (no matter why),
it would be much less than expected.
08 wouldn't parsed at all.

> +       if (deferred_probe_timeout > 0) {

Would it be harmful / useful if we skip this check and run the work immediately?

> +               schedule_delayed_work(&deferred_probe_timeout_work,
> +                       deferred_probe_timeout * HZ);
> +       }


-- 
With Best Regards,
Andy Shevchenko
