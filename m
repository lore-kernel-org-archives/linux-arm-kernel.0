From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Thu, 17 Dec 2015 17:45:37 +0200
Subject: [PATCH v4 1/5] PCI: designware: add memory barrier after enabling
 region
In-Reply-To: <CAHM4w1m-NiwyCLz9tikbOcNtCmVu0Vd9FhmKKSuMi5ChzfDafA@mail.gmail.com>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-2-git-send-email-stanimir.varbanov@linaro.org>
 <56669C50.9060700@linaro.org>
 <CAHM4w1k_EAt+xBBYyG3B7W9Fegc4j+uRq5t_biUsxOGt+k+xUA@mail.gmail.com>
 <20151209102359.GF8644@n2100.arm.linux.org.uk>
 <CAHM4w1m-NiwyCLz9tikbOcNtCmVu0Vd9FhmKKSuMi5ChzfDafA@mail.gmail.com>
Message-ID: <5672D8A1.2080407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2015 06:05 AM, Pratyush Anand wrote:
> On Wed, Dec 9, 2015 at 3:53 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> [...]
> 
>>>>>       dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>>>>> +     /*
>>>>> +      * ensure that the ATU enable has been happaned before accessing
>>>>> +      * pci configuration/io spaces through dw_pcie_cfg_[read|write].
>>>>> +      */
>>>>> +     wmb();
>>>>>  }
>>>>>
>>>
>>>
>>> My understnading is that since writel() of dw_pcie_writel_rc() in
>>> above code and readl(), writel() of dw_pcie_cfg_[read|write]() (which
>>> will follow) goes through same device (ie PCIe host here). So, it is
>>> guaranteed that 1st writel() will be executed before later
>>> readl()/writel(). If that is true then we do not need any explicit
>>> barrier here.
>>>
>>> Arnd, Russel: whats your opinion here.
>>               ^l
> 
> Sorry :(
> 
>>
>> writel() has a barrier _before_ the access but not after.
>>
>> The fact is that there's nothing which guarantees that the write will hit
>> the hardware in a timely manner (forget any rules about PCI config space,
>> the PCI ordering rules apply to the PCI bus, not to the ARM buses.)
>>
>> If you need this write to have hit the hardware before continuing, you
>> need to read back from the same register.
> 
> OK, so better to replace wmb() with read back of control register.

Would the patch be acceptable if I replace wmb with read?

-- 
regards,
Stan
