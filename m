From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 13 Nov 2014 12:32:18 +0100
Subject: [PATCH] can: Fix bug in suspend/resume
In-Reply-To: <9455da2b86c74d5aafe9bf118edec7bb@BN1AFFO11FD045.protection.gbl>
References: <a44efc1fb0144cca9d0c4851cc51db25@BL2FFO11FD024.protection.gbl>
 <546484D9.4030005@pengutronix.de> <54648BF4.60007@pengutronix.de>
 <9455da2b86c74d5aafe9bf118edec7bb@BN1AFFO11FD045.protection.gbl>
Message-ID: <20141113123218.79850236@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Appana Durga Kedareswara Rao wrote:
> Hi Marc,
> 
> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
> Sent: Thursday, November 13, 2014 4:16 PM
> To: Appana Durga Kedareswara Rao; wg at grandegger.com; Michal Simek; Soren Brinkmann; grant.likely at linaro.org; robh+dt at kernel.org
> Cc: linux-can at vger.kernel.org; netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Appana Durga Kedareswara Rao
> Subject: Re: [PATCH] can: Fix bug in suspend/resume
> 
> On 11/13/2014 11:15 AM, Marc Kleine-Budde wrote:
> > On 11/13/2014 07:58 AM, Kedareswara rao Appana wrote:
> >> When accessing the priv structure use container_of instead of dev_get_drvdata.
> >
> > Why?
> 
> The drvdata here is the struct net_device, not the platform device.
> Please state this in the commit message.
> 
> If I understand the code correct, you can make use of the existing helper function to_platform_device():
> 
> http://lxr.free-electrons.com/source/include/linux/platform_device.h#L42
> 
> Thanks for the suggestion.
>  Will use this macro(to_platform_device)  .
> 
> >
> >> Enable the clocks in the suspend before accessing the registers of the CAN.
> >>
> >> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> >> ---
> >>  drivers/net/can/xilinx_can.c |   20 ++++++++++++++++++--
> >>  1 files changed, 18 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/can/xilinx_can.c
> >> b/drivers/net/can/xilinx_can.c index 5e8b560..63ef645 100644
> >> --- a/drivers/net/can/xilinx_can.c
> >> +++ b/drivers/net/can/xilinx_can.c
> >> @@ -972,15 +972,30 @@ static const struct net_device_ops xcan_netdev_ops = {
> >>   */
> >>  static int __maybe_unused xcan_suspend(struct device *dev)  {
> >> -    struct platform_device *pdev = dev_get_drvdata(dev);
> >> +    struct platform_device *pdev = container_of(dev,
> >> +                    struct platform_device, dev);
> >>      struct net_device *ndev = platform_get_drvdata(pdev);
> >>      struct xcan_priv *priv = netdev_priv(ndev);
>
Why not simply:
	struct net_device *ndev = dev_get_drvdata(dev);

There is no need for a struct platform_device* at all.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
