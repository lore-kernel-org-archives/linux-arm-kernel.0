From: rui.zhang@intel.com (Zhang, Rui)
Date: Tue, 21 Jul 2015 13:35:31 +0000
Subject: [PATCH v2] thermal: consistently use int for temperatures
In-Reply-To: <9hhk2tteqb3.fsf@e105922-lin.cambridge.arm.com>
References: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
 <9hhk2tteqb3.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <744357E9AAD1214791ACBA4B0B9092630153E699@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Punit Agrawal [mailto:punit.agrawal at arm.com]
> Sent: Tuesday, July 21, 2015 6:52 PM
> To: Sascha Hauer
> Cc: linux-pm at vger.kernel.org; Zhang, Rui; Eduardo Valentin; linux-
> kernel at vger.kernel.org; Jean Delvare; Peter Feuerer; Heiko Stuebner;
> Lukasz Majewski; Stephen Warren; Thierry Reding; linux-
> acpi at vger.kernel.org; platform-driver-x86 at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-omap at vger.kernel.org; linux-samsung-
> soc at vger.kernel.org; Guenter Roeck; Rafael J. Wysocki; Maxime Ripard;
> Darren Hart; lm-sensors at lm-sensors.org
> Subject: Re: [PATCH v2] thermal: consistently use int for temperatures
> Importance: High
> 
> Hi Sascha,
> 
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > The thermal code uses int, long and unsigned long for temperatures in
> > different places.
> >
> > Using an unsigned type limits the thermal framework to positive
> > temperatures without need. Also several drivers currently will report
> > temperatures near UINT_MAX for temperatures below 0?C. This will
> > probably immediately shut the machine down due to overtemperature if
> > started below 0?C.
> >
> > 'long' is 64bit on several architectures. This is not needed since
> > INT_MAX ?mC is above the melting point of all known materials.
> >
> > Consistently use a plain 'int' for temperatures throughout the thermal
> > code and the drivers. This only changes the places in the drivers
> > where the temperature is passed around as pointer, when drivers
> > internally use another type this is not changed.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Jean Delvare <jdelvare@suse.de>
> > Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> > Reviewed-by: Darren Hart <dvhart@linux.intel.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > Reviewed-by: Peter Feuerer <peter@piie.net>
> > Cc: Punit Agrawal <punit.agrawal@arm.com>
> 
> The changes below look good.
> 
> For the power_allocator governor and corresponding trace events,
> 
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
> 
> Thanks
> 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: linux-pm at vger.kernel.org
> > Cc: linux-kernel at vger.kernel.org
> > Cc: Jean Delvare <jdelvare@suse.de>
> > Cc: Peter Feuerer <peter@piie.net>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Lukasz Majewski <l.majewski@samsung.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: linux-acpi at vger.kernel.org
> > Cc: platform-driver-x86 at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-omap at vger.kernel.org
> > Cc: linux-samsung-soc at vger.kernel.org
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: lm-sensors at lm-sensors.org
> > ---
> >
Patch applied.

