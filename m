From: jgarzik@pobox.com (Jeff Garzik)
Date: Thu, 16 Aug 2012 11:21:49 -0400
Subject: [GIT PULL] Update LZO compression
In-Reply-To: <502C92C3.7090701@oberhumer.com>
References: <50299142.2030504@oberhumer.com>
 <20120814123937.GA14756@sig21.net> <502B8FE3.7080501@oberhumer.com>
 <20120815144539.GA8300@sig21.net> <502C92C3.7090701@oberhumer.com>
Message-ID: <502D100D.2030609@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2012 02:27 AM, Markus F.X.J. Oberhumer wrote:
> On 2012-08-15 16:45, Johannes Stezenbach wrote:
>> On Wed, Aug 15, 2012 at 02:02:43PM +0200, Markus F.X.J. Oberhumer wrote:
>>> On 2012-08-14 14:39, Johannes Stezenbach wrote:
>>>> On Tue, Aug 14, 2012 at 01:44:02AM +0200, Markus F.X.J. Oberhumer wrote:
>>>>> On 2012-07-16 20:30, Markus F.X.J. Oberhumer wrote:
>>>>>>
>>>>>> As stated in the README this version is significantly faster (typically more
>>>>>> than 2 times faster!) than the current version, has been thoroughly tested on
>>>>>> x86_64/i386/powerpc platforms and is intended to get included into the
>>>>>> official Linux 3.6 or 3.7 release.
>>>>>>
>>>>>> I encourage all compression users to test and benchmark this new version,
>>>>>> and I also would ask some official LZO maintainer to convert the updated
>>>>>> source files into a GIT commit and possibly push it to Linus or linux-next.
>>>>
>>>> Sorry for not reporting earlier, but I didn't have time to do real
>>>> benchmarks, just a quick test on ARM926EJ-S using barebox,
>>>> and found in the new version decompression is slower:
>>>> http://lists.infradead.org/pipermail/barebox/2012-July/008268.html
>>>
>>> I can only guess, but maybe your ARM cpu does not have an efficient
>>> implementation of {get,put}_unaligned().
>>
>> Yes, ARMv5 cannot do unaligned access.  ARMv6+ could, but
>> I think the Linux kernel normally traps it for debug,
>> all ARM seem to use generic {get,put}_unaligned() implementation
>> which use byte access and shift.
>
> Hmm - I could imagine that we're wasting a lot of possible speed gain
> by not exploiting that feature on ARMv6+.

Or you could just realize that unaligned accesses are slow in the best 
case, and are simply not supported on some processors.

If you think a little bit, I bet you could come up with a solution that 
operates at cacheline-aligned granularity, something that would be _even 
faster_ than simply fixing the code to do aligned accesses.

	Jeff
