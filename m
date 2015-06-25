From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 25 Jun 2015 17:33:56 +0200
Subject: [PATCH v14 2/3] power-domain: rockchip: add power domain driver
In-Reply-To: <557CF1D6.4090506@163.com>
References: <1429862868-14218-1-git-send-email-wxt@rock-chips.com>
 <1429862868-14218-3-git-send-email-wxt@rock-chips.com>
 <CAPDyKFrBzZjOVZzq9unQQwm2BSA0kzeT7EE8_kSpH_udMKjo6A@mail.gmail.com>
 <557CF1D6.4090506@163.com>
Message-ID: <CAPDyKFqa9cQin2HUFuLO_-sSkeASSr08b-3DZ5xGbYHQBPxKag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>> +#include <linux/clk-provider.h>
>>
>> clk-provider.h, why?
>
>
> The following is needed.
>
> _clk_get_name(clk)

I see, you need it for for the dev_dbg().

I think you shall use "%pC" as the formatting string for the dev_dbg()
message, since that will take care of printing the clock name for you.

[...]

>>> +static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool
>>> power_on)
>>> +{
>>> +       int i;
>>> +
>>> +       mutex_lock(&pd->pmu->mutex);
>>
>> I don't quite understand why you need a lock, what are you protecting and
>> why?
>
>
> Says:
> [ 3551.678762] mali ffa30000.gpu: starting device in power domain 'pd_gpu'
> [ 3551.899180] mali ffa30000.gpu: stopping device in power domain 'pd_gpu'
> [ 3551.905958] mali ffa30000.gpu: starting device in power domain 'pd_gpu'
> [ 3551.912832] mali ffa30000.gpu: stopping device in power domain 'pd_gpu'
> [ 3551.919730] rockchip_pd_power:139: mutex_lock
> [ 3551.924130] rockchip_pd_power:167,mutex_unlock
> [ 3563.827295] rockchip_pd_power:139: mutex_lock
> [ 3563.831753] rockchip_pd_power:167,mutex_unlock
> [ 3563.836216] mali ffa30000.gpu: starting device in power domain 'pd_gpu'
> [ 3564.058989] mali ffa30000.gpu: stopping device in power domain 'pd_gpu'
> [ 3564.065659] mali ffa30000.gpu: starting device in power domain 'pd_gpu'
> [ 3564.072354] mali ffa30000.gpu: stopping device in power domain 'pd_gpu'
> [ 3564.079047] rockchip_pd_power:139: mutex_lock
> [ 3564.083426] rockchip_pd_power:167,mutex_unlock
> [ 3611.665726] rockchip_pd_power:139: mutex_lock
> [ 3611.670206] rockchip_pd_power:167,mutex_unlock
> [ 3611.674692] mali ffa30000.gpu: starting device in power domain 'pd_gpu'
> [ 3611.899160] mali ffa30000.gpu: stopping device in power domain 'pd_gpu'
> [ 3611.905938] mali ffa30000.gpu: starting device in power domain 'pd_gpu'
> [ 3611.912818] mali ffa30000.gpu: stopping device in power domain 'pd_gpu'
> [ 3611.919689] rockchip_pd_power:139: mutex_lock
> [ 3611.924090] rockchip_pd_power:167,mutex_unlock
> [ 3623.848296] rockchip_pd_power:139: mutex_lock
> [ 3623.852752] rockchip_pd_power:167,mutex_unlock
>
>
>
>
>>> +
>>> +       if (rockchip_pmu_domain_is_on(pd) != power_on) {
>>> +               for (i = 0; i < pd->num_clks; i++)
>>> +                       clk_enable(pd->clks[i]);
>>> +
>>> +               if (!power_on) {
>>> +                       /* FIXME: add code to save AXI_QOS */
>>> +
>>> +                       /* if powering down, idle request to NIU first */
>>> +                       rockchip_pmu_set_idle_request(pd, true);
>>> +               }
>>> +
>>> +               rockchip_do_pmu_set_power_domain(pd, power_on);
>>> +
>>> +               if (power_on) {
>>> +                       /* if powering up, leave idle mode */
>>> +                       rockchip_pmu_set_idle_request(pd, false);
>>> +
>>> +                       /* FIXME: add code to restore AXI_QOS */
>>> +               }
>>> +
>>> +               for (i = pd->num_clks - 1; i >= 0; i--)
>>> +                       clk_disable(pd->clks[i]);
>>> +       }
>>> +
>>> +       mutex_unlock(&pd->pmu->mutex);
>>> +       return 0;
>>> +}
>>> +
>>> +static int rockchip_pd_power_on(struct generic_pm_domain *domain)
>>> +{
>>> +       struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
>>> +
>>> +       return rockchip_pd_power(pd, true);
>>> +}
>>> +
>>> +static int rockchip_pd_power_off(struct generic_pm_domain *domain)
>>> +{
>>> +       struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
>>> +
>>> +       return rockchip_pd_power(pd, false);
>>> +}
>>> +
>>> +static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
>>> +                                 struct device *dev)
>>> +{
>>> +       struct clk *clk;
>>> +       int i;
>>> +       int error;
>>> +
>>> +       dev_dbg(dev, "attaching to power domain '%s'\n", genpd->name);
>>> +
>>> +       error = pm_clk_create(dev);
>>> +       if (error) {
>>> +               dev_err(dev, "pm_clk_create failed %d\n", error);
>>> +               return error;
>>> +       }
>>> +
>>> +       i = 0;
>>> +       while ((clk = of_clk_get(dev->of_node, i++)) && !IS_ERR(clk)) {
>>
>> This loop adds all available device clocks to the PM clock list. I
>> wonder if this could be considered as a common thing and if so, we
>> might want to extend the pm_clk API with this.
>
>
> There are several reasons as follows:
>
>     Firstly, the clocks need be turned off to save power when
>     the system enter the suspend state. So we need to enumerate the clocks
>     in the dts. In order to power domain can turn on and off.
>
>     Secondly, the reset-circuit should reset be synchronous on rk3288, then
> sync revoked.
>     So we need to enable clocks of all devices.

I think you misinterpreted my previous answer. Instead of fetching all
clocks for a device and manually create the pm_clk list as you do
here, I was suggesting to make this a part of the pm clk API.

I would happily support such an API, but I can't tell what the other
maintainers think.

>
>>> +               dev_dbg(dev, "adding clock '%s' to list of PM clocks\n",
>>> +                       __clk_get_name(clk));
>>> +               error = pm_clk_add_clk(dev, clk);
>>> +               clk_put(clk);
>>> +               if (error) {
>>> +                       dev_err(dev, "pm_clk_add_clk failed %d\n",
>>> error);
>>> +                       pm_clk_destroy(dev);
>>> +                       return error;
>>> +               }
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +

[...]

>>> +
>>> +static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>>> +                                     struct device_node *node)
>>> +{
>>> +       const struct rockchip_domain_info *pd_info;
>>> +       struct rockchip_pm_domain *pd;
>>> +       struct clk *clk;
>>> +       int clk_cnt;
>>> +       int i;
>>> +       u32 id;
>>> +       int error;
>>> +
>>> +       error = of_property_read_u32(node, "reg", &id);
>>> +       if (error) {
>>> +               dev_err(pmu->dev,
>>> +                       "%s: failed to retrieve domain id (reg): %d\n",
>>> +                       node->name, error);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       if (id >= pmu->info->num_domains) {
>>> +               dev_err(pmu->dev, "%s: invalid domain id %d\n",
>>> +                       node->name, id);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       pd_info = &pmu->info->domain_info[id];
>>> +       if (!pd_info) {
>>> +               dev_err(pmu->dev, "%s: undefined domain id %d\n",
>>> +                       node->name, id);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       clk_cnt = of_count_phandle_with_args(node, "clocks",
>>> "#clock-cells");
>>> +       pd = devm_kzalloc(pmu->dev,
>>> +                         sizeof(*pd) + clk_cnt * sizeof(pd->clks[0]),
>>> +                         GFP_KERNEL);
>>> +       if (!pd)
>>> +               return -ENOMEM;
>>> +
>>> +       pd->info = pd_info;
>>> +       pd->pmu = pmu;
>>> +
>>> +       for (i = 0; i < clk_cnt; i++) {
>>
>> This loop is similar to the one when creates the PM clock list in the
>> rockchip_pd_attach_dev().
>>
>> What's the reason you don't want to use pm clk for these clocks?
>>
>
> Ditto.

I don't follow. Can't you do the exact same thing via the pm clk API,
can you please elaborate!?

>
>>> +               clk = of_clk_get(node, i);
>>> +               if (IS_ERR(clk)) {
>>> +                       error = PTR_ERR(clk);
>>> +                       dev_err(pmu->dev,
>>> +                               "%s: failed to get clk %s (index %d):
>>> %d\n",
>>> +                               node->name, __clk_get_name(clk), i,
>>> error);
>>> +                       goto err_out;
>>> +               }
>>> +
>>> +               error = clk_prepare(clk);
>>> +               if (error) {
>>> +                       dev_err(pmu->dev,
>>> +                               "%s: failed to prepare clk %s (index %d):
>>> %d\n",
>>> +                               node->name, __clk_get_name(clk), i,
>>> error);
>>> +                       clk_put(clk);
>>> +                       goto err_out;
>>> +               }
>>> +
>>> +               pd->clks[pd->num_clks++] = clk;
>>> +
>>> +               dev_dbg(pmu->dev, "added clock '%s' to domain '%s'\n",
>>> +                       __clk_get_name(clk), node->name);
>>> +       }
>>> +
>>> +       error = rockchip_pd_power(pd, true);
>>> +       if (error) {
>>> +               dev_err(pmu->dev,
>>> +                       "failed to power on domain '%s': %d\n",
>>> +                       node->name, error);
>>> +               goto err_out;
>>> +       }
>>> +
>>> +       pd->genpd.name = node->name;
>>> +       pd->genpd.power_off = rockchip_pd_power_off;
>>> +       pd->genpd.power_on = rockchip_pd_power_on;
>>> +       pd->genpd.attach_dev = rockchip_pd_attach_dev;
>>> +       pd->genpd.detach_dev = rockchip_pd_detach_dev;
>>> +       pd->genpd.dev_ops.start = rockchip_pd_start_dev;
>>> +       pd->genpd.dev_ops.stop = rockchip_pd_stop_dev;
>>
>> Instead of assigning the ->stop|start() callbacks, which do
>> pm_clk_suspend|resume(), just set the genpd->flags to
>> GENPD_FLAG_PM_CLK, and genpd will fix this for you.
>>
> Ditto.

Again, I don't follow. Here is what goes on:

rockchip_pd_start_dev() calls pm_clk_resume() and
rockchip_pd_stop_dev() calls pm_clk_suspend().
Instead of assigning the below callbacks...

pd->genpd.dev_ops.start = rockchip_pd_start_dev;
pd->genpd.dev_ops.stop = rockchip_pd_stop_dev;

... just use GENPD_FLAG_PM_CLK and let genpd deal with the calls to
pm_clk_suspend|resume().

>
>
>>> +       pm_genpd_init(&pd->genpd, NULL, false);
>>> +
>>> +       pmu->genpd_data.domains[id] = &pd->genpd;
>>> +       return 0;
>>> +
>>> +err_out:
>>> +       while (--i >= 0) {
>>> +               clk_unprepare(pd->clks[i]);
>>> +               clk_put(pd->clks[i]);
>>> +       }
>>> +       return error;
>>> +}
>>> +

[...]

Kind regards
Uffe
