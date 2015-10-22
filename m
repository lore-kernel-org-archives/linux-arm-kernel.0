From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Oct 2015 10:40:57 -0700
Subject: [PATCH v5 1/4] ARM: mvebu: add broken-idle option
In-Reply-To: <1444140824-24132-2-git-send-email-simon.guinot@sequanux.org>
References: <1444140824-24132-1-git-send-email-simon.guinot@sequanux.org>
 <1444140824-24132-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <CAOesGMjUG0Ws7X7sw3H=8BNTNrwqmfPREpP0MK8RoJssAgiJ-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2015 at 7:13 AM, Simon Guinot <simon.guinot@sequanux.org> wrote:
> From: Vincent Donnefort <vdonnefort@gmail.com>
>
> The broken-idle option can be activated from the coherency-fabric DT
> node. This property allows to disable the idle capability, when the
> hardware doesn't support it, like the Seagate Personal Cloud boards.
>
> Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
> ---
>  .../devicetree/bindings/arm/coherency-fabric.txt   |  5 ++++
>  arch/arm/mach-mvebu/pmsu.c                         | 29 +++++++++++++++++++---
>  2 files changed, 31 insertions(+), 3 deletions(-)
>
> Changes for v5:
> - Make the broken-idle property boolean.
> - Don't use the broken-idle flag for Armada 38x.
>
> diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
> index 8dd46617c889..9b5c3f620e65 100644
> --- a/Documentation/devicetree/bindings/arm/coherency-fabric.txt
> +++ b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
> @@ -27,6 +27,11 @@ Required properties:
>   * For "marvell,armada-380-coherency-fabric", only one pair is needed
>     for the per-CPU fabric registers.
>
> +Optional properties:
> +
> +- broken-idle: boolean to set when the Idle mode is not supported by the
> +  hardware.
> +
>  Examples:
>
>  coherency-fabric at d0020200 {
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index e8fdb9ceedf0..cba3fa985734 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -379,6 +379,16 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
>
>  static struct platform_device mvebu_v7_cpuidle_device;
>
> +static int broken_idle(struct device_node *np)
> +{
> +       if (of_property_read_bool(np, "broken-idle")) {
> +               pr_warn("CPU idle is currently broken: disabling\n");
> +               return 0;
> +       }
> +
> +       return 1;
> +}

This is confusing. The function is called broken_idle(), but it
returns 0 if idle is broken and 1 if it isn't.

It means these tests look odd:

> +
>  static __init int armada_370_cpuidle_init(void)
>  {
>         struct device_node *np;
> @@ -387,7 +397,9 @@ static __init int armada_370_cpuidle_init(void)
>         np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
>         if (!np)
>                 return -ENODEV;
> -       of_node_put(np);
> +
> +       if (!broken_idle(np))
> +               goto end;

So, the way I read this when I read just this code is: "If idle is NOT
broken, then don't bother set up any of the idle stuff".

Please turn this the other way around so others don't make the same
mistake when reading the code.

I know it might come across as bikesheddy and nitpicky, but
readability trumps most other things when it comes to new code. :-/



-Olof
