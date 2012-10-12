From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 12 Oct 2012 14:25:32 +0300
Subject: [PATCH 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAKohponxbjTTDMOA_0=MT36wRh1NpzTAH4LdkaE=Z-ahup4BFg@mail.gmail.com>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350020375.git.viresh.kumar@linaro.org>
 <91e41b4cc972d298f714cbd6f400569a9710304c.1350020375.git.viresh.kumar@linaro.org>
 <1350030203.10584.139.camel@smile>
 <CAOh2x=m8OVNfMm5Fn+cr9Gxuh6oyt+8d4n-bkG8Xiw5zGncLiA@mail.gmail.com>
 <CAHp75VffAwZjfQLf=wS+nBhiRoMFOoyPeUCfrzF1G=+Kh7HHTA@mail.gmail.com>
 <CAKohponxbjTTDMOA_0=MT36wRh1NpzTAH4LdkaE=Z-ahup4BFg@mail.gmail.com>
Message-ID: <CAHp75Vcte64KF5k5gDjMtyff8KsOof-yT7iVWc3Gz_ECL+0+Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 2:01 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 12 October 2012 16:10, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>>> +     if (!found) {
>>>>> +             last_dw = dw;
>>>>> +             last_bus_id = param;
>>>>> +             return false;
>>>> Because of return here you could eliminate 'found' flag at all.
>
> Here is the stuff copied from you ;)
>
>
> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index a4ff04c..c24859e 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -1184,7 +1184,7 @@ bool dw_generic_filter(struct dma_chan *chan, void *param)
>         struct dw_dma *dw = to_dw_dma(chan->device);
>         static struct dw_dma *last_dw;
>         static char *last_bus_id;
> -       int found = 0, i = -1;
> +       int i = -1;
>
>         /*
>          * dmaengine framework calls this routine for all channels of all dma
> @@ -1212,22 +1212,17 @@ bool dw_generic_filter(struct dma_chan *chan,
> void *param)
>
>         while (++i < dw->sd_count) {
>                 if (!strcmp(dw->sd[i].bus_id, param)) {
> -                       found = 1;
> -                       break;
> -               }
> -       }
> +                       chan->private = &dw->sd[i];
> +                       last_dw = NULL;
> +                       last_bus_id = NULL;
>
> -       if (!found) {
> -               last_dw = dw;
> -               last_bus_id = param;
> -               return false;
> +                       return true;
> +               }
>         }
>
> -       chan->private = &dw->sd[i];
> -       last_dw = NULL;
> -       last_bus_id = NULL;
> -
> -       return true;
> +       last_dw = dw;
> +       last_bus_id = param;
> +       return false;
>  }
Yes, that what I refer to.

>  EXPORT_SYMBOL(dw_generic_filter);
Could we change a name to be more precise, like dw_dma_generic_filter ?


-- 
With Best Regards,
Andy Shevchenko
