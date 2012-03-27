From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 27 Mar 2012 16:28:19 -0700
Subject: [PATCH 05/10] clk: align error return of basic clks registeration
In-Reply-To: <1332833009-4121-6-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
 <1332833009-4121-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAJOA=zOVVnq8DgfAzqnC+XrGtSGU7SLF+8Qwn3L76EfwqOGzNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 12:23 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> clk_register_gate and clk_register_divider return NULL for error,
> which is aligned with clk_register function. ?But clk_register_mux
> and clk_register_fixed_rate return ERR_PTR. ?Change them to return
> NULL for better aligning with other registeration functions.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks for the patch Shawn, but this is actually the opposite
direction that I want to go.  In light of the other thread with
Saravana and Russell on a similar topic, I'd like to make sure that
the driver-facing functions clearly return -EERROR during failure.
I've lined up a patch for the same on my side.

Regards,
Mike

> ---
> ?drivers/clk/clk-fixed-rate.c | ? ?2 +-
> ?drivers/clk/clk-mux.c ? ? ? ?| ? ?2 +-
> ?2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> index 027e477..d268439 100644
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -50,7 +50,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
>
> ? ? ? ?if (!fixed) {
> ? ? ? ? ? ? ? ?pr_err("%s: could not allocate fixed clk\n", __func__);
> - ? ? ? ? ? ? ? return ERR_PTR(-ENOMEM);
> + ? ? ? ? ? ? ? return NULL;
> ? ? ? ?}
>
> ? ? ? ?/* struct clk_fixed_rate assignments */
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 5424488..19f3116 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -99,7 +99,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
>
> ? ? ? ?if (!mux) {
> ? ? ? ? ? ? ? ?pr_err("%s: could not allocate mux clk\n", __func__);
> - ? ? ? ? ? ? ? return ERR_PTR(-ENOMEM);
> + ? ? ? ? ? ? ? return NULL;
> ? ? ? ?}
>
> ? ? ? ?/* struct clk_mux assignments */
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
