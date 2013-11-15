From: micky_ching@realsil.com.cn (micky)
Date: Fri, 15 Nov 2013 10:59:02 +0800
Subject: [PATCH 2/4] mfd: rtsx: Generify the switch voltage routine
In-Reply-To: <1384421355-4434-3-git-send-email-lee.jones@linaro.org>
References: <1384421355-4434-1-git-send-email-lee.jones@linaro.org>
 <1384421355-4434-3-git-send-email-lee.jones@linaro.org>
Message-ID: <52858DF6.7010800@realsil.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee

Thank you for your work.

Switch output voltage may have some problem here.
1. modify params of function in pcr_ops may affect other chips, like
rts52xx, and we may add other registers or value in the future, just
add params may not enough to handle this case. So I think different
chip should use a different function here, and modify the function
will not affect others.

2. rtl8402 has another difference with 8411 here, it doesn't use
  BPP_ASIC_1V8, but use BPP_ASIC_2V0.

so, I will send another patch to fix this problem.

> -static int rtl8411_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
> +static int rtl84xx_switch_output_voltage(struct rtsx_pcr *pcr,
> +					 u8 voltage, int shift)
>   {
>   	u8 mask, val;
>   	int err;
>   
> -	mask = (BPP_REG_TUNED18 << BPP_TUNED18_SHIFT_8411) | BPP_PAD_MASK;
> +	mask = (BPP_REG_TUNED18 << shift) | BPP_PAD_MASK;
>   	if (voltage == OUTPUT_3V3) {
>   		err = rtsx_pci_write_register(pcr,
>   				SD30_DRIVE_SEL, 0x07, pcr->sd30_drive_sel_3v3);
>   		if (err < 0)
>   			return err;
> -		val = (BPP_ASIC_3V3 << BPP_TUNED18_SHIFT_8411) | BPP_PAD_3V3;
> +		val = (BPP_ASIC_3V3 << shift) | BPP_PAD_3V3;
>   	} else if (voltage == OUTPUT_1V8) {
>   		err = rtsx_pci_write_register(pcr,
>   				SD30_DRIVE_SEL, 0x07, pcr->sd30_drive_sel_1v8);
>   		if (err < 0)
>   			return err;
> -		val = (BPP_ASIC_1V8 << BPP_TUNED18_SHIFT_8411) | BPP_PAD_1V8;
> +		val = (BPP_ASIC_1V8 << shift) | BPP_PAD_1V8;
>   	} else {
>   		return -EINVAL;
>   	}


-- 
Best Regards
Micky.
