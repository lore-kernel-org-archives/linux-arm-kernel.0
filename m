From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 25 Jun 2013 23:00:49 +0900
Subject: [PATCH v2] ARM: shmobile: uImage load address rework
In-Reply-To: <76205076.EsFJngGrIh@avalon>
References: <20130610092857.19175.25629.sendpatchset@w520>
 <CANqRtoSoWesMgBmbfUKxeyfwWcKZ77MyckCdPpKwK4WxYynWbA@mail.gmail.com>
 <3243557.sP7VV5jPVm@avalon> <76205076.EsFJngGrIh@avalon>
Message-ID: <CANqRtoTmhrdB+U_kTdwStXY2xrrGxjMWOEY7NWMgFGXDYQNVNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, Jun 19, 2013 at 10:16 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 12 June 2013 04:31:26 Laurent Pinchart wrote:
>> On Wednesday 12 June 2013 11:21:34 Magnus Damm wrote:
>> > On Wed, Jun 12, 2013 at 6:50 AM, Laurent Pinchart wrote:
>> > > I've noticed today that KZM9G doesn't boot v3.10-rc2 with
>> > > CONFIG_AUTO_ZRELADDR=y. While not caused by this patch, that's something
>> > > that will need to be fixed to support multi-arch kernels. I'm not too
>> > > familiar with early boot code, would you be able to have a look at this
>> > > ?
>> >
>> > I will have a look. I suspect that issue is not related to this patch, is
>> > it?
>>
>> No, it isn't, the issue is present in v3.10-rc2. I don't know if it has ever
>> worked.
>
> The following patch fixes the issue, caused by physical RAM being present at
> 0x41000000 on KZM9G. I'm not sure if it would be acceptable as a generic
> solution though.
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index fe4d9c3..ea2f112 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -176,7 +176,7 @@ not_angel:
>  #ifdef CONFIG_AUTO_ZRELADDR
>                 @ determine final kernel image address
>                 mov     r4, pc
> -               and     r4, r4, #0xf8000000
> +               and     r4, r4, #0xff000000
>                 add     r4, r4, #TEXT_OFFSET
>  #else
>                 ldr     r4, =zreladdr

Thanks for tracking this down. I've now been looking into this a bit,
and I think we should try to get KZM9G working without modifying the
generic code. I am afraid that I have not been able to find the proper
fix for this though, see below for a dump of the current state.

To be able to get some more details from the kernel I've cooked up
some debug patches. It turns out that it's not really the code in
boot/compressed/ that is problematic - more the kernel itself. Also,
before trying to enable relocatable support via AUTO_ZRELADDR=y I
think we should try to get the regular AUTO_ZRELADDR=n case going with
an address that is compatible with the generic code that you pointed
out above. Then when that is fine it should be relatively easy to
support the relocatable case as well.

The attached patch
"linux-3.11-pre-arm-shmobile-kzm9g-zreladdr-48000000-20130625.patch"
makes sure the uImage gets loaded at 0x48008000 which from the
boot/compressed code is compatible with either AUTO_ZRELADDR=n or =y.

I've used the following patches on top of renesas git
renesas-next-20130620 to enable output together with DEBUG_LL=y and
EARLY_PRINTK=y:

linux-3.11-pre-arm-shmobile-kzm9g-putc-20130625b.patch
linux-3.11-pre-arm-shmobile-kzm9g-debug-macro-20130625.patch
linux-3.11-pre-arm-mem-add-printout-20130625.patch
linux-3.11-pre-arm-shmobile-kzm9g-zreladdr-48000000-20130625.patch

With the patches applied I get this serial output:

- - -

Filename 'kzm9g/uImage'.
Load address: 0x43000000
Loading: #################################################################
         ##########################
done
Bytes transferred = 1335151 (145f6f hex)
## Booting kernel from Legacy Image at 43000000 ...
   Image Name:   'Linux-3.10.0-rc2'
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1335087 Bytes = 1.3 MiB
   Load Address: 48008000
   Entry Point:  48008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.10.0-rc2 (damm at w520) (gcc version 4.5.1 (Sourcery G++
Lite 2010.09-50) ) #1 SMP Tue Jun 25 22:25:10 JST 2013
CPU: ARMv7 Processor [412fc098] revision 8 (ARMv7), cr=10c5347d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: kzm9g, model: KZM-A9-GT
Adding RAM at 41000000-5f7fffff.
bootconsole [earlycon0] enabled
debug: ignoring loglevel setting.
Ignoring RAM at 41000000-5f7fffff (vmalloc region overlap).
cma: CMA: failed to reserve 16 MiB
Memory policy: ECC disabled, Data cache writealloc
Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.

- - -

The fatal memory allocation most likely fails because all system
memory is ignored, see "(vmalloc region overlap)" above. This seems to
be the case regardless of HIGHMEM=y or =n.

It is possible to work around this issue by changing the memory bank
start address in the DTS:

--- 0001/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ work/arch/arm/boot/dts/sh73a0-kzm9g.dts     2013-06-25
22:17:19.000000000 +0900
@@ -19,8 +19,14 @@
                bootargs = "console=tty0 console=ttySC4,115200
root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200";
        };

-       memory {
+       memory at 48000000 {
                device_type = "memory";
-               reg = <0x41000000 0x1e800000>;
+               reg = <0x48000000 0x10000000>;
        };

With the above hunk the kernel boots just fine. Unfortunately we
cannot enable all memory which is kind of limiting. =)

So my current conclusion is that it looks like the kernel doesn't like
to have the memory start address not aligned to 128 MByte somehow..

Cheers,

/ magnus
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-3.11-pre-arm-shmobile-kzm9g-putc-20130625b.patch
Type: application/octet-stream
Size: 620 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/208d2cd9/attachment-0004.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-3.11-pre-arm-shmobile-kzm9g-debug-macro-20130625.patch
Type: application/octet-stream
Size: 1288 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/208d2cd9/attachment-0005.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-3.11-pre-arm-mem-add-printout-20130625.patch
Type: application/octet-stream
Size: 669 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/208d2cd9/attachment-0006.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-3.11-pre-arm-shmobile-kzm9g-zreladdr-48000000-20130625.patch
Type: application/octet-stream
Size: 747 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/208d2cd9/attachment-0007.obj>
