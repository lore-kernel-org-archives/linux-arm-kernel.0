From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 31 Aug 2011 21:16:17 +0530
Subject: [PATCH 4/6] DMA: PL330: Add device tree support
In-Reply-To: <4E5E2E36.1070006@gmail.com>
References: <1314348014-2481-1-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-2-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-3-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-4-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-5-git-send-email-thomas.abraham@linaro.org>
	<4E579C9B.7030807@gmail.com>
	<CAJuYYwR5GqqKjbMngQqorLuka4XN0jin5s6O66orTtSQg5eKRw@mail.gmail.com>
	<4E5CE37E.1050104@gmail.com>
	<CAJuYYwT5HGy9b06AyrLJv5hFCFf_YRA4md9N=m+cwcJNTqRDWg@mail.gmail.com>
	<4E5E2E36.1070006@gmail.com>
Message-ID: <CAJuYYwQ17MPD=hTYUxES5touFfd73W1unbtWfu_XqPR48t3P0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 31 August 2011 18:21, Rob Herring <robherring2@gmail.com> wrote:
> Thomas,

[...]

>> For PL330 dma controllers instantiated from device tree, the channel
>> lookup is based on phandle of the dma controller and dma request id
>> specified by the client node. During probe, the private data of each
>> channel of the controller is set to point to the device node of the
>> dma controller. The 'chan_id' of the each channel is used as the
>> dma request id.
>>
>> Client driver requesting dma channels specify the phandle of the
>> dma controller and the request id. The pl330 filter function
>> converts the phandle to the device node pointer and matches that
>> with channel's private data. If a match is found, the request id
>> from the client node and the 'chan_id' of the channel is matched.
>> A channel is found if both the values match.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?.../devicetree/bindings/dma/arm-pl330.txt ? ? ? ? ?| ? 29 ++++++++++++++++
>> ?drivers/dma/pl330.c ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 35 +++++++++++++++++---
>> ?2 files changed, 59 insertions(+), 5 deletions(-)
>> ?create mode 100644 Documentation/devicetree/bindings/dma/arm-pl330.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt
>> b/Documentation/devicetree/bindings/dma/arm-pl330.txt
>> new file mode 100644
>> index 0000000..89f4b9c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
>> @@ -0,0 +1,29 @@
>> +* ARM PrimeCell PL330 DMA Controller
>> +
>> +The ARM PrimeCell PL330 DMA controller can move blocks of memory contents
>> +between memory and peripherals or memory to memory.
>> +
>> +Required properties:
>> + ?- compatible: should be "arm,primecell".
>
> Sorry, I guess I wasn't clear. This has to be "arm,primecell" plus
> something else. In this case, "arm,pl330". If the IP is modified from
> standard ARM version (like ST likes to do), then something like
> "samsung,pl330" would be appropriate.
>
> This is not actually used by the kernel at the moment, but could if
> modified versions of pl330 show up.

of_platform_bus_create() checks for  "arm,primecell" compatible value
to instantiate a amba device from device tree. The peripheral_id is
also noted in the amba device instance. The amba drivers register with
a with a peripheral_id and peripheral_id is used match amba device
with a driver.

In cases of modified version of the same IP, the peripheral_id would
be different. So, "arm,primecell" would just be enough for now. Any
other compatible value would anyway go unused. I did use
"arm,primecell-pdma" and "arm-primecell-mdma" to derive the dma_cap
value. But, as per your comments, I dropped it.

So, for now, I will just list "arm,primecell" as required compatible
value. Please let me know if "arm,pl330" would be required here.

>
>> + ?- reg: physical base address of the controller and length of memory mapped
>> + ? ?region.
>> + ?- interrupts: interrupt number to the cpu.
>> +
>> +Example: (from Samsung's Exynos4 processor dtsi file)
>> +
>> + ? ? pdma0: pdma at 12680000 {
>> + ? ? ? ? ? ? compatible = "arm,primecell";
>> + ? ? ? ? ? ? reg = <0x12680000 0x1000>;
>> + ? ? ? ? ? ? interrupts = <99>;
>> + ? ? };
>> +
>> +Client drivers (device nodes requiring dma transfers from dev-to-mem or
>> +mem-to-dev) should specify the DMA channel numbers using a two-value pair
>> +as shown below.
>> +
>> + ?[property name] ?= <[phandle of the dma controller] [dma request id]>;
>
> At least fix the "-dma-channel" part of the name. It not clear if that's
> the case or just an example.
>
> [name]-dma-channel = <[phandle of the dma controller] [dma request id]>;

The name of the property that specifies the dma channel to use is
decided by the client device node. It is not enforced by the dma
device node. So, there will be no specific requirement stated in the
documentation for pl330 device node.

>
>
> The rest looks good.

Thanks for your review and comments.

Regards,
Thomas.

>
> Rob
>

[...]
