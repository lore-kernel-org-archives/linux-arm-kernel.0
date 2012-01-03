From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 3 Jan 2012 13:53:28 +0530
Subject: [PATCH 2/2] ARM: Exynos: Hook up power domains to generic power
 domain infrastructure
In-Reply-To: <4F022D7D.3060802@gmail.com>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>
 <4EFB66C3.4040504@gmail.com>
 <CAJuYYwQbTJTRdsa9WpQuCtSTYacbrcP3CVBFaAYHP1jLPky10A@mail.gmail.com>
 <4F022D7D.3060802@gmail.com>
Message-ID: <CAJuYYwSGYnyq+hEbgpyvFoAB9LWWLhD2URaWsCC4vMyZwRQVbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 3 January 2012 03:49, Sylwester Nawrocki <snjw23@gmail.com> wrote:
> Hi Thomas,
>
> thank you for clarifying.
>
> On 01/02/2012 03:14 AM, Thomas Abraham wrote:
>>
>> The following is a snippet from the dts file used for testing.
>>
>> ? ?[...]
>>
>> ? ?lcd0:power-domain-lcd0 {
>> ? ? ? ? ? ? compatible = "samsung,exynos4210-pd";
>> ? ? ? ? ? ? reg = <0x10023C00 0x10>;
>> ? ?};
>>
>> ? ?[...]
>>
>> ? ?fimd0:display-controller {
>> ? ? ? ? ? ? compatible = "samsung,exynos4-fimd";
>> ? ? ? ? ? ? [...]
>> ? ? ? ? ? ? pd = <&lcd0>;
>> ? ?};
>>
>> The fimd (display controller) driver would then do the following.
>>
>> parp = of_get_property(pdev->dev.of_node, "pd", NULL);
>> pd_np = of_find_node_by_phandle(be32_to_cpup(parp));
>> pm_genpd_of_add_device(pd_np, &pdev->dev);
>
> Sounds interesting. Currently it's platform code that adds devices to
> a corresponding power domain. But doing it at drivers might be more
> convenient for avoiding device/driver/power domain registration
> synchronization issues, especially that knowledge about power domain
> existence may be contained directly in DT description, not needing
> drivers to carry platform specific data.
>
> BTW, I have a feeling that "samsung" is a bit longish prefix for the bindings.
> Didn't you initially consider "sec" for instance ? Probably it is already
> too late for changing that though.

I had not thought of "sec". I agree that "sec" would have been better
as it is shorter and represents bindings specific to Samsung
Electronics. But it is not intuitive at the same time. If there is
greater consensus on using "sec", we could try and request for a
change but looks difficult to get through.

Thanks,
Thomas.

>
>> The lookup is based on the node pointer of the power domain.
>
> Thanks,
> Sylwester
