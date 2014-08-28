From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Aug 2014 10:48:23 +0200
Subject: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
In-Reply-To: <1409187562-12370-2-git-send-email-caesar.wang@rock-chips.com>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com>
 <1409187562-12370-2-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <2852853.mfRZfFVSev@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 August 2014 08:59:19 Caesar Wang wrote:
> Thermal is TS-ADC Controller module supports user-defined mode and automatic mode.
> 
> User-defined mode refers,TSADC all the control signals entirely by software
> writing to register for direct control.
> 
> Automaic mode refers to the module automatically poll TSADC output,and the results
> Were checked.
> 
> If you find that the temperature High in a period of time, an interrupt is generated
> to the processor down-measures taken;if the temperature over a period of time High,
> the resulting TSHUT gave CRU module,let it reset the entire chip, or via GPIO give PMIC.
> 
> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>

Hi Caesar,

After looking at the driver (last time I only received the patch for
the binding), I have a more general comment:

This looks like a general-purpose ADC device, not an IP block that is
specific to thermal management. The binding looks ok for that purpose
but should probably be moved into Documentation/devicetree/bindings/iio/adc/
as a minor change.

On the driver side, I believe the correct way to deal with this setup
is to split your driver into a generic drivers/iio/adc/rockchips-tsadc.c
file, and a smaller thermal driver that uses the iio in-kernel interfaces,
ideally one that is independent of the underlying hardware and can
work on any ADC implementation.

I've put the IIO maintainer on Cc in this mail, maybe Jonathan or someone
else on the linux-iio mailing list has some extra insight.

	Arnd
