From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 3 Apr 2013 13:10:52 +0200
Subject: [PATCH v4] clk: add si5351 i2c common clock driver
In-Reply-To: <20130402234648.8177.86213@quantum>
References: <1363603397-2762-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1364050010-23919-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130402234648.8177.86213@quantum>
Message-ID: <CABJ1b_RtBtLP6jQ1wt8xuLKhvRG2jPr0zcgGWYeWQUUxTd3h7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 3, 2013 at 1:46 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Sebastian Hesselbarth (2013-03-23 07:46:50)
>> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
>> new file mode 100644
>> index 0000000..9d0c210
>> --- /dev/null
>> +++ b/drivers/clk/clk-si5351.c
>> @@ -0,0 +1,1411 @@
>> +/*
>> + * clk-si5351.c: Silicon Laboratories Si5351A/B/C I2C Clock Generator
>> + *
>> + * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> + * Rabeeh Khoury <rabeeh@solid-run.com>
>> + *
>> + * References:
>> + * [1] "Si5351A/B/C Data Sheet"
>> + *     http://www.silabs.com/Support%20Documents/TechnicalDocs/Si5351.pdf
>> + * [2] "Manually Generating an Si5351 Register Map"
>> + *     http://www.silabs.com/Support%20Documents/TechnicalDocs/AN619.pdf
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/clk-private.h>
>
> I hope that this is supposed to be clk-provider.h.  I don't plan on
> taking in any more clock drivers that depend on clk-private.h.  I didn't
> see any reason for this patch to not use clk-provider.h.

True except for two things:
- The driver sets clk flags for the hierarchy after parsing the DT and
there is no helper __clk_set_flags()
- For single parent clks (pxtal, pclkin) I reuse &clk->name for .parent_names

For the latter I would have to add two static char *[1] somewhere, not
a big deal. But the for the flags,
I guess there will be no __clk_set_flags helper? Then I'd have to
parse the DT in advance to have the
correct flags ready at clk registration.

Sebastian
