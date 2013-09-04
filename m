From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 04 Sep 2013 10:43:31 +0200
Subject: [PROPOSAL] ARM/FDT: passing multiple binaries to a kernel
In-Reply-To: <CAL_JsqK9PjpScRO8561PhcyKkxhuL4pgMTCh2-UG_ubybJTcCw@mail.gmail.com>
References: <52260608.2030202@linaro.org>
 <CAL_JsqK9PjpScRO8561PhcyKkxhuL4pgMTCh2-UG_ubybJTcCw@mail.gmail.com>
Message-ID: <5226F2B3.10606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2013 12:00 AM, Rob Herring wrote:
> On Tue, Sep 3, 2013 at 10:53 AM, Andre Przywara

Hi Rob,

>> a normal Linux kernel currently supports reading the start and end address
>> of a single binary blob via the FDT's /chosen node.
>> This will be interpreted as the location of an initial RAM disk.
>>
>> The Xen hypervisor itself is a kernel, but needs up to _two_ binaries for
>> proper operation: a Dom0 Linux kernel and it's associated initrd.
>> On x86 this is solved via the multiboot protocol used by the Grub
>> bootloader, which supports to pass an arbitrary number of binary modules to
>> any kernel.
>>
>> Since in the ARM world we have the versatile device tree, we don't need to
>> implement the mulitboot protocol.
>
> But surely there would be some advantage of reuse by using the
> multi-boot protocol since Xen, grub, and OS tools already support it
> for x86.

Yes, but that is x86 only and multiboot is it's nature quite 
architecture specific. The current(?) multiboot v2 spec has no official 
ARM support (only x86 and MIPS), so this would need to be "invented" 
first. While this is technically easy, ARM software currently has no 
support for multiboot at all: not in u-boot and not in Xen.
Multiboot support in Xen lives entirely in the x86 directory, and big 
parts of it are even in assembly.

I am about to write up a more elaborate technical rationale describing 
the problems with multiboot on ARM:

https://wiki.linaro.org/AndrePrzywara/Multiboot

>> So I'd like to propose a new binding which denotes binary modules a kernel
>> can use at it's own discretion.
>> The need is triggered by the Xen hypervisor (which already uses a very
>> similar scheme), but the approach is deliberately chosen to be as generic as
>> possible to allow future uses (like passing firmware blobs for devices or
>> the like).
>> Credits for this go to Ian Campbell, who started something very similar [1]
>> for the Xen hypervisor. The intention of this proposal is to make this
>> generic and publicly documented.
>
> Can you describe how you see the boot flow working starting with OS
> installer writes kernel, initrd, xen and ??? to disk. How does the
> bootloader know what to load? The OS may not have access to the dtb,
> so this has to be described to the bootloader as well.

The idea is to use bootscripts (for instance in u-boot) to tackle this. 
See for an example below.

I don't see how the process would be differ significantly from the 
current process, where you have to load mostly two images, get hold of 
the DTB, enter image data into the DTB and launch the kernel. Now you 
just need to load an additional image and enter it's properties into the 
DTB, actually in a pretty generic way.

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
>> Boot loaders wanting to pass multiple additional binaries to a kernel shall
>> add a node "module" for each binary blob under the /chosen node with the
>> following properties:
>>
>> - compatible:
>>      compatible = "boot,module";
>>    A bootloader may add names to more specifically describe the module,
>>    e.g. Xen may use "xen,dom0-kernel" or "xen,dom0-ramdisk".
>>    If possible a kernel should be able to use modules even without a
>>    descriptive naming, by enumerating them in order and using hard-coded
>>    meanings for each module (e.g. first is kernel, second is initrd).
>>
>> - reg: specifies the base physical address and size of a region in
>>    memory where the bootloader loaded the respective binary data to.
>>
>> - bootargs:
>>    An optional property describing arguments to use for this module.
>>    Could be a command line or configuration data.
>
>> Example:
>> /chosen {
>>      #size-cells = <0x1>;
>>      #address-cells = <0x1>;
>>      module at 0 {
>>          compatible = "xen,linux-zimage", "xen,multiboot-module",
>> "boot,module";
>>          reg = <0x80000000 0x003dcff8>;
>>          bootargs = "console=hvc0 earlyprintk ro root=/dev/sda1 nosmp";
>>      };
>>      module at 1 {
>>          compatible = "xen,linux-initrd", "xen,multiboot-module",
>> "boot,module";
>>          reg = <0x08000000 0x00123456>;
>>      };
>
> This has to be created and parsed typically in FDT format by early
> boot code, and I worry about the complexity this has. Being future
> proof and extensible is good, but we could meet today's needs with
> something simple like this:

Parsing this is already done in Xen, for instance. In fact we just look 
for nodes matching "boot,module" and then check for other names to 
determine it's type (which is a few-liner patch in Xen which I will post 
later today). And I don't see a need to load modules that early that we 
don't have an un-flattened tree available.

Generating is also part of libfdt, in fact this whole subtree above has 
been generated on the command line of a stock Calxeda U-Boot:
dom0kernel=fdt addr ${fdt_addr}; fdt resize; fdt mknod /chosen module at 0; 
fdt set /chosen/module at 0 compatible "xen,linux-zimage" 
"xen,multiboot-module" "boot,module"; fdt set /chosen/module at 0 reg 
<${dom0_addr_r} 0x${filesize}>; fdt set /chosen/module at 0 bootargs 
"console=hvc0 earlyprintk ro root=/dev/sda1 nosmp"

With this you load the Dom0 kernel (via TFTP or ext2load) and do "run 
dom0kernel" and are done. I have also patches which add an u-boot 
command called "module" which automates this, but this is mostly 
syntactic sugar (though may be useful for future abstraction, for 
instance to support the x86 (or even ARM) "real" multiboot protocol).

> bootargs = "xen args --- linux args";
> xen,linux-image = <start size>;
>
> So, is having a more generic solution really needed?

Not necessarily needed, but useful, I think. As described above I don't 
see any technical obstacles of doing it in a more generic way, so we 
could as well go ahead with this. On x86 from time to time the need for 
additional binaries pops up (early microcode loading, for instance), so 
why not be be prepared.
Also this approach avoids hard-coding the Xen name into the bootloader, 
as said in the proposal the meaning could be derived from the order of 
the modules (as on x86), so a bootloader does not need to know anything 
about Xen at all.

Regards,
Andre.
