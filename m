From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Sep 2012 11:09:27 -0600
Subject: [PATCH 1/1] Fix segfault in DTC
In-Reply-To: <50632F78.4030709@broadcom.com>
References: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-2-git-send-email-mmayer@broadcom.com>
 <20120925233054.GL9800@truffula.fritz.box> <50624393.30607@broadcom.com>
 <20120926003508.GB31993@truffula.fritz.box> <50632F78.4030709@broadcom.com>
Message-ID: <5065D9C7.40906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 10:38 AM, Markus Mayer wrote:
> On 25/09/2012 17:35, David Gibson wrote:
>> On Tue, Sep 25, 2012 at 04:51:47PM -0700, Markus Mayer wrote:
>>> On 25/09/2012 16:30, David Gibson wrote:
>>>>
>>>> Which dtc version did you observe this with?  I'm unable to reproduce
>>>> the SEGV with current git.
>>>
>>> That was
>>>
>>> $ cat version_gen.h
>>> #define DTC_VERSION "DTC 1.2.0-g37c0b6a0"
>>>
>>> from
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git. In
>>> other words, the DTC used by the Linux 3.6-rc series.
>>
>> Ah, ok.  Patches to dtc should be made against the upstream version at
>> git://git.jdl.com/software/dtc.git.  In this case the bug was already
>> fixed there, in commit a6e6c60e3a97a6b3a033cd052bb3740fd53cbf4c.
> 
> Ah yes. That makes sense. Thanks for pointing out the commit that fixes
> the issue. I just checked it out.
> 
>> I think we're overdue to update the kernel copy of dtc from upstream.
> 
> Yeah, seems like the kernel DTC is quite old.

FYI, I'm working on a patch to the kernel to bring in the latest dtc.

I've run a regression test vs. the old dtc in the kernel and found that
some of the PowerPC .dts files don't compile with the new dtc (but did
with the old), all due to non-existent labels/paths being referenced.
I'll try and track down whether this is a regression in dtc, or simply
buggy .dts files that weren't noticed before.

Everything non-PowerPC works fine, and most PowerPC files work fine.
Where compilation succeeds, the md5sum of the .dtb is identical in every
case.
