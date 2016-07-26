From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 26 Jul 2016 10:07:47 +0200
Subject: usb keyboard and mouse can't work on QEMU ARM64 with KVM
In-Reply-To: <57971270.1010008@huawei.com>
References: <57971270.1010008@huawei.com>
Message-ID: <CAKv+Gu8jzjLjpC7FR4fq13H+4rThQsW=fpMZ0F3Qfc45Gj1XSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 July 2016 at 09:34, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> Hi?
>
> Recently I'm trying to use usb keyboard and mouse with QEMU on ARM64. Below is my QEMU command line,
> host and guest kernel both are 4.7.0-rc7+, and I ran it on Hikey board.
>
>     qemu-system-aarch64 \
>     -smp 1 -cpu host -enable-kvm \
>     -m 256 -M virt \
>     -k en-us \
>     -nographic \
>     -device usb-ehci -device usb-kbd -device usb-mouse -usb\
>     -kernel Image \
>     -initrd guestfs.cpio.gz \
>     -append "rdinit=/sbin/init console=ttyAMA0 root=/dev/ram earlycon=pl011,0x9000000 rw"
>
> The following guest log shows that usb controller can be probed but the keyboard and mouse can't be
> found.
>
> [    1.597433] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.599562] ehci-pci: EHCI PCI platform driver
> [    1.608082] ehci-pci 0000:00:03.0: EHCI Host Controller
> [    1.609485] ehci-pci 0000:00:03.0: new USB bus registered, assigned bus number 1
> [    1.611833] ehci-pci 0000:00:03.0: irq 49, io mem 0x10041000
> [    1.623599] ehci-pci 0000:00:03.0: USB 2.0 started, EHCI 1.00
> [    1.625867] hub 1-0:1.0: USB hub found
> [    1.626906] hub 1-0:1.0: 6 ports detected
> [    1.628685] ehci-platform: EHCI generic platform driver
> [    1.630263] ehci-msm: Qualcomm On-Chip EHCI Host Controller
> [    1.631947] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.633547] ohci-pci: OHCI PCI platform driver
> [    1.634807] ohci-platform: OHCI generic platform driver
> [...]
> [    1.939001] usb 1-1: new high-speed USB device number 2 using ehci-pci
> [   17.467040] usb 1-1: device not accepting address 2, error -110
> [   17.579165] usb 1-1: new high-speed USB device number 3 using ehci-pci
> [   32.287242] random: dd urandom read with 7 bits of entropy available
> [   33.110970] usb 1-1: device not accepting address 3, error -110
> [   33.223030] usb 1-1: new high-speed USB device number 4 using ehci-pci
> [   43.635185] usb 1-1: device not accepting address 4, error -110
> [   43.747033] usb 1-1: new high-speed USB device number 5 using ehci-pci
> [   54.159043] usb 1-1: device not accepting address 5, error -110
> [   54.160752] usb usb1-port1: unable to enumerate USB device
> [   54.307290] usb 1-2: new high-speed USB device number 6 using ehci-pci
> [   69.839052] usb 1-2: device not accepting address 6, error -110
> [   69.951249] usb 1-2: new high-speed USB device number 7 using ehci-pci
> [   85.483171] usb 1-2: device not accepting address 7, error -110
> [   85.595035] usb 1-2: new high-speed USB device number 8 using ehci-pci
> [   90.619247] usb 1-2: device descriptor read/8, error -110
> [   95.743482] usb 1-2: device descriptor read/8, error -110
> [   95.959165] usb 1-2: new high-speed USB device number 9 using ehci-pci
> [  106.371177] usb 1-2: device not accepting address 9, error -110
> [  106.372894] usb usb1-port2: unable to enumerate USB device
>
> lsusb shows:
> root at genericarmv8:~# lsusb
> Bus 001 Device 001: ID 1d6b:0002
>
> Besides, I have also tried QEMU TCG without KVM. The guest can successfully probe usb controller,
> keyboard and mouse.
> lsusb shows:
> root at genericarmv8:~# lsusb
> Bus 001 Device 002: ID 0627:0001
> Bus 001 Device 003: ID 0627:0001
> Bus 001 Device 001: ID 1d6b:0002
>
> So it looks like that usb keyboard and mouse don't work with KVM on QEMU ARM64 while they can work
> with TCG. IIUC, all the usb devices are emulated by QEMU, it has nothing with KVM. So it really
> confused me and I'm not familiar with usb devices. Also I have seen someone else reports this issue
> before[1].
>
> [1]https://lists.gnu.org/archive/html/qemu-arm/2016-06/msg00110.html
>
> Any comments and help are welcome. Thanks in advance.
>

Does your QEMU have this patch?
http://git.qemu.org/?p=qemu.git;a=commitdiff;h=5d636e21c44ecf982a22a7bc4ca89186079ac283

-- 
Ard.
