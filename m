From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 15 Jun 2017 13:01:22 +0530
Subject: [PATCH v3 1/9] ARM: dts: imx6ul-isiot: Add Sound card with codec
 node
In-Reply-To: <20170615071529.GC5902@dragon>
References: <1491501735-1649-1-git-send-email-jagan@openedev.com>
 <1491501735-1649-2-git-send-email-jagan@openedev.com>
 <20170407131649.GH16503@dragon>
 <CAMty3ZDj3XgeZwUTXTTX2svoXaNWJ3GJtbNAt9+jj+n8Z4640w@mail.gmail.com>
 <20170615022024.GE30112@dragon>
 <CAMty3ZAUK37JYnPwVRuBA6B67QV+S_BYQ6f=k6_rjw__ypTxBg@mail.gmail.com>
 <20170615071529.GC5902@dragon>
Message-ID: <CAMty3ZCwkP=EaFcSdA--yQNN9ebjE9JptfwWjQpceXqDq-xkyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, Jun 15, 2017 at 12:45 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Jun 15, 2017 at 10:21:43AM +0530, Jagan Teki wrote:
>> On Thu, Jun 15, 2017 at 7:50 AM, Shawn Guo <shawnguo@kernel.org> wrote:
>> > On Wed, Jun 14, 2017 at 08:17:04PM +0530, Jagan Teki wrote:
>> >> On Fri, Apr 7, 2017 at 6:46 PM, Shawn Guo <shawnguo@kernel.org> wrote:
>> >> > On Thu, Apr 06, 2017 at 11:32:07PM +0530, Jagan Teki wrote:
>> >> >> From: Jagan Teki <jagan@amarulasolutions.com>
>> >> >>
>> >> >> Add support for Sound card and related codec(via i2c1) nodes
>> >> >> on Engicam Is.IoT MX6UL variant module boards.
>> >> >>
>> >> >> Cc: Shawn Guo <shawnguo@kernel.org>
>> >> >> Cc: Matteo Lisi <matteo.lisi@engicam.com>
>> >> >> Cc: Michael Trimarchi <michael@amarulasolutions.com>
>> >> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> >> >> ---
>> >> >> Changes for v3:
>> >> >> - Replace fsl,imx-audio-sgtl5000 and use simple-audio-card
>> >> >> Changes for v2:
>> >> >> - Use proper [label:] node-name[@unit-address] for codec
>> >> >> - Remove incorrect codec property 'wlf,shared-lrclk'
>> >> >> - Remove 'gpr' from sound card node
>> >> >>
>> >> >>  arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 10 +++++++
>> >> >>  arch/arm/boot/dts/imx6ul-isiot.dtsi        | 44 ++++++++++++++++++++++++++++++
>> >> >
>> >> > Can you help me understand how these two files are related?  Why is
>> >> > sgtl5000 added into one and sound node added into the other?
>> >>
>> >> lcdif, ts and sound card which may differ based on the base-board
>> >> connected with SOM, So I moved these stuff which are related to
>> >> Starter kit supported once's and used with SOM dts files. if some
>> >> other board with same SOM can have different lcdif and etc so they can
>> >> define locally to dts.
>> >
>> > I do not follow how these stuff are organized.  So far we have the
>> > following isiot dts files.
>> >
>> >  - imx6ul-isiot-common.dtsi
>> >  - imx6ul-isiot.dtsi
>> >  - imx6ul-isiot-emmc.dts and imx6ul-isiot-nand.dts
>> >
>> > How are they mapping to SoM and base-board?
>>
>> isiot is a modules class, with that emmc and nand are two separate
>> SOM's. the current support is for mounting these SOM's on Development
>> base board[1]. So, for isiot module class we have imx6ul-isiot.dtsi
>> and emmc and nand SOM's have imx6ul-isiot-emmc.dts and
>> imx6ul-isiot-nand.dts. There are some Carrier boards[1] which were
>> used with different lcdif and other changes, So
>> imx6ul-isiot-common.dtsi have changes common across emmc and nand,
>> instead of adding them into individual dts files I moved in
>> -common.dtsi.  So in future if isiot SOM mounted on carrier board
>> which should have a separate dts and which may or may not use
>> imx6ul-isiot-common.dtsi
>
> So you are not sure if imx6ul-isiot-common.dtsi will be used by carrier
> board.  Then what's the point to have it now?
>
> You are saying imx6ul-isiot-common.dtsi is created to accommodate the
> common things across emmc and nand SoMs, but it actually contains LCD
> and Touch such base-board level of stuff.  Confusing.
>
> I feel the abstraction is wrong from the beginning.  Ideally, we should
> have something like below.
>
>  - imx6ul-isiot.dtsi
>  - imx6ul-isiot-kit.dts and imx6ul-isiot-carrier.dts
>
> The -isiot should have everything on SoM and common stuff between -kit
> and -carrier boards, while -kit and -carrier include -isiot and contains
> the base-board specific things.  The -isiot can have both emmc and nand
> devices with "disabled" status, and let firmware turn device on per SoM
> it boots.  In that case, the abstraction level can be less and clearer.
>
> Thoughts?

So,even the common stuff (lcdif, ts and etc) should be in -isiot.dtsi
and make it "disabled" and let them enabled on respective dts. this
what you mentioned here?

thank!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
