From: robherring2@gmail.com (Rob Herring)
Date: Tue, 3 Sep 2013 17:00:27 -0500
Subject: [PROPOSAL] ARM/FDT: passing multiple binaries to a kernel
In-Reply-To: <52260608.2030202@linaro.org>
References: <52260608.2030202@linaro.org>
Message-ID: <CAL_JsqK9PjpScRO8561PhcyKkxhuL4pgMTCh2-UG_ubybJTcCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 3, 2013 at 10:53 AM, Andre Przywara
<andre.przywara@linaro.org> wrote:
> Hi,
>
> a normal Linux kernel currently supports reading the start and end address
> of a single binary blob via the FDT's /chosen node.
> This will be interpreted as the location of an initial RAM disk.
>
> The Xen hypervisor itself is a kernel, but needs up to _two_ binaries for
> proper operation: a Dom0 Linux kernel and it's associated initrd.
> On x86 this is solved via the multiboot protocol used by the Grub
> bootloader, which supports to pass an arbitrary number of binary modules to
> any kernel.
>
> Since in the ARM world we have the versatile device tree, we don't need to
> implement the mulitboot protocol.

But surely there would be some advantage of reuse by using the
multi-boot protocol since Xen, grub, and OS tools already support it
for x86.

> So I'd like to propose a new binding which denotes binary modules a kernel
> can use at it's own discretion.
> The need is triggered by the Xen hypervisor (which already uses a very
> similar scheme), but the approach is deliberately chosen to be as generic as
> possible to allow future uses (like passing firmware blobs for devices or
> the like).
> Credits for this go to Ian Campbell, who started something very similar [1]
> for the Xen hypervisor. The intention of this proposal is to make this
> generic and publicly documented.

Can you describe how you see the boot flow working starting with OS
installer writes kernel, initrd, xen and ??? to disk. How does the
bootloader know what to load? The OS may not have access to the dtb,
so this has to be described to the bootloader as well.

>
> Looking forward to any comments!
>
> Thanks,
> Andre.
>
> [1]
> http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=docs/misc/arm/device-tree/booting.txt;h=94cd3f18a4e1317a35e1255bf5c6e1e091001d1a;hb=HEAD
> ----------------------------
> * Multiple boot modules device tree bindings
>
> Boot loaders wanting to pass multiple additional binaries to a kernel shall
> add a node "module" for each binary blob under the /chosen node with the
> following properties:
>
> - compatible:
>     compatible = "boot,module";
>   A bootloader may add names to more specifically describe the module,
>   e.g. Xen may use "xen,dom0-kernel" or "xen,dom0-ramdisk".
>   If possible a kernel should be able to use modules even without a
>   descriptive naming, by enumerating them in order and using hard-coded
>   meanings for each module (e.g. first is kernel, second is initrd).
>
> - reg: specifies the base physical address and size of a region in
>   memory where the bootloader loaded the respective binary data to.
>
> - bootargs:
>   An optional property describing arguments to use for this module.
>   Could be a command line or configuration data.

> Example:
> /chosen {
>     #size-cells = <0x1>;
>     #address-cells = <0x1>;
>     module at 0 {
>         compatible = "xen,linux-zimage", "xen,multiboot-module",
> "boot,module";
>         reg = <0x80000000 0x003dcff8>;
>         bootargs = "console=hvc0 earlyprintk ro root=/dev/sda1 nosmp";
>     };
>     module at 1 {
>         compatible = "xen,linux-initrd", "xen,multiboot-module",
> "boot,module";
>         reg = <0x08000000 0x00123456>;
>     };

This has to be created and parsed typically in FDT format by early
boot code, and I worry about the complexity this has. Being future
proof and extensible is good, but we could meet today's needs with
something simple like this:

bootargs = "xen args --- linux args";
xen,linux-image = <start size>;

So, is having a more generic solution really needed?

Rob
