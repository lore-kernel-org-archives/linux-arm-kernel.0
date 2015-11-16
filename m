From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 16 Nov 2015 22:13:07 +0900
Subject: [PATCH v2 3/3] [media] include/media: move platform_data to
 linux/platform_data/media
In-Reply-To: <b8bd73bedde742571b1ab8a7c0917a732dbf2ca1.1447671420.git.mchehab@osg.samsung.com>
References: <013152dcb3d4eaddd39aa4a37868430567bdc2d6.1447671420.git.mchehab@osg.samsung.com>
 <b8bd73bedde742571b1ab8a7c0917a732dbf2ca1.1447671420.git.mchehab@osg.samsung.com>
Message-ID: <5649D663.4070104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 16.11.2015 o 20:00, Mauro Carvalho Chehab pisze:
> Let's not mix platform_data headers with the core headers. Instead, let's
> create a subdir at linux/platform_data and move the headers to that
> common place, adding it to MAINTAINERS.
> 
> The headers were moved with:
> 	mkdir include/linux/platform_data/media/; git mv include/media/gpio-ir-recv.h include/media/ir-rx51.h include/media/mmp-camera.h include/media/omap1_camera.h include/media/omap4iss.h include/media/s5p_hdmi.h include/media/si4713.h include/media/sii9234.h include/media/smiapp.h include/media/soc_camera.h include/media/soc_camera_platform.h include/media/timb_radio.h include/media/timb_video.h include/linux/platform_data/media/
> 
> And the references fixed with this script:
>     MAIN_DIR="linux/platform_data/"
>     PREV_DIR="media/"
>     DIRS="media/"
> 
>     echo "Checking affected files" >&2
>     for i in $DIRS; do
> 	for j in $(find include/$MAIN_DIR/$i -type f -name '*.h'); do
> 		 n=`basename $j`
> 		git grep -l $n
> 	done
>     done|sort|uniq >files && (
> 	echo "Handling files..." >&2;
> 	echo "for i in \$(cat files|grep -v Documentation); do cat \$i | \\";
> 	(
> 		cd include/$MAIN_DIR;
> 		for j in $DIRS; do
> 			for i in $(ls $j); do
> 				echo "perl -ne 's,(include [\\\"\\<])$PREV_DIR($i)([\\\"\\>]),\1$MAIN_DIR$j\2\3,; print \$_' |\\";
> 			done;
> 		done;
> 		echo "cat > a && mv a \$i; done";
> 	);
> 	echo "Handling documentation..." >&2;
> 	echo "for i in MAINTAINERS \$(cat files); do cat \$i | \\";
> 	(
> 		cd include/$MAIN_DIR;
> 		for j in $DIRS; do
> 			for i in $(ls $j); do
> 				echo "  perl -ne 's,include/$PREV_DIR($i)\b,include/$MAIN_DIR$j\1,; print \$_' |\\";
> 			done;
> 		done;
> 		echo "cat > a && mv a \$i; done"
> 	);
>     ) >script && . ./script
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> ---
>  Documentation/video4linux/omap4_camera.txt                    | 2 +-
>  Documentation/video4linux/si4713.txt                          | 2 +-
>  MAINTAINERS                                                   | 1 +
>  arch/arm/mach-omap1/include/mach/camera.h                     | 2 +-
>  arch/arm/mach-omap2/board-rx51-peripherals.c                  | 4 ++--
>  arch/arm/plat-samsung/devs.c                                  | 2 +-

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