Thanks,
rui
> > changes since v1:
> > - Add missing pieces for power_allocator driver
> >
> >  drivers/acpi/thermal.c                             | 12 +++++-----
> >  drivers/hwmon/lm75.c                               |  2 +-
> >  drivers/hwmon/ntc_thermistor.c                     |  2 +-
> >  drivers/hwmon/tmp102.c                             |  2 +-
> >  drivers/input/touchscreen/sun4i-ts.c               |  8 +++----
> >  drivers/platform/x86/acerhdf.c                     |  9 ++++----
> >  drivers/platform/x86/intel_mid_thermal.c           |  9 ++++----
> >  drivers/power/power_supply_core.c                  |  2 +-
> >  drivers/thermal/armada_thermal.c                   |  2 +-
> >  drivers/thermal/db8500_thermal.c                   |  7 +++---
> >  drivers/thermal/dove_thermal.c                     |  2 +-
> >  drivers/thermal/fair_share.c                       |  2 +-
> >  drivers/thermal/gov_bang_bang.c                    |  5 ++--
> >  drivers/thermal/hisi_thermal.c                     |  4 ++--
> >  drivers/thermal/imx_thermal.c                      | 27 +++++++++++-----------
> >  drivers/thermal/int340x_thermal/int3400_thermal.c  |  2 +-
> > .../thermal/int340x_thermal/int340x_thermal_zone.c | 10 ++++----
> > .../thermal/int340x_thermal/int340x_thermal_zone.h |  8 +++----
> >  .../int340x_thermal/processor_thermal_device.c     |  4 ++--
> >  drivers/thermal/intel_quark_dts_thermal.c          | 13 +++++------
> >  drivers/thermal/intel_soc_dts_iosf.c               |  8 +++----
> >  drivers/thermal/kirkwood_thermal.c                 |  2 +-
> >  drivers/thermal/of-thermal.c                       | 14 +++++------
> >  drivers/thermal/power_allocator.c                  | 16 ++++++-------
> >  drivers/thermal/qcom-spmi-temp-alarm.c             |  2 +-
> >  drivers/thermal/rcar_thermal.c                     |  7 +++---
> >  drivers/thermal/rockchip_thermal.c                 | 10 ++++----
> >  drivers/thermal/samsung/exynos_tmu.c               | 23 +++++++++---------
> >  drivers/thermal/spear_thermal.c                    |  2 +-
> >  drivers/thermal/st/st_thermal.c                    |  5 ++--
> >  drivers/thermal/step_wise.c                        |  4 ++--
> >  drivers/thermal/tegra_soctherm.c                   |  4 ++--
> >  drivers/thermal/thermal_core.c                     | 26 ++++++++++-----------
> >  drivers/thermal/thermal_hwmon.c                    | 10 ++++----
> >  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 10 ++++----
> >  drivers/thermal/x86_pkg_temp_thermal.c             | 10 ++++----
> >  include/linux/thermal.h                            | 26 +++++++++------------
> >  include/trace/events/thermal_power_allocator.h     |  6 ++---
> >  38 files changed, 151 insertions(+), 166 deletions(-)
> >
> 
> [...]
> 
> > diff --git a/drivers/thermal/power_allocator.c
> > b/drivers/thermal/power_allocator.c
> > index 4672250..045aea59 100644
> > --- a/drivers/thermal/power_allocator.c
> > +++ b/drivers/thermal/power_allocator.c
> > @@ -92,8 +92,8 @@ struct power_allocator_params {
> >   * Return: The power budget for the next period.
> >   */
> >  static u32 pid_controller(struct thermal_zone_device *tz,
> > -			  unsigned long current_temp,
> > -			  unsigned long control_temp,
> > +			  int current_temp,
> > +			  int control_temp,
> >  			  u32 max_allocatable_power)
> >  {
> >  	s64 p, i, d, power_range;
> > @@ -102,7 +102,7 @@ static u32 pid_controller(struct
> > thermal_zone_device *tz,
> >
> >  	max_power_frac = int_to_frac(max_allocatable_power);
> >
> > -	err = ((s32)control_temp - (s32)current_temp);
> > +	err = control_temp - current_temp;
> >  	err = int_to_frac(err);
> >
> >  	/* Calculate the proportional term */ @@ -223,8 +223,8 @@ static
> > void divvy_up_power(u32 *req_power, u32 *max_power, int
> num_actors,  }
> >
> >  static int allocate_power(struct thermal_zone_device *tz,
> > -			  unsigned long current_temp,
> > -			  unsigned long control_temp)
> > +			  int current_temp,
> > +			  int control_temp)
> >  {
> >  	struct thermal_instance *instance;
> >  	struct power_allocator_params *params = tz->governor_data; @@ -
> 326,7
> > +326,7 @@ static int allocate_power(struct thermal_zone_device *tz,
> >  				      granted_power, total_granted_power,
> >  				      num_actors, power_range,
> >  				      max_allocatable_power, current_temp,
> > -				      (s32)control_temp - (s32)current_temp);
> > +				      control_temp - current_temp);
> >
> >  	devm_kfree(&tz->device, req_power);
> >  unlock:
> > @@ -411,7 +411,7 @@ static int power_allocator_bind(struct
> > thermal_zone_device *tz)  {
> >  	int ret;
> >  	struct power_allocator_params *params;
> > -	unsigned long switch_on_temp, control_temp;
> > +	int switch_on_temp, control_temp;
> >  	u32 temperature_threshold;
> >
> >  	if (!tz->tzp || !tz->tzp->sustainable_power) { @@ -476,7 +476,7 @@
> > static void power_allocator_unbind(struct thermal_zone_device *tz)
> > static int power_allocator_throttle(struct thermal_zone_device *tz,
> > int trip)  {
> >  	int ret;
> > -	unsigned long switch_on_temp, control_temp, current_temp;
> > +	int switch_on_temp, control_temp, current_temp;
> >  	struct power_allocator_params *params = tz->governor_data;
> >
> >  	/*
> 
> [...]
> 
> > diff --git a/include/trace/events/thermal_power_allocator.h
> > b/include/trace/events/thermal_power_allocator.h
> > index 12e1321..5afae8f 100644
> > --- a/include/trace/events/thermal_power_allocator.h
> > +++ b/include/trace/events/thermal_power_allocator.h
> > @@ -11,7 +11,7 @@ TRACE_EVENT(thermal_power_allocator,
> >  		 u32 total_req_power, u32 *granted_power,
> >  		 u32 total_granted_power, size_t num_actors,
> >  		 u32 power_range, u32 max_allocatable_power,
> > -		 unsigned long current_temp, s32 delta_temp),
> > +		 int current_temp, s32 delta_temp),
> >  	TP_ARGS(tz, req_power, total_req_power, granted_power,
> >  		total_granted_power, num_actors, power_range,
> >  		max_allocatable_power, current_temp, delta_temp), @@ -
> 24,7 +24,7 @@
> > TRACE_EVENT(thermal_power_allocator,
> >  		__field(size_t,        num_actors               )
> >  		__field(u32,           power_range              )
> >  		__field(u32,           max_allocatable_power    )
> > -		__field(unsigned long, current_temp             )
> > +		__field(int,           current_temp             )
> >  		__field(s32,           delta_temp               )
> >  	),
> >  	TP_fast_assign(
> > @@ -42,7 +42,7 @@ TRACE_EVENT(thermal_power_allocator,
> >  		__entry->delta_temp = delta_temp;
> >  	),
> >
> > -	TP_printk("thermal_zone_id=%d req_power={%s}
> total_req_power=%u granted_power={%s} total_granted_power=%u
> power_range=%u max_allocatable_power=%u current_temperature=%lu
> delta_temperature=%d",
> > +	TP_printk("thermal_zone_id=%d req_power={%s}
> total_req_power=%u
> > +granted_power={%s} total_granted_power=%u power_range=%u
> > +max_allocatable_power=%u current_temperature=%d
> > +delta_temperature=%d",
> >  		__entry->tz_id,
> >  		__print_array(__get_dynamic_array(req_power),
> >                                __entry->num_actors, 4),
