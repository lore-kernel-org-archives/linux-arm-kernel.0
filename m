From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Nov 2013 15:37:08 +0000
Subject: [PATCH 2/4] mfd: rtsx: Generify the switch voltage routine
In-Reply-To: <52858DF6.7010800@realsil.com.cn>
References: <1384421355-4434-1-git-send-email-lee.jones@linaro.org>
 <1384421355-4434-3-git-send-email-lee.jones@linaro.org>
 <52858DF6.7010800@realsil.com.cn>
Message-ID: <20131115153708.GE4996@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Switch output voltage may have some problem here.
> 1. modify params of function in pcr_ops may affect other chips, like
> rts52xx, and we may add other registers or value in the future, just
> add params may not enough to handle this case. So I think different
> chip should use a different function here, and modify the function
> will not affect others.

Okay, I agree to a certain extent. I'll drop this patch for now.

Can you please try to find a way to consolidate them. I'm really not
keen on keeping 6 functions around that are mostly identical.

> 2. rtl8402 has another difference with 8411 here, it doesn't use
>  BPP_ASIC_1V8, but use BPP_ASIC_2V0.
> 
> so, I will send another patch to fix this problem.
> 
> >-static int rtl8411_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
> >+static int rtl84xx_switch_output_voltage(struct rtsx_pcr *pcr,
> >+					 u8 voltage, int shift)
> >  {
> >  	u8 mask, val;
> >  	int err;
> >-	mask = (BPP_REG_TUNED18 << BPP_TUNED18_SHIFT_8411) | BPP_PAD_MASK;
> >+	mask = (BPP_REG_TUNED18 << shift) | BPP_PAD_MASK;
> >  	if (voltage == OUTPUT_3V3) {
> >  		err = rtsx_pci_write_register(pcr,
> >  				SD30_DRIVE_SEL, 0x07, pcr->sd30_drive_sel_3v3);
> >  		if (err < 0)
> >  			return err;
> >-		val = (BPP_ASIC_3V3 << BPP_TUNED18_SHIFT_8411) | BPP_PAD_3V3;
> >+		val = (BPP_ASIC_3V3 << shift) | BPP_PAD_3V3;
> >  	} else if (voltage == OUTPUT_1V8) {
> >  		err = rtsx_pci_write_register(pcr,
> >  				SD30_DRIVE_SEL, 0x07, pcr->sd30_drive_sel_1v8);
> >  		if (err < 0)
> >  			return err;
> >-		val = (BPP_ASIC_1V8 << BPP_TUNED18_SHIFT_8411) | BPP_PAD_1V8;
> >+		val = (BPP_ASIC_1V8 << shift) | BPP_PAD_1V8;
> >  	} else {
> >  		return -EINVAL;
> >  	}
> 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
