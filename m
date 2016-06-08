From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 8 Jun 2016 09:28:32 +0800
Subject: [PATCH v14.1 01/17] drm: bridge: analogix/dp: split exynos dp
 driver to bridge directory
In-Reply-To: <417ed48e-74e1-f747-34b9-0d1031a3d862@osg.samsung.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <1455534576-1486-1-git-send-email-ykk@rock-chips.com>
 <1811552.qvsCm7GUs1@diego>
 <417ed48e-74e1-f747-34b9-0d1031a3d862@osg.samsung.com>
Message-ID: <575774C0.4000900@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 06/08/2016 01:06 AM, Javier Martinez Canillas wrote:
> Hello Yakir,
>
> On 03/17/2016 05:47 PM, Heiko St?bner wrote:
>> Split the dp core driver from exynos directory to bridge directory,
>> and rename the core driver to analogix_dp_*, rename the platform
>> code to exynos_dp.
>>
>> Beside the new analogix_dp driver would export six hooks.
>> "analogix_dp_bind()" and "analogix_dp_unbind()"
>> "analogix_dp_suspned()" and "analogix_dp_resume()"
>> "analogix_dp_detect()" and "analogix_dp_get_modes()"
>>
>> The bind/unbind symbols is used for analogix platform driver to connect
>> with analogix_dp core driver. And the detect/get_modes is used for analogix
>> platform driver to init the connector.
>>
>> They reason why connector need register in helper driver is rockchip drm
>> haven't implement the atomic API, but Exynos drm have implement it, so
>> there would need two different connector helper functions, that's why we
>> leave the connector register in helper driver.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
> Marc reported that his Exynos5250 Snow Chromebook fails to boot with v4.7-rc.
>
> I've done a git bisect and tracked down to this commit. The problem is a NULL
> pointer dereference to connector->dev in drm_mode_create(connector->dev) when
> called from exynos_dp_get_modes(). The error log is at [1].
>
> I'm trying to figure out the issue but wanted to mention in case you have any
> hints about what could be the cause. AFAICT the problem is related to the fact
> that drm_connector_init() is called in analogix_dp_bridge_attach() and the
> connector passed as argument is the one in struct analogix_dp_device *dp, but
> later exynos_dp_get_modes() calls drm_mode_create() passing the connector in
> struct exynos_dp_device *dp, which has not been previously initialized.

Agree, this should be the problem, exynos_dp->connector haven't been
initialized, driver should make exynos_dp->dp to a connector point, and
record the passing connector in exynos_dp_bridge_attach(), that should
fix this problem.


Thanks,
- Yakir


