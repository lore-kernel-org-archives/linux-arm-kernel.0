From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 7 Apr 2015 15:11:29 +0300
Subject: [GIT PULL] ARM: OMAP2+: OMAP DRA7xx display-related hwmod data
 changes for v4.1
In-Reply-To: <20150403230833.GB18048@atomide.com>
References: <alpine.DEB.2.02.1504031953150.19540@utopia.booyaka.com>
 <20150403230833.GB18048@atomide.com>
Message-ID: <5523C971.1030904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

No, don't pull this, it doesn't work.

Paul, the hwmod patch cannot be picked from the DRA7 DSS series. We have
the problem with the DES HDCP clock, without that clock we will see
WARNINGs when booting if the "set DSS submodule parent hwmods" is applied.

We do see some errors when booting even with the current mainline,
caused by not having that clock enabled:

[    0.194524] omap_hwmod: dss_core: _wait_target_disable failed
[    0.194540] omap_hwmod: dss_core: _wait_target_ready failed: -16
[    0.194554] omap_hwmod: dss_core: cannot be enabled for reset (3)
[    0.197143] omap_hwmod: dss_dispc: _wait_target_ready failed: -16
[    0.197156] omap_hwmod: dss_dispc: cannot be enabled for reset (3)
[    0.199745] omap_hwmod: dss_hdmi: _wait_target_ready failed: -16
[    0.199759] omap_hwmod: dss_hdmi: cannot be enabled for reset (3)

But that's still much less spam than the above plus ~4 WARNs.

I'd rather merge the DRA7 DSS patches in one go, to avoid issues related
to the HDPC clock.

 Tomi

On 04/04/15 02:08, Tony Lindgren wrote:
> Hi Arnd & Olof,
> 
> Please feel free to pull this directly from Paul.
> 
> Regards,
> 
> Tony
> 
> * Paul Walmsley <paul@pwsan.com> [150403 12:55]:
>> Hi Tony
>>
>> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
>>
>>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.1/omap-hwmod-b
>>
>> for you to fetch changes up to 0d75ebdd3230b3d085812df80ec54138828cc76a:
>>
>>   ARM: DRA7: hwmod: set DSS submodule parent hwmods (2015-04-03 13:15:07 -0600)
>>
>> ----------------------------------------------------------------
>> OMAP DRA7xx display-related hwmod data changes for v4.1
>>
>> Add DMM hwmod data for DRA7xx, and set the parent hwmods fields
>> appropriately for the DRA7xx DSS submodules as we've done for
>> other OMAP devices.
>>
>> Note that I do not have a DRA7xx board, and thus cannot boot-test
>> these patches.
>>
>> Basic build, boot, and PM idle test logs are available at:
>>
>> http://www.pwsan.com/omap/testlogs/omap-hwmod-b-for-v4.1/20150403123702/
>>
>> ----------------------------------------------------------------
>> Tomi Valkeinen (2):
>>       ARM: DRA7: hwmod: add DMM hwmod description
>>       ARM: DRA7: hwmod: set DSS submodule parent hwmods
>>
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 +++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>>
>>
>> vmlinux object size
>> (delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539)):
>>    text     data      bss    total  kernel
>>       0        0        0        0  omap1_defconfig
>>       0        0        0        0  omap1_defconfig_1510innovator_only
>>       0        0        0        0  omap1_defconfig_5912osk_only
>>       0     +192        0     +192  multi_v7_defconfig
>>       0     +216        0     +216  omap2plus_defconfig
>>       0        0        0        0  omap2plus_defconfig_2430sdp_only
>>       0        0        0        0  omap2plus_defconfig_am33xx_only
>>       0        0        0        0  omap2plus_defconfig_am43xx_only
>>       0     +224        0     +224  omap2plus_defconfig_cpupm
>>       0     +192        0     +192  omap2plus_defconfig_dra7xx_only
>>       0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
>>       0        0        0        0  omap2plus_defconfig_n800_only_a
>>       0     +192        0     +192  omap2plus_defconfig_no_pm
>>       0        0        0        0  omap2plus_defconfig_omap2_4_only
>>       0        0        0        0  omap2plus_defconfig_omap3_4_only
>>       0        0        0        0  omap2plus_defconfig_omap5_only
>>       0        0        0        0  rmk_omap3430_ldp_allnoconfig
>>       0        0        0        0  rmk_omap3430_ldp_oldconfig
>>      +8        0       -8        0  rmk_omap4430_sdp_allnoconfig
>>       0        0        0        0  rmk_omap4430_sdp_oldconfig
>>
>> Boot-time memory difference
>> (delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539))
>>   avail  rsrvd   high  freed  board          kconfig
>>     -4k     4k      .      .  4460pandaes    omap2plus_defconfig
>>    -12k    12k      .      .  4460varsomom   omap2plus_defconfig
>>     -4k     4k      .      .  5430es2sbct54  omap2plus_defconfig
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150407/8e4c1055/attachment.sig>
