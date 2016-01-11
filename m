From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Jan 2016 18:14:31 -0200
Subject: arm qemu boot failures in -next due to 'PM / Domains: add setter
 for dev.pm_domain'
In-Reply-To: <20160111185459.GZ12777@atomide.com>
References: <5693EB8A.40802@roeck-us.net> <20160111185459.GZ12777@atomide.com>
Message-ID: <CAOMZO5CkfXcZV3LTOP0oT__012ena9kmTYLb83dY9+BMj5X3hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Rafael]

On Mon, Jan 11, 2016 at 4:55 PM, Tony Lindgren <tony@atomide.com> wrote:

>> I see 6 out of 24 arm qemu tests failing in next-20160111. Bisect points
>> to commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain").
>> Failures are silent - there is no output on the console.
>> Affected tests are
>>
>> arm:beagle:multi_v7_defconfig:omap3-beagle
>> arm:beaglexm:multi_v7_defconfig:omap3-beagle-xm
>> arm:overo:multi_v7_defconfig:omap3-overo-tobi
>> arm:beagle:omap2plus_defconfig:omap3-beagle
>> arm:beaglexm:omap2plus_defconfig:omap3-beagle-xm
>> arm:overo:omap2plus_defconfig:omap3-overo-tobi
>>
>> For details please see the 'next' column at http://server.roeck-us.net:8010/builders.
>>
>> Reverting the offending commit fixes the problems.
>>
>> Please let me know if there is anything I can do to help tracking down the problem.
>
> The following fixes the booting, but I wonder if it's a
> proper fix?
>
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -145,9 +145,10 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
>  {
>         if (dev->pm_domain == pd)
>                 return;
> -
> -       WARN(device_is_bound(dev),
> -            "PM domains can only be changed for unbound devices\n");
> +       if (device_is_registered(dev)) {
> +               WARN(device_is_bound(dev),
> +                    "PM domains can only be changed for unbound devices\n");
> +       }
>         dev->pm_domain = pd;
>         device_pm_check_callbacks(dev);

Commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain")
causes issues for me after doing a 'reboot' command.

Rafael proposed a patch which fixed the 'reboot' problem:
http://www.spinics.net/lists/arm-kernel/msg473562.html
