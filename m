From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 6 May 2015 15:40:39 +0200
Subject: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <CAErSpo7_ev1oYptvBObK2dS9_LXkU2_W_OMD825POE6L5Yh7Lw@mail.gmail.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
 <20150505221646.GE24643@google.com>
 <CAG374jAv9aHBPGV+x+xs2MyRGz+fw1ymwu78fqNXDPtPqehgZA@mail.gmail.com>
 <CAErSpo7_ev1oYptvBObK2dS9_LXkU2_W_OMD825POE6L5Yh7Lw@mail.gmail.com>
Message-ID: <CAG374jCfo1165cbMrip5SrYigjNkXPyc-dqgmRbTQ0Yaw3wmDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Bjorn,

I agree with last reply of Arnd.
 I will mark the probe function as __init and use
platform_driver_probe() to prevent the probe function from being
deferred.
And to prevent module unloading, i will use module_init only.

Ok i will wait before sending a v4.

Thanks.
Gabriel.

On 6 May 2015 at 15:29, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, May 6, 2015 at 4:14 AM, Gabriel Fernandez
> <gabriel.fernandez@linaro.org> wrote:
>> Hi Bjorn,
>>
>> On 6 May 2015 at 00:16, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Fri, Apr 10, 2015 at 11:12:46AM +0200, Gabriel FERNANDEZ wrote:
>>>> sti pcie is built around a Synopsis Designware PCIe IP.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>>>
>>>> +/* ST PCIe driver does not allow module unload */
>>>
>>> Is there something that prevents module unload, or is it just untested?
>>>
>> Yes we haven't tested
>>
>>>> +static int __init pcie_init(void)
>>>> +{
>>>> +     return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
>>>> +}
>>>> +device_initcall(pcie_init);
>>>
>>> Can you use module_platform_driver_probe() or module_init() here?
>>>
>>
>> Yes we can use module_init() here.
>>
>> By the way if figure out i removed __init attribute on st_pcie_probe()
>> in previous version to follow Arnd's remark.
>> But st_pcie_probe calls hook_fault_code() that has __init attribute.
>> So I think we need to keep __init for probe routine ?
>> Also, we have to restrict bind/unbind with "suppress_bind_attrs" in
>> platform_driver structure.
>> This is the main reason to not allow module unload/reload.
>
> I don't really care which solution you end up with here.  But please
> do take a look at how the other drivers solve the same problem.  Using
> "device_initcall()" is unique in drivers/pci/host, and I don't believe
> the problem is unique.  If several drivers have the same issue, they
> should solve it the same way.
>
>> If you are ok i will send a v4 ?
>
> I think I'll have a few questions about the designware changes, too,
> so you might want to wait a day or two.
>
>>>> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>>>> +MODULE_DESCRIPTION("PCI express Driver for ST SoCs");
>>>> +MODULE_LICENSE("GPL v2");
>>>> --
>>>> 1.9.1
>>>>
