From: labbott@redhat.com (Laura Abbott)
Date: Thu, 9 Aug 2018 09:36:12 +0200
Subject: qemu machine settings and root fs for armv8?
In-Reply-To: <CAKwvOdnA5OTcBuRVbcBv8oYHR-mU3+Ee_iFjqbHx4UQxVnpxtQ@mail.gmail.com>
References: <CAKwvOdkGatK1HbXG0hDr=a1DtnoCXUbVppLdR6uN5tAKzKdDDQ@mail.gmail.com>
 <CAKwvOdnA5OTcBuRVbcBv8oYHR-mU3+Ee_iFjqbHx4UQxVnpxtQ@mail.gmail.com>
Message-ID: <5d585df0-abbe-c95f-adff-c4c2e3962832@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2018 01:10 AM, Nick Desaulniers wrote:
> On Wed, Aug 8, 2018 at 11:52 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> I was wondering if folks had recommendations for testing armv8 kernels
>> in qemu, such as what machine settings and if root fs images existed.
>> I've been playing around with buildroot, but was curious if people had
>> recipes they could share?
> 
> Following up, I found:
> https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_arm64-kernel.md
> helpful to build the rootfs using buildroot.
> 
> Then:
> 
> $ qemu-system-aarch64 -kernel arch/arm64/boot/Image -machine virt -cpu
> cortex-a57 -hda rootfs.ext2 -append "console=ttyAMA0 root=/dev/vda"
> -serial mon:stdio -m 512 -nographic
> 
> worked for me.
> 


I usually use a buildroot environment and just boot as an initramfs:

qemu-system-aarch64 \
	-s \
	-smp 8 \
	-machine virt \
	-cpu cortex-a57 \
	-machine type=virt \
	-nographic \
	-m 1024 \
	-kernel /path/to/kernel \
	--append "nokaslr slub_debug=- console=ttyAMA0 debug_pagealloc=on 
earlycon=pl011,0x9000000" \
	-initrd /path/to/arm64_rootfs.cpio \
	-fsdev local,security_model=passthrough,id=fsdev0,path=/tmp/share \
	-device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare

I'll note that this setup makes using kernel modules a big pain but
it's useful for certain types of testing.
The virtio settings are from https://www.linux-kvm.org/page/9p_virtio
for sharing files.

Thanks,
Laura
