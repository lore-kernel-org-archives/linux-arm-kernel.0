From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Aug 2014 16:30:37 -0600
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <CAL1qeaGHz1+L8r-AXetw422ZWSJX1h025YOx9kB+EE4yJpOowQ@mail.gmail.com>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>	<1408381705-3623-3-git-send-email-abrestic@chromium.org>	<53FB8820.4010202@wwwdotorg.org>	<CAL1qeaERHeKKNpqh9qHOppgT7ymvntisdjVvZheP78U6NaPz-A@mail.gmail.com>	<53FE1A7A.4010906@wwwdotorg.org>	<CAL1qeaGPr=BeYL1-=ddRL7rSuvYdQcd6vCEEHDrNA-KYst6bnw@mail.gmail.com>	<53FE2129.6080305@wwwdotorg.org>
 <CAL1qeaGHz1+L8r-AXetw422ZWSJX1h025YOx9kB+EE4yJpOowQ@mail.gmail.com>
Message-ID: <53FE5C0D.8000004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 03:56 PM, Andrew Bresticker wrote:
> On Wed, Aug 27, 2014 at 11:19 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 08/27/2014 12:13 PM, Andrew Bresticker wrote:
>>>
>>> On Wed, Aug 27, 2014 at 10:50 AM, Stephen Warren <swarren@wwwdotorg.org>
>>> wrote:
>>>>
>>>> On 08/27/2014 11:38 AM, Andrew Bresticker wrote:
>>>>>
>>>>>
>>>>> On Mon, Aug 25, 2014 at 12:01 PM, Stephen Warren <swarren@wwwdotorg.org>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
>>>>>>>
>>>>>>>
>>>>>>> +static int tegra_xusb_mbox_probe(struct platform_device *pdev)
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>>>
>>>>>>> +       if (!res)
>>>>>>> +               return -ENODEV;
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Should devm_request_mem_region() be called here to claim the region?
>>>>>
>>>>>
>>>>>
>>>>> No, the xHCI host driver also needs to map these registers, so they
>>>>> cannot be mapped exclusively here.
>>>>
>>>>
>>>>
>>>> That's unfortunate. Having multiple drivers with overlapping register
>>>> regions is not a good idea. Can we instead have a top-level driver map
>>>> all
>>>> the IO regions, then instantiate the various different sub-components
>>>> internally, and divide up the address space. Probably via MFD or similar.
>>>> That would prevent multiple drivers from touching the same register
>>>> region.
>>>
>>>
>>> Perhaps I'm misunderstanding, but I don't see how MFD would prevent us
>>> from having to map this register space in two different locations -
>>> the XUSB FPCI address space cannot be divided cleanly between host and
>>> mailbox registers.  Or are you saying that there should be a separate
>>> device driver that exposes an API for accessing this register space,
>>> like the Tegra fuse or PMC drivers?
>>
>>
>> With MFD, there's typically a top-level driver for the HW module (or
>> register space) that gets instantiated by the DT node. This driver then
>> instantiates all the different sub-drivers that use that register space, and
>> provides APIs for the sub-drivers to access the registers (either custom
>> APIs or more recently by passing a regmap object down to the sub-drivers).
>>
>> This top-level driver is the only driver that maps the space, and can manage
>> sharing the space between the various sub-drivers.
>
> So if I'm understanding correctly, we end up with something like this:
>
> usb at 70090000 {
>          compatible = "nvidia,tegra124-xusb";
>          reg = <0x0 0x70090000 0x0 0x8000>, // xHCI host registers
>                <0x0 0x70098000 0x0 0x1000>, // FPCI registers
>                <0x0 0x70099000 0x0 0x1000>; // IPFS registers
>          interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>, // host interrupt
>                       <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH"; // mailbox interrupt
>
>          host-controller {
>                  compatible = "nvidia,tegra124-xhci";
>                  ...
>          };
>
>          mailbox {
>                  compatible = "nvidia,tegra124-xusb-mailbox";
>                 ...
>          };
> };
>
> To be honest though, this seems like overkill to share a couple of
> registers when no other resources are shared between the two.

Something like that, yes.

Given that the "xusb" driver knows that its HW module contains both an 
XHCI and XUSB mailbox chunk, those might not need to appear inside the 
main XUSB module, but could be hard-coded into the driver. They might 
serve as convenient containers for sub-device-specific properties though.

Other alternatives might be:

a) If the registers that are shared between drivers are distinct, then 
divide the reg values into non-overlapping lists. We have taken this 
approach for the MC/SMMU drivers on Tegra, although it's a horrible mess 
and Thierry is actively thinking about reverting that and doing it 
through MFD or something MFD-like.

b) Allow the same IO region to be claimed by multiple devices, perhaps 
with a new API so that it doesn't accidentally happen when not desired.

c) Ignore the issue and deal with the fact that not all driver usage 
shows up in /proc/iomem. This is what we have for the Tegra USB2 and 
USB2 PHY drivers, and this is (I think) what your current patch does.

To be honest, none of the options are that good; some end up with the 
correct result but are a pain to implement, but others are nice and 
simple yet /proc/iomem isn't complete. Given that, I'm personally not 
going to try and mandate one option or the other, so the current patch 
is fine. Food for thought though:-)
