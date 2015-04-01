From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 01 Apr 2015 15:21:33 -0600
Subject: "ARM: multi_v7_defconfig: Enable shmobile platforms" breaks
 Tegra20 multi_v7_defconfig boot
In-Reply-To: <551C445C.7040107@nvidia.com>
References: <alpine.DEB.2.02.1503251740130.13341@utopia.booyaka.com>
 <CANMBJr7ibVCxQRUG47OT0meNntMjEoVqL7kiEK9DtCfp5NXPgg@mail.gmail.com>
 <alpine.DEB.2.02.1503252157240.7173@utopia.booyaka.com>
 <55137098.4030903@wwwdotorg.org>
 <alpine.DEB.2.02.1503261826210.18294@utopia.booyaka.com>
 <5514569E.2030406@wwwdotorg.org> <551C2768.6060209@wwwdotorg.org>
 <551C2F7A.7040107@nvidia.com> <551C3F25.40105@wwwdotorg.org>
 <551C445C.7040107@nvidia.com>
Message-ID: <551C615D.3040907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2015 01:17 PM, Paul Walmsley wrote:
> On 04/01/2015 12:55 PM, Stephen Warren wrote:
>> (Dropping people likely not interested in Tegra U-Boot from explicit Cc)
>>
>> On 04/01/2015 11:48 AM, Paul Walmsley wrote:
>>> On 04/01/2015 11:14 AM, Stephen Warren wrote:
>>>> On 03/26/2015 12:57 PM, Stephen Warren wrote:
>>>>> On 03/26/2015 12:35 PM, Paul Walmsley wrote:
>>>>>> On Wed, 25 Mar 2015, Stephen Warren wrote:
>>>>>>
>>>>>>> On 03/25/2015 04:00 PM, Paul Walmsley wrote:
>>>>>>>> On Wed, 25 Mar 2015, Tyler Baker wrote:
>>>>>>>>> On 25 March 2015 at 11:03, Paul Walmsley <paul@pwsan.com> wrote:
>>>>>>>>>> Looks like commit 4a3a6f86693922b29cf829c63f652b057f14619e ("ARM:
>>>>>>>>>> multi_v7_defconfig: Enable shmobile platforms") breaks Tegra20
>>>>>>>>>> multi_v7_defconfig boot.
>>>> ...
>>>>>>>>> Can you try to shift your kernel load address around a bit? From
>>>>>>>>> experience with the boards from kernelci.org we find that as the
>>>>>>>>> multi
>>>>>>>>> v7 kernel size increases they can clobber memory when they get
>>>>>>>>> decompressed.
>>>>>>>>
>>>>>>>> Thanks, that was it:
>>>>>>>>
>>>>>>>> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150325144058_6af714b069dc278d5d8e1b7afc13568f71d9aba8/20150325144058/boot/tegra20-trimslice/tegra20-trimslice/multi_v7_defconfig_log.txt
>>>>>>>>
>>>>>>>>
>>>> ...
>>>>>>> Interesting. Do the values in U-Boot's default environment work
>>>>>>> correctly
>>>>>>
>>>>>> No idea, I haven't tried.  (The load addresses I used are
>>>>>> observable in
>>>>>> the boot logs above.)
>>>>>
>>>>> Sure. I was hoping you'd try it out since you already had the setup to
>>>>> repro the issue.
>>>>>
>>>>> It'd be good if your test-bed used the built-in U-Boot variables
>>>>> too, so
>>>>> we're testing them.
>>>>
>>>> I've reproduced the original problem, and then validated that using
>>>> the addresses from U-Boot's default environment (at least with a ToT
>>>> U-Boot that I just built) does indeed solve it.
>>>>
>>>> I'd like to re-iterate that the test bed should be using the values
>>>> from U-Boot's environment rather than making up its own. That way:
>>>>
>>>> * The value the test bed uses for the kernel load address likely
>>>> overlaps where the kernel decompressor writes to for even slightly
>>>> large kernels. This means the decompressor must move itself before
>>>> decompressing. IIUC, there's zero guarantee that moving the
>>>> decompressor won't overwrite the DTB, since IIUC the decompressor uses
>>>> zero knowledge of the DTB location. In other words, if the compressed
>>>> kernel is loaded somewhere that's likely to require it to move itself,
>>>> there's a real risk of the exact same problem cropping up again in the
>>>> future if the kernel happens to overwrite the DTB during relocation.
>>>>
>>>> * The values are part of every Tegra U-Boot port (and hopefully for
>>>> other SoCs too given any distro using boot.scr with
>>>> config_distro_bootcmd.h will expect the variables to exist), so for
>>>> future (Tegra) chips you won't have to adjust the test bed if RAM
>>>> layout changes.
>>>>
>>>> * Those values get testing, so we'll find out if the ever don't work.
>>>> We get more test coverage.
>>>
>>> Sounds reasonable, I'll try to get to this at some point soon.
>>>
>>> BTW, it might be worth changing U-boot CONFIG_LOADADDR to point to the
>>> value you define for kernel_addr_r.  That would reinforce to folks who
>>> aren't using the U-boot scripts that they should use that address for
>>> loading their kernel.
>>
>> Hmm. Our values for CONFIG_LOADADDR and CONFIG_SYS_LOADADDR in U-Boot
>> seem to be a mess.
>>
>> Essentially they are used for the same semantic purpose, it's just
>> that different U-Boot features use one or the other. I propose we make
>> them the same value. There are certainly many other boards that do
>> (and many that don't, strangely).
>
> That sounds fine to me.  I got totally confused trying to figure out the
> difference between CONFIG_LOADADDR and CONFIG_SYS_LOAD_ADDR.
>
>>
>> I'm not sure that pointing those at the same location as kernel_addr_r
>> is best. I'd expect modern scripts to explicitly use one of the
>> type-specific (kernel, DT, script, initrd, ...) variables and never
>> rely on simple $loadaddr. How about we point these variables somewhere
>> that doesn't overlap with any of the memory regions
>> "reserved"/intended for a specific purpose?
>>
>> In other words, I'd suggest 0x90200000 as the value for Tegra30+;
>> that's consistent with the default values of $scriptaddr and
>> $pxefile_addr_r, i.e. 1MB beyond the latter, and well out of the way
>> from anything else.
>>
>> Does all that sound reasonable? If so, I'll send a patch for U-Boot.
>
> I always used to treat CONFIG_LOADADDR as the "recommended" load address
> for the kernel, as did my colleagues.  But that was years ago in the
> days of uImages and things have changed a lot since then.  So to be
> perfectly honest, I don't know what the right path forward is.  I'd hate
> to add more work to your plate, but maybe we should ask on the U-boot
> mailing lists to see what folks there would recommend?  If you're busy
> I'd be happy to send the initial query, just let me know.
>
> Otherwise, I think you probably know U-boot better than I, so ultimately
> I'm fine with your discretion.

Thinking about this more, there's a case where setting CONFIG_LOADADDR 
to 0x90200000 won't work (raw zImage loaded at that address, with 
AUTO_ZRELADDR in use, booted using U-Boot's bootz command which IIRC 
never relocates the zImage). I would not expect scripts to mix "old" 
variables such as $loadaddr with "new" variables such as $kernel_addr_r, 
so sharing the same location for them should work out fine. I'll just do 
that.
