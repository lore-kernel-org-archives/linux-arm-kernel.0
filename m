From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 05 May 2014 18:23:55 +0900
Subject: [PATCH 0/4] Introducing Exynos ChipId driver
In-Reply-To: <13946837.RfnRDPQdge@wuerfel>
References: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
 <13946837.RfnRDPQdge@wuerfel>
Message-ID: <536758AB.2060503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for review and suggestions.

On 05/04/2014 12:02 AM, Arnd Bergmann wrote:
> On Saturday 03 May 2014 15:11:36 Pankaj Dubey wrote:
>> This patch series attempts to get rid of soc_is_exynosXXXX macros
>> and eventually with the help of this series we can probably get
>> rid of CONFIG_SOC_EXYNOSXXXX in near future.
>> Each Exynos SoC has ChipID block which can give information about
>> SoC's product Id and revision number. Currently we have single
>> DT binding information for this as "samsung,exynos4210-chipid".
>> But Exynos4 and Exynos5 SoC series have one small difference in
>> chip Id, with resepect to product id bit-masks. So it means we
>> should have separate compatible string for these different series
>> of SoCs. So I have created new binding information for handling
>> this difference. Also currently I can think of putting this driver
>> code under "drivers/misc/" but suggestions are welcome.
>> Also current form of driver is missing platfrom driver and needs
>> init function to be called from machine file (either exynos.c or
>> platsmp.c). I hope lot of suggestions and comments to improve this
>> further.
>>
>> This patch series is based on Kukjin Kim's for-next (3.14_rc1 tag)
>> and prepared on top of following patch series and it's dependent
>> patch series.
> I think putting it into drivers/soc would be most appropriate.
> We already have a few drivers lined up that we want in there,
> although the directory currently doesn't exist.
OK. Will move to "drivers/soc". I can see already some patches
have been posted [1] by Andy Gross for creating directory
"drivers/soc" I will use those patches for adding samsung folder
under "drivers/soc".

[1]: https://lkml.org/lkml/2014/4/21/46

>
> However, I would ask that you use the infrastructure provided by
> drivers/base/soc.c when you add this driver, to also make the
> information available to user space using a standard API.

OK. Will update in next version.

>
> Ideally this should be done by slightly restructuring the DT
> source to make all on-chip devices appear below the soc node.

Currently I can't see soc nodes in exynos4 and exynos5 DT files.
So isn't it should be a separate patch first to modify all exynos4
exynos5 DT files to move all devices under soc node?
In that case existing chipid node will be also moved under soc node.

> We'd have to think a bit about how to best do this while
> preserving compatibility with existing dts files.

Is it necessary in this case?
As I have mentioned there is difference in bit-mask among exynos4
and exynos5's chipid. So is this reason not sufficient to keep separate
compatible for both?
Also even if we get some way to preserve existing compatibility, I afraid
in chipid driver that implementation will not look good, at least I am not
able to think of any good way. Any suggestions?

>
> Regarding patch 4, this is not what I meant when I asked for
> removing the soc_is_exynos* macros. You basically do a 1:1 replacement
> using a different interface, but you still have code that does
> things differently based on a global identification.
I agree with what you are trying to say. But if you see recently we had some
patches (cpu_idle.c: [2], pmu.c: [3])  to remove usage of such macros from
exynos machine files. So only leftover files using these macros are exynos.c
platsmp.c and pm.c.

For exynos.c I have tried to remove soc_is_exynos4/exynos5 by matching with
compatible string in patch 1 of this series. Please let me know if that is OK?

Also for platsmp.c and pm.c I can think of following approaches
1: Keep these macros till we get generic solution?
2: Allow chipid driver to expose APIs to check SoC id and SoC revisions 
till we get
generic solution. So that at least we can remove #ifdef  based macros
as soc_is_exynosXYZ.
3: Use of "of_flat_dt_is_compatible" or similar APIs in these machine files 
till we get
generic solution. For some cases where we want to know SoC revision let us
map chipid register and get revision there itself.

Please let me know what approach you think will be good?

[2]: http://thread.gmane.org/gmane.linux.kernel.samsung-soc/29085
[3]: https://lkml.org/lkml/2014/5/2/612
> The only user left in device drivers is now the cpufreq driver,
> which is going to be replaced anyway, so that is ok. Having
> a global variable that is accessible to random device drivers
> is probably not a good idea though, it will just lead to
> bad coding in drivers again.
>
> To give an example of how I think it should really be restructured,
> let's look at one function:
>
> static const struct exynos_wkup_irq exynos4_wkup_irq[] = {
>          { 76, BIT(1) }, /* RTC alarm */
>          { 77, BIT(2) }, /* RTC tick */
>          { /* sentinel */ },
> };
>
> static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
>          { 75, BIT(1) }, /* RTC alarm */
>          { 76, BIT(2) }, /* RTC tick */
>          { /* sentinel */ },
> };
>
> static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
> {
>          const struct exynos_wkup_irq *wkup_irq;
>
>          if (soc_is_exynos5250())
>                  wkup_irq = exynos5250_wkup_irq;
>          else
>                  wkup_irq = exynos4_wkup_irq;
>
> 	...
> }
>
> There are multiple problems with this code:
>
> - As mentioned, you depend on a specific SoC identification for
>    something that could be done completely generic.
> - The knowledge about what is a wakeup source or not doesn't
>    really belong here. We don't have a DT binding for wakeups
>    as far as I'm aware of, but this should probably be handled
>    locally in the RTC device node, possibly in the node that
>    contains the S5P_WAKEUP_MASK register.
>
> 	Arnd
>


-- 
Best Regards,
Pankaj Dubey
