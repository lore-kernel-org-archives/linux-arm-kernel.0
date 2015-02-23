From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 23 Feb 2015 10:11:53 +0000
Subject: stand-alone kvmtool
In-Reply-To: <20150218155042.GF22017@arm.com>
References: <54DDD465.3050300@arm.com> <20150218155042.GF22017@arm.com>
Message-ID: <54EAFCE9.5030000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 18/02/15 15:50, Will Deacon wrote:
> Hi Andre,
> 
> Thanks for doing this. Since it looks unlikely that kvmtool will ever be
> merged back into the kernel tree, it makes sense to cut the dependency
> in my opinion.
> 
> On Fri, Feb 13, 2015 at 10:39:33AM +0000, Andre Przywara wrote:
>> as I found it increasingly inconvenient to use kvmtool[1] as part of a
>> Linux repository, I decided to give it a go and make it a stand-alone
>> project. So I filtered all the respective commits, adjusted the paths in
>> there (while keeping authorship and commit date, of course) and then
>> added the missing bits to let it compile without a kernel tree nearby.
>> The result is now available on:
>>
>> git://linux-arm.org/kvmtool.git
>> http://linux-arm.org/kvmtool.git
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
> 
> In which case, it's probably best to post the patches for review rather
> than just point me at your git repo!

Makes some sense, although part of the exercise was to get rid of the
huge, now unneeded Linux kernel code base.
So this approach required a fresh repository, and due to the different
paths there is no out-of-the-box patch compatibility between the two.
Also I wanted to provide an easy way for people to give it a test.

So what I could do is to send the top-most patches against Pekka's
github repository, which would eliminate the references to the kernel
directory (at the cost of duplicating some files).
Once this is settled, acked and applied, one could try to create a new
repository with the tools/kvm directory being the new root.

Let me know if that makes more sense and I will rework the patches to
apply against the current upstream kvmtool.

Cheers,
Andre.

P.S. Although both approaches still provide the kvmtool patch history,
they do not compile before the dependency cut patches. If that is an
issue, one could think about injecting those new patches back into the
repository time line. Admittedly that sounds scary, but would solve the
problem.
