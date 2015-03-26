From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Mar 2015 12:57:34 -0600
Subject: "ARM: multi_v7_defconfig: Enable shmobile platforms" breaks
 Tegra20 multi_v7_defconfig boot
In-Reply-To: <alpine.DEB.2.02.1503261826210.18294@utopia.booyaka.com>
References: <alpine.DEB.2.02.1503251740130.13341@utopia.booyaka.com>
 <CANMBJr7ibVCxQRUG47OT0meNntMjEoVqL7kiEK9DtCfp5NXPgg@mail.gmail.com>
 <alpine.DEB.2.02.1503252157240.7173@utopia.booyaka.com>
 <55137098.4030903@wwwdotorg.org>
 <alpine.DEB.2.02.1503261826210.18294@utopia.booyaka.com>
Message-ID: <5514569E.2030406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2015 12:35 PM, Paul Walmsley wrote:
> On Wed, 25 Mar 2015, Stephen Warren wrote:
>
>> On 03/25/2015 04:00 PM, Paul Walmsley wrote:
>>> On Wed, 25 Mar 2015, Tyler Baker wrote:
>>>> On 25 March 2015 at 11:03, Paul Walmsley <paul@pwsan.com> wrote:
>>>>> Looks like commit 4a3a6f86693922b29cf829c63f652b057f14619e ("ARM:
>>>>> multi_v7_defconfig: Enable shmobile platforms") breaks Tegra20
>>>>> multi_v7_defconfig boot.
>>>>>
>>>>> Boot log before:
>>>>>
>>>>> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150325105514_6af714b069dc278d5d8e1b7afc13568f71d9aba8/20150325105514/boot/tegra20-trimslice/tegra20-trimslice/multi_v7_defconfig_log.txt
>>>>>
>>>>> Boot log after:
>>>>>
>>>>> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150325105350_4a3a6f86693922b29cf829c63f652b057f14619e/20150325105350/boot/tegra20-trimslice/tegra20-trimslice/multi_v7_defconfig_log.txt
>>>>>
>>>>>
>>>>> Any ideas?  Stephen Warren thinks there might be an initcall that might
>>>>> not check to see what kind of device it's running on.
>>>>
>>>> Can you try to shift your kernel load address around a bit? From
>>>> experience with the boards from kernelci.org we find that as the multi
>>>> v7 kernel size increases they can clobber memory when they get
>>>> decompressed.
>>>
>>> Thanks, that was it:
>>>
>>> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150325144058_6af714b069dc278d5d8e1b7afc13568f71d9aba8/20150325144058/boot/tegra20-trimslice/tegra20-trimslice/multi_v7_defconfig_log.txt
>>>
>>> Should have guessed when absolutely no debug output was emitted by the
>>> board...
>>>
>>> Sorry for the false alarm, Geert!
>>
>> Interesting. Do the values in U-Boot's default environment work
>> correctly
>
> No idea, I haven't tried.  (The load addresses I used are observable in
> the boot logs above.)

Sure. I was hoping you'd try it out since you already had the setup to 
repro the issue.

It'd be good if your test-bed used the built-in U-Boot variables too, so 
we're testing them.

>> ("env default -f -a" will reset the environment to default, in
>> case some old values are saved in flash); I put some effort into picking
>> them so I really hope they work! ${kernel_addr_r}, ${fdt_addr_r},
>> ${ramdisk_addr_r}.
>
> According to the tegra20-common.h file in the u-boot source here,
> kernel_addr_r is 0x01000000 and fdt_addr_r is 0x02000000.  If one assumes
> the problem is that the kernel decompressor is overwriting the DTB, then
> I suspect they wouldn't work either, since the gap between the addresses
> is the same as what I used (0x01000000).

I expect the issue is more how close the uncompressed kernel and/or DTB 
are to the start of RAM (where the decompressor writes to). IIRC, if the 
decompressor is going to overwrite the compressed kernel during 
decompression, it moves itself first. I can't remember where the 
destination of the move is, but perhaps the relocation can over-write 
the DTB. By pushing the location of the compressed kernel away from the 
start of RAM, this relocation won't happen. IIRC when the decompression 
happens, or relocation prior to decompression, there's no protection of 
the DTB being overwritten.
