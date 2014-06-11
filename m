From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 11 Jun 2014 15:06:37 -0600
Subject: [PATCH v2 2/4] pinctrl: Add NVIDIA Tegra XUSB pad controller
 support
In-Reply-To: <CAL1qeaGKUGjSzriDGptR+h23+bS3ZWuStz6koPURCstkFbEjNA@mail.gmail.com>
References: <1402398708-10722-1-git-send-email-thierry.reding@gmail.com>	<1402398708-10722-2-git-send-email-thierry.reding@gmail.com>
 <CAL1qeaGKUGjSzriDGptR+h23+bS3ZWuStz6koPURCstkFbEjNA@mail.gmail.com>
Message-ID: <5398C4DD.6020509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2014 02:23 PM, Andrew Bresticker wrote:
> On Tue, Jun 10, 2014 at 4:11 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> The XUSB pad controller found on NVIDIA Tegra SoCs provides several pads
>> that lanes can be assigned to in order to support a variety of interface
>> options: USB 2.0, USB 3.0, PCIe and SATA.
>>
>> In addition to the pin controller used to assign lanes to pads two PHYs
>> are exposed to allow the bricks for PCIe and SATA to be powered up and
>> down by PCIe and SATA drivers.

>> diff --git a/drivers/pinctrl/pinctrl-tegra-xusb.c b/drivers/pinctrl/pinctrl-tegra-xusb.c

>> +static int tegra_xusb_padctl_pinconf_group_set(struct pinctrl_dev *pinctrl,
>> +                                              unsigned int group,
>> +                                              unsigned long *configs,
>> +                                              unsigned int num_configs)

>> +       for (i = 0; i < num_configs; i++) {
>> +               param = TEGRA_XUSB_PADCTL_UNPACK_PARAM(configs[i]);
>> +               value = TEGRA_XUSB_PADCTL_UNPACK_VALUE(configs[i]);
>> +
>> +               switch (param) {
>> +               case TEGRA_XUSB_PADCTL_IDDQ:
>> +                       value = padctl_readl(padctl, lane->offset);
> 
> This overwrites the configuration value - probably want to use a
> separate variable for the register value.

It'd be nice to trim what you quote so that people don't have to wade
through hundreds of lines of code to find a 2-line comment. It's easily
missed.
