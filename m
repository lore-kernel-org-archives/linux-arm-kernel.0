From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Mar 2013 11:40:38 -0700
Subject: [PATCH 3/5] ARM: DT: tegra114:add aliases and DMA requestor for
 serial controller
In-Reply-To: <513A281B.9010702@nvidia.com>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
 <1362750782-15174-4-git-send-email-ldewangan@nvidia.com>
 <513A25E4.8040504@wwwdotorg.org> <513A281B.9010702@nvidia.com>
Message-ID: <513A30A6.3040806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 11:04 AM, Laxman Dewangan wrote:
> On Friday 08 March 2013 11:24 PM, Stephen Warren wrote:
>> On 03/08/2013 06:53 AM, Laxman Dewangan wrote:
>>> Add APB DMA requestor and serial aliases for serial controller.
>>> There will be two serial driver i.e. 8250 based simple serial driver
>>> and APB DMA based serial driver for higher baudrate and performace.
>>>
>>> The simple serial driver get enabled with compatible nvidia,tegra20-uart
>>> and APB DMA based driver will get enabled with compatible
>>> nvidia,tegra30-hsuart.

>>> diff --git a/arch/arm/boot/dts/tegra114.dtsi
>>> b/arch/arm/boot/dts/tegra114.dtsi
>>> +    /*
>>> +     * There are two serial driver i.e. 8250 based simple serial
>>> +     * driver and APB DMA based serial driver for higher baudrate
>>> +     * and performace. To enable the 8250 based driver, the compatible
>>> +     * is "nvidia,tegra30-uart", "nvidia,tegra20-uart" and to enable
>>> +     * the APB DMA based serial driver, the comptible is
>>> +     * "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
>>> +     */
>> Any references to Tegra30 there should be changed to Tegra114 I think.
> 
> Ok, there is not change on tegra30 and Tegra114, also we have not added
> the tegra114 compatible in driver file.

As I mentioned elsewhere, compatible must always include the most
specific value; nvidia,tegra114-uart in this case. If the HW is
backwards-compatible, then also include entries for the HW it's
compatible with.

Hence here, you want:

compatible = "nvidia,tegra114-uart", "nvdia,tegra20-uart";

Since the compatible value here shouldn't include any Tegra30-related
value, the comment shouldn't say that it should.

Note that when there are multiple values in the compatible property,
even if the driver doesn't know about the first value, it will still get
matched based upon the 2nd/3rd/... value, so even though the driver
doesn't explicitly know about nvidia,tegra114-uart, it will still get
instantiated, because it does support nvdia,tegra20-uart.
