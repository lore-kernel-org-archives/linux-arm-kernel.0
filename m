From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 14 May 2012 14:53:04 -0700
Subject: [PATCH] clk: Constify struct clk_init_data
In-Reply-To: <1337004763-21250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1337004763-21250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120514215304.GB3075@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 7:12 AM, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> Allow drivers to declare their clk_init_data const, the framework really
> shouldn't be modifying the data.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

+interested parties

Mark, I like this change but it's reminded me of a few things I meant to
bring up on the list in the past.  Certainly some folks will mark their
struct clk_hw_init data as __initconst.  Currently none of the
documentation mentions that fact and I'm a bit worried about clk code
which assumes that hw->init will always be around and freely accesses
it.

I think that, as a rule, hw->init cannot be assumed to be valid after
clk_register returns.  Would anyone else like to weigh in on it?  If so
then I'll cook up a follow-up patch to reflect this in the kerneldoc.

Thanks,
Mike

> ---
> ?include/linux/clk-provider.h | ? ?2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index c1c23b9..fc43ea6 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -143,7 +143,7 @@ struct clk_init_data {
> ?*/
> ?struct clk_hw {
> ? ? ? ?struct clk *clk;
> - ? ? ? struct clk_init_data *init;
> + ? ? ? const struct clk_init_data *init;
> ?};
>
> ?/*
> --
> 1.7.10
>
