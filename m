From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 5 Nov 2014 09:03:50 -0800
Subject: [PATCH 0/7] Pinctrl support for Zynq
In-Reply-To: <5459BC1C.3000807@suse.de>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <5459BC1C.3000807@suse.de>
Message-ID: <44de30f0237545c6b62871d6c0480a67@BY2FFO11FD050.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-11-05 at 06:56AM +0100, Andreas F?rber wrote:
> Hi S?ren,
> 
> Am 03.11.2014 um 20:05 schrieb Soren Brinkmann:
> > Soren Brinkmann (7):
> >   pinctrl: pinconf-generic: Declare dt_params/conf_items const
> >   pinctrl: pinconf-generic: Infer map type from DT property
> >   pinctrl: pinconf-generic: Allow driver to specify DT params
> >   pinctrl: zynq: Document DT binding
> >   pinctrl: Add driver for Zynq
> >   ARM: zynq: Enable pinctrl
> >   ARM: zynq: DT: Add pinctrl information
> 
> Thanks for your work on this,
> 
> Tested-by: Andreas F?rber <afaerber@suse.de>

Thanks for testing.

> 
> I've tracked down all 54 MIO pins of the Parallella and cooked up the
> equivalent DT patch. QSPI and USB still seem to be missing drivers
> upstream; I reused the SPI driver for the QSPI with pinctrl and
> Punnaiah's chipidea driver (not fully working) without pinctrl for lack
> of group/function definitions. For testing purposes I've configured a
> heartbeat trigger for the USER_LED (CR10).
> 
> To my disappointment these pinctrl additions did not fix one issue:
> Whenever a write access to be handled by the bitstream (0x808f0f04) is
> performed, the board hangs and the heartbeat stops. Would a bug in the
> bitstream allow this to happen, or are more drivers missing to actually
> make use of the PL in general? With a downstream ADI/Xilinx 3.12 kernel
> that problem does not surface.

This doesn't sound like being related to pinctrl at all.
Devices in the PL are just memory mapped on the AXI bus. There is
nothing needed to access those. Hangs do in most cases indicate that the
IP does not respond (properly). In my experience this is mostly caused
by 
 - level shifters not enabled
 - IP kept in reset
 - IP is clock gated
With the clock gating being the culprit in most cases. Did you check
those things?

	S?ren
