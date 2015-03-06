From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 6 Mar 2015 10:54:32 +0000
Subject: [PATCH 16/27] mfd: ab8500-debugfs: Remove use of seq_printf
 return value
In-Reply-To: <077b4778e5b1267b8e41b0ec764050f2092e476d.1424573328.git.joe@perches.com>
References: <cover.1424573328.git.joe@perches.com>
 <077b4778e5b1267b8e41b0ec764050f2092e476d.1424573328.git.joe@perches.com>
Message-ID: <20150306105432.GB3318@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 21 Feb 2015, Joe Perches wrote:

> The seq_printf return value, because it's frequently misused,
> will eventually be converted to void.
> 
> See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
>      seq_has_overflowed() and make public")

I'm not a fan of mixing functional patches with clean-ups, but I'm in
a particually good mood today (it must be Firday).

Applied, thanks.

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/mfd/ab8500-debugfs.c | 196 ++++++++++++++++++++++++++-----------------
>  1 file changed, 121 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
> index 9a8e185..cdd6f3d 100644
> --- a/drivers/mfd/ab8500-debugfs.c
> +++ b/drivers/mfd/ab8500-debugfs.c
> @@ -1283,7 +1283,7 @@ static irqreturn_t ab8500_debug_handler(int irq, void *data)
>  
>  /* Prints to seq_file or log_buf */
>  static int ab8500_registers_print(struct device *dev, u32 bank,
> -				struct seq_file *s)
> +				  struct seq_file *s)
>  {
>  	unsigned int i;
>  
> @@ -1304,20 +1304,19 @@ static int ab8500_registers_print(struct device *dev, u32 bank,
>  			}
>  
>  			if (s) {
> -				err = seq_printf(s,
> -						 "  [0x%02X/0x%02X]: 0x%02X\n",
> -						 bank, reg, value);
> -				if (err < 0) {
> -					/* Error is not returned here since
> -					 * the output is wanted in any case */
> +				seq_printf(s, "  [0x%02X/0x%02X]: 0x%02X\n",
> +					   bank, reg, value);
> +				/* Error is not returned here since
> +				 * the output is wanted in any case */
> +				if (seq_has_overflowed(s))
>  					return 0;
> -				}
>  			} else {
>  				dev_info(dev, " [0x%02X/0x%02X]: 0x%02X\n",
>  					 bank, reg, value);
>  			}
>  		}
>  	}
> +
>  	return 0;
>  }
>  
> @@ -1330,8 +1329,7 @@ static int ab8500_print_bank_registers(struct seq_file *s, void *p)
>  
>  	seq_printf(s, " bank 0x%02X:\n", bank);
>  
> -	ab8500_registers_print(dev, bank, s);
> -	return 0;
> +	return ab8500_registers_print(dev, bank, s);
>  }
>  
>  static int ab8500_registers_open(struct inode *inode, struct file *file)
> @@ -1355,9 +1353,12 @@ static int ab8500_print_all_banks(struct seq_file *s, void *p)
>  	seq_puts(s, AB8500_NAME_STRING " register values:\n");
>  
>  	for (i = 0; i < AB8500_NUM_BANKS; i++) {
> -		seq_printf(s, " bank 0x%02X:\n", i);
> +		int err;
>  
> -		ab8500_registers_print(dev, i, s);
> +		seq_printf(s, " bank 0x%02X:\n", i);
> +		err = ab8500_registers_print(dev, i, s);
> +		if (err)
> +			return err;
>  	}
>  	return 0;
>  }
> @@ -1458,7 +1459,8 @@ static const struct file_operations ab8500_all_banks_fops = {
>  
>  static int ab8500_bank_print(struct seq_file *s, void *p)
>  {
> -	return seq_printf(s, "0x%02X\n", debug_bank);
> +	seq_printf(s, "0x%02X\n", debug_bank);
> +	return 0;
>  }
>  
>  static int ab8500_bank_open(struct inode *inode, struct file *file)
> @@ -1490,7 +1492,8 @@ static ssize_t ab8500_bank_write(struct file *file,
>  
>  static int ab8500_address_print(struct seq_file *s, void *p)
>  {
> -	return seq_printf(s, "0x%02X\n", debug_address);
> +	seq_printf(s, "0x%02X\n", debug_address);
> +	return 0;
>  }
>  
>  static int ab8500_address_open(struct inode *inode, struct file *file)
> @@ -1598,7 +1601,8 @@ static int ab8500_interrupts_print(struct seq_file *s, void *p)
>  	for (line = 0; line < num_interrupt_lines; line++) {
>  		struct irq_desc *desc = irq_to_desc(line + irq_first);
>  
> -		seq_printf(s, "%3i:  %6i %4i", line,
> +		seq_printf(s, "%3i:  %6i %4i",
> +			   line,
>  			   num_interrupts[line],
>  			   num_wake_interrupts[line]);
>  
> @@ -1705,8 +1709,7 @@ static int ab8500_print_modem_registers(struct seq_file *s, void *p)
>  			dev_err(dev, "ab->read fail %d\n", err);
>  			return err;
>  		}
> -		err = seq_printf(s, "  [0x%02X/0x%02X]: 0x%02X\n",
> -			bank, reg, value);
> +		seq_printf(s, "  [0x%02X/0x%02X]: 0x%02X\n", bank, reg, value);
>  	}
>  	err = abx500_set_register_interruptible(dev,
>  		AB8500_REGU_CTRL1, AB8500_SUPPLY_CONTROL_REG, orig_value);
> @@ -1743,8 +1746,9 @@ static int ab8500_gpadc_bat_ctrl_print(struct seq_file *s, void *p)
>  	bat_ctrl_convert = ab8500_gpadc_ad_to_voltage(gpadc,
>  		BAT_CTRL, bat_ctrl_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		bat_ctrl_convert, bat_ctrl_raw);
> +	seq_printf(s, "%d,0x%X\n", bat_ctrl_convert, bat_ctrl_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_bat_ctrl_open(struct inode *inode, struct file *file)
> @@ -1773,8 +1777,9 @@ static int ab8500_gpadc_btemp_ball_print(struct seq_file *s, void *p)
>  	btemp_ball_convert = ab8500_gpadc_ad_to_voltage(gpadc, BTEMP_BALL,
>  		btemp_ball_raw);
>  
> -	return seq_printf(s,
> -		"%d,0x%X\n", btemp_ball_convert, btemp_ball_raw);
> +	seq_printf(s, "%d,0x%X\n", btemp_ball_convert, btemp_ball_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_btemp_ball_open(struct inode *inode,
> @@ -1804,8 +1809,9 @@ static int ab8500_gpadc_main_charger_v_print(struct seq_file *s, void *p)
>  	main_charger_v_convert = ab8500_gpadc_ad_to_voltage(gpadc,
>  		MAIN_CHARGER_V, main_charger_v_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -			main_charger_v_convert, main_charger_v_raw);
> +	seq_printf(s, "%d,0x%X\n", main_charger_v_convert, main_charger_v_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_main_charger_v_open(struct inode *inode,
> @@ -1835,8 +1841,9 @@ static int ab8500_gpadc_acc_detect1_print(struct seq_file *s, void *p)
>  	acc_detect1_convert = ab8500_gpadc_ad_to_voltage(gpadc, ACC_DETECT1,
>  		acc_detect1_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		acc_detect1_convert, acc_detect1_raw);
> +	seq_printf(s, "%d,0x%X\n", acc_detect1_convert, acc_detect1_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_acc_detect1_open(struct inode *inode,
> @@ -1866,8 +1873,9 @@ static int ab8500_gpadc_acc_detect2_print(struct seq_file *s, void *p)
>  	acc_detect2_convert = ab8500_gpadc_ad_to_voltage(gpadc,
>  		ACC_DETECT2, acc_detect2_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		acc_detect2_convert, acc_detect2_raw);
> +	seq_printf(s, "%d,0x%X\n", acc_detect2_convert, acc_detect2_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_acc_detect2_open(struct inode *inode,
> @@ -1897,8 +1905,9 @@ static int ab8500_gpadc_aux1_print(struct seq_file *s, void *p)
>  	aux1_convert = ab8500_gpadc_ad_to_voltage(gpadc, ADC_AUX1,
>  		aux1_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		aux1_convert, aux1_raw);
> +	seq_printf(s, "%d,0x%X\n", aux1_convert, aux1_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_aux1_open(struct inode *inode, struct file *file)
> @@ -1926,8 +1935,9 @@ static int ab8500_gpadc_aux2_print(struct seq_file *s, void *p)
>  	aux2_convert = ab8500_gpadc_ad_to_voltage(gpadc, ADC_AUX2,
>  		aux2_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -			aux2_convert, aux2_raw);
> +	seq_printf(s, "%d,0x%X\n", aux2_convert, aux2_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_aux2_open(struct inode *inode, struct file *file)
> @@ -1955,8 +1965,9 @@ static int ab8500_gpadc_main_bat_v_print(struct seq_file *s, void *p)
>  	main_bat_v_convert = ab8500_gpadc_ad_to_voltage(gpadc, MAIN_BAT_V,
>  		main_bat_v_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		main_bat_v_convert, main_bat_v_raw);
> +	seq_printf(s, "%d,0x%X\n", main_bat_v_convert, main_bat_v_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_main_bat_v_open(struct inode *inode,
> @@ -1986,8 +1997,9 @@ static int ab8500_gpadc_vbus_v_print(struct seq_file *s, void *p)
>  	vbus_v_convert = ab8500_gpadc_ad_to_voltage(gpadc, VBUS_V,
>  		vbus_v_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		vbus_v_convert, vbus_v_raw);
> +	seq_printf(s, "%d,0x%X\n", vbus_v_convert, vbus_v_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_vbus_v_open(struct inode *inode, struct file *file)
> @@ -2015,8 +2027,9 @@ static int ab8500_gpadc_main_charger_c_print(struct seq_file *s, void *p)
>  	main_charger_c_convert = ab8500_gpadc_ad_to_voltage(gpadc,
>  		MAIN_CHARGER_C, main_charger_c_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		main_charger_c_convert, main_charger_c_raw);
> +	seq_printf(s, "%d,0x%X\n", main_charger_c_convert, main_charger_c_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_main_charger_c_open(struct inode *inode,
> @@ -2046,8 +2059,9 @@ static int ab8500_gpadc_usb_charger_c_print(struct seq_file *s, void *p)
>  	usb_charger_c_convert = ab8500_gpadc_ad_to_voltage(gpadc,
>  		USB_CHARGER_C, usb_charger_c_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		usb_charger_c_convert, usb_charger_c_raw);
> +	seq_printf(s, "%d,0x%X\n", usb_charger_c_convert, usb_charger_c_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_usb_charger_c_open(struct inode *inode,
> @@ -2077,8 +2091,9 @@ static int ab8500_gpadc_bk_bat_v_print(struct seq_file *s, void *p)
>  	bk_bat_v_convert = ab8500_gpadc_ad_to_voltage(gpadc,
>  		BK_BAT_V, bk_bat_v_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		bk_bat_v_convert, bk_bat_v_raw);
> +	seq_printf(s, "%d,0x%X\n", bk_bat_v_convert, bk_bat_v_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_bk_bat_v_open(struct inode *inode, struct file *file)
> @@ -2107,8 +2122,9 @@ static int ab8500_gpadc_die_temp_print(struct seq_file *s, void *p)
>  	die_temp_convert = ab8500_gpadc_ad_to_voltage(gpadc, DIE_TEMP,
>  		die_temp_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		die_temp_convert, die_temp_raw);
> +	seq_printf(s, "%d,0x%X\n", die_temp_convert, die_temp_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_die_temp_open(struct inode *inode, struct file *file)
> @@ -2137,8 +2153,9 @@ static int ab8500_gpadc_usb_id_print(struct seq_file *s, void *p)
>  	usb_id_convert = ab8500_gpadc_ad_to_voltage(gpadc, USB_ID,
>  		usb_id_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		usb_id_convert, usb_id_raw);
> +	seq_printf(s, "%d,0x%X\n", usb_id_convert, usb_id_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_usb_id_open(struct inode *inode, struct file *file)
> @@ -2166,8 +2183,9 @@ static int ab8540_gpadc_xtal_temp_print(struct seq_file *s, void *p)
>  	xtal_temp_convert = ab8500_gpadc_ad_to_voltage(gpadc, XTAL_TEMP,
>  		xtal_temp_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		xtal_temp_convert, xtal_temp_raw);
> +	seq_printf(s, "%d,0x%X\n", xtal_temp_convert, xtal_temp_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8540_gpadc_xtal_temp_open(struct inode *inode, struct file *file)
> @@ -2197,8 +2215,9 @@ static int ab8540_gpadc_vbat_true_meas_print(struct seq_file *s, void *p)
>  		ab8500_gpadc_ad_to_voltage(gpadc, VBAT_TRUE_MEAS,
>  					   vbat_true_meas_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n",
> -		vbat_true_meas_convert, vbat_true_meas_raw);
> +	seq_printf(s, "%d,0x%X\n", vbat_true_meas_convert, vbat_true_meas_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8540_gpadc_vbat_true_meas_open(struct inode *inode,
> @@ -2233,9 +2252,13 @@ static int ab8540_gpadc_bat_ctrl_and_ibat_print(struct seq_file *s, void *p)
>  	ibat_convert = ab8500_gpadc_ad_to_voltage(gpadc, IBAT_VIRTUAL_CHANNEL,
>  		ibat_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n"  "%d,0x%X\n",
> -		bat_ctrl_convert, bat_ctrl_raw,
> -		ibat_convert, ibat_raw);
> +	seq_printf(s,
> +		   "%d,0x%X\n"
> +		   "%d,0x%X\n",
> +		   bat_ctrl_convert, bat_ctrl_raw,
> +		   ibat_convert, ibat_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8540_gpadc_bat_ctrl_and_ibat_open(struct inode *inode,
> @@ -2269,9 +2292,13 @@ static int ab8540_gpadc_vbat_meas_and_ibat_print(struct seq_file *s, void *p)
>  	ibat_convert = ab8500_gpadc_ad_to_voltage(gpadc, IBAT_VIRTUAL_CHANNEL,
>  		ibat_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n"  "%d,0x%X\n",
> -		vbat_meas_convert, vbat_meas_raw,
> -		ibat_convert, ibat_raw);
> +	seq_printf(s,
> +		   "%d,0x%X\n"
> +		   "%d,0x%X\n",
> +		   vbat_meas_convert, vbat_meas_raw,
> +		   ibat_convert, ibat_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8540_gpadc_vbat_meas_and_ibat_open(struct inode *inode,
> @@ -2307,9 +2334,13 @@ static int ab8540_gpadc_vbat_true_meas_and_ibat_print(struct seq_file *s,
>  	ibat_convert = ab8500_gpadc_ad_to_voltage(gpadc, IBAT_VIRTUAL_CHANNEL,
>  		ibat_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n"  "%d,0x%X\n",
> -		vbat_true_meas_convert, vbat_true_meas_raw,
> -		ibat_convert, ibat_raw);
> +	seq_printf(s,
> +		   "%d,0x%X\n"
> +		   "%d,0x%X\n",
> +		   vbat_true_meas_convert, vbat_true_meas_raw,
> +		   ibat_convert, ibat_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8540_gpadc_vbat_true_meas_and_ibat_open(struct inode *inode,
> @@ -2344,9 +2375,13 @@ static int ab8540_gpadc_bat_temp_and_ibat_print(struct seq_file *s, void *p)
>  	ibat_convert = ab8500_gpadc_ad_to_voltage(gpadc, IBAT_VIRTUAL_CHANNEL,
>  		ibat_raw);
>  
> -	return seq_printf(s, "%d,0x%X\n"  "%d,0x%X\n",
> -		bat_temp_convert, bat_temp_raw,
> -		ibat_convert, ibat_raw);
> +	seq_printf(s,
> +		   "%d,0x%X\n"
> +		   "%d,0x%X\n",
> +		   bat_temp_convert, bat_temp_raw,
> +		   ibat_convert, ibat_raw);
> +
> +	return 0;
>  }
>  
>  static int ab8540_gpadc_bat_temp_and_ibat_open(struct inode *inode,
> @@ -2373,16 +2408,19 @@ static int ab8540_gpadc_otp_cal_print(struct seq_file *s, void *p)
>  	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
>  	ab8540_gpadc_get_otp(gpadc, &vmain_l, &vmain_h, &btemp_l, &btemp_h,
>  			&vbat_l, &vbat_h, &ibat_l, &ibat_h);
> -	return seq_printf(s, "VMAIN_L:0x%X\n"
> -			  "VMAIN_H:0x%X\n"
> -			  "BTEMP_L:0x%X\n"
> -			  "BTEMP_H:0x%X\n"
> -			  "VBAT_L:0x%X\n"
> -			  "VBAT_H:0x%X\n"
> -			  "IBAT_L:0x%X\n"
> -			  "IBAT_H:0x%X\n",
> -			  vmain_l, vmain_h, btemp_l, btemp_h,
> -			  vbat_l, vbat_h, ibat_l, ibat_h);
> +	seq_printf(s,
> +		   "VMAIN_L:0x%X\n"
> +		   "VMAIN_H:0x%X\n"
> +		   "BTEMP_L:0x%X\n"
> +		   "BTEMP_H:0x%X\n"
> +		   "VBAT_L:0x%X\n"
> +		   "VBAT_H:0x%X\n"
> +		   "IBAT_L:0x%X\n"
> +		   "IBAT_H:0x%X\n",
> +		   vmain_l, vmain_h, btemp_l, btemp_h,
> +		   vbat_l, vbat_h, ibat_l, ibat_h);
> +
> +	return 0;
>  }
>  
>  static int ab8540_gpadc_otp_cal_open(struct inode *inode, struct file *file)
> @@ -2400,7 +2438,9 @@ static const struct file_operations ab8540_gpadc_otp_calib_fops = {
>  
>  static int ab8500_gpadc_avg_sample_print(struct seq_file *s, void *p)
>  {
> -	return seq_printf(s, "%d\n", avg_sample);
> +	seq_printf(s, "%d\n", avg_sample);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_avg_sample_open(struct inode *inode, struct file *file)
> @@ -2445,7 +2485,9 @@ static const struct file_operations ab8500_gpadc_avg_sample_fops = {
>  
>  static int ab8500_gpadc_trig_edge_print(struct seq_file *s, void *p)
>  {
> -	return seq_printf(s, "%d\n", trig_edge);
> +	seq_printf(s, "%d\n", trig_edge);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_trig_edge_open(struct inode *inode, struct file *file)
> @@ -2490,7 +2532,9 @@ static const struct file_operations ab8500_gpadc_trig_edge_fops = {
>  
>  static int ab8500_gpadc_trig_timer_print(struct seq_file *s, void *p)
>  {
> -	return seq_printf(s, "%d\n", trig_timer);
> +	seq_printf(s, "%d\n", trig_timer);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_trig_timer_open(struct inode *inode, struct file *file)
> @@ -2533,7 +2577,9 @@ static const struct file_operations ab8500_gpadc_trig_timer_fops = {
>  
>  static int ab8500_gpadc_conv_type_print(struct seq_file *s, void *p)
>  {
> -	return seq_printf(s, "%d\n", conv_type);
> +	seq_printf(s, "%d\n", conv_type);
> +
> +	return 0;
>  }
>  
>  static int ab8500_gpadc_conv_type_open(struct inode *inode, struct file *file)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
