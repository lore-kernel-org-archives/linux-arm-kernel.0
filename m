From: agraf@suse.de (Alexander Graf)
Date: Tue, 21 Aug 2018 18:45:46 +0200
Subject: [PATCH v3 7/9] KVM: arm/arm64: Only clean the dcache on
 translation fault
In-Reply-To: <2686ddfc-935a-18e0-46bd-0cb608ae44e1@suse.de>
References: <20171023161122.15291-1-marc.zyngier@arm.com>
 <20171023161122.15291-8-marc.zyngier@arm.com>
 <bfeee11e-f8bf-78f2-ab61-27e43781e2e3@suse.de>
 <9fa7efdf-1c21-7b07-edb9-0c7d0d91eaed@arm.com>
 <2686ddfc-935a-18e0-46bd-0cb608ae44e1@suse.de>
Message-ID: <7e6b101a-4f2d-b49c-2639-fd1f1363d8a2@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2018 04:08 PM, Alexander Graf wrote:
> On 08/21/2018 03:57 PM, Marc Zyngier wrote:
>> On 21/08/18 14:35, Alexander Graf wrote:
>>> On 10/23/2017 06:11 PM, Marc Zyngier wrote:
>>>> The only case where we actually need to perform a dcache maintenance
>>>> is when we map the page for the first time, and subsequent permission
>>>> faults do not require cache maintenance. Let's make it conditional
>>>> on not being a permission fault (and thus a translation fault).
>>>>
>>>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> This patch unfortunately breaks something on Hi1616 SoCs when running
>>> 32bit guests. With this patch applied (and thus with 4.18) I get random
>>> illegal instruction warnings from 32bit code inside VMs. I do not know
>>> at this point whether this affects other CPUs as well.
>> Can you please give a few more details?
>>
>> - what are the CPUs on this Hi1616? At least a /proc/cpuinfo would help
>
> These are A72s:
>
> processor??? : 0
> BogoMIPS??? : 100.00
> Features??? : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> CPU implementer??? : 0x41
> CPU architecture: 8
> CPU variant??? : 0x0
> CPU part??? : 0xd08
> CPU revision??? : 2
>
>>
>> - an example of the crash? Is it within the decompressor? After? This
>> things do matter, given the number of crazy things the 32bit kernel does
>
> They are always in user space. My current reproducer is this:
>
> ? $ while rpm -qa > /dev/null; do :; done
>
> If I run this in parallel with something that just populates RAM (dd 
> if=/dev/nvme0n1 of=/dev/null bs=10G) I get an illegal instruction 
> fault within seconds:
>
> sh-4.4# while rpm -qa > /dev/null; do true; done
> Illegal instruction (core dumped)
>
>
>> - a host kernel configuration?
>
> Host kernel configuration is just the normal openSUSE one:
>
> https://kernel.opensuse.org/cgit/kernel-source/plain/config/arm64/default?h=stable 
>
>
>>> If anyone is interested in a reproducer, I have something handy. But 
>>> for
>>> now I believe we should just revert this patch.
>> Before we revert anything, I'd like to understand what is happening.
>
> Yeah, I didn't realize the commit is already in since 4.16, so I 
> agree. I'll bisect a bit, but it may take a while.

I'm stuck on bisect. Somewhere in the merge window things broke so badly 
that udev just segfaults on boot. I got this far:

$ git bisect log
git bisect start
# good: [29dcea88779c856c7dc92040a0c01233263101d4] Linux 4.17
git bisect good 29dcea88779c856c7dc92040a0c01233263101d4
# bad: [529bea37411759c2b5b41a187b3020723c67c16d] Linux 4.18.1
git bisect bad 529bea37411759c2b5b41a187b3020723c67c16d
# good: [3036bc45364f98515a2c446d7fac2c34dcfbeff4] Merge tag 
'media/v4.18-2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 3036bc45364f98515a2c446d7fac2c34dcfbeff4
# good: [721afaa2aeb860067decdddadc84ed16f42f2048] Merge tag 'armsoc-dt' 
of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 721afaa2aeb860067decdddadc84ed16f42f2048
# good: [e7441c9274a6a5453e06f4c2b8b5f72eca0a3f17] mac80211: disable 
BHs/preemption in ieee80211_tx_control_port()
git bisect good e7441c9274a6a5453e06f4c2b8b5f72eca0a3f17
# bad: [05df204549c510c7c56e58d25098c448998a0cd5] Merge tag 
'devicetree-fixes-for-4.18' of 
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect bad 05df204549c510c7c56e58d25098c448998a0cd5
# good: [b19b9282093588e73401f9d4981310a8de975f7d] Merge tag 
'riscv-for-linus-4.18-rc4' of 
git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux
git bisect good b19b9282093588e73401f9d4981310a8de975f7d
# good: [bf642e3a1996f1ed8f083c5ecd4b51270a9e11bc] Merge tag 
'drm-intel-fixes-2018-07-12' of 
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
git bisect good bf642e3a1996f1ed8f083c5ecd4b51270a9e11bc
# bad: [2a7e1211e130c51a2b5743ecf247645ac8e936ee] Merge tag 
'vfio-v4.18-rc5' of git://github.com/awilliam/linux-vfio
git bisect bad 2a7e1211e130c51a2b5743ecf247645ac8e936ee
# bad: [a74aa9676c0256eac05efb2c8e3127e0835e66e5] Merge tag 
'char-misc-4.18-rc5' of 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect bad a74aa9676c0256eac05efb2c8e3127e0835e66e5
# bad: [f1454959ad89f9fe2b6862fa3c41070feaffeab9] Merge tag 
'mmc-v4.18-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad f1454959ad89f9fe2b6862fa3c41070feaffeab9
# bad: [1e09177acae32a61586af26d83ca5ef591cdcaf5] Merge tag 
'mips_fixes_4.18_3' of 
git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect bad 1e09177acae32a61586af26d83ca5ef591cdcaf5
# good: [4f65245f2d178b9cba48350620d76faa4a098841] HID: hiddev: fix 
potential Spectre v1
git bisect good 4f65245f2d178b9cba48350620d76faa4a098841



Alex
