From: mmarek@suse.cz (Michal Marek)
Date: Thu, 19 Feb 2015 13:11:07 +0100
Subject: [PATCH] [media] [kbuild] Add and use IS_REACHABLE macro
In-Reply-To: <6116702.rrbrOqQ26P@wuerfel>
References: <6116702.rrbrOqQ26P@wuerfel>
Message-ID: <20150219121107.GA19684@sepie.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-02-18 18:12, Arnd Bergmann wrote:
> In the media drivers, the v4l2 core knows about all submodules
> and calls into them from a common function. However this cannot
> work if the modules that get called are loadable and the
> core is built-in. In that case we get
> 
> drivers/built-in.o: In function `set_type':
> drivers/media/v4l2-core/tuner-core.c:301: undefined reference to `tea5767_attach'
> drivers/media/v4l2-core/tuner-core.c:307: undefined reference to `tea5761_attach'
> drivers/media/v4l2-core/tuner-core.c:349: undefined reference to `tda9887_attach'
> drivers/media/v4l2-core/tuner-core.c:405: undefined reference to `xc4000_attach'
> [...]
> Ideally Kconfig would be used to avoid the case of a broken dependency,
> or the code restructured in a way to turn around the dependency, but either
> way would require much larger changes here.

What can be done without extending kbuild is to accept
CONFIG_VIDEO_TUNER=y and CONFIG_MEDIA_TUNER_FOO=m, but build both into
the kernel, e.g.

diff --git a/drivers/media/tuners/Kconfig b/drivers/media/tuners/Kconfig
index 42e5a01..d2c7e89 100644
--- a/drivers/media/tuners/Kconfig
+++ b/drivers/media/tuners/Kconfig
@@ -71,6 +71,11 @@ config MEDIA_TUNER_TEA5767
 	help
 	  Say Y here to include support for the Philips TEA5767 radio tuner.
 
+config MEDIA_TUNER_TEA5767_BUILD
+	tristate
+	default VIDEO_TUNER || MEDIA_TUNER_TEA5767
+	depends on MEDIA_TUNER_TEA5767!=n
+
 config MEDIA_TUNER_MSI001
 	tristate "Mirics MSi001"
 	depends on MEDIA_SUPPORT && SPI && VIDEO_V4L2

Actually, I have hard time coming up with a kconfig syntactic sugar to
express such dependency. If I understand it correctly, the valid
configurations in this case are

MEDIA_TUNER_TEA5767	n	m	y
VIDEO_TUNER	n	x	x	x
		m	x	x	x
		y	x		x

I.e. only VIDEO_TUNER=y and MEDIA_TUNER_TEA5767=m is incorrect, isn't
it?

Thanks,
Michal
