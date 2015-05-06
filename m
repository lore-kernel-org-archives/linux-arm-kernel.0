From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 6 May 2015 11:14:25 +0200
Subject: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <20150505221646.GE24643@google.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
 <20150505221646.GE24643@google.com>
Message-ID: <CAG374jAv9aHBPGV+x+xs2MyRGz+fw1ymwu78fqNXDPtPqehgZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 6 May 2015 at 00:16, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Apr 10, 2015 at 11:12:46AM +0200, Gabriel FERNANDEZ wrote:
>> sti pcie is built around a Synopsis Designware PCIe IP.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>
>> +/* ST PCIe driver does not allow module unload */
>
> Is there something that prevents module unload, or is it just untested?
>
Yes we haven't tested

>> +static int __init pcie_init(void)
>> +{
>> +     return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
>> +}
>> +device_initcall(pcie_init);
>
> Can you use module_platform_driver_probe() or module_init() here?
>

Yes we can use module_init() here.

By the way if figure out i removed __init attribute on st_pcie_probe()
in previous version to follow Arnd's remark.
But st_pcie_probe calls hook_fault_code() that has __init attribute.
So I think we need to keep __init for probe routine ?
Also, we have to restrict bind/unbind with "suppress_bind_attrs" in
platform_driver structure.
This is the main reason to not allow module unload/reload.

If you are ok i will send a v4 ?

BR
Gabriel

>> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>> +MODULE_DESCRIPTION("PCI express Driver for ST SoCs");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 1.9.1
>>
