From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 13 Feb 2015 14:40:29 +0000
Subject: stand-alone kvmtool
In-Reply-To: <54DE0A9C.7080505@huawei.com>
References: <54DDD465.3050300@arm.com> <54DE0A9C.7080505@huawei.com>
Message-ID: <54DE0CDD.70308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ciao Claudio,

On 13/02/15 14:30, Claudio Fontana wrote:
> Hello Andre,
> 
> On 13.02.2015 11:39, Andre Przywara wrote:
>> Hi,
>>
>> as I found it increasingly inconvenient to use kvmtool[1] as part of a
>> Linux repository, I decided to give it a go and make it a stand-alone
>> project. So I filtered all the respective commits, adjusted the paths in
>> there (while keeping authorship and commit date, of course) and then
>> added the missing bits to let it compile without a kernel tree nearby.
>> The result is now available on:
>>
>> git://linux-arm.org/kvmtool.git
>> http://linux-arm.org/kvmtool.git
> 
> It builds fine on x86_64, but when I tried to crosscompile from x86_64 to AArch64,
> I get in trouble because of libfdt: I have the aarch64 libs (static and shared), but how do I instruct the build system to get it from the right place?

You have to install them into your cross-compiler's SYSROOT.
Get the location of that by executing
$ ${CROSS_COMPILE}gcc -print-sysroot.
If it's just for libfdt, it's probably the easiest to copy them
manually, the header files into $SYSROOT/usr/include, the libraries into
$SYSROOT/usr/lib/aarch64-linux-gnu
That fixed it for me ;-)

For a more robust approach you would use your distribution's packaging
system to install the aarch64 package into $SYSROOT.

Cheers,
Andre.

> 
>>
>> You can simply check it out, type make and use "./lkvm run" for a quick
>> test. So far I briefly tested x86-64, arm and arm64, the later two were
>> also cross-compiled. For sure there are rough edges in there (for
>> instance copying a few non-uapi header files into), but I deem it worthy
>> enough to get some public comments.
>> For me that also fixed some nasty warnings about libfdt, which now are
>> gone due it using your system library version of it.
>> I also managed to get rid of the libc-i386-dev dependency when compiling
>> for x86-64, but that still needs to be cleaned up and thus is not in the
>> current HEAD.
>> I haven't got around to compile-test the other supported architectures,
>> but supporting them should be as easy as copying over the uapi kvm.h
>> header file (see the respective ARM commit). Contributions (and tests!)
>> are welcome.
>>
>> Please give it a go and tell me what you think. I don't want to fork the
>> project, so I am happy if someone "official" picks it up.
>>
>> Cheers,
>> Andre.
>>
>> [1] https://github.com/penberg/linux-kvm/tree/master/tools/kvm
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm at lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>>
> 
> 
