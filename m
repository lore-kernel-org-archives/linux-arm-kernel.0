From: Nitin.Chaudhary@zii.aero (Nitin Chaudhary)
Date: Thu, 18 Aug 2016 18:40:57 -0700
Subject: [PATCH v3 0/3] Re:[PATCH v2] Added perf functionality to mmdc driver 
In-Reply-To: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
References: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
Message-ID: <1471570860-2087-1-git-send-email-Nitin.Chaudhary@zii.aero>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series of patch resolve the kernel compilation errors with the
proposed perf functionality integration into MMDC driver by Zhengyu Shen and
hence provide the working code which can be enhanced upon as per the reviews
from Mark Rutland and Peter Zilstra. The code still retains the original working
as was proposed by Zhengyu except a few minor changes to resolve probe failure
in the latest version of kernel. These patchsets are second version of patches
incorporating the inputs from Zhengyu. The below is description:
 v2 - Migrated driver to use state machine based CPU notifier
 v3 - Fixed the code for probe failure while polling on MMDC MAPSR bit 4

The following are results after running v3 version of the patches on an i.MX6Q
board

root at RDU2:/mnt/disk ./perf stat -a -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc
/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/de
v/zero of=/dev/null bs=1M count=5000
5000+0 records in
5000+0 records out
5242880000 bytes (5.2 GB) copied, 4.63319 s, 1.1 GB/s

 Performance counter stats for 'system wide':

         823347142      mmdc/busy-cycles/
          12406525      mmdc/read-accesses/
            404.43 MB   mmdc/read-bytes/
        2460141184      mmdc/total-cycles/
          11050765      mmdc/write-accesses/
            353.64 MB   mmdc/write-bytes/

       4.661893334 seconds time elapsed

Any review & comments are welcomed!

Nitin Chaudhary (3):
  Error: Fix mmdc compilation errors due to cpu notifier
  [i.MX6Q] Code cleanup & verification after fixing compilation error
  [i.MX6Q]Removed MMDC Auto Power saving timeout error

 arch/arm/mach-imx/mmdc.c   | 122 +++++++++++++++++++++++++--------------------
 include/linux/cpuhotplug.h |   1 +
 2 files changed, 69 insertions(+), 54 deletions(-)

--
2.7.4


________________________________


This email and any files transmitted with it are confidential & proprietary to Zodiac Inflight Innovations. This information is intended solely for the use of the individual or entity to which it is addressed. Access or transmittal of the information contained in this e-mail, in full or in part, to any other organization or persons is not authorized.
