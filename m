From: drjones@redhat.com (Andrew Jones)
Date: Fri, 7 Apr 2017 13:40:53 +0200
Subject: [RFC kvm-unit-tests PATCH 1/8] configure: make it run-able from
 outside source tree
In-Reply-To: <20170406190727.5624-2-alex.bennee@linaro.org>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
 <20170406190727.5624-2-alex.bennee@linaro.org>
Message-ID: <20170407114053.powj76325kjseqek@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 08:07:20PM +0100, Alex Benn?e wrote:
> This is a first step to enabling out-of-tree builds for
> kvm-unit-tests. When you invoke configure like this:
> 
>   ../tree.git/configure [args]
> 
> It will detect we the case and:
> 
>   - link ../tree.git/Makefile to the build-dir
>   - ensure lib is created with a correct lib/asm
>   - set SRCDIR in the config.mk
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---
>  configure | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/configure b/configure
> index 8821f37..223809c 100755
> --- a/configure
> +++ b/configure
> @@ -1,5 +1,6 @@
>  #!/bin/bash
>  
> +srcdir=$(cd "$(dirname "$0")"; pwd)

Why not just $(dirname "$0")? Any reason the path can't
be relative?  Also, could use realpath vs. the cd/pwd.

>  prefix=/usr/local
>  cc=gcc
>  ld=ld
> @@ -102,12 +103,12 @@ elif [ "$arch" = "ppc64" ]; then
>  else
>      testdir=$arch
>  fi
> -if [ ! -d $testdir ]; then
> +if [ ! -d $srcdir/$testdir ]; then
>      echo "$testdir does not exist!"
>      exit 1
>  fi
> -if [ -f $testdir/run ]; then
> -    ln -fs $testdir/run $testdir-run
> +if [ -f $srcdir/$testdir/run ]; then
> +    ln -fs $srcdir/$testdir/run $testdir-run
>  fi

$srcdir could have spaces in it, so now we need "" on all these
references, e.g. [ -f "$srcdir/$testdir/run" ]

>  
>  # check if uint32_t needs a long format modifier
> @@ -135,18 +136,27 @@ fi
>  rm -f lib_test.c
>  fi
>  
> +# Are we in a separate build tree? If so, link the Makefile
> +# so that 'make' works.
> +if test ! -e Makefile; then

[ ! -e Makefile ]

> +    echo "linking Makefile..."
> +    ln -s "${srcdir}/Makefile" .

No need for the {}

> +fi
> +
>  # link lib/asm for the architecture
>  rm -f lib/asm
>  asm=asm-generic
> -if [ -d lib/$arch/asm ]; then
> -	asm=$arch/asm
> -elif [ -d lib/$testdir/asm ]; then
> -	asm=$testdir/asm
> +if [ -d $srcdir/lib/$arch/asm ]; then
> +	asm=$srcdir/lib/$arch/asm
> +elif [ -d $srcdir/lib/$testdir/asm ]; then
> +	asm=$srcdir/lib/$testdir/asm

""'s

>  fi
> +mkdir -p lib
>  ln -s $asm lib/asm
>  
>  # create the config
>  cat <<EOF > config.mak
> +SRCDIR=$srcdir
>  PREFIX=$prefix
>  HOST=$host
>  ARCH=$arch
> -- 
> 2.11.0
>

Thanks,
drew
