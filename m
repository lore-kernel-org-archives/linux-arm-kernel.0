From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 12 May 2015 16:02:59 -0600
Subject: [PATCH 1/2] selftests/lib.mk: fix INSTALL_RULE
In-Reply-To: <1431467947-29847-2-git-send-email-tyler.baker@linaro.org>
References: <1431467947-29847-1-git-send-email-tyler.baker@linaro.org>
 <1431467947-29847-2-git-send-email-tyler.baker@linaro.org>
Message-ID: <55527893.4070305@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2015 03:59 PM, tyler.baker at linaro.org wrote:
> From: Tyler Baker <tyler.baker@linaro.org>

This is odd. Did you use git send-email to send the patches?

-- Shuah
> 
> This patch fixes the INSTALL_RULE to gracefully handle the case where
> TEST_PROGS and TEST_PROGS_EXTENDED and TEST_FILES are not set. In this case,
> install is called without any SOURCE arguments causing make install to fail.
> The proposed fix is to loop over the items in these variables and only call
> install if there is a test artifact present.
> 
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  tools/testing/selftests/lib.mk | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index ee412ba..89dd785f 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -13,10 +13,12 @@ run_tests: all
>  
>  define INSTALL_RULE
>  	mkdir -p $(INSTALL_PATH)
> -	@for TEST_DIR in $(TEST_DIRS); do\
> +	@for TEST_DIR in $(TEST_DIRS); do \
>  		cp -r $$TEST_DIR $(INSTALL_PATH); \
>  	done;
> -	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
> +	@for ARTIFACT in $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES); do \
> +		install -t $(INSTALL_PATH) $$ARTIFACT; \
> +	done;
>  endef
>  
>  install: all
> 


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
