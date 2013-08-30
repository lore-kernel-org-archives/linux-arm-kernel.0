From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 30 Aug 2013 15:34:03 +0100
Subject: [Patch v3 3/3] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <20130830112448.GC12160@mudshark.cambridge.arm.com>
References: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
 <1377183748-5717-4-git-send-email-punit.agrawal@arm.com>
 <20130830112448.GC12160@mudshark.cambridge.arm.com>
Message-ID: <5220AD5B.2090300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/13 12:24, Will Deacon wrote:
> Hi Punit,
>
> On Thu, Aug 22, 2013 at 04:02:28PM +0100, Punit Agrawal wrote:
>> Extend the existing CCI driver to support the PMU by registering a perf
>> backend for it.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Nicolas Pitre <nico@linaro.org>
>> Cc: Dave Martin <dave.martin@linaro.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>> ---
>>   drivers/bus/arm-cci.c |  628 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 628 insertions(+)
>
> [...]
>
>> +static int cci_platform_probe(struct platform_device *pdev)
>> +{
>> +       if (!cci_probed())
>> +               return -ENODEV;
>> +
>> +       return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
>> +}
>
> cci_probed is marked as __init, so you have a section mismatch here:
>
>    arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO: return_address should use unwind tables" [-Wcpp]
>    WARNING: drivers/bus/built-in.o(.text+0xb48): Section mismatch in reference from the function cci_platform_probe() to the function .init.text:cci_probed()
>    The function cci_platform_probe() references
>    the function __init cci_probed().
>    This is often because cci_platform_probe lacks a __init
>    annotation or the annotation of cci_probed is wrong.
>

Good catch. Missed this one.

> Unfortunately, resolving this requires removing a bunch of annotations (see
> patch below), so you might want to reconsider how the probe checking is
> handled (by moving the cci_init_status check out of cci_init).
>

In cci_platform_probe, cci_probed is called to check whether the CCI has 
been initialised, and also to initialise it if required.

Even if the check for cci_init_status is moved out, I'll still need to 
call cci_init which will again cause a section mis-match.

I think removing the annotations is the way to go. Is it OK to fold your 
patch into the CCI PMU patch, or you prefer to keep it separate?

Cheers,
Punit

> Will
>
> --->8
>
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index ddc36f6..4816759 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -711,7 +711,7 @@ int cci_ace_get_port(struct device_node *dn)
>   }
>   EXPORT_SYMBOL_GPL(cci_ace_get_port);
>
> -static void __init cci_ace_init_ports(void)
> +static void cci_ace_init_ports(void)
>   {
>          int port, ac, cpu;
>          u64 hwid;
> @@ -991,7 +991,7 @@ static const struct of_device_id arm_cci_ctrl_if_matches[] = {
>          {},
>   };
>
> -static int __init cci_probe(void)
> +static int cci_probe(void)
>   {
>          struct cci_nb_ports const *cci_config;
>          int ret, i, nb_ace = 0, nb_ace_lite = 0;
> @@ -1095,7 +1095,7 @@ memalloc_err:
>   static int cci_init_status = -EAGAIN;
>   static DEFINE_MUTEX(cci_probing);
>
> -static int __init cci_init(void)
> +static int cci_init(void)
>   {
>          if (cci_init_status != -EAGAIN)
>                  return cci_init_status;
> @@ -1149,7 +1149,7 @@ static int __init cci_platform_init(void)
>    * has been initialized, if not it calls the init function that probes
>    * the driver and updates the return value.
>    */
> -bool __init cci_probed(void)
> +bool cci_probed(void)
>   {
>          return cci_init() == 0;
>   }
>
>
>
