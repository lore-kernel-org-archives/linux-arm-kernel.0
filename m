From: robherring2@gmail.com (Rob Herring)
Date: Mon, 05 Sep 2011 10:30:44 -0500
Subject: [PATCH] mach-integrator: fix VGA base regression
In-Reply-To: <CACRpkdYw4WCJ+kBm_FBH=H-vPKBUsb9DFToK0MN4F8t5T8Tc9g@mail.gmail.com>
References: <1315172408-18957-1-git-send-email-linus.walleij@linaro.org>
	<4E64496E.1090000@gmail.com>
	<CACRpkdYw4WCJ+kBm_FBH=H-vPKBUsb9DFToK0MN4F8t5T8Tc9g@mail.gmail.com>
Message-ID: <4E64EB24.7010800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2011 01:46 AM, Linus Walleij wrote:
> On Mon, Sep 5, 2011 at 6:00 AM, Rob Herring <robherring2@gmail.com> wrote:
> 
>>> @@ -154,6 +155,7 @@ static struct map_desc ap_io_desc[] __initdata = {
>>>  static void __init ap_map_io(void)
>>>  {
>>>       iotable_init(ap_io_desc, ARRAY_SIZE(ap_io_desc));
>>> +     vga_base = PCI_MEMORY_VADDR;
>>>  }
>>> @@ -505,7 +504,6 @@ void __init pci_v3_preinit(void)
>>>
>>>       pcibios_min_io = 0x6000;
>>>       pcibios_min_mem = 0x00100000;
>>> -     vga_base = PCI_MEMORY_VADDR;
>>>
>>>       /*
>>>        * Hook in our fault handler for PCI errors
>>
>> Should the VGA memory really be accessed before PCI host is initialized?
> 
> I don' know, I don't know one bit about how PCI works and should
> work, you tell me :-)
> 

I guess it's normal (from init/main.c):

        /*
         * HACK ALERT! This is early. We're enabling the console before
         * we've done PCI setups etc, and console_init() must be aware of
         * this. But we do want output early, in case something goes wrong.
         */

> What I know is that without this patch the 3.1 rc does not boot on
> Integrator.
> 
> Do you prefer that I revert your commit and wait with this thing
> until we figured out why it breaks the Integrator instead?

Well, it's really no difference with your patch or reverting mine in
terms of init order. I'd rather not have to add back hardware.h as a
required mach header.

So FWIW:

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob
