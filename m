From: robert.walker@arm.com (Robert Walker)
Date: Wed, 29 Aug 2018 15:34:16 +0100
Subject: [PATCH v2] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
In-Reply-To: <20180829084943.eca3716eb2a2141e5eb8e6ee@arm.com>
References: <1535535863-1818-1-git-send-email-robert.walker@arm.com>
 <20180829084943.eca3716eb2a2141e5eb8e6ee@arm.com>
Message-ID: <8ff74d1f-e211-7423-2ad4-35369444488e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kim,


On 29/08/18 14:49, Kim Phillips wrote:
> On Wed, 29 Aug 2018 10:44:23 +0100
> Robert Walker <robert.walker@arm.com> wrote:
>
>> This patch adds support for generating instruction samples from trace of
>> AArch32 programs using the A32 and T32 instruction sets.
>>
>> T32 has variable 2 or 4 byte instruction size, so the conversion between
>> addresses and instruction counts requires extra information from the trace
>> decoder, requiring version 0.9.1 of OpenCSD.  A check for the new struct
>> member has been added to the feature check for OpenCSD.
>>
>> Signed-off-by: Robert Walker <robert.walker@arm.com>
>> ---
> ...
>> +++ b/tools/build/feature/test-libopencsd.c
>> @@ -3,6 +3,13 @@
>>   
>>   int main(void)
>>   {
>> +	/*
>> +	 * Requires ocsd_generic_trace_elem.num_instr_range introduced in
>> +	 * OpenCSD 0.9
> 0.9 != 0.9.1 in the above commit text: which is it?
I'll change it to 0.9.1 if there's another version of the patch (it was 
introduced in 0.9, but 0.9.1 has a necessary bug fix)
>> +	 */
>> +	ocsd_generic_trace_elem elem;
>> +	(void)elem.num_instr_range;
>> +
> This breaks building against older versions of OpenCSD, right?
>
>>   	(void)ocsd_get_version();
> Why don't we maintain building against older versions of the library,
> and use the version information to make the decision on whether to use
> the new feature being introduced in this patch?
The intention is to fail the feature detection check if the older 
version is installed - perf will still compile, but without the 
CoreSight trace support.

OpenCSD is still in development, so new features like this are being 
added and it would add a lot of #ifdef mess to the perf code to continue 
to support any machines with the old library version installed - there 
will only be a handful of machines affected and it's trivial to upgrade 
them (the new Debian packages are available).? How long would we 
continue to support such an older version?? I also don't see any 
precedent for supporting multiple dependent library versions in perf.
>
> Thanks,
>
> Kim
Regards

Rob
