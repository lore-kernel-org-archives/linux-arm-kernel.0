From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 14 Sep 2012 11:23:03 +0800
Subject: [PATCH] ARM: mmp: using for_each_set_bit to simplify the code
In-Reply-To: <CAPgLHd-ac3JYu4SEQd0pPO-YBW4kM+DqcjHs3QzPdLWqc+CXfw@mail.gmail.com>
References: <CAPgLHd-ac3JYu4SEQd0pPO-YBW4kM+DqcjHs3QzPdLWqc+CXfw@mail.gmail.com>
Message-ID: <CAMPhdO8G_GzOBKB=pdWgKv5GxnYoSNC2mRVwpHYqz4d648pwkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 10:30 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Using for_each_set_bit() to simplify the code.
>
> spatch with a semantic match is used to found this.
> (http://coccinelle.lip6.fr/)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Great API, this is good. Acked-by: Eric Miao <eric.y.miao@gmail.com>

> ---
>  arch/arm/mach-mmp/irq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
> index e60c7d9..3c71246 100644
> --- a/arch/arm/mach-mmp/irq.c
> +++ b/arch/arm/mach-mmp/irq.c
> @@ -153,10 +153,8 @@ static void icu_mux_irq_demux(unsigned int irq, struct irq_desc *desc)
>                 status = readl_relaxed(data->reg_status) & ~mask;
>                 if (status == 0)
>                         break;
> -               n = find_first_bit(&status, BITS_PER_LONG);
> -               while (n < BITS_PER_LONG) {
> +               for_each_set_bit(n, &status, BITS_PER_LONG) {
>                         generic_handle_irq(icu_data[i].virq_base + n);
> -                       n = find_next_bit(&status, BITS_PER_LONG, n + 1);
>                 }
>         }
>  }
>
