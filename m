From: xudong.chen@mediatek.com (xudong chen)
Date: Fri, 14 Nov 2014 11:12:32 +0800
Subject: [PATCH v2 0/3] ARM: mediatek: Add driver for Mediatek I2C
 controller
In-Reply-To: <20141113183122.GH1275@katana>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
 <20141113183122.GH1275@katana>
Message-ID: <1415934752.2152.58.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-11-13 at 19:31 +0100, Wolfram Sang wrote:
> > MTK I2C HW has some limitation.
> > 1. If the i2c_msg number is more than one, STOP will be issued instead of
> > RS(Repeat Start) between each message.
> > 
> > 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> > mode the Repeat Start will be issued between 2 messages.
> > In this driver if 2 messages is first write then read, the driver will
> > combine 2 messages using Write-Read mode so the RS will be issued between
> > the 2 messages.
> > Ex: W/R/R, driver will combine first W/R and then R.
> > 
> > 3. Due to HW limitation, in this version the max transfer data length is 255
> > in one message.
> 
> This looks to me more like an SMBUS controller instead of I2C. Maybe you
> should populate smbus_xfer rather than master_xfer?

This is the HW limitation, we will try to workaround this in the
separate patch.

> 
> > MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> > registers in MT8135 side.
> 
> I still didn't get this, even after reading the mail thread of old
> series. Can someone maybe draw me a nice ASCII picture showing the setup
> which is going on here?
> 

1. The DIR_PATH register is in MT8135.
2. All the registers used in the driver are in MT8135.
3. If want I2C wave go/from PMIC need to set the DIR_PATH register bit^0
to 1 extra.

>From the picture:
If MT8135 connected to PMIC(MT6397), when set the DIR_PATH register
bit^0 to 1, the HW will transfer the i2c wave from pins(SDA4_pmic &
SCL4_pmic) on MT6397 side.
If want use pins(SDA4 & SCL4) on 8135 side directly, we should set the
DIR_PATH register bit^0 to 0.

_______       ________
|      |______|       |
|      |      |  PMIC |
| 8135 |______| (6397)|___SDA4_pmic
|      |      |       |___SCL4_pmic
!______!      !_______!
  |   |
SDA4 SCL4


Thanks!
