From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 7 May 2017 20:21:31 +0200
Subject: ARM Power Firmware / "APPF"
Message-ID: <CAFBinCCDC=ZDBrqMo37jV32c2vE0mMvSEsEXC7SJDotHFdV0nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

recently I've been looking into the older-gen Amlogic Meson SoCs.
while looking at the suspend code from the vendor GPL kernel sources I
found something interesting:
these SoCs (Meson6, Meson8, Meson8b and Meson8m2) seem to use the ARM
Power Firmware, also called "APPF"

there's not much information about this on the internet.
however, the Amlogic u-boot GPL sources come with documentation for this: [0]

Amlogic seems to use APPF in case "Trustzone" is disabled (see [1]).
the actual invocation to APPF during suspend can be found here [2] for
non-Trustzone kernels, and here [3] for kernels with Trustzone enabled
(in the latter case a SMC is used)

from what I understood so far it works like this:
1. APPF - which is compiled as position independent ELF - is loaded
into main memory by u-boot, see [4]
2. u-boot initializes APPF (also part of [4])
3. kernel boots and should not modify this memory-region (reading and
executing is fine)
4. kernel initializes APPF by calling appf_runtime_call with function
APPF_INITIALIZE (this is done by simply jumping to the memory from the
APPF ELF -> this lands us here: [5])
5. appf_runtime_call is invoked with function APPF_POWER_DOWN_CPU ->
this blocks until the system is woken up

so far this sounds pretty generic and does not contain (much) Amlogic
specific code.
there is a second (Amlogic specific) part which is involved in system
suspend: arc_power firmware - this seems to be executed on an ARC core
embedded in the Amlogic SoCs using the SRAM instead of DRAM (as the
latter is powered down / in self-refresh mode). sources for the
arc_power firmware can be found here: [6]

onto the actual question(s):
- are there any other SoC vendors which use APPF other than Amlogic?
- is there anything else I should know about this "feature"?
- is there a good reason why I should not try to implement mainline
support for this?


Regards,
Martin


[0] https://github.com/endlessm/u-boot-meson/blob/3286dd744d2b33a228f7f7f82109fd5fd9c8471e/arch/arm/cpu/aml_meson/m8/firmware/appf/ARM%20Firmware%20Specification.doc?raw=true
[1] https://github.com/endlessm/linux-meson/blob/9bddb0a81b9f7de9ee099bd578aaef3408b66d94/arch/arm/mach-meson8/pm.c#L269
[2] https://github.com/endlessm/linux-meson/blob/c173f4653186870f08dc9131b5d82ef4ab4151e1/arch/arm/mach-meson8/power_suspend.c#L99
[3] https://github.com/endlessm/linux-meson/blob/c173f4653186870f08dc9131b5d82ef4ab4151e1/arch/arm/mach-meson8/meson-smc.S#L125
[4] https://github.com/endlessm/u-boot-meson/blob/3286dd744d2b33a228f7f7f82109fd5fd9c8471e/arch/arm/cpu/aml_meson/m8/firmwareld.c
[5] https://github.com/endlessm/u-boot-meson/blob/3286dd744d2b33a228f7f7f82109fd5fd9c8471e/arch/arm/cpu/aml_meson/m8/firmware/appf/os_api.c#L40
[6] https://github.com/endlessm/u-boot-meson/tree/3286dd744d2b33a228f7f7f82109fd5fd9c8471e/arch/arm/cpu/aml_meson/m8/firmware/arc_power
