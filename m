From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 13 Dec 2013 14:50:33 +0800
Subject: [PATCH v6 15/15] usb: phy-mxs: Add sync time after controller
 clear phcd
In-Reply-To: <20131213043923.GJ867@saruman.home>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-16-git-send-email-peter.chen@freescale.com>
 <20131213043923.GJ867@saruman.home>
Message-ID: <CAL411-oMFOebQ5sEivQ9eu1-=8ayD_O8twtwoG3cO=nA9vA6Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 12:39 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Dec 13, 2013 at 09:23:45AM +0800, Peter Chen wrote:
>> After clear portsc.phcd, PHY needs 200us stable time for switch
>> 32K clock to AHB clock.
>>
>> Signed-off-by: Peter Chen <peter.chen@freescale.com>
>> ---
>>  drivers/usb/phy/phy-mxs-usb.c |   11 +++++++++++
>>  1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
>> index 885f8d9..68bd981 100644
>> --- a/drivers/usb/phy/phy-mxs-usb.c
>> +++ b/drivers/usb/phy/phy-mxs-usb.c
>> @@ -156,6 +156,15 @@ static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
>>       return mxs_phy->data == &imx6sl_phy_data;
>>  }
>>
>> +/*
>> + * PHY needs some 32K cycles to switch from 32K clock to
>> + * bus (such as AHB/AXI, etc) clock.
>> + */
>> +static void mxs_phy_clock_switch_delay(void)
>> +{
>> +     usleep_range(300, 400);
>> +}
>
> shouldn't this be handled by clk_set_parent() itself ?
>
> --

This clock switching is finished by hardware, no related clkgates are
at clock module.

-- 
BR,
Peter Chen
