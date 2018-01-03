From: silvano.dininno@nxp.com (Silvano di Ninno)
Date: Wed, 3 Jan 2018 17:32:49 +0100
Subject: [RFC] ARM: decompressor: Make RAM sections Outer non-cacheable
Message-ID: <1514997170-31906-1-git-send-email-silvano.dininno@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There has been few attempts [1] [2] to make i.MX6 SoC run linux in Non-secure world,
with OP-TEE running in Secure world.
As you may know, the OP-TEE firmware (on Cortex A9) enables PL310 cache
controller at boot time and before the switch to Non-secure. The Way to allow
Linux to boot normally is currently to lock the ways so that L2 cache lines
are not filled.
It looks like Linux Kernel itself does not suffer from this (as it
does not have to perform cache management at boot time prior to l2 controller
initialization).
However, the decompressor code does and (at least for i.MX6 SoC families) this
is why Linux cannot boot correctly.

The patch [3] makes the RAM section outer non-cacheable so that the Linux code gets
correctly flush to DDR.

Is that solution acceptable?

Note on write_sec:
I am not a fan of the write_sec solution.
The idea behing Trustzone and Secure World is that the code being run in Non-secure
world (in this case linux) should not be (or is less) trusted.
In this context, it makes sense to rely as less as possible on Linux and so if
a solution can be found that does not require Linux intervention, I would favor that one.

Thanks,
Silvano

[1] http://archive.armlinux.org.uk/lurker/message/20171230.123403.ea9ef177.en.html
[2] http://archive.armlinux.org.uk/lurker/message/20171126.122530.ea0a4791.en.html
[3] [PATCH] ARM: decompressor: Make RAM sections Outer non-cacheable

Silvano di Ninno (1):
  ARM: decompressor: Make RAM sections Outer non-cacheable

 arch/arm/boot/compressed/head.S | 1 +
 1 file changed, 1 insertion(+)

-- 
2.7.4
