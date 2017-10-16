From: ahs3@redhat.com (Al Stone)
Date: Mon, 16 Oct 2017 17:43:19 -0600
Subject: [PATCH 0/3] arm64: cpuinfo: make /proc/cpuinfo more human-readable
In-Reply-To: <20171013142724.GA5893@leverpostej>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170927103406.GC32150@leverpostej>
 <CAOZdJXUzo3JrHW1h6W3y3BnVq472NjPpaqTztzEODZnnMyvJRg@mail.gmail.com>
 <20171013142724.GA5893@leverpostej>
Message-ID: <abeb1756-3635-2f86-131c-cd904731a308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2017 08:27 AM, Mark Rutland wrote:
> Hi Timur,
> 
> On Fri, Oct 13, 2017 at 08:39:09AM -0500, Timur Tabi wrote:
>> On Wed, Sep 27, 2017 at 5:34 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> On Tue, Sep 26, 2017 at 04:23:21PM -0600, Al Stone wrote:
>>>> As ARMv8 servers get deployed, I keep getting the same set of questions
>>>> from end-users of those systems: what do all the hex numbers mean in
>>>> /proc/cpuinfo and could you make them so I don't have to carry a cheat
>>>> sheet with me all the time?
>>>
>>> I appreciate that /proc/cpuinfo can be opaque to end users, but I do not
>>> believe that this is the right solution to that problem.
>>>
>>> There are a number of issues stemming from the face that /proc/cpuinfo
>>> is ill-defined and overused for a number of cases. Changes to it almost
>>> certainly violate brittle de-facto ABI details people are relying on,
>>> and there's a very long tail on fallout resulting from this. In
>>> addition, many niceties come at an excessive maintenance cost, and are
>>> simply unreliable as an ABI.
>>>
>>> So, as with all other patches modifying /proc/cpuinfo, I must NAK this
>>> series.
>>
>> Qualcomm Datacenter Technologies is very interested in seeing these
>> patches (or some variant of them) accepted. Updates to /proc/cpuinfo
>> are long overdue, and I'm asking you to reconsider your objections.
> 
> I more than appreciate that there is information that people want access
> to, and I'd really like to expose that in a consistent and structured
> manner.
> 
> So please propose exposing the information elsewhere, which I would be
> more than happy with for information that the kernel already has access
> to.
> 
> I object to /proc/cpuinfo changes because they impose an ABI break, and
> because some of the proposed changes impose new and requirements on the
> kernel that cannot be maintained in a forwards-compatible manner (which
> is liable to result in other ABI breaks).
> 
> For better or worse, we're stuck with the existing arch-specific format
> of /proc/cpuinfo, as this is parsed by a wide variety of applications,
> and any change risks breaking these.
> 
>> We're willing to work with distro vendors to get this information
>> added to their products while upstream is left behind, but I hope that
>> won't be necessary.
> 
> Please understand that this is an ABI break, and that is why it is being
> NAK'd.
> 
> I don't have the power to stop Red Hat or other vendors from
> deliberately breaking ABI, but I would very strongly recommend that they
> do not.
> 
>> I would even go so far as to say that we should be making
>> /proc/cpuinfo for ARM match the x86 output as closely as possible,
> 
> As has been stated before, /proc/cpuinfo is an existing arch-specific ABI.
> 
> For better or worse, we're stuck with it as-is, regardless of what could
> be nicer had we done something different from the outset.
> 
> It has never been portable across architectures, and applications
> relying upon it have never been portable except by chance.
> 
>> even using their terminology.  We should be providing information like
>> frequencies and product names.
> 
> As has been stated before, the problem with exposing these is that we
> don't have the relevant information.
> 
> We have no consistent mechanism for acquiring product names, and for
> those cases where it is truly necessary to identify an implementation,
> the MIDR+REVIDR provide the exact same information.
> 
> For frequencies, I'd be more than happy to expose this information when
> we have it, in new files. In practice today, we do not have this
> information most of the time.
> 
>> Having a human-readable /proc/cpuinfo with extensive details of the
>> CPU spelled out is very useful, and Al's reasoning is valid.  The fact
>> that it's "fragile" is not as important as the fact that on x86,
>> /proc/cpuinfo is much more useful.
> 
> I must disagree.
> 
> We care about that fragility so that we do not break userspace, which is
> the most important upstream rule.
> 
> I certainly agree that exposing the information that we have is useful,
> as I have stated several times. I'm not NAKing exposing this information
> elsewhere.
> 
> If you want a consistent cross-architecture interface for this
> information, then you need to propose a new one. That was we can
> actually solve the underlying issues, for all architectures, without
> breaking ABI.
> 
> I would be *very* interested in such an interface, and would be more
> than happy to help.

I'm playing with some patches that do very similar things in sysfs, vs
proc.  Is that better :)?  Obviously, you'll have to see the patches to
properly answer that, but what I'm playing with at present is placing
this info in new entries in /sys/devices/cpu and/or /sys/devices/system,
and generating some of the content based on what's already in header files
(e.g., in cputype.h).  The idea of course is to keep this new info from
touching any existing info so we don't break compatibility -- does that
feel like a better direction, at least?

> Thanks,
> Mark.
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
