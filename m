From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 6 Mar 2012 19:10:23 -0500
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <1330989122-6323-1-git-send-email-paul.gortmaker@windriver.com>
References: <1330989122-6323-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CAP=VYLp-weNj35OHtmZ6pf5-t7OUxWREeu8r5sSOLhFYu0CppQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2012 at 6:12 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

[...]

> -REGULATOR_CONSUMER(ldo3, &em_x270_gps_userspace_consumer.dev, "vcc gps");
> -REGULATOR_CONSUMER(ldo5, NULL, "vcc cam");
> -REGULATOR_CONSUMER(ldo10, &pxa_device_mci.dev, "vcc sdio");
> -REGULATOR_CONSUMER(ldo12, NULL, "vcc usb");
> -REGULATOR_CONSUMER(ldo19, &em_x270_gprs_userspace_consumer.dev, "vcc gprs");
> -REGULATOR_CONSUMER(buck2, NULL, "vcc_core");
> +REGULATOR_CONSUMER(ldo3, "vcc gps");
> +REGULATOR_CONSUMER(ldo5, "vcc cam");
> +REGULATOR_CONSUMER(ldo10, "vcc sdio");
> +REGULATOR_CONSUMER(ldo12, "vcc usb");
> +REGULATOR_CONSUMER(ldo19, "vcc gprs");
> +REGULATOR_CONSUMER(buck2, "vcc_core");

Based on today's discussions, I'm no longer convinced the above
is right.  If I understand correctly, for the case of say the top one:

      em_x270_gps_userspace_consumer

I need to go find that struct, determine that it has a .name entry like:

        .name           = "reg-userspace-consumer",

and then use (for each case) something like:

      REGULATOR_SUPPLY("vcc gps", "reg-userspace-consumer")

The above wrapper for REGULATOR_CONSUMER would have
to be changed to either use or inline the REGULATOR_SUPPLY.

Let me know if I'm on the right track here.  This code is completely
foreign to me.   As such, the naming in the magician_defconfig
patch is also probably needing rework (i.e. it needs the corresponding
value for .name, and not the name of the parent struct itself.)

THanks,
Paul.
--

>
> ?#define REGULATOR_INIT(_ldo, _min_uV, _max_uV, _ops_mask) ? ? ? ? ? ? ?\
> ? ? ? ?static struct regulator_init_data _ldo##_data = { ? ? ? ? ? ? ? \
> --
> 1.7.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
