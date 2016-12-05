From: dianders@chromium.org (Doug Anderson)
Date: Mon, 5 Dec 2016 08:13:12 -0800
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <305f6531-3102-d0f5-cb22-bdd965e39519@laposte.net>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
 <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
 <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
 <66751ab5-59a4-ec30-07cd-44ca03694723@laposte.net>
 <d1801c1e-cd74-b79c-0280-8fb5dc377c91@intel.com>
 <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
 <485a747c-47e3-bc0e-093a-4ec9ab719987@laposte.net>
 <CAD=FV=XrJHFbpbhsJZAEE-HLMe47Ov=BgvHw8ZtfCazzT75pKQ@mail.gmail.com>
 <305f6531-3102-d0f5-cb22-bdd965e39519@laposte.net>
Message-ID: <CAD=FV=VfVUETgDkgHRzVn8yGm4zuKuRTmmZgPKuq3sbwacHLQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 5, 2016 at 4:28 AM, Sebastian Frias <sf84@laposte.net> wrote:
> Hi Doug,
>
> On 28/11/16 18:46, Doug Anderson wrote:
>> Hi,
>>
>> On Mon, Nov 28, 2016 at 6:39 AM, Sebastian Frias <sf84@laposte.net> wrote:
>>>> I will try to send another patch with what a different approach
>>>>
>>>
>>> Here's a different approach (I just tested that it built, because I don't have the
>>> rk3399 platform):
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>> index 410a55b..5be6e67 100644
>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>> @@ -382,22 +382,6 @@ static int sdhci_arasan_resume(struct device *dev)
>>>  static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>>>                          sdhci_arasan_resume);
>>>
>>> -static const struct of_device_id sdhci_arasan_of_match[] = {
>>> -       /* SoC-specific compatible strings w/ soc_ctl_map */
>>> -       {
>>> -               .compatible = "rockchip,rk3399-sdhci-5.1",
>>> -               .data = &rk3399_soc_ctl_map,
>>> -       },
>>> -
>>> -       /* Generic compatible below here */
>>> -       { .compatible = "arasan,sdhci-8.9a" },
>>> -       { .compatible = "arasan,sdhci-5.1" },
>>> -       { .compatible = "arasan,sdhci-4.9a" },
>>> -
>>> -       { /* sentinel */ }
>>> -};
>>> -MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
>>> -
>>>  /**
>>>   * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
>>>   *
>>> @@ -578,28 +562,18 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
>>>         of_clk_del_provider(dev->of_node);
>>>  }
>>>
>>> -static int sdhci_arasan_probe(struct platform_device *pdev)
>>> +static int sdhci_rockchip_platform_init(struct sdhci_host *host,
>>> +                                       struct platform_device *pdev)
>>>  {
>>>         int ret;
>>> -       const struct of_device_id *match;
>>>         struct device_node *node;
>>> -       struct clk *clk_xin;
>>> -       struct sdhci_host *host;
>>>         struct sdhci_pltfm_host *pltfm_host;
>>>         struct sdhci_arasan_data *sdhci_arasan;
>>> -       struct device_node *np = pdev->dev.of_node;
>>> -
>>> -       host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
>>> -                               sizeof(*sdhci_arasan));
>>> -       if (IS_ERR(host))
>>> -               return PTR_ERR(host);
>>>
>>>         pltfm_host = sdhci_priv(host);
>>>         sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>>> -       sdhci_arasan->host = host;
>>>
>>> -       match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
>>> -       sdhci_arasan->soc_ctl_map = match->data;
>>> +       sdhci_arasan->soc_ctl_map = &rk3399_soc_ctl_map;
>>>
>>>         node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
>>>         if (node) {
>>> @@ -611,10 +585,107 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>>                         if (ret != -EPROBE_DEFER)
>>>                                 dev_err(&pdev->dev, "Can't get syscon: %d\n",
>>>                                         ret);
>>> -                       goto err_pltfm_free;
>>> +                       return -1;
>>>                 }
>>>         }
>>>
>>> +       if (of_property_read_bool(pdev->dev.of_node, "xlnx,fails-without-test-cd"))
>>> +               sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int sdhci_rockchip_clock_init(struct sdhci_host *host,
>>> +                                       struct platform_device *pdev)
>>> +{
>>> +       struct sdhci_pltfm_host *pltfm_host;
>>> +       struct sdhci_arasan_data *sdhci_arasan;
>>> +
>>> +       pltfm_host = sdhci_priv(host);
>>> +       sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>>> +
>>> +       if (of_device_is_compatible(pdev->dev.of_node,
>>> +                                   "rockchip,rk3399-sdhci-5.1"))
>>> +               sdhci_arasan_update_clockmultiplier(host, 0x0);
>>
>> This _does_ belong in a Rockchip-specific init function, for now.
>
> I'm not sure I understood. Are you saying that you agree to put this
> into a specific function? Essentially agreeing with the concept the
> patch is putting forward?
>
> Note, I'm more interested in the concept (i.e.: init functions) and less
> in knowing if my patch (which was a quick and dirty thing) properly moved
> the functions into the said init functions. For example, I did not move
> the code dealing with "arasan,sdhci-5.1", but it could go into another
> callback.
>
> Right now there are no "chip-specific" functions.
> Just a code in sdhci_arasan_probe() that by checking various compatible
> strings and the presence of other specific properties, acts as a way of
> "chip-specific" initialisation, because it calls or not some functions.
> (or the functions do nothing if some DT properties are not there).
>
> The proposed patch is an attempt to clean up sdhci_arasan_probe() from
> all those checks and move them into separate functions, for clarity and
> maintainability reasons.
>
> What are your thoughts in that regard?
>
> From what I've seen in other drivers, for example drivers/net/ethernet/aurora/nb8800.c
> One matches the compatible string to get a (likely) chip-specific set of
> callbacks to use in the 'probe' function.

I have no objections to chip-specific functions if they are needed.
It's really just a cleaner way to avoid doing "if this chip then, else
if this other chip then, else if this third chip them".

The thing I worry about is that too much stuff will be jammed into
chip-specific functions and that we'll end up solving the same thing
more than one way.


> Then, adding support for other chips is just a matter of replacing some
> of those callbacks with others adapted to a given platform.
>
>> Other platforms might want different values for
>> corecfg_clockmultiplier, I think.
>>
>> If it becomes common to need to set this, it wouldn't be hard to make
>> it generic by putting it in the data matched by the device tree, then
>> generically call sdhci_arasan_update_clockmultiplier() in cases where
>> it is needed.  sdhci_arasan_update_clockmultiplier() itself should be
>> generic enough to handle it.
>>
>>
>>> +
>>> +       sdhci_arasan_update_baseclkfreq(host);
>>
>> If you make soc_ctl_map always part of "struct sdhci_arasan_cs_ops"
>> then other platforms will be able to use it.
>
> I thought that soc_ctl_map was specific and for a given platform.

I believe the soc_ctl_map will be used by more than one chip, mostly
because I saw these same fields referenced in the generic
(non-Rockchip) Arasan docs.  Obviously I have a very small view of the
SDHCI-Arasan world though.


> For what is worth, I don't know which of these calls are or can be made
> generic or not.
>
> Indeed, I'm not an expert in this code; However, I think that given the
> amount of checks for specific properties, probably part of this is chip-
> specific, and as such, it would benefit from some re-factoring so that
> the chip-specific parts are clearly separated from the rest, instead of
> being mixed together inside the probe function.

I believe the only chip-specific stuff was the part that is currently
guarded by the "if rk3399" check.  Everything else seems like it ought
to be applicable to other platforms using Arasan's SDHCI IP.


>> As argued in my original patch the field "corecfg_baseclkfreq" is
>> documented in the generic Arasan document
>> <https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf>
>> and thus is unlikely to be Rockchip specific.  It is entirely possible
>> that not everyone who integrates this IP block will need this register
>> set, but in that case they can set an offset as "-1" and they'll be
>> fine.
>>
>> Said another way: the concept of whether or not to set "baseclkfreq"
>> doesn't need to be tired to whether or not we're on Rockchip.
>>
>
> I see.
> For what is worth, the documentation for 'sdhci_arasan_update_baseclkfreq()'
> says something like:
>
>  *   Many existing devices don't seem to do this and work fine.  To keep
>  *   compatibility for old hardware where the device tree doesn't provide a
>  *   register map, this function is a noop if a soc_ctl_map hasn't been provided
>  *   for this platform.

Yup.  I wrote that.  See "git blame".
