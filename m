From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 14 Nov 2014 16:00:30 +0800
Subject: [PATCH v2 0/3] ARM: mediatek: Add driver for Mediatek I2C
 controller
In-Reply-To: <1415934752.2152.58.camel@mhfsdcap03>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
 <20141113183122.GH1275@katana>  <1415934752.2152.58.camel@mhfsdcap03>
Message-ID: <1415952030.17958.129.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-11-14 at 11:12 +0800, xudong chen wrote:
> On Thu, 2014-11-13 at 19:31 +0100, Wolfram Sang wrote:
> > > MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> > > registers in MT8135 side.
> > 
> > I still didn't get this, even after reading the mail thread of old
> > series. Can someone maybe draw me a nice ASCII picture showing the setup
> > which is going on here?
> > 
> 
> 1. The DIR_PATH register is in MT8135.
> 2. All the registers used in the driver are in MT8135.
> 3. If want I2C wave go/from PMIC need to set the DIR_PATH register bit^0
> to 1 extra.

Hi,

Some supplemental, I hope this make it more clear.

    +---------------+
    |     MT8135    |
    |               |
    |    +----------|
    |    |I2C       |___SDA
    |    |controller|___SCL
    |    +----------|
    |               |      +-------+
    |    +----------|      | MT6397|
    |    |  pwrap   |      |       |___SDA_pmic
    |    |          |<---->|       |___SCL_pmic
    +---------------+      +-------+

This is the simplified block diagram of mt8135 and mt6397. MT8135 can
works with MTK PMIC MT6397. On MT8135, it use pwrap module to control
/communicate with the PMIC. Pwrap is a hardware communicate with pmic
through MTK proprietary interface.

There are several PMIC functionality that is controlled by registers
and controllers on MT8135, I2C is one of them.

On MT8135, I2C controller can control I2C pins on MT8135 and MT6397.
When you set I2C DIR_PATH register on MT8135, i2c controller will
control PMIC pins(through pwrap) to send i2c signal. Because the
i2c controllers are on 8135, it can still do DMA from system memory.
So it kinds of like these 2 works like a virtual SoC.

Joe.C
