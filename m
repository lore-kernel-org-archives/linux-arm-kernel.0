From: alexg@meprolight.com (Alex Gershgorin)
Date: Thu, 8 Mar 2012 13:16:50 +0200
Subject: I.MX35 PDK
In-Reply-To: <CAOMZO5DnP7+zupy9vwBPS0+2XtKM1+nLbwCqBzuCqEG5OWbZRQ@mail.gmail.com>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CBD666A28@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Thanks for you response...

> in spite of this I get from ov2640 driver error
> Here Linux Kernel boot message:
>
> "Linux video capture interface: v2.00
> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
> mx3-camera mx3-camera.0: MX3 Camera driver attached to camera 0
> ov2640 0-0030: Product ID error fb:fb"
>
> I cannot understand what the problem is, if someone tested this?

>>Looks like a I2C issue.

>>Check the I2C1 pad settings in the mainline kernel.

>>On FSL kernel we have:

#<<define PAD_CONFIG (PAD_CTL_HYS_SCHMITZ | PAD_CTL_PKE_ENABLE |
>>PAD_CTL_PUE_PUD | PAD_CTL_ODE_OpenDrain)

	<<switch (i2c_num) {
	<<case 0:
		<<mxc_request_iomux(MX35_PIN_I2C1_CLK, MUX_CONFIG_SION);
		<<mxc_request_iomux(MX35_PIN_I2C1_DAT, MUX_CONFIG_SION);

		<<mxc_iomux_set_pad(MX35_PIN_I2C1_CLK, PAD_CONFIG);
		<<mxc_iomux_set_pad(MX35_PIN_I2C1_DAT, PAD_CONFIG);

>>Also check if you are getting the proper voltage levels at the I2C1 lines.

Yes this I2C problem, all I2C slave device need response to Host CPU by pulls I2C data bus to low, in other words generate ACK, the clock pulse for the acknowledge bit is always created by the bus master.

In this case, the camera tries to reset the data bus and generate an ACK, but the voltage drops to the area of two volts, although it should be reset to zero.
I replaced R172 with 10K on CPU board and got a good result, but there are other surprises 

Linux video capture interface: v2.00
soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
mx3-camera mx3-camera.0: MX3 Camera driver attached to camera 0
ov2640 0-0030: ov2640 Product ID 26:42 Manufacturer ID 7f:a2
i2c i2c-0: OV2640 Probed
mx3-camera mx3-camera.0: MX3 Camera driver detached from camera 0
dmaengine: failed to get dma1chan0: (-22)
dmaengine: failed to get dma1chan1: (-22)
dmaengine: failed to get dma1chan2: (-22)
dmaengine: failed to get dma1chan3: (-22)
dmaengine: failed to get dma1chan4: (-22)
dmaengine: failed to get dma1chan5: (-22)
dmaengine: failed to get dma1chan6: (-22)
dmaengine: failed to get dma1chan7: (-22)
dmaengine: failed to get dma1chan8: (-22)
dmaengine: failed to get dma1chan9: (-22)
dmaengine: failed to get dma1chan10: (-22)
dmaengine: failed to get dma1chan11: (-22)
dmaengine: failed to get dma1chan12: (-22)
dmaengine: failed to get dma1chan13: (-22)
dmaengine: failed to get dma1chan14: (-22)
dmaengine: failed to get dma1chan15: (-22)
dmaengine: failed to get dma1chan16: (-22)
dmaengine: failed to get dma1chan17: (-22)
dmaengine: failed to get dma1chan18: (-22)
dmaengine: failed to get dma1chan19: (-22)
dmaengine: failed to get dma1chan20: (-22)
dmaengine: failed to get dma1chan21: (-22)
dmaengine: failed to get dma1chan22: (-22)
dmaengine: failed to get dma1chan23: (-22)
dmaengine: failed to get dma1chan24: (-22)
dmaengine: failed to get dma1chan25: (-22)
dmaengine: failed to get dma1chan26: (-22)
dmaengine: failed to get dma1chan27: (-22)
dmaengine: failed to get dma1chan28: (-22)
dmaengine: failed to get dma1chan29: (-22)
dmaengine: failed to get dma1chan30: (-22):


What is the problem? 
Guennadi please help me understand 

Thanks,
 
Alex Gershgorin
