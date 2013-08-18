From: gnurou@gmail.com (Alexandre Courbot)
Date: Sun, 18 Aug 2013 17:37:00 +0900
Subject: [PATCH v3 2/5] ARM: tegra: add support for Trusted Foundations
In-Reply-To: <520BF8BD.7050706@wwwdotorg.org>
References: <1376360992-1508-1-git-send-email-acourbot@nvidia.com>
 <1376360992-1508-3-git-send-email-acourbot@nvidia.com>
 <520BF8BD.7050706@wwwdotorg.org>
Message-ID: <CAAVeFuJY_UkS8rF=xfB0uEpJp4bZpc77i599bP4qmY9Xr91PSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 6:38 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/12/2013 08:29 PM, Alexandre Courbot wrote:
>> Register the firmware operations for Trusted Foundations if the device
>> tree indicates it is active on the device.
>
>> diff --git a/arch/arm/mach-tegra/firmware.c b/arch/arm/mach-tegra/firmware.c
>
>> +void __init tegra_init_firmware(void)
>> +{
>> +     struct device_node *node;
>> +
>> +     if (!of_have_populated_dt())
>> +             return;
>
> That's never false on Tegra, at least upstream.

Will remove, thanks.

>> +     node = of_find_compatible_node(NULL, NULL, "tl,trusted-foundations");
>> +     if (node) {
>> +             const char *tf_version;
>> +             int err;
>> +
>> +             err = of_property_read_string(node, "version", &tf_version);
>> +             if (err != 0) {
>> +                     pr_crit("Cannot read Trusted Foundation version: %d\n",
>> +                             err);
>> +                     BUG();
>> +             } else {
>> +                     register_trusted_foundations(tf_version);
>> +             }
>> +     }
>> +}
>
> I think most/all of that function will be common across all SoCs that
> support the TF monitor. I think you want to move the code into
> register_trusted_foundations() (or a function that calls that) in patch 1?

Agreed. If we push the logic a bit further, we should also have some
platform parameters for non-DT users, along with an
of_register_trusted_foundations() for those who prefer DT.

Thanks,
Alex.
