From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 19 Oct 2016 08:56:04 -0700
Subject: [PATCH v5 0/5] Add support for legacy SCPI protocol
In-Reply-To: <ff62da76-a7b9-6891-c198-f9049dfa7bb5@arm.com> (Sudeep Holla's
 message of "Wed, 19 Oct 2016 15:44:23 +0100")
References: <1476881472-13055-1-git-send-email-narmstrong@baylibre.com>
 <ff62da76-a7b9-6891-c198-f9049dfa7bb5@arm.com>
Message-ID: <7h7f949vu3.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep Holla <sudeep.holla@arm.com> writes:

> On 19/10/16 13:51, Neil Armstrong wrote:
>> This patchset aims to support the legacy SCPI firmware implementation that was
>> delivered as early technology preview for the JUNO platform.
>>
>> Finally a stable, maintained and public implementation for the SCPI protocol
>> has been upstreamed part of the JUNO support and it is the recommended way
>> of implementing SCP communication on ARMv8 platforms.
>>
>> The Amlogic GXBB platform is using this legacy protocol, as the RK3368 & RK3399
>> platforms. This patchset will only add support for Amlogic GXBB SoC.
>>
>> This patchset add support for the legacy protocol in the arm_scpi.c file,
>> avoiding code duplication.
>>
>> This patchset is rebased against scpi-updates/for-next from [2] and with
>> already merged patches [3], [4] and [5] and ommited in this patchset.
>>
>> Last RFC discution thread can be found at : https://lkml.org/lkml/2016/8/9/210
>>
>> Changes since v4 at : http://lkml.kernel.org/r/1475652814-30619-1-git-send-email-narmstrong at baylibre.com
>>  - Removed legacy locking scheme
>>  - Removed cmd copy back after token insert
>>  - Various cleanups
>>
>> Changes since v3 at : http://lkml.kernel.org/r/1473262477-18045-1-git-send-email-narmstrong at baylibre.com
>>  - Changed back author to Sudeep Holla for first patch
>>  - Merged legacy functions to scpi_send_message, tx_prepare and handle_remote_message
>>  - Added legacy locking scheme
>>  - Merged back legacy_scpi_sensor_get_value into scpi_sensor_get_value
>>  - Rebased on linux-next-20161004 with patchset [1]
>>
>> Changes since v2 at : http://lkml.kernel.org/r/1471952816-30877-1-git-send-email-narmstrong at baylibre.com
>>  - Added command indirection table and use it in each commands
>>  - Added bitmap for high priority commands
>>  - Cleaned up legacy tx_prepare/handle_message to align to standard functions
>>  - Dropped legacy_scpi_ops
>>
>> Changes since v1 at : http://lkml.kernel.org/r/1471515066-3626-1-git-send-email-narmstrong at baylibre.com
>>  - Dropped vendor_send_message and rockchip vendor mechanism patches
>>  - Merged alternate functions into main functions using is_legacy boolean
>>  - Added DT match table to set is_legacy to true
>>  - Kept alternate scpi_ops structure for legacy
>>
>> [1] http://lkml.kernel.org/r/1475595430-30075-1-git-send-email-narmstrong at baylibre.com
>> [2] git.kernel.org/sudeep.holla/linux
>> [3] scpi: Add cmd indirection table to prepare for legacy commands
>> [4] scpi: grow MAX_DVFS_OPPS to 16 entries
>> [5] dt-bindings: Add support for Amlogic GXBB SCPI Interface
>>
>> Neil Armstrong (5):
>>   scpi: Add alternative legacy structures, functions and macros
>>   scpi: Do not fail if get_capabilities is not implemented
>>   scpi: Add support for Legacy match table for Amlogic GXBB SoC
>>   ARM64: dts: meson-gxbb: Add SRAM node
>>   ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes
>>
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  57 ++++++++
>>  drivers/firmware/arm_scpi.c                 | 206 +++++++++++++++++++++++++---
>>  2 files changed, 245 insertions(+), 18 deletions(-)
>>
>
> Nice to see this diff stat from a whole new file legacy_scpi.c and 1000+
> delta. Thanks for working on this. I have applied the first 3 patches in
> this series with some subject/commit message changes to [1].
>
> I assume the DT changes needs to go via the corresponding platform
> maintainer.

Yes, I'll queue the DT changes through the amlogic tree (which then goes
through the arm-soc tree.)

Thanks,

Kevin
