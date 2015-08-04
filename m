From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 04 Aug 2015 10:30:24 +0200
Subject: [RFC PATCH 2/3] mailbox: Hisilicon: add mailbox driver
In-Reply-To: <1438564390-28111-3-git-send-email-leo.yan@linaro.org>
References: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
 <1438564390-28111-3-git-send-email-leo.yan@linaro.org>
Message-ID: <1438677024.8734.24.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(This RFC was part of this mornings catch of my crude mail filter. So,
for what it's worth, what follows are a few random comments for the few
things I'm able to spot.)

On ma, 2015-08-03 at 09:13 +0800, Leo Yan wrote:
> --- /dev/null
> +++ b/drivers/mailbox/hisilicon/Kconfig

> +config HISI_MBOX
> +	bool "Hisilicon's Mailbox"
> +	depends on ARCH_HISI || OF

ARCH_HISI is available on either ARM64 or ARM. ARM64 selects OF. On ARM
ARCH_HISI depends on ARCH_MULTIV7 which depends on ARCH_MULTIPLATFORM.
That selects USE_OF which on its turn selects OF.

So, HISI_MBOX implies OF, correct?

> +	help
> +	  Support for mailbox drivers on Hisilicon series of SoCs.
> +
> +config HI6220_MBOX
> +	tristate "Hi6220 Mailbox Controller"
> +	depends on HISI_MBOX
> +	help
> +	  An implementation of the hi6220 mailbox. It is used to send message
> +	  between application processors and MCU. Say Y here if you want to build
> +	  the Hi6220 mailbox controller driver.

> --- /dev/null
> +++ b/drivers/mailbox/hisilicon/common.c

> +int hisi_mbox_register(struct hisi_mbox_hw *mbox_hw)
> +{
> +	[...]
> +
> +	mbox->chan = devm_kzalloc(dev,
> +		mbox_hw->chan_num * sizeof(struct mbox_chan), GFP_KERNEL);
> +	if (!mbox)

	if (!mbox->chan)

> +		return -ENOMEM;
> +
> +	[...]
> +}

> --- /dev/null
> +++ b/drivers/mailbox/hisilicon/hi6220-mailbox.c

> +static struct platform_driver hi6220_mbox_driver = {
> +	.driver = {
> +		[...]
> +		.of_match_table = of_match_ptr(hi6220_mbox_of_match),

of_match_ptr(x) becomes NULL when CONFIG_OF is not defined. But I think
CONFIG_OF will always be defined, see above. So of_match_ptr() isn't per
se needed.

> +	},
> +	[...]
> +};

> +static int __init hi6220_mbox_init(void)
> +{
> +	return platform_driver_register(&hi6220_mbox_driver);
> +}
> +module_init(hi6220_mbox_init);
> +
> +static void __exit hi6220_mbox_exit(void)
> +{
> +	platform_driver_unregister(&hi6220_mbox_driver);
> +}
> +module_exit(hi6220_mbox_exit);

This could be flattened into one line:
    module_platform_driver(hi6220_mbox_driver);

Thanks,


Paul Bolle
