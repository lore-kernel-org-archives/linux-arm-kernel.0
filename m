From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 17 Apr 2015 15:28:29 -0700
Subject: [PATCH v2 7/8] selftest/x86: install tests
In-Reply-To: <1429308126-5591-1-git-send-email-tyler.baker@linaro.org>
References: <1429308126-5591-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <CALCETrU+jzrt=JLYR_YAqtiEjmY5dZP_Bqus8qE-upj_zydVFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 3:02 PM, Tyler Baker <tyler.baker@linaro.org> wrote:
> Include lib.mk and set TEST_PROGS where appropriate. Skip the install and test
> case when CROSS_COMPILE is not set.
>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  tools/testing/selftests/x86/Makefile | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 9962e10..622717e 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -12,19 +12,28 @@ UNAME_M := $(shell uname -m)
>  ifeq ($(CROSS_COMPILE),)
>  # Always build 32-bit tests
>  all: all_32
> +# Install 32-bit tests
> +TEST_PROGS += $(BINARIES_32) run_x86_tests.sh
>  # If we're on a 64-bit host, build 64-bit tests as well
>  ifeq ($(UNAME_M),x86_64)
>  all: all_32 all_64
> +# Install 64-bit tests
> +TEST_PROGS += $(BINARIES_64)
>  endif
>  else
>  # No dependency on all when cross building
>  all:
> +# Skip install and test case when not built
> +override INSTALL_RULE :=
> +override EMIT_TESTS :=  echo "echo \"selftests: run_x86_tests.sh [SKIP]\""

I may just be confused, but why is an emply TEST_PROGS insufficient?

--Andy

>  endif
>
>  all_32: check_build32 $(BINARIES_32)
>
>  all_64: $(BINARIES_64)
>
> +include ../lib.mk
> +
>  clean:
>         $(RM) $(BINARIES_32) $(BINARIES_64)
>
> --
> 2.1.4
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
