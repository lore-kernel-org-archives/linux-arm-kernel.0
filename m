From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 7 Dec 2011 22:19:41 +0530
Subject: [PATCH 4/4] arm: exynos4: add device tree support for external
 wakeup interrupt controller
In-Reply-To: <4EDF9169.2030100@gmail.com>
References: <1323266392-28330-1-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-2-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-3-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-4-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-5-git-send-email-thomas.abraham@linaro.org>
 <4EDF9169.2030100@gmail.com>
Message-ID: <CAJuYYwSp_5Bvcz7JqP7u6xd5DQXBRroezFNCRNh=A=Vf+pAhZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 7 December 2011 21:46, Rob Herring <robherring2@gmail.com> wrote:
> On 12/07/2011 07:59 AM, Thomas Abraham wrote:
>> Add device tree support for external wakeup source interrupt controller
>> on Exynos4.
>>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---

[...]

>> diff --git a/Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt b/Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt
>> new file mode 100644
>> index 0000000..0ca5782
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt
>> @@ -0,0 +1,14 @@
>> +* Samsung Exynos4 External Wakeup Interrupt Source Controller
>> +
>> +Samsung Exynos4 processor supports 32 external wakeup interrupt sources. First
>> +16 of these interrupts are directly connected to GIC and the rest 16 of the
>> +interrupts are grouped together to deliver a single interrupt to GIC.
>> +
>> +Required properties:
>> +
>> +- compatible: should be "samsung,exynos4210-wakeup-eint".
>> +- interrupt-controller: Identifies the node as an interrupt controller.
>> +- interrupt-cells: Specifies the number of cells required to specify the
>> + ? ?interrupt source number. The value of should be <2>. The first cell
>> + ? ?represents the wakeup interrupt source number and the second cell
>> + ? ?should be zero (currently unused).
>
> interrupt-parent needs to be set to the gic?

Yes, I missed that. gic is set as the interrupt parent in the root
node and all child nodes inherit it. I will add interrupt-parent as
the required property as list gic as the parent.

>
>> diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c

[...]

>> +#ifdef CONFIG_OF
>> + ? ? if (of_have_populated_dt()) {
>> + ? ? ? ? ? ? domain->of_node = of_find_compatible_node(NULL, NULL,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "samsung,exynos4210-wakeup-eint");
>> + ? ? ? ? ? ? if (!domain->of_node)
>> + ? ? ? ? ? ? ? ? ? ? pr_info("exynos4_init_irq_eint: of_node not found\n");
>> + ? ? }
>> +#endif
>
> Your function prototype is wrong for of_irq_init as it provides you the
> node ptr.

Thanks. I got this wrong. That would make the code above much simpler.
I will fix this.

>
> Otherwise, the series looks pretty good.
>
> Rob

Thanks for your review and comments.

Regards,
Thomas.
