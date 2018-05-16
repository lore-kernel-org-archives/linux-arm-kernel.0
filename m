From: tfiga@chromium.org (Tomasz Figa)
Date: Thu, 17 May 2018 00:15:41 +0900
Subject: [PATCH v6 04/17] media: rkisp1: add Rockchip MIPI Synopsys DPHY
 driver
In-Reply-To: <CAFLEztTsPdR9mjj7uu+0dUpUecUx=bLRBRcfue06Gy5YdrgGDA@mail.gmail.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <20180308094807.9443-5-jacob-chen@iotwrt.com>
 <18647985.GIavVuIZz4@avalon>
 <CAFLEztRY0xSScE51uvUtS89PqE_bNjkMfzBeTQTPyKd6asfPEQ@mail.gmail.com>
 <CAFLEztTsPdR9mjj7uu+0dUpUecUx=bLRBRcfue06Gy5YdrgGDA@mail.gmail.com>
Message-ID: <CAAFQd5C6deXgEj5+oH41g+4Yqre2RMq9m+efZ40M_7Eks=X8ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

On Wed, May 16, 2018 at 11:54 PM Jacob Chen <jacobchen110@gmail.com> wrote:

> 2018-05-16 22:39 GMT+08:00 Jacob Chen <jacobchen110@gmail.com>:
> > Hi Laurent,
> >
> > 2018-05-16 13:20 GMT+08:00 Laurent Pinchart <
laurent.pinchart@ideasonboard.com>:
> >> Hi Jacob,
> >>
> >> Thank you for the patch.
> >>
> >> On Thursday, 8 March 2018 11:47:54 EEST Jacob Chen wrote:
> >>> From: Jacob Chen <jacob2.chen@rock-chips.com>
> >>>
> >>> This commit adds a subdev driver for Rockchip MIPI Synopsys DPHY
driver
> >>
> >> Should this really be a subdev driver ? After a quick look at the
code, the
> >> only parameters you need to configure the PHY is the number of lanes
and the
> >> data rate. Implementing the whole subdev API seems overcomplicated to
me,
> >> especially given that the D-PHY doesn't deal with video streams as
such, but
> >> operates one level down. Shouldn't we model the D-PHY using the Linux
PHY
> >> framework ? I believe all the features you need are there except for a
D-PHY-
> >> specific configuration function that should be very easy to add.
> >>
> >
> > It deserves a subdev driver since the ISP is not the only user.
> > Other driver, like VIP, use it too.
> >
> >

> For example, if there are two sensors connected to a rk3399 board.

> Sensor1 --> DPHY1
> Sensor2 --> DPHY2

> With a subdev phy driver, i can choose either ISP or VIP for
> sensor1/sensor2 by enable/disable media link in the run time.
> 1.
> Sensor1 --> DPHY1 ---> VIP
> Sensor2 --> DPHY2 ---> ISP1
> 2.
> Sensor1 --> DPHY1 ---> ISP1
> Sensor2 --> DPHY2 ---> VIP


What is VIP?

Also, if we model the DPHY using the PHY interface, it will be still
possible to achieve the same, just by toggling the link between sensor and
VIP or ISP1:

1.

Sensor1 -------|~|--- VIP
         \             | (PHY interface)
          \           DPHY1
           \           | (PHY interface)
            \---| |-- ISP1

Sensor2 -------| |-- VIP
         \             | (PHY interface)
          \           DPHY2
           \           | (PHY interface)
            \---|~|-- ISP1

2.

Sensor1 -------| |-- VIP
         \             | (PHY interface)
          \           DPHY1
           \           | (PHY interface)
            \---|~|-- ISP1

Sensor2 -------|~|-- VIP
         \             | (PHY interface)
          \           DPHY2
           \           | (PHY interface)
            \---| |-- ISP1

Best regards,
Tomasz
