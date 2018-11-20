From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 20 Nov 2018 16:23:57 +0100
Subject: [PATCH] cpuidle: big.LITTLE: add of_node_put()
In-Reply-To: <20181120130012.19471-1-tiny.windzz@gmail.com>
References: <20181120130012.19471-1-tiny.windzz@gmail.com>
Message-ID: <CAJZ5v0g==G+_HkOnjfecCimxpQgXxeTJ3e-Uyi_YHfq+BE5jRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 2:00 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> use of_node_put() to release the refcount.

I gather that the of_node_put() is missing?

If so, that should be stated in the changelog too.

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-big_little.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index db2ede565f1a..a3b8bc09bac8 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -174,8 +174,10 @@ static int __init bl_idle_init(void)
>         /*
>          * Initialize the driver just for a compliant set of machines
>          */
> -       if (!of_match_node(compatible_machine_match, root))
> -               return -ENODEV;
> +       if (!of_match_node(compatible_machine_match, root)){
> +               ret = -ENODEV;
> +               goto out_release_node;
> +       }
>
>         if (!mcpm_is_available())
>                 return -EUNATCH;
> @@ -222,6 +224,8 @@ static int __init bl_idle_init(void)
>         kfree(bl_idle_big_driver.cpumask);
>  out_uninit_little:
>         kfree(bl_idle_little_driver.cpumask);
> +out_release_node:
> +       of_node_put(root);
>
>         return ret;
>  }
> --
> 2.17.0
>
