From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 13 May 2015 15:41:47 -0600
Subject: [PATCH 2/2] selftests/breakpoints: only set TEST_PROGS when built
In-Reply-To: <1431467947-29847-3-git-send-email-tyler.baker@linaro.org>
References: <1431467947-29847-1-git-send-email-tyler.baker@linaro.org>
 <1431467947-29847-3-git-send-email-tyler.baker@linaro.org>
Message-ID: <5553C51B.6080504@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2015 03:59 PM, tyler.baker at linaro.org wrote:
> From: Tyler Baker <tyler.baker@linaro.org>
> 
> Set TEST_PROGS only when a build has occurred.
> 
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  tools/testing/selftests/breakpoints/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing/selftests/breakpoints/Makefile
> index 1822356..54cc3e7 100644
> --- a/tools/testing/selftests/breakpoints/Makefile
> +++ b/tools/testing/selftests/breakpoints/Makefile
> @@ -12,12 +12,11 @@ endif
>  all:
>  ifeq ($(ARCH),x86)
>  	gcc breakpoint_test.c -o breakpoint_test
> +	TEST_PROGS := breakpoint_test
>  else
>  	echo "Not an x86 target, can't build breakpoints selftests"
>  endif
>  
> -TEST_PROGS := breakpoint_test
> -
>  include ../lib.mk
>  
>  clean:
> 

Hmm. With this change install fails to copy breakpoint_test all
together. Remember setting TEST_PROGS in compile step makes it
not stick around when install target is called. A better approach
would be the following:

if [ -f breakpoint_test ]
    TEST_PROGS := breakpoint_test
fi

include ../lib.mk

-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
