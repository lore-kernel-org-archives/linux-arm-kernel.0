From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 27 Sep 2016 21:15:12 +0800
Subject: [PATCH 5/5] tty: amba-pl011: Add earlycon support for SBSA UART
In-Reply-To: <20160927105748.GA3847@kroah.com>
References: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
 <1474708465-38958-6-git-send-email-wangkefeng.wang@huawei.com>
 <20160927105748.GA3847@kroah.com>
Message-ID: <281fb262-d9b8-9543-e35e-5db41fcea5d1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/9/27 18:57, Greg Kroah-Hartman wrote:
> On Sat, Sep 24, 2016 at 05:14:25PM +0800, Kefeng Wang wrote:
>> Declare an OF early console for SBSA UART so that the early console device
>> can be specified via the "stdout-path" property in device-tree.
>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  drivers/tty/serial/amba-pl011.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 7d9b291..3688d3b 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -2330,6 +2330,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
>>  	return 0;
>>  }
>>  OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
>> +OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
> 
> Why do you need another option for the same thing?


It is used to support earlycon(without option) for sbsa-uart in bootargs.

	chosen {
		stdout-path = "serial0:115200n8";
		bootargs = "earlycon"
	};

	uart0: uart at 602b0000 {
		compatible = "arm,sbsa-uart";
		reg = <0x0 0x602b0000 0x0 0x1000>;
		...
	};

We setup a unique struct with compatible name by OF_EARLYCON_DECLARE,
#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
	static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name)	\
	     __used __section(__earlycon_table)				\
		= { .name = __stringify(_name),				\
		    .compatible = compat,				\
		    .setup = fn  }

if without this patch(see drivers/of/fdt.c),

early_init_dt_scan_chosen_serial()
 - for (match = __earlycon_table; match < __earlycon_table_end; match++)
  -- if (fdt_node_check_compatible(fdt, offset, match->compatible))
	countinue;
  -- of_setup_earlycon(match, offset, options); // will never touch here.

Thanks,
Kefeng

> 
> confused,
> 
> greg k-h
> 
> .
> 
