From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 25 Sep 2015 11:46:44 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56051393.2080709@free.fr>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56051393.2080709@free.fr>
Message-ID: <CABxcv=kVMqwAaP5HYF31ZcmTDsuCMziZdwZTee51noeHMqse3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mason,

On Fri, Sep 25, 2015 at 11:27 AM, Mason <slash.tmp@free.fr> wrote:
> On 21/09/2015 17:49, Arnd Bergmann wrote:
>
>> - Makefile.boot should not be needed
>
> $ cat arch/arm/mach-tangox/Makefile.boot
>   zreladdr-y            += 0x80008000
> params_phys-y           := 0x80000100
> initrd_phys-y           := 0x80800000
>
> I see that defining ARCH_MULTIPLATFORM selects AUTO_ZRELADDR
> Is that what is supposed to make Makefile.boot not required?
>
> If I remove Makefile.boot altogether, 'make uImage' fails with
>
>   Kernel: arch/arm/boot/Image is ready
>   Kernel: arch/arm/boot/Image is ready
>   Kernel: arch/arm/boot/zImage is ready
>   Kernel: arch/arm/boot/Image is ready
>   Kernel: arch/arm/boot/zImage is ready
> multiple (or no) load addresses:
> This is incompatible with uImages
> Specify LOADADDR on the commandline to build an uImage
> make[1]: *** [arch/arm/boot/uImage] Error 1
> make: *** [uImage] Error 2
>

As the comment say, for multi platforms kernel you need to specify the
load adddress in the command line to build a uImage:

$ make uImage LOADADDR=0x80008000

Or you can build a zImage and then create the uImage by using the mkimage tool:

$ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e
0x80008000 -n Linux -d arch/arm/boot/zImage uImage

Alternatively, you can use a u-boot that has CONFIG_CMD_BOOTZ enabled
and use bootz to boot a zImage instead of bootm that expects a uImage.

Best regards,
Javier
