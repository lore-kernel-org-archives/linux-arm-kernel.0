From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 1 Nov 2018 15:53:36 +0800
Subject: [PATCH 5/7] arm64: allwinner: h6: Add RTC node
In-Reply-To: <CAMty3ZAW5KndyJj81obK49MKczdbk4SoUncmiiE_OhH1g7qFUA@mail.gmail.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-5-jagan@amarulasolutions.com>
 <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
 <CAMty3ZAW5KndyJj81obK49MKczdbk4SoUncmiiE_OhH1g7qFUA@mail.gmail.com>
Message-ID: <CAGb2v67WZmG7qPqf_UoR4v=Zm2AbS8pcOQsWJPRVHr-i2NvRPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 3:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Nov 1, 2018 at 8:25 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > From: Jagan Teki <jagan@openedev.com>
> > >
> > > RTC controller is similar to A31, so use the same compatible
> > > for H6 and update interrupt numbers as per manual.
> >
> > No. Unfortunately they are not that compatible. The A31 does not have
> > the RTC clock output. So everyone got it wrong. :( Plus the clock rate
> > of the internal RC oscillator varies between SoCs. I'm working on a
> > series of patches to correct this. Stay tuned.
>
> 4 bit, EXT_LOSC_EN of LOSC_CTRL_REG (0x00) seem available in H6. I can
> see external clock working with WIFI for A31 compatible.

That bit turns on the external crystal, i.e. X32KIN and X32KOUT pins.

I'm talking about the X32KFOUT pin, which feeds the WiFi module the
LPO clock in typical Allwinner designs. That is controlled by register
0x60, and is not present on the A31. That is the clock you say is
working. You have the two confused.

The clock tree looks like this:

IOSC -----------------------------\
                                   SUN6I_LOSC_CTRL_EXT_OSC mux ---->
LOSC --> (to CCU)
32k crystal --> EXT_LOSC_EN gate -/                              \
                                                                  \
                                                                  /
      (to WiFi) <-- X32KFOUT pin <-- LOSC_OUT_GATING_EN gate <---/

The bottom part does not exist in the A31. Meanwhile we've been claiming that
all later RTC modules that actually have that part are compatible with the A31.
Also the IOSC part has different clock rates for different chips.

Do you see the problem?


ChenYu
