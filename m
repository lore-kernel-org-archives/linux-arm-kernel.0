From: anurup.m@huawei.com (Anurup M)
Date: Mon, 27 Jul 2015 11:03:22 +0530
Subject: kexec crash kernel boot failure on arm64
In-Reply-To: <20150724092934.GA23074@leverpostej>
References: <D2393EB95A9993478029A6FE6A290A9F81D90EF8@szxeml510-mbx.china.huawei.com>
 <20150724092934.GA23074@leverpostej>
Message-ID: <55B5C2A2.6040100@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Sorry that I missed the details.
please find it inline


On 7/24/2015 2:59 PM, Mark Rutland wrote:
> On Fri, Jul 24, 2015 at 03:07:24AM +0100, Anurup m wrote:
>> Hi All,
>>
>> There is a problem observed with crash kernel boot in kdump on arm64.
> 
> With which kernel? Mainline doesn't have kexec or kdump support for
> arm64.
> 

I use 3.19 kernel + kexec+kdump patches applied from
https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git/commit/?h=kexec-4.0-stable

>> On arm64 hardware board, when I enable the purgatory segment, the crash kernel doesnot boot.
>> When checked with trace32, it is observed that the control comes to purgatory_start routine, 
>> but the instructions are seen as UNDEF and the boot hangs. But when I took the memory dump, the
>> contents were seen as proper(matching with the purgatory_start code).
>>
>> I did some experiments to analyze this issue. Tried changing the Load order of kexec segments and
>> observed results as below
>> ------------------------------------------------------------------------------
>>     Segments Load order						crash kernel boot status
>>     --------------------			            -------------------------
>> 1) crash kernel, initrd, dtb. Elfcorehdr		-	 Boot Success - without purgatory
>> 2) crash kernel, initrd, dtb. Purgatory, elfcorehdr -  HUNG as control does not reach purgatory segment.
>> 3) crash kernel, elfcorehdr, purgatory, dtb, initrd -	 Boot Success
>> 4) crash kernel, initrd, dtb, purgatory, elfcorehdr, - Boot Success
>>    an extra segment(~20M)).
>>
>> From this I could infer that If I load a larger segment after purgatory (in the load order), the crash
>> Kernel boots. i.e. memory sync is taking some time.
>>
>> So to clarify if memory sync is the Issue, I tried flush the data cache after writing the kexec segments.
>>
>> kernel/kexec.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/kexec.c b/kernel/kexec.c index 7bb25f0..ca36aa0 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -1176,6 +1176,10 @@ static int kimage_load_crash_segment(struct kimage *image,
>>  		else
>>  			result = copy_from_user(ptr, buf, uchunk);
>>  		kexec_flush_icache_page(page);
>> +		/* Flush Dcache to make sure it is push to DRAM
>> +		 * This is added as workaround for crash kernel
>> +		 * boot failure */
>> +		__flush_dcache_area((__force void *)ptr, uchunk);
>>  		kunmap(page);
>>  		if (result) {
>>  			result = -EFAULT;
>>
>> With the above change, control could reach purgatory_start, but this time it loops due to sha256_digest
>> Verify failure. It is able to boot to crash kernel (after comment verify_sha256_digest)
>>
>> What could be the possible reasons for this issue? Please share your comments.
> 
> The only verify_sha256_digest I can see in the kernel tree is under
> arch/x86. Without knowing what kernel you're running, it's not possible
> to answer your question.
> 
  The verify_sha256_digest is done by purgatory module in kexec-tools(purgatory is the intermediate code executed between first and second kernel
).

The kexec-tools used is taken from
https://git.linaro.org/people/takahiro.akashi/kexec-tools.git/shortlog/refs/heads/kdump/v0.12

-Anurup

> Mark.
> 
> .
> 
