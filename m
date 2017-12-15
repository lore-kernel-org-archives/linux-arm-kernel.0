From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Dec 2017 10:54:32 +0000
Subject: [PATCH v1] mfd: ab8500: introduce DEFINE_SHOW_ATTRIBUTE() macro
In-Reply-To: <20171214105121.77015-1-andriy.shevchenko@linux.intel.com>
References: <20171214105121.77015-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20171215105432.pm36mtles7mpvcye@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

> This macro deduplicates a lot of similar code in the ab8500-debugfs.c module.
> Targeting to be moved to seq_file.h eventually.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/ab8500-debugfs.c | 406 +++++++------------------------------------
>  1 file changed, 62 insertions(+), 344 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
> index 7eaa3493a828..f66c458228ec 100644
> --- a/drivers/mfd/ab8500-debugfs.c
> +++ b/drivers/mfd/ab8500-debugfs.c
> @@ -1258,6 +1258,19 @@ static struct ab8500_prcmu_ranges ab8540_debug_ranges[AB8500_NUM_BANKS] = {
>  	},
>  };
>  
> +#define DEFINE_SHOW_ATTRIBUTE(__name)					      \
> +static int __name ## _open(struct inode *inode, struct file *file)	      \
> +{									      \
> +	return single_open(file, __name ## _show, inode->i_private);	      \
> +}									      \
> +									      \
> +static const struct file_operations __name ## _fops = {			      \
> +	.owner		= THIS_MODULE,					      \
> +	.open		= __name ## _open,				      \
> +	.read		= seq_read,					      \
> +	.llseek		= seq_lseek,					      \
> +	.release	= single_release,				      \
> +}									      \
>  
>  static irqreturn_t ab8500_debug_handler(int irq, void *data)
>  {
> @@ -1318,7 +1331,7 @@ static int ab8500_registers_print(struct device *dev, u32 bank,
>  	return 0;
>  }
>  
> -static int ab8500_print_bank_registers(struct seq_file *s, void *p)
> +static int ab8500_bank_registers_show(struct seq_file *s, void *p)
>  {
>  	struct device *dev = s->private;
>  	u32 bank = debug_bank;
> @@ -1330,18 +1343,7 @@ static int ab8500_print_bank_registers(struct seq_file *s, void *p)
>  	return ab8500_registers_print(dev, bank, s);
>  }
>  
> -static int ab8500_registers_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_print_bank_registers, inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_registers_fops = {
> -	.open = ab8500_registers_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8500_bank_registers);
>  
>  static int ab8500_print_all_banks(struct seq_file *s, void *p)
>  {
> @@ -1528,7 +1530,7 @@ void ab8500_debug_register_interrupt(int line)
>  		num_interrupts[line]++;
>  }
>  
> -static int ab8500_interrupts_print(struct seq_file *s, void *p)
> +static int ab8500_interrupts_show(struct seq_file *s, void *p)
>  {
>  	int line;
>  
> @@ -1557,10 +1559,7 @@ static int ab8500_interrupts_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_interrupts_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_interrupts_print, inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8500_interrupts);
>  
>  /*
>   * - HWREG DB8500 formated routines
> @@ -1603,7 +1602,7 @@ static int ab8500_hwreg_open(struct inode *inode, struct file *file)
>  #define AB8500_LAST_SIM_REG 0x8B
>  #define AB8505_LAST_SIM_REG 0x8C
>  
> -static int ab8500_print_modem_registers(struct seq_file *s, void *p)
> +static int ab8500_modem_show(struct seq_file *s, void *p)
>  {
>  	struct device *dev = s->private;
>  	struct ab8500 *ab8500;
> @@ -1659,21 +1658,9 @@ static int ab8500_print_modem_registers(struct seq_file *s, void *p)
>  	return err;
>  }
>  
> -static int ab8500_modem_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_print_modem_registers,
> -			   inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_modem_fops = {
> -	.open = ab8500_modem_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8500_modem);
>  
> -static int ab8500_gpadc_bat_ctrl_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_bat_ctrl_show(struct seq_file *s, void *p)
>  {
>  	int bat_ctrl_raw;
>  	int bat_ctrl_convert;
> @@ -1690,21 +1677,9 @@ static int ab8500_gpadc_bat_ctrl_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_bat_ctrl_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_bat_ctrl_print,
> -			   inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_bat_ctrl_fops = {
> -	.open = ab8500_gpadc_bat_ctrl_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_bat_ctrl);
>  
> -static int ab8500_gpadc_btemp_ball_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_btemp_ball_show(struct seq_file *s, void *p)
>  {
>  	int btemp_ball_raw;
>  	int btemp_ball_convert;
> @@ -1721,22 +1696,9 @@ static int ab8500_gpadc_btemp_ball_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_btemp_ball_open(struct inode *inode,
> -					struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_btemp_ball_print,
> -			   inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_btemp_ball);
>  
> -static const struct file_operations ab8500_gpadc_btemp_ball_fops = {
> -	.open = ab8500_gpadc_btemp_ball_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_main_charger_v_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_main_charger_v_show(struct seq_file *s, void *p)
>  {
>  	int main_charger_v_raw;
>  	int main_charger_v_convert;
> @@ -1753,22 +1715,9 @@ static int ab8500_gpadc_main_charger_v_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_main_charger_v_open(struct inode *inode,
> -					    struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_main_charger_v_print,
> -		inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_main_charger_v);
>  
> -static const struct file_operations ab8500_gpadc_main_charger_v_fops = {
> -	.open = ab8500_gpadc_main_charger_v_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_acc_detect1_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_acc_detect1_show(struct seq_file *s, void *p)
>  {
>  	int acc_detect1_raw;
>  	int acc_detect1_convert;
> @@ -1785,22 +1734,9 @@ static int ab8500_gpadc_acc_detect1_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_acc_detect1_open(struct inode *inode,
> -					 struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_acc_detect1_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_acc_detect1_fops = {
> -	.open = ab8500_gpadc_acc_detect1_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_acc_detect1);
>  
> -static int ab8500_gpadc_acc_detect2_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_acc_detect2_show(struct seq_file *s, void *p)
>  {
>  	int acc_detect2_raw;
>  	int acc_detect2_convert;
> @@ -1817,22 +1753,9 @@ static int ab8500_gpadc_acc_detect2_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_acc_detect2_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_acc_detect2_print,
> -		inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_acc_detect2);
>  
> -static const struct file_operations ab8500_gpadc_acc_detect2_fops = {
> -	.open = ab8500_gpadc_acc_detect2_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_aux1_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_aux1_show(struct seq_file *s, void *p)
>  {
>  	int aux1_raw;
>  	int aux1_convert;
> @@ -1849,20 +1772,9 @@ static int ab8500_gpadc_aux1_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_aux1_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_aux1_print, inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_aux1_fops = {
> -	.open = ab8500_gpadc_aux1_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_aux1);
>  
> -static int ab8500_gpadc_aux2_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_aux2_show(struct seq_file *s, void *p)
>  {
>  	int aux2_raw;
>  	int aux2_convert;
> @@ -1879,20 +1791,9 @@ static int ab8500_gpadc_aux2_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_aux2_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_aux2_print, inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_aux2_fops = {
> -	.open = ab8500_gpadc_aux2_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_aux2);
>  
> -static int ab8500_gpadc_main_bat_v_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_main_bat_v_show(struct seq_file *s, void *p)
>  {
>  	int main_bat_v_raw;
>  	int main_bat_v_convert;
> @@ -1909,22 +1810,9 @@ static int ab8500_gpadc_main_bat_v_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_main_bat_v_open(struct inode *inode,
> -					struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_main_bat_v_print,
> -			   inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_main_bat_v);
>  
> -static const struct file_operations ab8500_gpadc_main_bat_v_fops = {
> -	.open = ab8500_gpadc_main_bat_v_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_vbus_v_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_vbus_v_show(struct seq_file *s, void *p)
>  {
>  	int vbus_v_raw;
>  	int vbus_v_convert;
> @@ -1941,20 +1829,9 @@ static int ab8500_gpadc_vbus_v_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_vbus_v_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_vbus_v_print, inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_vbus_v);
>  
> -static const struct file_operations ab8500_gpadc_vbus_v_fops = {
> -	.open = ab8500_gpadc_vbus_v_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_main_charger_c_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_main_charger_c_show(struct seq_file *s, void *p)
>  {
>  	int main_charger_c_raw;
>  	int main_charger_c_convert;
> @@ -1971,22 +1848,9 @@ static int ab8500_gpadc_main_charger_c_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_main_charger_c_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_main_charger_c_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_main_charger_c_fops = {
> -	.open = ab8500_gpadc_main_charger_c_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_main_charger_c);
>  
> -static int ab8500_gpadc_usb_charger_c_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_usb_charger_c_show(struct seq_file *s, void *p)
>  {
>  	int usb_charger_c_raw;
>  	int usb_charger_c_convert;
> @@ -2003,22 +1867,9 @@ static int ab8500_gpadc_usb_charger_c_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_usb_charger_c_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_usb_charger_c_print,
> -		inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_usb_charger_c);
>  
> -static const struct file_operations ab8500_gpadc_usb_charger_c_fops = {
> -	.open = ab8500_gpadc_usb_charger_c_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_bk_bat_v_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_bk_bat_v_show(struct seq_file *s, void *p)
>  {
>  	int bk_bat_v_raw;
>  	int bk_bat_v_convert;
> @@ -2035,21 +1886,9 @@ static int ab8500_gpadc_bk_bat_v_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_bk_bat_v_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_bk_bat_v_print,
> -			   inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_bk_bat_v_fops = {
> -	.open = ab8500_gpadc_bk_bat_v_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_bk_bat_v);
>  
> -static int ab8500_gpadc_die_temp_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_die_temp_show(struct seq_file *s, void *p)
>  {
>  	int die_temp_raw;
>  	int die_temp_convert;
> @@ -2066,21 +1905,9 @@ static int ab8500_gpadc_die_temp_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_die_temp_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_die_temp_print,
> -			   inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_die_temp);
>  
> -static const struct file_operations ab8500_gpadc_die_temp_fops = {
> -	.open = ab8500_gpadc_die_temp_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8500_gpadc_usb_id_print(struct seq_file *s, void *p)
> +static int ab8500_gpadc_usb_id_show(struct seq_file *s, void *p)
>  {
>  	int usb_id_raw;
>  	int usb_id_convert;
> @@ -2097,20 +1924,9 @@ static int ab8500_gpadc_usb_id_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8500_gpadc_usb_id_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8500_gpadc_usb_id_print, inode->i_private);
> -}
> -
> -static const struct file_operations ab8500_gpadc_usb_id_fops = {
> -	.open = ab8500_gpadc_usb_id_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8500_gpadc_usb_id);
>  
> -static int ab8540_gpadc_xtal_temp_print(struct seq_file *s, void *p)
> +static int ab8540_gpadc_xtal_temp_show(struct seq_file *s, void *p)
>  {
>  	int xtal_temp_raw;
>  	int xtal_temp_convert;
> @@ -2127,21 +1943,9 @@ static int ab8540_gpadc_xtal_temp_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8540_gpadc_xtal_temp_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_xtal_temp_print,
> -		inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8540_gpadc_xtal_temp);
>  
> -static const struct file_operations ab8540_gpadc_xtal_temp_fops = {
> -	.open = ab8540_gpadc_xtal_temp_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_vbat_true_meas_print(struct seq_file *s, void *p)
> +static int ab8540_gpadc_vbat_true_meas_show(struct seq_file *s, void *p)
>  {
>  	int vbat_true_meas_raw;
>  	int vbat_true_meas_convert;
> @@ -2159,22 +1963,9 @@ static int ab8540_gpadc_vbat_true_meas_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8540_gpadc_vbat_true_meas_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_vbat_true_meas_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations ab8540_gpadc_vbat_true_meas_fops = {
> -	.open = ab8540_gpadc_vbat_true_meas_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8540_gpadc_vbat_true_meas);
>  
> -static int ab8540_gpadc_bat_ctrl_and_ibat_print(struct seq_file *s, void *p)
> +static int ab8540_gpadc_bat_ctrl_and_ibat_show(struct seq_file *s, void *p)
>  {
>  	int bat_ctrl_raw;
>  	int bat_ctrl_convert;
> @@ -2200,22 +1991,9 @@ static int ab8540_gpadc_bat_ctrl_and_ibat_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8540_gpadc_bat_ctrl_and_ibat_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_bat_ctrl_and_ibat_print,
> -		inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8540_gpadc_bat_ctrl_and_ibat);
>  
> -static const struct file_operations ab8540_gpadc_bat_ctrl_and_ibat_fops = {
> -	.open = ab8540_gpadc_bat_ctrl_and_ibat_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_vbat_meas_and_ibat_print(struct seq_file *s, void *p)
> +static int ab8540_gpadc_vbat_meas_and_ibat_show(struct seq_file *s, void *p)
>  {
>  	int vbat_meas_raw;
>  	int vbat_meas_convert;
> @@ -2240,23 +2018,9 @@ static int ab8540_gpadc_vbat_meas_and_ibat_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8540_gpadc_vbat_meas_and_ibat_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_vbat_meas_and_ibat_print,
> -		inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8540_gpadc_vbat_meas_and_ibat);
>  
> -static const struct file_operations ab8540_gpadc_vbat_meas_and_ibat_fops = {
> -	.open = ab8540_gpadc_vbat_meas_and_ibat_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_vbat_true_meas_and_ibat_print(struct seq_file *s,
> -						      void *p)
> +static int ab8540_gpadc_vbat_true_meas_and_ibat_show(struct seq_file *s, void *p)
>  {
>  	int vbat_true_meas_raw;
>  	int vbat_true_meas_convert;
> @@ -2282,23 +2046,9 @@ static int ab8540_gpadc_vbat_true_meas_and_ibat_print(struct seq_file *s,
>  	return 0;
>  }
>  
> -static int ab8540_gpadc_vbat_true_meas_and_ibat_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_vbat_true_meas_and_ibat_print,
> -		inode->i_private);
> -}
> -
> -static const struct file_operations
> -ab8540_gpadc_vbat_true_meas_and_ibat_fops = {
> -	.open = ab8540_gpadc_vbat_true_meas_and_ibat_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8540_gpadc_vbat_true_meas_and_ibat);
>  
> -static int ab8540_gpadc_bat_temp_and_ibat_print(struct seq_file *s, void *p)
> +static int ab8540_gpadc_bat_temp_and_ibat_show(struct seq_file *s, void *p)
>  {
>  	int bat_temp_raw;
>  	int bat_temp_convert;
> @@ -2323,22 +2073,9 @@ static int ab8540_gpadc_bat_temp_and_ibat_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8540_gpadc_bat_temp_and_ibat_open(struct inode *inode,
> -		struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_bat_temp_and_ibat_print,
> -		inode->i_private);
> -}
> +DEFINE_SHOW_ATTRIBUTE(ab8540_gpadc_bat_temp_and_ibat);
>  
> -static const struct file_operations ab8540_gpadc_bat_temp_and_ibat_fops = {
> -	.open = ab8540_gpadc_bat_temp_and_ibat_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
> -static int ab8540_gpadc_otp_cal_print(struct seq_file *s, void *p)
> +static int ab8540_gpadc_otp_calib_show(struct seq_file *s, void *p)
>  {
>  	struct ab8500_gpadc *gpadc;
>  	u16 vmain_l, vmain_h, btemp_l, btemp_h;
> @@ -2362,18 +2099,7 @@ static int ab8540_gpadc_otp_cal_print(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int ab8540_gpadc_otp_cal_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ab8540_gpadc_otp_cal_print, inode->i_private);
> -}
> -
> -static const struct file_operations ab8540_gpadc_otp_calib_fops = {
> -	.open = ab8540_gpadc_otp_cal_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ab8540_gpadc_otp_calib);
>  
>  static int ab8500_gpadc_avg_sample_print(struct seq_file *s, void *p)
>  {
> @@ -2906,14 +2632,6 @@ static const struct file_operations ab8500_val_fops = {
>  	.owner = THIS_MODULE,
>  };
>  
> -static const struct file_operations ab8500_interrupts_fops = {
> -	.open = ab8500_interrupts_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.owner = THIS_MODULE,
> -};
> -
>  static const struct file_operations ab8500_subscribe_fops = {
>  	.open = ab8500_subscribe_unsubscribe_open,
>  	.write = ab8500_subscribe_write,
> @@ -3000,7 +2718,7 @@ static int ab8500_debug_probe(struct platform_device *plf)
>  		goto err;
>  
>  	file = debugfs_create_file("all-bank-registers", S_IRUGO, ab8500_dir,
> -				   &plf->dev, &ab8500_registers_fops);
> +				   &plf->dev, &ab8500_bank_registers_fops);
>  	if (!file)
>  		goto err;
>  

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
