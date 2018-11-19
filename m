From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 19 Nov 2018 08:32:36 +0100
Subject: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
In-Reply-To: <20181117015651.GA28503@flashbox>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
 <20181107085503.GA31517@flashbox>
 <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
 <CAKwvOdmkC1LqMokhQUebpEZRoWWWwtQnbm8xGwiwdBy9UOMT5Q@mail.gmail.com>
 <af717713-9e51-139d-1206-1682b83ae434@xilinx.com>
 <20181108150116.GA2830@flashbox>
 <40a17c3e-6c81-6f59-cff6-003a91e10b29@xilinx.com>
 <20181109153626.GA6494@flashbox>
 <fd608da5-c1fb-ed55-bf74-7ed476d58c12@xilinx.com>
 <20181117015651.GA28503@flashbox>
Message-ID: <3e65ea20-f850-b66c-b4f8-0a846d4317cc@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17. 11. 18 2:56, Nathan Chancellor wrote:
> On Fri, Nov 16, 2018 at 09:40:45AM +0100, Michal Simek wrote:
>> On 09. 11. 18 16:36, Nathan Chancellor wrote:
>>> On Fri, Nov 09, 2018 at 10:33:00AM +0100, Michal Simek wrote:
>>>> On 08. 11. 18 16:01, Nathan Chancellor wrote:
>>>>> On Thu, Nov 08, 2018 at 07:45:42AM +0100, Michal Simek wrote:
>>>>>> On 07. 11. 18 18:48, Nick Desaulniers wrote:
>>>>>>> On Wed, Nov 7, 2018 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>>>>>>
>>>>>>>> On 07. 11. 18 9:55, Nathan Chancellor wrote:
>>>>>>>>> On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
>>>>>>>>>> On 01. 11. 18 1:57, Nathan Chancellor wrote:
>>>>>>>>>>> Clang warns when one enumerated type is implicitly converted to another:
>>>>>>>>>>>
>>>>>>>>>>> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
>>>>>>>>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
>>>>>>>>>>> type 'enum pin_config_param' [-Wenum-conversion]
>>>>>>>>>>>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
>>>>>>>>>>>         ~               ^~~~~~~~~~~~~~~~~~~~~
>>>>>>>>>>> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
>>>>>>>>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
>>>>>>>>>>> type 'enum pin_config_param' [-Wenum-conversion]
>>>>>>>>>>>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
>>>>>>>>>>>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>>>>> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
>>>>>>>>>>> macro 'PCONFDUMP'
>>>>>>>>>>>         .param = a, .display = b, .format = c, .has_arg = d     \
>>>>>>>>>>>                  ^
>>>>>>>>>>> 2 warnings generated.
>>>>>>>>>>
>>>>>>>>>> This is interesting. I have never tried to use llvm for building the
>>>>>>>>>> kernel. Do you have any description how this can be done?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Depending on what version of Clang you have access to, it is usually just as
>>>>>>>>> simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.
>>>>>>>>>
>>>>>>>>> Clang 7.0+ is recommended but 6.0 might work too.
>>>>>>>>
>>>>>>>> TBH I would expect to download container and run this there to make sure
>>>>>>>> that I don't break anything else.
>>>>>>>
>>>>>>> This is the first request we've had for a container in order to test a
>>>>>>> patch.  If it comes up again from other folks, I think it makes sense
>>>>>>> to create one.  Until then, its nice to have.  It's definitely
>>>>>>> overkill for this patch.
>>>>>>
>>>>>> I have played with it to see that error and here are some steps I did.
>>>>>>
>>>>>> docker run --name test-clang -it --rm debian:latest bash
>>>>>> apt-get update
>>>>>> apt-get install gcc-arm-linux-gnueabi gcc-aarch64-linux-gnu clang git bc
>>>>>> build-essential bison flex make llvm vim libssl-dev sparse
>>>>>>
>>>>>> git clone
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --depth 1
>>>>>> cd linux
>>>>>>
>>>>>> export ARCH=arm64
>>>>>> export CROSS_COMPILE=aarch64-linux-gnu-
>>>>>>
>>>>>> make defconfig
>>>>>
>>>>> This should also have 'CC=clang' because compiler detection happens in
>>>>> Kconfig now so compiler flags get properly set. Other than that, looks
>>>>> good and I was able to build pinctrl-zynq.o without any issues with
>>>>> those commands.
>>>>
>>>> For arm32 I am still getting compilation issue (arm64 is fine)
>>>> Below are my steps and version I use. Do you know what could be the
>>>> problem?
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>> root at 1e15921e6d15:~/linux# arm-linux-gnueabi-gcc --version
>>>> arm-linux-gnueabi-gcc (Debian 6.3.0-18) 6.3.0 20170516
>>>> Copyright (C) 2016 Free Software Foundation, Inc.
>>>> This is free software; see the source for copying conditions.  There is NO
>>>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>>>
>>>> root at 1e15921e6d15:~/linux# clang --version
>>>> clang version 3.8.1-24 (tags/RELEASE_381/final)
>>>> Target: x86_64-pc-linux-gnu
>>>> Thread model: posix
>>>> InstalledDir: /usr/bin
>>>>
>>>>
>>>> export ARCH=arm
>>>> export CROSS_COMPILE=arm-linux-gnuaebi-
>>>> make CC=clang defconfig
>>>> make CC=clang drivers/pinctrl/pinctrl-zynq.o
>>>>
>>>> and I get
>>>> clang: error: unsupported argument '-W' to option 'Wa,'
>>>> scripts/Makefile.build:305: recipe for target 'scripts/mod/empty.o' failed
>>>> make[2]: *** [scripts/mod/empty.o] Error 1
>>>> scripts/Makefile.build:546: recipe for target 'scripts/mod' failed
>>>>
>>>
>>> Ah because Debian's regular Clang is ancient.
>>>
>>> For testing, we use the builds from apt.llvm.org. Commands assuming
>>> you're using the normal Debian image:
>>>
>>> curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
>>> echo "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch main" | tee -a /etc/apt/sources.list
>>> apt-get update -qq && apt-get install -y clang-8
>>>
>>> Then use `CC=clang-8' instead of 'CC=clang' for all make invocations.
>>>
>>
>> Still I see some issues. Log below.
>>
>> Thanks,
>> Michal
>>
>> root at 1e15921e6d15:~/linux# git reset --hard v4.20-rc2
>> HEAD is now at ccda4af0f4b9 Linux 4.20-rc2
>> root at 1e15921e6d15:~/linux#
>> root at 1e15921e6d15:~/linux#
>> root at 1e15921e6d15:~/linux# export ARCH=arm
>> root at 1e15921e6d15:~/linux# export CROSS_COMPILE=arm-linux-gnuaebi-
>> root at 1e15921e6d15:~/linux# export CC=clang-8
>> root at 1e15921e6d15:~/linux# make CC=clang-8 defconfig
>>   HOSTCC  scripts/kconfig/conf.o
>>   HOSTLD  scripts/kconfig/conf
>> *** Default configuration is based on 'multi_v7_defconfig'
>> #
>> # configuration written to .config
>> #
>> root at 1e15921e6d15:~/linux# make CC=clang-8
>> scripts/kconfig/conf  --syncconfig Kconfig
>>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-common.h
>>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
>>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
>>   UPD     include/config/kernel.release
>>   UPD     include/generated/uapi/linux/version.h
>>   UPD     include/generated/utsrelease.h
>>   SYSNR   arch/arm/include/generated/asm/unistd-nr.h
>>   SYSTBL  arch/arm/include/generated/calls-oabi.S
>>   SYSTBL  arch/arm/include/generated/calls-eabi.S
>>   CC      kernel/bounds.s
>> clang: warning: argument unused during compilation: '-Wa,-W'
>> [-Wunused-command-line-argument]
>> clang: warning: argument unused during compilation: '-Wa,-march=armv7-a'
>> [-Wunused-command-line-argument]
>>   UPD     include/generated/bounds.h
>>   CC      arch/arm/kernel/asm-offsets.s
>> clang: warning: argument unused during compilation: '-Wa,-W'
>> [-Wunused-command-line-argument]
>> clang: warning: argument unused during compilation: '-Wa,-march=armv7-a'
>> [-Wunused-command-line-argument]
>>   UPD     include/generated/asm-offsets.h
>>   CALL    scripts/checksyscalls.sh
>> clang: warning: argument unused during compilation: '-Wa,-W'
>> [-Wunused-command-line-argument]
>> clang: warning: argument unused during compilation: '-Wa,-march=armv7-a'
>> [-Wunused-command-line-argument]
>>   CC      scripts/mod/empty.o
>> clang: error: unsupported argument '-W' to option 'Wa,'
>> scripts/Makefile.build:293: recipe for target 'scripts/mod/empty.o' failed
>> make[2]: *** [scripts/mod/empty.o] Error 1
>> scripts/Makefile.build:518: recipe for target 'scripts/mod' failed
>> make[1]: *** [scripts/mod] Error 2
>> Makefile:1075: recipe for target 'scripts' failed
>> make: *** [scripts] Error 2
>> root at 1e15921e6d15:~/linux# clang-8 --version
>> clang version 8.0.0-svn345496-1~exp1+0~20181029105533.852~1.gbpf10f36
>> (trunk)
>> Target: x86_64-pc-linux-gnu
>> Thread model: posix
>> InstalledDir: /usr/bin
>> root at 1e15921e6d15:~/linux# arm-linux-gnueabi-gcc --version
>> arm-linux-gnueabi-gcc (Debian 6.3.0-18) 6.3.0 20170516
>> Copyright (C) 2016 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>
>>
> 
> I think it's the 'export CC=clang-8'; without it, I can get past that
> point without any issues. Our continuous integration setup provides CC
> to make on the same line, without an export.
> 
> https://github.com/ClangBuiltLinux/continuous-integration/blob/master/driver.sh
> 
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/159007956

ok - Nice links. You use docker already which is exactly what I was
looking for.

I found where the issue was. I did a typo
export CROSS_COMPILE=arm-linux-gnuaebi-
it should be
export CROSS_COMPILE=arm-linux-gnueabi-

Thanks for help to resolve this.

Thanks,
Michal
