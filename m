From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Apr 2015 09:29:34 +0100
Subject: kvm vs host (arm64)
In-Reply-To: <1755708226.1162022.1429597412117.JavaMail.yahoo@mail.yahoo.com>
References: <5534DCB6.2070304@arm.com>
 <1755708226.1162022.1429597412117.JavaMail.yahoo@mail.yahoo.com>
Message-ID: <55360A6E.3080201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/15 07:23, Mohan G wrote:
> comments inline

[...]

> However, we just realised what we were doing wrong. We did not use
> the accel=kvm flag with qemu which stopped us from using the -cpu
> type as host.(without which i think makes qemu emulate the processor

This really suggest you should do your homework before saying "it is
broken".

> (cortex-a57) itself). Now with using this flag we are about 35%
> slower in guest vs host for smaller block sizes (8k,32k,64k). However
> what is surprising is the fact that we are seeing better than host
> numbers with 512k and 1M record sizes of iozone.

Not surprising at all, as it is likely that you're simply exercising the
caches on the host side. Small sizes only show the overhead of trapping
to userspace. These should improve once vhost can be enabled (v4.1).

> Just wanted some confirmation about the below options. (this gives us good numbers)
> 
> qemu-system-aarch64 -machine virt,accel=kvm -cpu host -nographic -smp
> 4 -m 8192 -global virtio-blk-device.scsi=off -device
> virtio-scsi-device,id=scsi -drive
> file=/vm/ubuntu-core-14.04.1-core-arm64.img,id=coreimg,cache=none,if=none
> -device scsi-hd,drive=coreimg -kernel /boot/vmlinuz-3.18.9 -initrd
> /boot/initrd.img-3.18.9 -netdev user,id=unet -device
> virtio-net-device,netdev=unet -drive
> file=/dev/sdb,cache=directsync,if=scsi,bus=0,unit=1 --append
> "console=ttyAMA0 root=/dev/sda"
> 

No idea. Ask someone who knows about QEMU (I don't, and LAK is not the
right place).

> but with
> =======
> qemu-system-aarch64 -machine virt -cpu cortex-a57 (i.e without
> accel=kvm and -cpu as this one) we are pretty bad.

What did you expect?

	M.
-- 
Jazz is not dead. It just smells funny...
