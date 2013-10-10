From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 17:11:26 +0200
Subject: [PATCH 6/6] cpufreq: probe the Integrator cpufreq driver from DT
In-Reply-To: <20131008100044.GF28972@e106331-lin.cambridge.arm.com>
References: <1380816238-3255-1-git-send-email-linus.walleij@linaro.org>
 <20131008100044.GF28972@e106331-lin.cambridge.arm.com>
Message-ID: <CACRpkdY7kiuBzN=tYW-iGdW+LjvJ+oEg4WwOkxX_XnprOtZXVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 12:00 PM, Mark Rutland <mark.rutland@arm.com> wrote:

>> +static int __init integrator_cpufreq_probe(struct platform_device *pdev)
>>  {
>> +     struct device_node *np = pdev->dev.of_node;
>> +
>> +     cm_base = of_iomap(np, 0);
>> +     if (!cm_base)
>> +             return -ENODEV;
>>       return cpufreq_register_driver(&integrator_driver);
>
> If we fail to register the driver we could unmap cm_base, no?

Using devm_* is better so I'll revise it to do this.

>> -static void __exit integrator_cpu_exit(void)
>> +static void __exit integrator_cpufreq_remove(struct platform_device *pdev)
>>  {
>>       cpufreq_unregister_driver(&integrator_driver);
>
> Unmap here?

Dito. Check v2.

>> +static const struct of_device_id integrator_cpufreq_match[] = {
>> +     { .compatible = "arm,core-module-integrator"},
>> +     { },
>> +};
>
> It feels a little scary that this also got handled by some other code in
> the previous patch. Is no arbitrarion required between the two when
> accessing the core module registers?

They are using totally different registers, so it should not be an
issue. Inside the mach folder there is some arbitration for the
register that is actually accessed by several consumers.

Yours,
Linus Walleij
