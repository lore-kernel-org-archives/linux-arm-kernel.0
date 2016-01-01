From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 01 Jan 2016 23:10:54 +0100
Subject: [RESEND PATCH v1 4/4] clk: rockchip: rk3036: fix and add node id
 for emac clock
In-Reply-To: <5681F121.3070307@rock-chips.com>
References: <1451293433-32392-1-git-send-email-zhengxing@rock-chips.com>
 <5681E8E4.2010303@rock-chips.com> <5681F121.3070307@rock-chips.com>
Message-ID: <1562268.fb58QJ4jV7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

Am Dienstag, 29. Dezember 2015, 10:34:09 schrieb Xing Zheng:
> On 2015?12?29? 09:59, Yakir Yang wrote:
> > On 12/28/2015 08:41 PM, Heiko St?bner wrote:
> >> Am Montag, 28. Dezember 2015, 17:03:53 schrieb Xing Zheng:
> >>> Due to referred old version TRM, there is incorrect emac clock node,
> >>> we should fix it. The SEL_21_9 is the parent of SEL_21_4.
> >>> 
> >>> In the emac driver, we need to refer HCLK_MAC, and because There are
> >>> only 3PLLs (APLL/GPLL/DPLL) on the rk3036, most clock are under the
> >>> GPLL, and it is unable to provide the accurate rate for mac_ref which
> >>> need to 50MHz probability, we should let it under the APLL and are
> >>> able to set the freq which integer multiples of 50MHz, so we add these
> >>> emac node for reference.
> >> 
> >> I don't really follow here. While I do understand that the emac needs
> >> 50MHz, I
> >> don't think using the APLL as source is helpful.
> >> 
> >> The APLL is the main clocksource for the cpu-cores, including frequency
> >> scaling, and while it currently only lists 816MHz as sole frequency,
> >> you're
> >> pretty much guaranteed to not get your correct multiple of 50MHz from
> >> there
> >> either. And limiting the cpu to just do 600MHz to get the mac working
> >> sounds
> >> pretty bad ;-) .
> >> 
> >> 
> >> In the rk3036 cru-node the gpll gets set to 594MHz. Is there a
> >> special reason
> >> why it needs to be 594MHz and cannot be a round 600MHz? Because that
> >> would
> >> also provide your 50MHz-multiple nicely.
> > 
> > Yes, this magic 594MHz would help to support the standard HDMI
> > resolutions, here are the math:
> > 
> > 1920x1080-60Hz DCLK = 148.5MHz = 594MHz / 4
> > 1280x720-60Hz DCLK = 74.25MHz = 594MHz / 8
> > 720x480-60Hz DCLK = 27MHz = 594MHz / 22
> > 
> > Thanks,
> > - Yakir
> 
> Thanks Yakir.
> 
> Hi Heiko,
>  From the above, do you have better idea for the RK3036's emac without
> ext-oscillator?

During the last days I did play a bit with the clock framework. As I don't 
have a Kylin (or any rk3036) board, I did build a test-case with pclk_cpu on 
the rk3188 (which can be affected by the armclk if not reparented to the 
gpll), which got sucessfully adapted to get back to (or near) the originally 
requested frequency.

So ideally you could roll back your mux/div split here and try the attached 
diff. In theory it should help :-) .
As can be seen by the FIXMEs, not fully finished, but I'd like to determine if 
it fixes the issue at least.


Heiko
-------------- next part --------------
A non-text attachment was scrubbed...
Name: clk-keep-req-rate.diff
Type: text/x-patch
Size: 2997 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160101/1db1687e/attachment-0001.bin>
