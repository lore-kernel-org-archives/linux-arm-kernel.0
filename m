From: stf_xl@wp.pl (Stanislaw Gruszka)
Date: Mon, 13 Dec 2010 22:35:49 +0100
Subject: [PATCH v2] ide: at91_ide.c bugfix for high master clock
In-Reply-To: <1292100326-637-1-git-send-email-plyatov@gmail.com>
References: <1292100326-637-1-git-send-email-plyatov@gmail.com>
Message-ID: <20101213213549.GA2077@r2bh72.net.upc.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 11, 2010 at 11:45:26PM +0300, Igor Plyatov wrote:
> The AT91SAM9 microcontrollers with master clock higher then 105 MHz
> and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
> lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and driver
> does not detect IDE device.

The overflow happens because MSB (bit 6) is multiplied by 256.
NCS pulse length = 256*NCS_RD_PULSE[6] + NCS_RD_PULSE[5:0] clock
cycles. So NCS_RD_PULSE 0x41 gives 257 clock cycles not 65 as we
expected before. Static memory controller behaviour is undefined
when pulse length is bigger than cycle length, so things not work.

> +	u16 ncs_rd_pulse;
>  	unsigned long mode = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
>  			     AT91_SMC_BAT_SELECT;
>  
> @@ -81,19 +84,29 @@ static void set_smc_timings(const u8 chipselect, const u16 cycle,
>  	if (data_float)
>  		mode |= AT91_SMC_TDF_(data_float);
>  
> +	ncs_rd_pulse = cycle;
> +	if (ncs_rd_pulse > NCS_RD_PULSE_LIMIT) {
> +		ncs_rd_pulse = NCS_RD_PULSE_LIMIT;
> +		pr_warn(DRV_NAME ": ncs_rd_pulse limited to maximal value %d\n",
> +			ncs_rd_pulse);
> +	}

I'm fine with that fix. We can possibly still have problems with higher
frequencies, but I'm not sure if someone will use that hardware with 
faster clocks. 

Thanks
Stanislaw
