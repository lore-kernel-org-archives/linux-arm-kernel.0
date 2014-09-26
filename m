From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 26 Sep 2014 09:15:11 +0800
Subject: [PATCH v4 0/8] arm/arm64: KVM: dynamic VGIC sizing
In-Reply-To: <20140925133531.GA15736@cbox>
References: <1410433755-3612-1-git-send-email-marc.zyngier@arm.com>
 <54240E20.8060505@huawei.com> <20140925133531.GA15736@cbox>
Message-ID: <5424BE1F.5010801@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/9/25 21:35, Christoffer Dall wrote:
> On Thu, Sep 25, 2014 at 08:44:16PM +0800, Shannon Zhao wrote:
>> Hi all,
>>
>> I have a problem that I want to ask for your advice.
>> Before I send this mail to Marc and Christoffer. But it seems that they are busy or not online recently.
>>
>> I git clone Marc's "kvmtool-vgic-dyn" branch and run it on Fastmodel Cortex-A57*4 with qemu 2.1.0.
>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
>>
>> I want to do repeated lifecycle test. The test is that start 2 VMs, sleep 10 and do pkill qemu.
>> Test script is following:
>> #!/bin/sh
>> while true
>> do
>> 	qemu-system-aarch64 \
>>     		-enable-kvm -smp 4 \
>>     		-kernel Image \
>>     		-m 512 -machine virt,kernel_irqchip=on \
>>     		-initrd guestfs.cpio.gz \
>>     		-cpu host \
>>     		-chardev pty,id=pty0,mux=on -monitor chardev:pty0 \
>>     		-serial chardev:pty0 -daemonize \
>>     		-vnc 0.0.0.0:0 \
>>     		-append "rdinit=/sbin/init console=ttyAMA0 mem=512M root=/dev/ram earlyprintk=pl011,0x9000000 rw" &
>>
>> 	qemu-system-aarch64 \
>>     		-enable-kvm -smp 4 \
>>     		-kernel Image \
>>     		-m 512 -machine virt,kernel_irqchip=on \
>>     		-initrd guestfs.cpio.gz \
>>     		-cpu host \
>>     		-chardev pty,id=pty0,mux=on -monitor chardev:pty0 \
>>    		-serial chardev:pty0 -daemonize \
>>     		-vnc 0.0.0.0:1 \
>>     		-append "rdinit=/sbin/init console=ttyAMA0 mem=512M root=/dev/ram earlyprintk=pl011,0x9000000 rw" &
>>     	sleep 10
>> 	pkill qemu
>> done
>>
>> After repeating sometimes there is something wrong happened as followed.
>> Look forward for your reply.
>> Thanks,
>> Shannon
>>
> Hi Shannon,
> 
> This appears to be related to a bug in vgic_set_attr() which messes up
> the bitmap initialization, I'm working on a patch.
> 
> -Christoffer
> 
> .
> 
Hi Christoffer,

Thanks for you reply.
I will test your patch to check whether the bug disappears.
Thanks,
-- 
Shannon
