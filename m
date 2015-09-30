From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 30 Sep 2015 11:18:45 +0200
Subject: [PATCH v4 3/4] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <CAHM4w1=g=UFoz=R-6hxJC0=fSieN1WDvZT97ykL1b3_YPhBjZg@mail.gmail.com>
References: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
 <1440678857-27118-4-git-send-email-gabriel.fernandez@linaro.org>
 <CAHM4w1=g=UFoz=R-6hxJC0=fSieN1WDvZT97ykL1b3_YPhBjZg@mail.gmail.com>
Message-ID: <CAG374jAx8DN8GXkv7O0jcgnvVTnH4U3LegX-hPq5RWo1_cy+OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

Thanks for the review.

Best regards

Gabriel

On 27 August 2015 at 19:31, Pratyush Anand <pratyush.anand@gmail.com> wrote:
> Hi Gabriel,
>
> Looks good to me.
>
> On Thu, Aug 27, 2015 at 6:04 PM, Gabriel Fernandez
> <gabriel.fernandez@linaro.org> wrote:
>> sti pcie is built around a Synopsis Designware PCIe IP.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>
>
>> +static int st_pcie_link_up(struct pcie_port *pp)
>> +{
>> +       u32 status;
>> +       int link_up;
>
> nit: why not bool

i prefer to keep it as 'int' because the prototype of link_up callback
is an 'int'.

>
>> +       int count = 0;
>
> [...]
>
>> +static void st_pcie_board_reset(struct pcie_port *pp)
>> +{
>> +       struct st_pcie *pcie = to_st_pcie(pp);
>> +
>> +       if (!gpio_is_valid(pcie->reset_gpio))
>> +               return;
>> +
>> +       if (gpio_direction_output(pcie->reset_gpio, 0)) {
>> +               dev_err(pp->dev, "Cannot set PERST# (gpio %u) to output\n",
>> +                       pcie->reset_gpio);
>> +               return;
>> +       }
>> +
>> +       /* From PCIe spec */
>> +       msleep(2);
>> +       gpio_direction_output(pcie->reset_gpio, 1);
>> +
>> +       /*
>> +        * PCIe specification states that you should not issue any config
>> +        * requests until 100ms after asserting reset, so we enforce that here
>> +        */
>> +       msleep(100);
>
> IIRC, specification says to wait after link training completes. So
> shouldn't it be after st_pcie_enable_ltssm. Moreover, I wonder why
> others do not need it.
>
Ok i will fix it.

> Reviewed-by: Pratyush Anand <pratyush.anand@gmail.com>
