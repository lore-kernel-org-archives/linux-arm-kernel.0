From: rruigrok@codeaurora.org (Ruigrok, Richard)
Date: Mon, 25 Sep 2017 14:52:26 -0600
Subject: ARM64: kernel panics in DABT in sys_msync path
In-Reply-To: <20170925190426.6prpcfn7lly26clm@yury-thinkpad>
References: <20170924213622.75e7r3k56tgxlezh@yury-thinkpad>
 <20170925105335.GA24042@arm.com>
 <20170925140240.vl5mvbce5lb37dxe@yury-thinkpad>
 <20170925190426.6prpcfn7lly26clm@yury-thinkpad>
Message-ID: <67f93803-0e94-d922-ab85-9b3a5f887bd8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/25/2017 1:04 PM, Yury Norov wrote:
> On Mon, Sep 25, 2017 at 05:02:40PM +0300, Yury Norov wrote:
>>  Hi Will,
>>  
>>>> The bug is reproducible for ilp32 and lp64 binaries. For kernel 4.12
>>>> and for all kernels if '-smp 1' is passed to qemu, everything works
>>>> fine. If no ideas, I think I'm able bisect it.
>>> I tried to reproduce this on hardware, but failed to do so. Our nightly
>>> tests are also coming back fine for rwtest03. I just built Qemu v2.10.0
>>> and that also passes the test with -smp 4 for me, so I'm a bit stuck.
Hi Will,

I also found this issue with kernels from 4.11 through 4.13, reproduced on Hardware.? In my tests, I found that it reproduces only with 4K page and Transparent Huge Pages. With 64K page I was not able to reproduce. RH also reported it here: https://bugzilla.redhat.com/show_bug.cgi?id=1491504 and Linaro reported on the 4.12 based RPK kernel.

https://bugs.linaro.org/show_bug.cgi?id=3191

https://bugs.linaro.org/show_bug.cgi?id=3068.

I was able to bisect down to a specific commit:? f27176cfc363 mm: convert page_mkclean_one() to use page_vma_mapped_walk()

Ran with LTP 20170516 release, rwtest:?? ./runltp -p -f fs -s rwtest
To validate bisecting (good points), I ran 30 iterations.? Usually it reproduces in 5-10 iterations.

LMK if you have any suggestions for instrumentation, when running with ftrace I could not repro. I can run tests on 4.13 or on 4.11 at the above bisect point.
I have not tried any 4.14-rc yet.
>> I also see the test passed sometimes. I run it in endless cycle and
>> leave for a while. 5-10 iterations are usually enough.
>>
>>> Could you share:
>>>
>>>   * Your kernel .config
>>>   * Your QEMU command line
>>>   * Details of your userspace
>> Qemu configure command:
>> ./configure --target-list=aarch64-softmmu --enable-fdt --enable-vhost-net --enable-kvm
>>
>> And run command:
>> /home/yury/work/qemu-2.10.0/aarch64-softmmu/qemu-system-aarch64 \
>> 	-machine virtualization=true -machine gic-version=3 \
>> 	-machine virt -cpu cortex-a57 -nographic -smp 4  -m 1024 \
>> 	-global virtio-blk-device.scsi=off -device virtio-scsi-device,id=scsi \
>> 	-drive file=img/ubuntu-core-14.04.1-core-arm64.img,id=coreimg,cache=unsafe,if=none -device scsi-hd,drive=coreimg \
>> 	-kernel /home/yury/work/linux/arch/arm64/boot/Image \
>> 	--append "console=ttyAMA0 root=/dev/sda" \
>> 	-initrd initrd.img-3.13.0-62-generic \
>> 	$NETWORK \
>> 	-redir tcp:2222::22 \
>> 	-s \
>> 	$@
>>
>> My userspace is Ubuntu 14. I build lp64 tests with default Ubuntu
>> toolchain, and ilp32 tests with Linaro cross-toolchain. 
>>
>> The config is attached, and the branch is vanilla 4.13 kernel, or this
>> one:
>> https://github.com/norov/linux/tree/ilp32-4.13
>>
>> Later today I will share the whole qemu environment I use.
> https://drive.google.com/file/d/0B07VUB3kjLD8Mm5XN21qTTBfbnc/view
>
>> Yury
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