diff --git a/drivers/gpu/drm/exynos/exynos_dp.c 
b/drivers/gpu/drm/exynos/exynos_dp.c
index 468498e..4c1fb3f 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -34,7 +34,7 @@

  struct exynos_dp_device {
         struct drm_encoder         encoder;
-       struct drm_connector       connector;
+       struct drm_connector       *connector;
         struct drm_bridge          *ptn_bridge;
         struct drm_device          *drm_dev;
         struct device              *dev;
@@ -70,7 +70,7 @@ static int exynos_dp_poweroff(struct 
analogix_dp_plat_data *plat_data)
  static int exynos_dp_get_modes(struct analogix_dp_plat_data *plat_data)
  {
         struct exynos_dp_device *dp = to_dp(plat_data);
-       struct drm_connector *connector = &dp->connector;
+       struct drm_connector *connector = dp->connector;
         struct drm_display_mode *mode;
         int num_modes = 0;

@@ -103,6 +103,7 @@ static int exynos_dp_bridge_attach(struct 
analogix_dp_plat_data *plat_data,
         int ret;

         drm_connector_register(connector);
+       dp->connector = connector;

         /* Pre-empt DP connector creation if there's a bridge */
         if (dp->ptn_bridge) {


> [1]
> [    4.175676] Unable to handle kernel NULL pointer dereference at virtual address 00000210
> [    4.182793] pgd = c0004000
> [    4.185171] [00000210] *pgd=00000000
> [    4.188657] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [    4.194164] Modules linked in:
> [    4.196964] CPU: 1 PID: 68 Comm: kworker/1:1 Not tainted 4.7.0-rc2-next-20160606-00006-g876c3150327a #97
> [    4.206565] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    4.212582] Workqueue: events hdmi_hotplug_work_func
> [    4.217383] task: ed758000 ti: ed75c000 task.ti: ed75c000
> [    4.222887] PC is at __mutex_lock_slowpath+0x6c/0x404
> [    4.227913] LR is at preempt_count_add+0xa4/0x140
> [    4.232592] pc : [<c06d21d4>]    lr : [<c0139de4>]    psr: 60000093
> [    4.232592] sp : ed75dd80  ip : 00000000  fp : ee8c1180
> [    4.244193] r10: 00000300  r9 : ed758000  r8 : 00000001
> [    4.249262] r7 : 60000013  r6 : c0b473a8  r5 : 00000210  r4 : 0000020c
> [    4.261955] r3 : 00000000  r2 : 00000001  r1 : ee8c2808  r0 : 00000000
> [    4.273270] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    4.285336] Control: 10c5387d  Table: 4000406a  DAC: 00000051
> [    4.295885] Process kworker/1:1 (pid: 68, stack limit = 0xed75c210)
> [    4.306979] Stack: (0xed75dd80 to 0xed75e000)
> [    4.316102] dd80: ee8c1180 c03dd21c ee8f0820 00000001 0000020c 0000020c 00000000 00000000
> [    4.329201] dda0: 00000001 dededede 00000300 c06d2578 ee8c2808 c03d00f4 ee801d80 c0b0261c
> [    4.342362] ddc0: 00000041 ee8c2800 00000000 00000001 ee8f0810 ee8f0b65 c074d2b4 c03d35b0
> [    4.353140] dde0: 00000000 00000300 ee8c1180 c03d81d0 c387cf74 ee8f0820 00000001 c03eaffc
> [    4.361811] de00: 00000000 ee8f0820 00000001 c03f28bc ee8f0b65 c06d400c ee8c1180 006d40a4
> [    4.370483] de20: 00000000 01820a11 81010300 00000100 00000064 ee8f085c ee8f0820 c0b1f894
> [    4.379150] de40: c3872800 c0b82fac c074d2b4 c03b7550 c0b13274 c0327974 00000001 eefb8530
> [    4.387805] de60: 00000556 00000000 c38729b0 c3872800 ee8c1180 00000001 ee8c7000 00000000
> [    4.396467] de80: 00000556 00000300 c38729b0 00000002 ee8c1180 c03c107c ee8c7000 c3872800
> [    4.405121] dea0: ee8c7240 c3872800 c0b82fac c03c3268 c3872ad4 00000001 c3872ae0 c03b7af0
> [    4.413776] dec0: eefb8000 c0139804 00000000 c0136484 ee8a0000 ee8c1180 c3870b4c eefb7b00
> [    4.422415] dee0: eefbb000 00000000 00000000 eefb7b00 ee8c1180 c012ff2c 00000008 eefb7b24
> [    4.431045] df00: eefb7b00 ee8c1198 00000008 eefb7b24 c0b02100 ed75c000 eefb7b00 c0130178
> [    4.439664] df20: ed75c000 ee863040 ee8c1180 00000000 ee863040 ee8c1180 c0130140 00000000
> [    4.448274] df40: 00000000 00000000 00000000 c0135454 00000000 00000000 00000000 ee8c1180
> [    4.456879] df60: 00000000 00000000 dead4ead ffffffff ffffffff ed75df74 ed75df74 00000000
> [    4.465462] df80: 00000000 dead4ead ffffffff ffffffff ed75df90 ed75df90 ed75dfac ee863040
> [    4.474028] dfa0: c0135378 00000000 00000000 c0107978 00000000 00000000 00000000 00000000
> [    4.482597] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    4.491133] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    4.499643] [<c06d21d4>] (__mutex_lock_slowpath) from [<c06d2578>] (mutex_lock+0xc/0x24)
> [    4.507102] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [    4.514264] [<c06d2578>] (mutex_lock) from [<c03d00f4>] (drm_mode_object_get_reg+0x28/0x80)
> [    4.522981] [<c03d00f4>] (drm_mode_object_get_reg) from [<c03d35b0>] (drm_mode_object_get+0x18/0x20)
> [    4.532491] [<c03d35b0>] (drm_mode_object_get) from [<c03d81d0>] (drm_mode_create+0x3c/0x58)
> [    4.541316] [<c03d81d0>] (drm_mode_create) from [<c03eaffc>] (exynos_dp_get_modes+0x24/0x80)
> [    4.550160] [<c03eaffc>] (exynos_dp_get_modes) from [<c03f28bc>] (analogix_dp_get_modes+0x198/0x278)
> [    4.559735] [<c03f28bc>] (analogix_dp_get_modes) from [<c03b7550>] (drm_helper_probe_single_connector_modes+0x114/0x554)
> [    4.571078] [<c03b7550>] (drm_helper_probe_single_connector_modes) from [<c03c107c>] (drm_fb_helper_probe_connector_modes+0x48/0x68)
> [    4.583513] [<c03c107c>] (drm_fb_helper_probe_connector_modes) from [<c03c3268>] (drm_fb_helper_hotplug_event+0x70/0xdc)
> [    4.594921] [<c03c3268>] (drm_fb_helper_hotplug_event) from [<c03b7af0>] (drm_helper_hpd_irq_event+0xd4/0x160)
> [    4.605474] [<c03b7af0>] (drm_helper_hpd_irq_event) from [<c012ff2c>] (process_one_work+0x124/0x338)
> [    4.615144] [<c012ff2c>] (process_one_work) from [<c0130178>] (worker_thread+0x38/0x4d4)
> [    4.623764] [<c0130178>] (worker_thread) from [<c0135454>] (kthread+0xdc/0xf4)
> [    4.631512] [<c0135454>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
> [    4.639239] Code: e10f7000 f10c0080 e2845004 f595f000 (e1953f9f)
> [    4.645845] ---[ end trace 3bfc770b9638a54b ]---
>
> Best regards,
