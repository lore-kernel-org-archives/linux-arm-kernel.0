From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 22 Jul 2011 11:19:32 +0800
Subject: mmc: sdio add regulator vsdio
In-Reply-To: <37C1B996-A455-4EA9-A916-F4ED8C034167@marvell.com>
References: <37C1B996-A455-4EA9-A916-F4ED8C034167@marvell.com>
Message-ID: <CAMj5Bkjtjn9PvGy1_OxGevjNuk-=ACk7rP-=6fZG1hWQXYB3Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>+
>>+static int __init brownstone_init_mmc(void)
>>+{
>>+ ? ? ?/*
>>+ ? ? ? * PDn: GPIO58; RESETn: GPIO57
>>+ ? ? ? * 8787, RESETn keeps high, PDn control power
>>+ ? ? ? * on: PDn 1; off: PDn 0;
>>+ ? ? ? */
>
> Comment unclear
>
> GPIO57 is power
> GPIO58 is reset

yes, typo, thanks
>
>
>
>>+ ? ? ?int RESETn = mfp_to_gpio(MFP_PIN_GPIO58);
>>+
>>+ ? ? ?if (gpio_request(RESETn, "sdio RESETn")) {
>>+ ? ? ? ? ? ? ?pr_err("Failed to request sdio RESETn gpio\n");
>>+ ? ? ? ? ? ? ?return -EIO;
>>+ ? ? ?}
>>+ ? ? ?gpio_direction_output(RESETn, 1);
>>+ ? ? ?gpio_free(RESETn);
>
>
> The 8787 ?data sheet indicated that PDn should be inactive as well as reset before
> initiating power up.
>
> Pull PDn high.

The PDn is super-set of RESETn, keep RESETn high, and control 8787
with PDn is enough.
The "Internal Reset" in data sheet is not RESET pin.
