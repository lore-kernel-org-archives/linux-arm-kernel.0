From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 8 Oct 2014 04:17:29 -0700
Subject: [PATCH 1/6] ARM: cygnus: Initial support for Broadcom Cygnus SoC
In-Reply-To: <20141008081112.GB5182@n2100.arm.linux.org.uk>
References: <sbranden@broadcom.com>
 <1412746025-11998-1-git-send-email-sbranden@broadcom.com>
 <1412746025-11998-2-git-send-email-sbranden@broadcom.com>
 <20141008081112.GB5182@n2100.arm.linux.org.uk>
Message-ID: <54351D49.7040104@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-10-08 01:11 AM, Russell King - ARM Linux wrote:
> On Tue, Oct 07, 2014 at 10:27:00PM -0700, Scott Branden wrote:
>> +static void __init bcm_cygnus_init(void)
>> +{
>> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> +
>> +	l2x0_of_init(0, ~0UL);
>
> Please don't explicitly call l2x0 initialisation.  Instead, set the
> appropriate l2c members here:
>
>> +DT_MACHINE_START(BCM_CYGNUS_DT, "Broadcom Cygnus SoC")
>> +	.init_machine = bcm_cygnus_init,
>> +	.map_io = debug_ll_io_init,
>> +	.dt_compat = bcm_cygnus_dt_compat,
>> +	.restart   = bcm_cygnus_restart
>> +MACHINE_END
>
> and let the core code call it at the appropriate time.  Thanks.
>
Thanks - was unaware of this functionality.  Will add .l2c_aux_val and 
.l2c_aux mask to DT_MATCHINE_START.  BUT, what happens when we need to 
add trustzone support and make SMC call to secure monitor?
