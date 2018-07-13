From: daniel@iogearbox.net (Daniel Borkmann)
Date: Fri, 13 Jul 2018 15:24:40 +0200
Subject: [PATCH 00/14] ARM BPF jit compiler improvements
In-Reply-To: <20180712213547.GW17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
 <bf534d05-8f75-20bc-e25e-4536c1123585@iogearbox.net>
 <20180712210236.GV17271@n2100.armlinux.org.uk>
 <fbfa3684-b5a0-670d-c8f7-8c14829565cb@iogearbox.net>
 <20180712213547.GW17271@n2100.armlinux.org.uk>
Message-ID: <2d4cbb80-b8f9-fe96-378d-e49bb787aa85@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2018 11:35 PM, Russell King - ARM Linux wrote:
> On Thu, Jul 12, 2018 at 11:12:45PM +0200, Daniel Borkmann wrote:
>> On 07/12/2018 11:02 PM, Russell King - ARM Linux wrote:
>>> On Thu, Jul 12, 2018 at 09:02:41PM +0200, Daniel Borkmann wrote:
>>>> Applied to bpf-next, thanks a lot Russell!
>>>
>>> Thanks, I've just sent four more patches, which is the sum total of
>>> what I'm intending to send for BPF improvements for the next merge
>>> window.
>>
>> Great, thanks a lot for the batch of improvements, Russell!
>>
>> Did you manage to get the BPF kselftest suite working on arm32 under
>> tools/testing/selftests/bpf/? In particular the test_verfier with
>> bpf_jit_enabled set to 1 and test_kmod.sh has a bigger number of
>> runtime tests that would stress it.
> 
> I have a big issue with almost all of the tools/ subdirectory, and
> that is that it isn't "portable".
> 
> It seems that cross-build environments just weren't considered when
> the tools subdirectory was created - it appears to require the entire
> kernel tree and build tree to be accessible on the target in order
> to build almost everything there.  (I also exclusively do split-object
> builds, I never do an in-source-tree build.)
> 
> At least perf has the ability to ask Kbuild to package it up as a
> tar.* file.  That can be easily transported to the target as a
> self-contained buildable tree, and then be able to built from that.
> 
> My cross-build environment for the kernel is just for building
> kernels, it does not have the facilities to build for userspace - I
> have a wide range of userspaces across targets, with a multitude of
> different glibc versions, and even when they're compatible versions,
> they're built differently.
> 
> As far as I can see, basically, most tools/ stuff requires too much
> effort to work around this to be of any use to me.  Even if I did
> unpick it from the kernel source tree by hand, that would be wasted
> effort, because I'd need to repeat that same process whenever
> anything there gets updated.

Right, that's unfortunate, although there is one option which you could
try out. The test_kmod.sh does nothing more than insmodding the test_bpf
kernel module built from lib/test_bpf.c. This one at least has all the
cBPF tests and a couple of eBPF ones (though most for the latter have
been moved to test_verfier). You can enable it via CONFIG_TEST_BPF=m and
then load it with bpf_jit_enabled set to 1. Hope that helps a bit.

Thanks,
Daniel
