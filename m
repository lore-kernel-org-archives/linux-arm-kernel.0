From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 10 Jul 2013 15:09:17 +0800
Subject: [PATCH] ARM: dts: imx: add tempmon node for imx6q thermal support
In-Reply-To: <51DC256D.6040204@denx.de>
References: <1370330008-5982-1-git-send-email-shawn.guo@linaro.org>
 <1370330226-6030-1-git-send-email-shawn.guo@linaro.org>
 <51DC256D.6040204@denx.de>
Message-ID: <20130710070915.GA12605@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On Tue, Jul 09, 2013 at 04:59:57PM +0200, Stefano Babic wrote:
> > -			ocotp at 021bc000 {
> > -				compatible = "fsl,imx6q-ocotp";
> > +			ocotp: ocotp at 021bc000 {
> > +				compatible = "fsl,imx6q-ocotp", "syscon";
> >  				reg = <0x021bc000 0x4000>;
> 
> Sorry to check this very late - is ocotp at 021bc000 the right address for
> the thermal data ? According to User Manual (Table 62.3), the start
> address is 0x20C8180. Using your patch, by loading the driver I get :

Address 0x20C8180 is where TEMPMON control registers are - they are
embedded in ANATOP block, while calibration data is stored in OCOTP fuse
block.

> imx_thermal tempmon.7: invalid sensor calibration data
> imx_thermal tempmon.7: failed to get sensor data
> imx_thermal: probe of tempmon.7 failed with error -22

What's your chip revision?  Early revisions may not have the calibration
data.  TO1.2 should have, I think.

> The driver is loaded successfully if I changed the tempdata to point to
> 020C8180. Not sure if I get the right values from temp1_crit and
> temp1_input, but no error at the initialisation. Am I missing something ?

It reads some data but that's not calibration data, so it should not work.

Also, you need a cpu_cooling fix [1], if you want to play the thermal
patches on imx6q.

Shawn

[1] http://thread.gmane.org/gmane.linux.power-management.general/34389
