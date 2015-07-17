From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 17 Jul 2015 12:14:36 +0100
Subject: [PATCH] thermal: consistently use int for temperatures
In-Reply-To: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
 (Sascha Hauer's message of "Mon, 6 Jul 2015 09:19:49 +0200")
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <9hhd1zrc9yb.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Sascha Hauer <s.hauer@pengutronix.de> writes:

> The thermal code uses int, long and unsigned long for temperatures
> in different places.
>
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0?C. This will probably
> immediately shut the machine down due to overtemperature if started below
> 0?C.
>
> 'long' is 64bit on several architectures. This is not needed since INT_MAX ?mC
> is above the melting point of all known materials.
>
> Consistently use a plain 'int' for temperatures throughout the thermal code and
> the drivers. This only changes the places in the drivers where the temperature
> is passed around as pointer, when drivers internally use another type this is
> not changed.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks for moving over the thermal sub-system in Linux to consistently
use a single type.

In your patch, you missed migrating over power_allocator governor and
it's associated trace events. It got merged for v4.2.

Could you incorporate something like below in your next version?

Thanks,
Punit

[...]

--------------->8-----------------------
Subject: [PATCH] Use int for temperature in power_allocator governor

---
 drivers/thermal/power_allocator.c              | 10 ++++------
 include/trace/events/thermal_power_allocator.h |  6 +++---
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 4672250..1bb7d7f 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -92,8 +92,7 @@ struct power_allocator_params {
  * Return: The power budget for the next period.
  */
 static u32 pid_controller(struct thermal_zone_device *tz,
-			  unsigned long current_temp,
-			  unsigned long control_temp,
+			  int current_temp, int control_temp,
 			  u32 max_allocatable_power)
 {
 	s64 p, i, d, power_range;
@@ -223,8 +222,7 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 }
 
 static int allocate_power(struct thermal_zone_device *tz,
-			  unsigned long current_temp,
-			  unsigned long control_temp)
+			  int current_temp, int control_temp)
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
@@ -411,7 +409,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 {
 	int ret;
 	struct power_allocator_params *params;
-	unsigned long switch_on_temp, control_temp;
+	int switch_on_temp, control_temp;
 	u32 temperature_threshold;
 
 	if (!tz->tzp || !tz->tzp->sustainable_power) {
@@ -476,7 +474,7 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 {
 	int ret;
-	unsigned long switch_on_temp, control_temp, current_temp;
+	int switch_on_temp, control_temp, current_temp;
 	struct power_allocator_params *params = tz->governor_data;
 
 	/*
diff --git a/include/trace/events/thermal_power_allocator.h b/include/trace/events/thermal_power_allocator.h
index 12e1321..5afae8f 100644
--- a/include/trace/events/thermal_power_allocator.h
+++ b/include/trace/events/thermal_power_allocator.h
@@ -11,7 +11,7 @@ TRACE_EVENT(thermal_power_allocator,
 		 u32 total_req_power, u32 *granted_power,
 		 u32 total_granted_power, size_t num_actors,
 		 u32 power_range, u32 max_allocatable_power,
-		 unsigned long current_temp, s32 delta_temp),
+		 int current_temp, s32 delta_temp),
 	TP_ARGS(tz, req_power, total_req_power, granted_power,
 		total_granted_power, num_actors, power_range,
 		max_allocatable_power, current_temp, delta_temp),
@@ -24,7 +24,7 @@ TRACE_EVENT(thermal_power_allocator,
 		__field(size_t,        num_actors               )
 		__field(u32,           power_range              )
 		__field(u32,           max_allocatable_power    )
-		__field(unsigned long, current_temp             )
+		__field(int,           current_temp             )
 		__field(s32,           delta_temp               )
 	),
 	TP_fast_assign(
@@ -42,7 +42,7 @@ TRACE_EVENT(thermal_power_allocator,
 		__entry->delta_temp = delta_temp;
 	),
 
-	TP_printk("thermal_zone_id=%d req_power={%s} total_req_power=%u granted_power={%s} total_granted_power=%u power_range=%u max_allocatable_power=%u current_temperature=%lu delta_temperature=%d",
+	TP_printk("thermal_zone_id=%d req_power={%s} total_req_power=%u granted_power={%s} total_granted_power=%u power_range=%u max_allocatable_power=%u current_temperature=%d delta_temperature=%d",
 		__entry->tz_id,
 		__print_array(__get_dynamic_array(req_power),
                               __entry->num_actors, 4),
-- 
2.1.2
