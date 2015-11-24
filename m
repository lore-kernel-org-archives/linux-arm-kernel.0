From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 14:24:06 +0800
Subject: [PATCH v2] [media] move media platform data to
 linux/platform_data/media
In-Reply-To: <592e25aa9ecb358f48f844195252368b950059b6.1447759269.git.mchehab@osg.samsung.com>
References: <592e25aa9ecb358f48f844195252368b950059b6.1447759269.git.mchehab@osg.samsung.com>
Message-ID: <20151124062405.GK11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 09:21:13AM -0200, Mauro Carvalho Chehab wrote:
> Now that media has its own subdirectory inside platform_data,
> let's move the headers that are already there to such subdir.
> 
> After moving those files, the references were adjusted using this
> script:
> 
>     MAIN_DIR="linux/platform_data/"
>     PREV_DIR="linux/platform_data/"
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
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
