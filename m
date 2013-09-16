From: andre.przywara@linaro.org (Andre Przywara)
Date: Mon, 16 Sep 2013 19:01:26 +0200
Subject: [PROPOSAL] ARM/FDT: passing multiple binaries to a kernel
In-Reply-To: <20130915123744.48AD1C42C2D@trevor.secretlab.ca>
References: <52260608.2030202@linaro.org>
 <20130915123744.48AD1C42C2D@trevor.secretlab.ca>
Message-ID: <52373966.9000504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2013 02:37 PM, Grant Likely wrote:
> On Tue, 03 Sep 2013 17:53:44 +0200, Andre Przywara <andre.przywara@linaro.org> wrote:
>> Hi,
>>
>> a normal Linux kernel currently supports reading the start and end
>> address of a single binary blob via the FDT's /chosen node.
>> This will be interpreted as the location of an initial RAM disk.
>>
>> The Xen hypervisor itself is a kernel, but needs up to _two_ binaries
>> for proper operation: a Dom0 Linux kernel and it's associated initrd.
>> On x86 this is solved via the multiboot protocol used by the Grub
>> bootloader, which supports to pass an arbitrary number of binary modules
>> to any kernel.
>>
>> Since in the ARM world we have the versatile device tree, we don't need
>> to implement the mulitboot protocol.
>>
>> So I'd like to propose a new binding which denotes binary modules a
>> kernel can use at it's own discretion.
>> The need is triggered by the Xen hypervisor (which already uses a very
>> similar scheme), but the approach is deliberately chosen to be as
>> generic as possible to allow future uses (like passing firmware blobs
>> for devices or the like).
>> Credits for this go to Ian Campbell, who started something very similar
>> [1] for the Xen hypervisor. The intention of this proposal is to make
>> this generic and publicly documented.
>>
>> Looking forward to any comments!
>>
>> Thanks,
>> Andre.
>>
>> [1]
>> http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=docs/misc/arm/device-tree/booting.txt;h=94cd3f18a4e1317a35e1255bf5c6e1e091001d1a;hb=HEAD
>> ----------------------------
>> * Multiple boot modules device tree bindings
>>
>> Boot loaders wanting to pass multiple additional binaries to a kernel
>> shall add a node "module" for each binary blob under the /chosen node
>> with the following properties:
>>
>> - compatible:
>>       compatible = "boot,module";
>>     A bootloader may add names to more specifically describe the module,
>>     e.g. Xen may use "xen,dom0-kernel" or "xen,dom0-ramdisk".
>>     If possible a kernel should be able to use modules even without a
>>     descriptive naming, by enumerating them in order and using hard-coded
>>     meanings for each module (e.g. first is kernel, second is initrd).
>>
>> - reg: specifies the base physical address and size of a region in
>>     memory where the bootloader loaded the respective binary data to.
>>
>> - bootargs:
>>     An optional property describing arguments to use for this module.
>>     Could be a command line or configuration data.
>>
>> Example:
>> /chosen {
>>       #size-cells = <0x1>;
>>       #address-cells = <0x1>;
>>       module at 0 {
>>           compatible = "xen,linux-zimage", "xen,multiboot-module",
>> "boot,module";
>>           reg = <0x80000000 0x003dcff8>;
>>           bootargs = "console=hvc0 earlyprintk ro root=/dev/sda1 nosmp";
>>       };
>>       module at 1 {
>>           compatible = "xen,linux-initrd", "xen,multiboot-module",
>> "boot,module";
>>           reg = <0x08000000 0x00123456>;
>>       };

Grant,

thanks for looking at this. Appreciate your comments.

> The moment you pull in a 'reg' property, your required to property parse
> #size-cells and #address-cells and also 'ranges' which is missing from
> the above.

You mean that early boot code has to read #size-cells and #address-cells 
and act accordingly when parsing the reg property? So just more code in 
early boot? But that would easily open the door for 64bit addresses for 
instance, right?

> I don't necessarily object to that, but it can be a lot to
> ask for during early boot.

I don't think Xen in particular has a lot of problems with that. The DT 
implementation is quite capable (see Julien's latest updates).

 > It also looks really weird in the chosen node.

TBH this initrd syntax looks a bit weird to me in general, not following 
the nice and well defined DT way (no compatible, separate properties for 
start and length, ...)

> For boot time artifacts like this, I'd rather see a duplication of
> the linux,initrd- pattern. Something like:
> /chosen {
> 	xen,linux-zimage-start = <0x80000000>;
> 	xen,linux-zimage-end = <0x803dcff8>;
> 	linux,initrd-start = <0x8000000>;
> 	linux,initrd-end = <0x8123456>;
> }

To me that sounds like a hack to avoid more coding work.
The problem with that is that it would introduce a Xen specific property 
(actually two).
So from a user's perspective you want:

a) generic properties to support future OSes without much hassle (using 
the DT's compatible semantic)
b) specifying load address and length in the normal way
c) adding command lines
d) potentially adding more arbitrary properties
e) allowing an arbitrary number of modules

To just go ahead with another hard-coded property to make life easier 
for us kernel level developers doesn't sound very convincing to me.
And especially supporting multiple modules would be very hackish then.

> If have two reason for this; consistency and simplicity. Consistent
> because it matches what Linux already uses,

But this is actually not consistent with the rest of the DT 
architecture. Defining an own node for that looks like a perfect match 
to me in the DT world.

> and really easy to parse
> without mucking with ranges or #address/size-cells. The assumption is
> that during early boot the system is dealing with a 1:1 mapped physical
> address and there isn't any bus translations that need to be processed.

I see your point with early boot code constraints. But my idea was to 
create a flexible and generic solution, so that there will be a 
framework for bootloaders to specify blobs without needing updates every 
time someone comes up with a need for one. On x86 there was once such a 
need for microcode updates which couldn't be easily satisfied because 
Linux/x86 itself does not support the multiboot protocol.

> Question: what is the need for the xen,linux-initrd node? Why can't the
> existing "linux,initrd-*" properties continue to be used?

The main driver for this was to avoid patching bootloaders just to boot 
Xen specifically. Rather we want to patch bootloaders to support some 
kind of "multiboot" protocol once and let Xen piggy-back on this. I 
think that is somewhat driven by experiences in the x86 world, were 
especially kernel people are reluctant to support something just for 
Xen's need.

Regards,
Andre.
