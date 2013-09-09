From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 9 Sep 2013 15:38:28 +0900
Subject: [PATCH v5 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <522A2D1B.3010508@wwwdotorg.org>
References: <1378351680-14696-1-git-send-email-acourbot@nvidia.com>
 <1378351680-14696-2-git-send-email-acourbot@nvidia.com>
 <522A2D1B.3010508@wwwdotorg.org>
Message-ID: <CAAVeFuJF-cu9aPCruGPQk9WHV7VAGhGpU0bU6LToxP38YBnS_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 7, 2013 at 4:29 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/04/2013 09:27 PM, Alexandre Courbot wrote:
>> Trusted Foundations is a TrustZone-based secure monitor for ARM that
>> can be invoked  using a consistent SMC-based API on all supported
>> platforms. This patch adds initial basic support for Trusted
>> Foundations using the ARM firmware API. Current features are limited
>> to the ability to boot secondary processors.
>
>> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
> ...
>> +void of_register_trusted_foundations(void)
>> +{
>> +     struct device_node *node;
>> +     struct trusted_foundations_platform_data pdata;
>> +     int err;
>> +
>> +     node = of_find_compatible_node(NULL, NULL, "tl,trusted-foundations");
>> +
>> +     if (!node)
>> +             return;
>
> If you're going to revise this patch for the comment below, then I would
> suggest removing the blank line before that if statement.

Sure.

>
>> diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
>
> Do we need to add the following here:
>
> #if !IS_ENABLED(CONFIG_OF)
> static inline void register_trusted_foundations(...) {}
> #endif
>
> So that there is a dummy no-op function for the non-DT-support case? I
> guess Tegra always has CONFIG_OF enabled so that call from
> mach-tegra/common.c in patch 2 will never be an issue, but perhaps it
> might if anyone else uses this?

My expectation is that register_trusted_foundations() is called by the
platform code once it has established (through whatever mean it likes)
that Trusted Foundations is required. For platforms supporting DT,
of_register_trusted_foundations() takes care of that. Platforms that
don't support DT need another way to decide whether they *need* TF or
not. Once a platform decided that it needs TF, its absence is not an
option, and therefore I'd think that register_trusted_foundations()
should hard-fail if support is not compiled in. Or maybe I missed your
point?

Alex.
