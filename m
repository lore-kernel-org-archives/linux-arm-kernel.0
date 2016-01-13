From: daniel@iogearbox.net (Daniel Borkmann)
Date: Wed, 13 Jan 2016 01:31:20 +0100
Subject: [PATCH] arm64: Allow vmalloc regions to be set with set_memory_*
In-Reply-To: <20160113000112.GA36310@ast-mbp.thefacebook.com>
References: <1452635187-8057-1-git-send-email-labbott@fedoraproject.org>
 <20160113000112.GA36310@ast-mbp.thefacebook.com>
Message-ID: <56959AD8.90206@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2016 01:01 AM, Alexei Starovoitov wrote:
> On Tue, Jan 12, 2016 at 01:46:27PM -0800, Laura Abbott wrote:
>>
>> The range of set_memory_* is currently restricted to the module address
>> range because of difficulties in breaking down larger block sizes.
>> vmalloc maps PAGE_SIZE pages so it is safe to use as well. Update the
>> function ranges and add a comment explaining why the range is restricted
>> the way it is.
>>
>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>> ---
>> This should let the protections for the eBPF work as expected, I don't
>> know if there is some sort of self test for thatL.
>
> you can test it with:
> # sysctl net.core.bpf_jit_enable=1
> # insmod test_bpf.ko
>
> On x64 it shows:
> test_bpf: Summary: 291 PASSED, 0 FAILED, [282/283 JIT'ed]
>
> arm64 may have less JIT'ed tests.

Also, in that lib/test_bpf.c file, you can do a test by overwriting/'corrupting'
part of the fp->insnsi instructions right after bpf_prog_select_runtime(fp) to
see if setting the bpf_prog as RO works.

Thanks,
Daniel
