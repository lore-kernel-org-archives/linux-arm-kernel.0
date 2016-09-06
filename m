From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 Sep 2016 09:38:31 +0530
Subject: [v14 PATCH 2/5] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <57CCCA56.5000702@samsung.com>
References: <1472015825-11365-1-git-send-email-zyw@rock-chips.com>
 <CGME20160824051805epcas1p2e63c7c5a8cb28e34b7a96cef0bf20e01@epcas1p2.samsung.com>
 <1472015825-11365-3-git-send-email-zyw@rock-chips.com>
 <57CCCA56.5000702@samsung.com>
Message-ID: <57CE413F.8030203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi chanwoo,

On Monday 05 September 2016 06:58 AM, Chanwoo Choi wrote:
> Dear all,
> 
> On 2016? 08? 24? 14:17, Chris Zhong wrote:
>> Add a PHY provider driver for the rk3399 SoC Type-c PHY. The USB
>> Type-C PHY is designed to support the USB3 and DP applications.
>> The USB3 operates in SuperSpeed mode and the DP can operate at RBR,
>> HBR and HBR2 data rates. This driver create 2 PHY devices separately
>> for USB3 and DisplyPort, and registers them under the child node.
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> Reviewed-by: Guenter Roeck <groeck@chromium.org>
>> Tested-by: Guenter Roeck <groeck@chromium.org>
>>
>> ---
>>
>> Changes in v14:
>> - change the name of property from super speed to EXTCON_PROP_USB_SS
>>
>> Changes in v13:
>> - add some description in front of driver
>> - change name of usb to usb3
>> - add a USB3 RX register configuration
>> - do not return err if nothing connected with Type-C, when usb phy power on,
>>   since the USB core driver will call phy power without USB3 device connected.
>>
>> Changes in v12:
>> - enable DP+USB3 mode, only when EXTCON_PROP_USB_SUPERSPEED equal 1
>>   and DP is attached
>>
>> Changes in v11:
>> - make a clearer demarcation between usb phy and dp phy.
>>
>> Changes in v10:
>> - do not control dp select and hpd config in phy driver
>>
>> Changes in v9:
>> - the new_mode should be int not u8
>> - move mutex_lock(&tcphy->lock); to earlier place. in
>>   rockchip_usb3_phy_power_off
>> - better mutex lock for phy mode and flip
>> - split the Type-C PHY into two PHYs: USB3 and DP
>>
>> Changes in v8:
>> - set the default cable id to EXTCON_USB_HOST
>> - optimization Error log
>>
>> Changes in v7:
>> - support new API of extcon
>>
>> Changes in v6:
>> - delete the support of PIN_ASSIGN_A/B
>> - set the default mode to MODE_DFP_USB
>> - disable DP PLL at USB3 only mode
>>
>> Changes in v5:
>> - support get property from extcon
>> - remove PIN ASSIGN A/B support
>>
>> Changes in v4:
>> - select EXTCON
>> - use phy framework to control the USB3 and DP function
>> - rename PIN_MAP_ to PIN_ASSIGN_
>>
>> Changes in v3:
>> - remove the phy framework(Kishon Vijay Abraham I)
>> - add parentheses around the macro
>> - use a single space between type and name
>> - add spaces after opening and before closing braces.
>> - use u16 for register value
>> - remove type-c phy header file
>> - CodingStyle optimization
>> - use some cable extcon to get type-c port information
>> - add a extcon to notify Display Port
>>
>> Changes in v2:
>> - select RESET_CONTROLLER
>> - alphabetic order
>> - modify some spelling mistakes
>> - make mode cleaner
>> - use bool for enable/disable
>> - check all of the return value
>> - return a better err number
>> - use more readx_poll_timeout()
>> - clk_disable_unprepare(tcphy->clk_ref);
>> - remove unuse functions, rockchip_typec_phy_power_on/off
>> - remove unnecessary typecast from void *
>> - use dts node to distinguish between phys.
>>
>> Changes in v1:
>> - update the licence note
>> - init core clock to 50MHz
>> - use extcon API
>> - remove unused global
>> - add some comments for magic num
>> - change usleep_range(1000, 2000) tousleep_range(1000, 1050)
>> - remove __func__ from dev_err
>> - return err number when get clk failed
>> - remove ADDR_ADJ define
>> - use devm_clk_get(&pdev->dev, "tcpdcore")
>>
>>  drivers/phy/Kconfig              |    9 +
>>  drivers/phy/Makefile             |    1 +
>>  drivers/phy/phy-rockchip-typec.c | 1013 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 1023 insertions(+)
>>  create mode 100644 drivers/phy/phy-rockchip-typec.c
>>
> 
> [snip]
> 
> This patch rely on the extcon git repository to support the extcon property
> and USB 3.0 property. I created the immutable branch(ib-extcon-phy-4.9).
> I send this pull request to prevent the build error.
> 
> (The patches of extcon property for USB 3.0 depend on the other extcon patches
> which are already merged. So, it is diffcult to separate the only patches
> of extcon property.)
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> 
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git ib-extcon-phy-4.9

I've included this branch in linux-phy next for merging phy-rockchip-typec.c.

Thanks
Kishon
> 
> for you to fetch changes up to 8457a1b49a2af0a0e71f80afed9f7c80de361610:
> 
>   extcon: Introduce EXTCON_PROP_USB_SS property for SuperSpeed mode (2016-08-18 10:23:36 +0900)
> 
> ----------------------------------------------------------------
> Chanwoo Choi (12):
>       extcon: arizona: Remove the usage of extcon_update_state()
>       extcon: adc-jack: Remove the usage of extcon_set_state()
>       extcon: gpio: Remove the usage of extcon_set_state()
>       extcon: Remove the state_store() to prevent the wrong access
>       extcon: Block the bit masking operation for cable state except for extcon core
>       extcon: Add the extcon_type to gather each connector into five category
>       extcon: Add the support for extcon property according to extcon type
>       extcon: Add the support for the capability of each property
>       extcon: Rename the extcon_set/get_state() to maintain the function naming pattern
>       extcon: Add the synchronization extcon APIs to support the notification
>       extcon: Add new EXTCON_DISP_HMD for Head-mounted Display device
>       extcon: Add new EXTCON_CHG_WPT for Wireless Power Transfer device
> 
> Charles Keepax (1):
>       extcon: arizona: Remove unneeded semi-colon
> 
> Chris Zhong (1):
>       extcon: Add EXTCON_DISP_DP and the property for USB Type-C
> 
> Guenter Roeck (1):
>       extcon: Introduce EXTCON_PROP_USB_SS property for SuperSpeed mode
> 
> Maninder Singh (1):
>       extcon: Fix compile time warning
> 
> Stephen Boyd (1):
>       extcon: Move extcon_get_edev_by_phandle() errors to dbg level
> 
> Venkat Reddy Talla (1):
>       extcon: adc-jack: update cable state during boot
> 
>  drivers/extcon/extcon-adc-jack.c       |  27 +-
>  drivers/extcon/extcon-arizona.c        |  13 +-
>  drivers/extcon/extcon-gpio.c           |   2 +-
>  drivers/extcon/extcon.c                | 774 ++++++++++++++++++++++++++-------
>  include/linux/extcon.h                 | 181 +++++++-
>  include/linux/extcon/extcon-adc-jack.h |   4 +-
>  6 files changed, 809 insertions(+), 192 deletions(-)
> 
