From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sun, 18 Nov 2018 23:50:45 +0530
Subject: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
In-Reply-To: <eb23f0f8-0270-d4fa-2cac-5b65ee4af42c@samsung.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
 <20181026144344.27778-18-jagan@amarulasolutions.com>
 <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
 <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
 <bfe28e8d-3786-d35d-a589-abed9ee8e7d5@samsung.com>
 <CAMty3ZAWkX8YSRzFs_GS2O4+=pf68e4EuSMym+_XpCe3_4-2yw@mail.gmail.com>
 <25c24350-4acd-68b8-ef5d-75a60094f0b6@samsung.com>
 <CAMty3ZDTAiW=Lx2H4WvdsdJRYsVe1CpCJx7D0f7yANx7Lx25PA@mail.gmail.com>
 <eb23f0f8-0270-d4fa-2cac-5b65ee4af42c@samsung.com>
Message-ID: <CAMty3ZD8wOyKJ32-itxshXmNbPs-_yf-S4_AmKcV4YuVX_gHGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 1:26 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 10.11.2018 08:32, Jagan Teki wrote:
> > On Wed, Nov 7, 2018 at 2:41 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >> On 06.11.2018 19:08, Jagan Teki wrote:
> >>> On Wed, Oct 31, 2018 at 2:45 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >>>> On 31.10.2018 09:58, Chen-Yu Tsai wrote:
> >>>>> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >>>>>> On 26.10.2018 16:43, Jagan Teki wrote:
> >>>>>>> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
> >>>>>>> bridge panel, which is available on same PCB with 24-bit RGB interface.
> >>>>>>>
> >>>>>>> So, this patch adds DSI specific binding details on existing
> >>>>>>> dt-bindings file.
> >>>>>>>
> >>>>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >>>>>>> ---
> >>>>>>> Changes for v3:
> >>>>>>> - Use existing binding doc and update dsi details
> >>>>>>> Changes for v2:
> >>>>>>> - none
> >>>>>>>
> >>>>>>>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
> >>>>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> >>>>>>> index 35bc0c839f49..b7855dc7c66f 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> >>>>>>> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> >>>>>>> @@ -1,12 +1,39 @@
> >>>>>>>  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
> >>>>>>>
> >>>>>>> +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
> >>>>>>> +
> >>>>>>> +Depending on the variant, the PCB attached to the panel module either
> >>>>>>> +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> >>>>>>> +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> >>>>>>> +itself
> >>>>>> As I understand this is display board, which contains 'pure' RGB panel
> >>>>>> S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
> >>>>>> These are separate devices, just connected by vendor to simplify its
> >>>>>> assembly. Why don't you create then bridge driver for ICN6211 and RGB
> >>>>>> panel driver for S070WV20-CT16 - it looks more generic.
> >>>>>> Then you can describe both in dts and voila.
> >>>>>> Creating drivers for every combo of devices (panel + bridge), just
> >>>>>> because some vendor sells them together seems incorrect - we have
> >>>>>> devicetree for it.
> >>>>> Rob suggested this, and also the opposite: using the same
> >>>>> "bananapi,s070wv20-ct16"
> >>>>> compatible string for both types of connections, and have the driver deal with
> >>>>> detecting the bus type.
> >>>>>
> >>>>> The thing about the bridge chip is that there's no available datasheet that
> >>>>> describes all the parts of the init sequence, in fact none at all. I managed
> >>>>> to work out some bits, but the others remain a mystery and must be hard-coded
> >>>>> to match the panel. That would work against having a generic bridge driver.
> >>>> But it is common for many chips - 1st version of the driver is developed
> >>>> on one platform and it supports only one configuration, if next platform
> >>>> with the same cheap appears the driver is augmented if necessary.
> >>> At-least few of the commands from panel initialization code, the
> >>> respective opcode data values are based on panel timings and even
> >>> clock value is different in DSI. I think it look hard to try bridge
> >>> driver for these restrictions, do you have any suggestions?
> >>
> >> Where do you see an issue? Since panel is RGB it should have no
> >> initialization sequence (beside regulator/gpio power on/off), so the
> >> only thing to do is to figure out which regulators/gpios belongs to
> >> which component - with publicly available specs it should be doable.
> >>
> >> The whole initialization sequence is for the bridge, so you put it into
> >> bridge driver, for starters it can be hardcoded.
> > Yes, I understand we can move regulators/gpio setup separately and
> > though we hardcode the init sequence there is difference  in clock for
> > DSI(which I mentioned in previous mail). DSI panel can't work with
> > clock used by RGB panel-simple.
>
>
> If you mean pixel clock from timings in next patch it seems incorrect.
> Pixel clock should be always
>
> htotal * vtotal * vrefresh, in case of drm_display_mode result should be
> divided by 1000 (as .clock is in kHz).
>
> With timings provided there you have: 928*525*60 = 29232000
>
> So pixel clock should be 29232, if other timings are correct. DSI clock
> is a different thing and it is private thing of DSI bridge/panel it
> should not be exposed via drm_display_mode.

I understand your point, but in Allwinner case DSI clock which is
named in tcon block can be computed using clock value from
drm_display_mode from panel driver.

DE -> Mixer -> tcon-> MIPI <--> panel

So, for the value
- 55MHz panel clock the computed divider for DSI clock in tcon [1] is
6 which is proper and working divider
- 30MHz panel clock the computed divider for DSI clock in tcon [2] is
11 which can't work for this specific panel.

I have verified other panels, the divider value work similar to this
computation and those panels work accordingly.  but this panel case
the divider computation look weird, so we have used working and know
clock. I'm thinking since this panel is of DSI to RGB bridge, so it
may require some higher frequency to work but I've no document to
confirm the same.

Hope this information help, let me know if you have any inputs.

[1] https://paste.ubuntu.com/p/drvzfHFMtY/
[2] https://paste.ubuntu.com/p/hz29CTJY2J/
