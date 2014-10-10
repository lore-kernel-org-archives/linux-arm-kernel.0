From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 10 Oct 2014 09:24:39 +0200
Subject: [RFC] drop owner assignment from platform_drivers
Message-ID: <20141010072439.GA1741@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

people found out that for platform_driver, we don't need to set the
.owner field because this is done by the platform driver core. So far,
so good. However, now I got patches removing the .owner field for this
single i2c driver or for that one. To prevent getting thousands of
patches fixing single drivers, I used coccinelle to remove all instances
from the kernel. The SmPL looks like this, it doesn't blindly remove all
THIS_MODULE, but checks if the platform_driver struct was really used by
a call actually setting the .owner field:

===

@match1@
declarer name module_platform_driver;
declarer name module_platform_driver_probe;
identifier __driver;
@@
(
	module_platform_driver(__driver);
|
	module_platform_driver_probe(__driver, ...);
)

@fix1 depends on match1@
identifier match1.__driver;
@@
	static struct platform_driver __driver = {
		.driver = {
-			.owner = THIS_MODULE,
		}
	};

@match2@
identifier __driver;
@@
(
	platform_driver_register(&__driver)
|
	platform_driver_probe(&__driver, ...)
|
	platform_create_bundle(&__driver, ...)
)

@fix2 depends on match2@
identifier match2.__driver;
@@
	static struct platform_driver __driver = {
		.driver = {
-			.owner = THIS_MODULE,
		}
	};

===

I tried to group the changes. The current granularity is directory
level. The resulting branch can be found here (it is based on linux-next
of yesterday):

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git drop_platform_driver_owner

This still results in 300 patches as this shortened pull request shows:

===

Wolfram Sang (299):
      ARM: common: drop owner assignment from platform_drivers
      ARM: mach-davinci: drop owner assignment from platform_drivers
      ARM: mach-imx: drop owner assignment from platform_drivers
...
      ASoC: txx9: drop owner assignment from platform_drivers
      ASoC: ux500: drop owner assignment from platform_drivers
      ALSA: sparc: drop owner assignment from platform_drivers

 arch/arm/common/sa1111.c                                         | 1 -
 arch/arm/mach-davinci/cpuidle.c                                  | 1 -
 arch/arm/mach-davinci/pm.c                                       | 1 -
...
 sound/sparc/amd7930.c                                            | 1 -
 sound/sparc/cs4231.c                                             | 1 -
 sound/sparc/dbri.c                                               | 1 -
 1688 files changed, 1718 deletions(-)

===

I don't want to send all 300 patches to lkml. I still think, they should
go via subsystems, though, and not via a single pull request. So, I am
working on just sending smaller pieces of this huge series to the
apropriate mailing lists (like arm, netdev...) as an independent series.
Then, each subsystem can decide if the patches should be further folded.
In my experience, this mileage varies from subsystem to subsystem.

That's my plan for today. If you have comments, other suggestions or
remarks, I'd like to hear them.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/b4ab6c43/attachment.sig>
