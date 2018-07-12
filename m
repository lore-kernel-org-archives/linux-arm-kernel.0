From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Jul 2018 18:17:23 +0800
Subject: [PATCH] mmc: sunxi: Use new timing mode for A64 eMMC controller
In-Reply-To: <20180712071959.fi4rhgwv2iuoelbl@flea>
References: <20180712030225.15681-1-wens@csie.org>
 <20180712071959.fi4rhgwv2iuoelbl@flea>
Message-ID: <CAGb2v65rE2nQbyeiSPAyTzw-n-EQsUwQABx3nrvXTu4JogFPBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 3:19 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Hi,
>
> On Thu, Jul 12, 2018 at 11:02:25AM +0800, Chen-Yu Tsai wrote:
>> The eMMC controller is also a new timing mode controller, but it doesn't
>> have the timing mode switch. It does however have signal delay and
>> calibration controls, typical of Allwinner MMC controllers that support
>> the new timing mode.
>>
>> Enable the new timing mode setting for the A64 eMMC controller. This
>> also enables MMC HS-DDR modes, which gives higher throughput for eMMC
>> chips that support it, and can deliver such throughput.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> That doesn't look right. The datasheet explicitly mentions that this
> bit doesn't apply to the eMMC controller, and the BSP is doing the same:
> https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-1.c
>
> vs
> https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-2.c

You mean the bit in SDXC_REG_SD_NTSR? Yes I know that doesn't exist for
the eMMC controller. I mentioned this in the commit message. It doesn't
exist, and writes to it become a no-op.

Would a comment, or comments, help with making this clear?

> And I definitely remember having HS-DDR working back when I added the
> a64 eMMC support.

Well it doesn't at the moment. My BPI-M64 reports:

    [    1.634276] mmc2: new high speed MMC card at address 0001

And with the patch:

    [    1.632552] mmc2: new DDR MMC card at address 0001

Regards
ChenYu
