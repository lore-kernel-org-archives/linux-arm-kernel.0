From: maxime.coquelin-nonst@stericsson.com (Maxime Coquelin)
Date: Fri, 11 Mar 2011 13:35:09 +0100
Subject: [RFC PATCHv2 0/2] Export SoC info through sysfs
Message-ID: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the second version of the proposal to export SoC related information to user-space through sysFS interface.

The first patch introduces the common part, which provides an interface to the platform to export platform-defined IDs to user-space.
The IDs strings can be provided in two ways: either with a pointer to the string, or by a callback fullfilling the sysfs's "show" callback buffer.

The second patch is given as example for the ux500 architecture. It registers the socinfo interface, and exports 5 values (Family name, machine name, silicon process, silicon revision, and serial number).

Here is the output for DB8500:
root at ME:/sys/socinfo ls -l
-r--r--r-- 1 root root 4096 Jan  2 03:35 family
-r--r--r-- 1 root root 4096 Jan  2 03:35 machine
-r--r--r-- 1 root root 4096 Jan  2 03:35 process
-r--r--r-- 1 root root 4096 Jan  2 03:35 revision
-r--r--r-- 1 root root 4096 Jan  2 03:35 soc_id
root at ME:/sys/socinfo cat machine
DB8500
root at ME:/sys/socinfo cat family
Ux500
root at ME:/sys/socinfo cat process
Standard
root at ME:/sys/socinfo cat revision
2.0
root at ME:/sys/socinfo cat soc_id
2ba07ce9e5835d6185321e9577462ef2ea2129cf

-------------------------------------------------------------------------------
v1:
	Conclusion about first version :
		* /sys/devices/system is not right place for this interface.
		* "mach_name" should be declared as other attributes to simplify code.
		* The get_info callback should use directly the "show" callback buffer.
		* Documentation was missing (ABI description required)
		* Errors were not reported at registration time.
		* Macros should be used to create attributes.
		* Some kernel coding rules not followed.

-------------------------------------------------------------------------------

Any comments are welcome.

Note that I will be off from 13th to 21th of March.

Regards,
Maxime

-------------------------------------------------------------------------------

Maxime Coquelin (2):
  Export SoC info through sysfs
  ux500: Export U8500 SoC info through sysfs

 Documentation/ABI/testing/sysfs-socinfo |   16 ++++++
 arch/arm/mach-ux500/Kconfig             |    1 +
 arch/arm/mach-ux500/id.c                |   70 +++++++++++++++++++++++++++
 drivers/base/Kconfig                    |    3 +
 drivers/base/Makefile                   |    1 +
 drivers/base/soc.c                      |   79 +++++++++++++++++++++++++++++++
 include/linux/sys_soc.h                 |   50 +++++++++++++++++++
 7 files changed, 220 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-socinfo
 create mode 100644 drivers/base/soc.c
 create mode 100644 include/linux/sys_soc.h
