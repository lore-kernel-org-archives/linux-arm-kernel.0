From: dann.frazier@canonical.com (Dann Frazier)
Date: Tue, 9 Dec 2014 15:18:51 -0700
Subject: [PATCH V2] arm64: optimized copy_to_user and copy_from_user
 assembly code
In-Reply-To: <A044731C-F47E-4CB2-ACBE-CA73FC950F4D@theobroma-systems.com>
References: <1407538940-9167-1-git-send-email-fkan@apm.com>
 <20141127114322.GA20659@linaro.org>
 <CALdTtnt_AGmTSYmL37rJbVs8r4fvvhXKzFMW4k8KP2j6N7dvCg@mail.gmail.com>
 <CAKp6GAseBB-gPNV-o+NhEFifUpuSUx=FdyZisE2F-ZS83mXGXQ@mail.gmail.com>
 <CAPvkgC2Ofz-hPO=bOFoOdFJPTRuhaZxNE7PCz1YoHqnBqndRcA@mail.gmail.com>
 <A044731C-F47E-4CB2-ACBE-CA73FC950F4D@theobroma-systems.com>
Message-ID: <CALdTtnvExpbDh8jfQL4pxop-K0mOYGk1cR5c6KaZ=1QQpyyVeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 4, 2014 at 6:56 AM, Dr. Philipp Tomsich
<philipp.tomsich@theobroma-systems.com> wrote:
> Craig/Steve/Dann,
>
> trying to understand what went wrong and when, I just went back to my original mail (May 1st, 2013) providing the original optimized functions for an iperf run at APM? this had two separate error-handling paths for _to_user and _from_user, where the _to_user case didn?t zeroize.
>
> I can?t quite track when these two paths were unified (or by who)? but I can confirm that only the _from_user path was designed to zeroize the buffer on error.

This is the source we pulled (previous version had some issues w/
licensing iirc):
  http://www.spinics.net/lists/arm-kernel/msg353650.html

 -dann

> @Craig: I?ll also forward you the original files, which I had earlier sent to Dann on Jul 3rd 2014. This should provide a point-of-reference for resolving this.
>
> Best,
> Philipp.
>
>> On 04 Dec 2014, at 13:27, Steve Capper <steve.capper@linaro.org> wrote:
>>
>> On 3 December 2014 at 20:01, Craig Magina <craig.magina@canonical.com> wrote:
>> [...]
>>>
>>> Could you provide the steps you used to reproduce this issue? I have
>>> already submitted an SRU to revert this patch, but would like to have
>>> the method you used to reproduce it for testing. Thanks for reporting
>>> this.
>>>
>>> --
>>> Craig Magina
>>
>> Hi Craig,
>> It's not easy to reproduce as the problem occurs when the kernel is
>> copying memory to userspace and experiences a page fault.
>>
>> I have come across it whilst running "perf record -a" on a system that
>> is swapping.
>>
>> Also, building source code under memory pressure (i.e. kernel compile
>> just after the system has swapped out pages), gave me this problem
>> too.
>>
>> Cheers,
>> --
>> Steve
>
