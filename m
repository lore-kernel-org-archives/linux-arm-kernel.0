From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri, 20 Mar 2015 15:31:04 +0530
Subject: [PATCH v3 1/6] clk: qcom: Add support for GDSCs
In-Reply-To: <550BED93.3000305@codeaurora.org>
References: <1426832483-27026-1-git-send-email-rnayak@codeaurora.org>
 <1426832483-27026-2-git-send-email-rnayak@codeaurora.org>
 <550BCE7C.3030000@linaro.org> <550BED93.3000305@codeaurora.org>
Message-ID: <550BEFE0.1020004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[]...
>>> @@ -0,0 +1,46 @@
>>> +/*
>>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 and
>>> + * only version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#ifndef __QCOM_GDSC_H__
>>> +#define __QCOM_GDSC_H__
>>> +
>>> +#include <linux/pm_domain.h>
>>> +
>>> +struct regmap;

I realized, after Srini pointed out on irc that this fwd declaration
is a complete waste. I'll remove it when I do a repost.

>>> +
>>> +/**
>>> + * struct gdsc - Globally Distributed Switch Controller
>>> + * @pd: generic power domain
>>> + * @regmap: regmap for MMIO accesses
>>> + * @gdscr: gsdc control register
>>> + */
>>> +struct gdsc {
>>> +    struct generic_pm_domain    pd;
>>> +    struct regmap            *regmap;
>>> +    unsigned int            gdscr;
>>> +};
>>> +
>>> +#define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
>>> +
>>> +#ifdef CONFIG_QCOM_GDSC
>>> +int gdsc_register(struct device *, struct gdsc **, size_t n, struct
>>> regmap *);
>>> +void gdsc_unregister(struct device *);
>>> +#else
>>> +int gdsc_register(struct device *d, struct gdsc **g, size_t n, struct
>>> regmap *r)
