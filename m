From: linuxzsc@gmail.com (Richard Zhao)
Date: Wed, 20 Jun 2012 07:41:11 +0800
Subject: [Patch v5 08/13] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <CAOMZO5AxnOCqajCS39bpjo-86FXSV9C8fMPrhmRXH=OndfXuVQ@mail.gmail.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-9-git-send-email-richard.zhao@freescale.com>
 <CAOMZO5AxnOCqajCS39bpjo-86FXSV9C8fMPrhmRXH=OndfXuVQ@mail.gmail.com>
Message-ID: <c29d9643-0962-46e7-b726-cebdac7d9a67@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Fabio Estevam <festevam@gmail.com> wrote:

>On Wed, Jun 13, 2012 at 9:34 AM, Richard Zhao
><richard.zhao@freescale.com> wrote:
>
>> +static void __init imx6q_config_on_boot(void)
>> +{
>> + ? ? ? struct device_node *np;
>> + ? ? ? struct property *pp;
>> + ? ? ? int cnt, len, i;
>> + ? ? ? int gpio;
>> +
>> + ? ? ? np = of_find_node_by_path("/config-on-boot");
>> + ? ? ? if (!np)
>> + ? ? ? ? ? ? ? return;
>> + ? ? ? cnt = of_gpio_named_count(np, "output-gpios");
>> + ? ? ? pp = of_find_property(np, "output-gpio-values", &len);
>> + ? ? ? if (!pp || cnt != len / sizeof(u32)) {
>> + ? ? ? ? ? ? ? pr_err("Invalid config-on-boot gpios!\n");
>> + ? ? ? ? ? ? ? of_node_put(np);
>> + ? ? ? ? ? ? ? return;
>> + ? ? ? }
>> + ? ? ? for (i = 0; i < cnt; i++) {
>> + ? ? ? ? ? ? ? gpio = of_get_named_gpio(np, "output-gpios", i);
>> + ? ? ? ? ? ? ? if (gpio_is_valid(gpio))
>> + ? ? ? ? ? ? ? ? ? ? ? gpio_request_one(gpio, GPIOF_OUT_INIT_HIGH,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "config-on-boot");
>> + ? ? ? }
>> +
>> + ? ? ? of_node_put(np);
>> +}
>
>Couldn't this function be made generic and put outside of mach-imx6q.c
>so that other platforms could use it?
>
>I need the same for mxs.
Yes, it is common. But it must be called after populate devices.  Rob didn't agree the way yet.
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
