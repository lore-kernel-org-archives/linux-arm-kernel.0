From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 28 Oct 2018 21:10:04 +0100 (CET)
Subject: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
In-Reply-To: <f9670cb6f44dc63dd7a475f843572f4c16359181.camel@suse.de>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <f9670cb6f44dc63dd7a475f843572f4c16359181.camel@suse.de>
Message-ID: <362789745.3759.1540757404969@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 13:06 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Thu, 2018-10-25 at 17:29 +0200, Stefan Wahren wrote:
> > This patch series improves the load/unload of bcm2835 camera and
> > audio
> > drivers. It has been tested with Raspberry Pi 3 B and a camera module
> > V1.
> > 
> > This series based on current linux-next and Phil Elwell's series
> > ("Improve VCHIQ
> > cache line size handling"). After Nicolas' series ("staging:
> > vc04_services:
> > Some dead code removal") has been applied, i will rebase my series.
> > 
> > Stefan Wahren (11):
> >   staging: bcm2835-camera: Abort probe if there is no camera
> >   staging: bcm2835-camera: fix module autoloading
> >   staging: bcm2835-camera: Move module info to the end
> >   staging: vchiq_arm: Fix platform device unregistration
> >   staging: vchiq_arm: Fix camera device registration
> >   staging: vchiq_arm: Register a platform device for audio
> >   staging: bcm2835-audio: Enable compile test
> >   staging: bcm2835-audio: use module_platform_driver() macro
> >   staging: bcm2835-audio: Drop DT dependency
> >   staging: bcm2835-camera: Provide more specific probe error messages
> >   staging: bcm2835-camera: Add hint about possible faulty config
> > 
> >  .../staging/vc04_services/bcm2835-audio/Kconfig    |  2 +-
> >  .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 61 ++++++----
> > -------
> >  .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 78
> > +++++++++++++++-------
> >  .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  5 +-
> >  .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 27 ++++++--
> >  5 files changed, 102 insertions(+), 71 deletions(-)
> > 
> 
> I prefer Dan's approach to error checking in vchiq_probe(). Apart from
> that seems good to me.
> 
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

unfortunately there is a issue with this series, after enabling the memleak detector i'm getting this:

unreferenced object 0xec9c9300 (size 64):
comm "systemd-udevd", pid 182, jiffies 4294937996 (age 1376.140s)
hex dump (first 32 bytes):
ff ff ff ff 00 00 00 00 2f 70 6c 61 74 66 6f 72 ......../platfor
6d 2f 73 6f 63 2f 33 66 30 30 62 38 34 30 2e 6d m/soc/3f00b840.m
backtrace:
[<9d7676d1>] vchiq_register_child+0x58/0x74 [vchiq]
[<6a2780cc>] vchiq_probe+0x1c0/0x264 [vchiq]
[<278d830e>] platform_drv_probe+0x48/0x98
[<c9846b79>] really_probe+0x228/0x2d0
[<489d6b89>] driver_probe_device+0x60/0x164
[<ccf84a43>] __driver_attach+0xd0/0xd4
[<042acada>] bus_for_each_dev+0x74/0xb4
[<b04ae13a>] bus_add_driver+0x18c/0x210
[<a66d3fa5>] driver_register+0x7c/0x114
[<a7353eeb>] do_one_initcall+0x54/0x1fc
[<9420261f>] do_init_module+0x64/0x1f4
[<571c859a>] load_module+0x1dfc/0x24bc
[<06885682>] sys_finit_module+0xac/0xd8
[<85e18c3d>] __sys_trace_return+0x0/0x20
[<0051c54d>] 0xbecb0898
[<0a0ced8e>] 0xffffffff

> 
> Regards,
> Nicolas
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
