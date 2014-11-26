From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 26 Nov 2014 11:41:58 -0800
Subject: [PATCH V6 07/12] pinctrl: tegra-xusb: Add USB PHY support
In-Reply-To: <547488EB.2040507@ti.com>
References: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
 <1416874644-12070-8-git-send-email-abrestic@chromium.org>
 <547488EB.2040507@ti.com>
Message-ID: <CAL1qeaHZCh1AomPTQGKN-ytx7EyW8Gncb64S1ikGk0eB16maRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 5:49 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Tuesday 25 November 2014 05:47 AM, Andrew Bresticker wrote:
>> In addition to the PCIe and SATA PHYs, the XUSB pad controller also
>> supports 3 UTMI, 2 HSIC, and 2 USB3 PHYs.  Each USB3 PHY uses a single
>> PCIe or SATA lane and is mapped to one of the three UTMI ports.
>>
>> The xHCI controller will also send messages intended for the PHY driver,
>> so request and listen for messages on the mailbox's PHY channel.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> No changes from v5.
>> Changes from v4:
>>  - Disabled USB support on missing mailbox channel instead of failing
>>    to probe.
>>  - Made usb3-port a pinconfig property.
>>  - Addressed review comments from Thierry.
>> No changes from v3.
>> Changes from v2:
>>  - Added support for nvidia,otg-hs-curr-level-offset property.
>>  - Moved mailbox request handling to workqueue.
>>  - Added filtering out of non-PHY mailbox messages.
>>  - Dropped "-otg" from VBUS supplies.
>> Changes from v1:
>>  - Updated to use common mailbox API.
>>  - Added SATA PHY enable sequence for USB3 ports using the SATA lane.
>>  - Made USB3 port-to-lane mappins a top-level binding rather than a pinconfig
>>    binding.
>> ---
>>  drivers/pinctrl/Kconfig              |    1 +
>>  drivers/pinctrl/pinctrl-tegra-xusb.c | 1262 +++++++++++++++++++++++++++++++++-
>>  include/soc/tegra/xusb.h             |    7 +
>>  3 files changed, 1254 insertions(+), 16 deletions(-)
>
> The devm_phy_create() API has changed (see linux-phy next) and the patch that
> modified the existing devm_phy_create() in pinctrl-tegra-xusb.c has also been
> merged in linux-phy tree.

Ok, I'll rebase on top of that.
