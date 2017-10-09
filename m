From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 9 Oct 2017 19:05:14 +0200
Subject: [RFC 1/2] ARM: dts: exynos: update the usbdrd phy and ref clk
In-Reply-To: <CANAwSgRX0FJ0piYd_T_FeUpKP=Dg5sCjhAH+7r_=JUvS-CNONQ@mail.gmail.com>
References: <1507264595-3565-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPe=hd7QdsaqpqPv3cNvL59FBqCfy24mYmGdQvi7Yp8wBQ@mail.gmail.com>
 <CANAwSgRK+F62xKFeFM9ZJ_rgPWj831ca=tX9BSKXUyRBhN4yhA@mail.gmail.com>
 <20171008154759.moic645jwrp7nztg@kozik-lap>
 <CANAwSgRX0FJ0piYd_T_FeUpKP=Dg5sCjhAH+7r_=JUvS-CNONQ@mail.gmail.com>
Message-ID: <20171009170514.saqrbv7rmjdkghkp@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 02:36:13AM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> On 8 October 2017 at 21:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Sun, Oct 08, 2017 at 06:06:19PM +0530, Anand Moon wrote:
> >> Hi Krzysztof,
> >>
> >> On 6 October 2017 at 12:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> > On Fri, Oct 6, 2017 at 6:36 AM, Anand Moon <linux.amoon@gmail.com> wrote:
> >> >> update the usbdrd link control and phy contol clks.
> >> >
> >> > The commit title and especially commit message should explain why you
> >> > are doing this and what are you doing. "Update" is not enough.
> >> > Everything could be called update.
> >> >
> >> > Therefore I do not understand the reason behind the patch.
> >> >
> >> > BR,
> >> > Krzysztof
> >>
> >> so as per the driver.
> >> @clk: phy clock for register access
> >> @ref_clk: reference clock to PHY block from which PHY's operational
> >> clocks are derived
> >>
> >> Both CLK_SCLK_USBPHY300 and CLK_SCLK_USBD300 belong to FSYS Clock
> >> and CLK_USBD300 clk is being used by the usbdrd dwc3 module.
> >>
> >> [0] https://github.com/torvalds/linux/blob/master/drivers/clk/samsung/clk-exynos5420.c#L1040-L1053
> >>
> >> So their is mismatch of the clk used by the usbdrd driver.
> >
> > Where is the mismatch? I do not understand.
> >
> >> with the above changes the driver work well with camera and disk drives
> >> connected to usb 3.0 ports and their is improvement in the performance.
> >
> > If something is not working now, please describe it exactly so we could
> > both reproduce and then observe the end results of fix.
> >
> > I do not understand how the change of these clocks brings improvement in
> > performance... ok, sometimes it might happen if the rate of clock is
> > being used on bus. Is this the case?
> >
> > Best regards,
> > Krzysztof
> >
> [snip]
> 
> As per Exynos5422 CMU
> 
> CLK_SCLK_USBPHY300 and CLK_SCLK_USBD300 are special clk meant to
> control the usbdrd
> 
> CLK_SCLK_USBPHY300/1 is used for phy control
> CLK_SCLK_USBD300/1 is used for link control.
> 
> Following link share the details of the CMU_TOP
> [0] https://imgur.com/9OKaXEM

... and? Unfortunately this does not explain the problem to me.

> 
> On Odroid cloudshell module with old hard disk it time to time do reset of hub.
> on heavy traffic of data.
> 
> [46953.765974] usb 4-1.1: reset SuperSpeed USB device number 3 using xhci-hcd
> [47006.851310] usb 4-1.1: reset SuperSpeed USB device number 3 using xhci-hcd
> 
> [  730.078441] sd 1:0:0:0: [sdb] tag#5 CDB: opcode=0x2a 2a 00 26 b6 58
> 80 00 00 80 00
> [  730.078471] sd 1:0:0:0: [sdb] tag#6 uas_zap_pending 0 uas-tag 7 inflight: CMD
> [  730.078498] sd 1:0:0:0: [sdb] tag#6 CDB: opcode=0x28 28 00 00 00 20
> 00 00 04 00 00
> [  730.161071] usb 4-1.2: reset SuperSpeed USB device number 4 using xhci-hcd
> [  730.187194] scsi host1: uas_eh_bus_reset_handler success
> 
> At some time it work stable but eventfully their is loss of data.

Thanks for the error log. You still did not say it explicitly so I am
guessing: do you mean that these errors are the effect of disabled clock?

Maybe try to explain in simple sentences:
1. What is the visible problem.
2. How to reproduce it (you partially mentioned this here - Odroid
   cloudshell with some disk)
3. What is the reason behind the problem.
4. How this patch fixes the reason behind (thus fixing the visible
   problem).

> 
> On 3.10.x
> It clk gate is tuned to support CLK_GATE_MULTI_BIT_SET, I am not sure
> how this will apply on 4.x kernel
> 
> [1] https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/drivers/clk/samsung/clk-exynos5422.c#L1771-L1777

Me neither.

Best regards,
Krzysztof
