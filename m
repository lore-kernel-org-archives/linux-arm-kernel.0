From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Oct 2012 15:33:30 -0600
Subject: [PATCH 1/1] Fix segfault in DTC
In-Reply-To: <20121002000851.GA29302@truffula.fritz.box>
References: <50624393.30607@broadcom.com>
 <20120926003508.GB31993@truffula.fritz.box> <50632F78.4030709@broadcom.com>
 <5065D9C7.40906@wwwdotorg.org> <E1THfgr-0006Fg-KT@jdl.com>
 <5065F4FD.4010807@wwwdotorg.org> <20120929235342.GA23078@truffula.fritz.box>
 <50692B7A.8000405@wwwdotorg.org> <20121001064610.GA5323@truffula.fritz.box>
 <5069C7A5.8090409@wwwdotorg.org> <20121002000851.GA29302@truffula.fritz.box>
Message-ID: <506CAF2A.204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2012 06:08 PM, David Gibson wrote:
> On Mon, Oct 01, 2012 at 10:41:09AM -0600, Stephen Warren wrote:
>> On 10/01/2012 12:46 AM, David Gibson wrote:
>>> On Sun, Sep 30, 2012 at 11:34:50PM -0600, Stephen Warren wrote:
>>>> On 09/29/2012 05:53 PM, David Gibson wrote:
>>>>> On Fri, Sep 28, 2012 at 01:05:33PM -0600, Stephen Warren wrote:
>>>>>> On 09/28/2012 12:53 PM, Jon Loeliger wrote:
>>>>>>>>>
>>>>>>>>> Yeah, seems like the kernel DTC is quite old.
>>>>>>>>
>>>>>>>> FYI, I'm working on a patch to the kernel to bring in the latest dtc.
>>>>>>>
>>>>>>> Awesome.  Thank you.
>>>>>>>
>>>>>>>> I've run a regression test vs. the old dtc in the kernel ...
>>>>>>>
>>>>>>> Which is the icky step.  Again, thank you.
>>>>>>>
>>>>>>>> ... and found that
>>>>>>>> some of the PowerPC .dts files don't compile with the new dtc (but did
>>>>>>>> with the old), all due to non-existent labels/paths being referenced.
>>>>>>>> I'll try and track down whether this is a regression in dtc, or simply
>>>>>>>> buggy .dts files that weren't noticed before.
>>>>>>>
>>>>>>> I think you should just smack the PowerPC guys. :-)
>>>>>>
>>>>>> For the record in this thread, it was a regression I introduced into dtc
>>>>>> - the patch I just sent was for this.
>>>>>
>>>>> I would be nice to add a testcase for this regression into dtc.
>>>>
>>>> The issue here was caused by uninitialized memory, so it would, I think,
>>>> be basically impossible to create a test-case that would be guaranteed
>>>> to fail because of this; it'd depend on the internal details of the
>>>> malloc library and how/when it re-used previously free()d memory blocks.
>>>
>>> It doesn't have to be guaranteed to fail to be useful.  Plus, we
>>> already have the infrastructure to run the tests under valgrind, which
>>> would catch it.
>>
>> I certainly disagree here; the absolute worst kind of test is one which
>> gives different results each time it's run, or statically gives
>> different results to different people. People will either ignore the
>> test because it's flaky, or it'll end up blaming the wrong person due to
>> some entirely unrelated and correct change just happening to tickle the
>> test.
> 
> I'd agree 100% if the test could give false failures.  But in this
> case it can only give false passes.

That is true. I still dislike flaky tests irrespective of
false-{negative,positive} though.

> If the test fails there is a bug
> *somewhere*, even if it's not actually in whatever changed last.  The
> test framework actually has a "PASS (inconclusive)" result for exactly
> this sort of case.
> 
>> If we were to force any such new test to always run under valgrind, then
>> hopefully the test would always fail (assuming the test harness triggers
>> failure if valgrind finds problems).
> 
> Aside: it's supposed to;  if it doesn't, that's a bug.  You can try it
> easily enough with "make checkm".

Ah, I didn't know about that make target (or even "make check"; I'd
always run run_tests.sh manually).

Incidentally, before commit 317a5d9 "dtc: zero out new label objects"
the following two tests fail under make checkm:

dtc -I dts -O dtb -o multilabel.test.dtb multilabel.dts:        FAIL
Returned error code 126

dtc -I dts -O dtb -o multilabel_merge.test.dtb multilabel_merge.dts:
FAIL Returned error code 126

However, they pass at/after that commit.

Equally, those failures were introduced with commit 45013d8 "dtc: Add
ability to delete nodes and properties", which is exactly what I'd
expect given the fix was a fix for that commit.

So, it seems like we already have tests that catch this problem. Do we
need to do anything given that?

I am slightly surprised that the problem didn't cause all tests to fail
make checkm though (I'd expect any usage of a label to trigger the
problem); I'll have to think about why some more...
