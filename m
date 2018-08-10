From: labbott@redhat.com (Laura Abbott)
Date: Fri, 10 Aug 2018 08:38:37 +0200
Subject: qemu machine settings and root fs for armv8?
In-Reply-To: <CAKwvOdnaknwFshVAk=G0x44RxZyrMPp+O2yFBauAe9-3C4DpTQ@mail.gmail.com>
References: <CAKwvOdkGatK1HbXG0hDr=a1DtnoCXUbVppLdR6uN5tAKzKdDDQ@mail.gmail.com>
 <CAKwvOdnA5OTcBuRVbcBv8oYHR-mU3+Ee_iFjqbHx4UQxVnpxtQ@mail.gmail.com>
 <5d585df0-abbe-c95f-adff-c4c2e3962832@redhat.com>
 <CAKwvOdnaknwFshVAk=G0x44RxZyrMPp+O2yFBauAe9-3C4DpTQ@mail.gmail.com>
Message-ID: <f2ad3497-5176-d319-1c4a-7b91651d2473@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2018 07:15 PM, Nick Desaulniers wrote:
> On Thu, Aug 9, 2018 at 12:36 AM Laura Abbott <labbott@redhat.com> wrote:
>>
>> I usually use a buildroot environment and just boot as an initramfs:
> 
> I need to play around more with buildroot, but I'll bet that's an
> option to make a ramdisk instead of a full disk image?
> 
>> qemu-system-aarch64 \
>>          -s \
>>          -smp 8 \
>>          -machine virt \
>>          -cpu cortex-a57 \
>>          -machine type=virt \
>>          -nographic \
>>          -m 1024 \
>>          -kernel /path/to/kernel \
>>          --append "nokaslr slub_debug=- console=ttyAMA0 debug_pagealloc=on
>> earlycon=pl011,0x9000000" \
> 
> Very cool, thank you for sharing!
> 
> I'm guessing that kaslr makes it difficult to keep track of addresses
> in between reboots?  There's a parameter "panic=-1" that will reboot
> the kernel on panic that probably works well with this >

Yes, I just disable nokaslr for most testing to make looking
at the addresses easier since I'm often staring at kernel panics
and dumps.

>>          -initrd /path/to/arm64_rootfs.cpio \
>>          -fsdev local,security_model=passthrough,id=fsdev0,path=/tmp/share \
>>          -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare
>>
>> I'll note that this setup makes using kernel modules a big pain but
> 
> How come?
> 

I build the buildroot initrd separately from the kernel. This means that
to include modules in the initrd I have to rebuild the initrd which is
yet another step.

>> it's useful for certain types of testing.
>> The virtio settings are from https://www.linux-kvm.org/page/9p_virtio
>> for sharing files.
> 
> Wow, that's super cool!  That probably helps so that you don't need to
> keep rebuilding your ramdisk.  For binaries I'd guess that any
> dynamically linked dependencies would have to be in that dir, too,
> otherwise the VM wouldn't be able to load them.  But maybe nice for
> statically linked cross compiled binaries.
> 

Yes, binaries are a bit of a pain. buildroot has a good selection of
libraries available to include so I can rebuild the ramdisk to include
those. It's still a lot of trial and error so if I can get away with
it I prefer to have everything statically linked.

> Thanks again.
> 

Thanks,
Laura
