From: jcm@redhat.com (Jon Masters)
Date: Fri, 20 Oct 2017 13:24:25 -0400
Subject: [PATCH 0/3] arm64: cpuinfo: make /proc/cpuinfo more human-readable
In-Reply-To: <20171020161053.ujw3spzizhgu4g7b@lakrids.cambridge.arm.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170927103406.GC32150@leverpostej>
 <CAOZdJXUzo3JrHW1h6W3y3BnVq472NjPpaqTztzEODZnnMyvJRg@mail.gmail.com>
 <20171013142724.GA5893@leverpostej>
 <abeb1756-3635-2f86-131c-cd904731a308@redhat.com>
 <20171020161053.ujw3spzizhgu4g7b@lakrids.cambridge.arm.com>
Message-ID: <d544f5a8-e6b2-f645-23cc-0d1466f49bf8@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 10/20/2017 12:10 PM, Mark Rutland wrote:

> On Mon, Oct 16, 2017 at 05:43:19PM -0600, Al Stone wrote:

>> Obviously, you'll have to see the patches to
>> properly answer that, but what I'm playing with at present is placing
>> this info in new entries in /sys/devices/cpu and/or /sys/devices/system,
>> and generating some of the content based on what's already in header files
>> (e.g., in cputype.h). 
> 
> My opposition to MIDR -> string mapping applies regardless of
> location...

Well, we do need to have the name to display to the user. Two things
that absolutely need to be in a clear, easy to find place:

1). The make and model of the CPU in human readable format
2). The nominal and operating frequency of the CPU(s)

Obviously, I want this to be in /proc/cpuinfo, but if it goes elsewhere
(and other arches get behind it), then that could work. For the mapping
of name to model, I agree that hard coding stuff in the kernel is ugly.
This means that we need to either leverage DMI/SMBIOS data or add a new
API to something like PSCI (ugly, maybe dangerous) to get the info.

Here are some reasons that I care:

1). The first thing people do when they get an Arm server is to cat
/proc/cpuinfo. They then come complaining that it's not like x86. They
can't get the output their looking for and this results in bug filing,
and countless hours on phone calls discussing over and over again.
Worse, there are some parts of the stack that really need this.

2). I have seen entire Arm server SoCs get a bad review because the
person running some test couldn't get the frequency reported in a
sensible enough place that they noticed it was an early part clocked at
half the frequency. Today, they have little opportunity to notice the
frequency and a lot of chance to start spreading rumors that some part
"sucks". Sure, bogomips, other numbers are all lies. But if I had a
penny for every time someone said "man, this server only runs at 100/400
MHz! that's so slow!" (arch timer)

So we're going to clean this up. I've spoken with all of the vendors and
there's general agreement that this needs changing for Enterprise users.
But how it's done - definitely there's flexibility there. One thing that
we won't do is have no solution. While it would be very unfortunate to
carry something just in RHEL, we'll do it (hopefully in collaboration
with other distros) if this isn't resolvable upstream.

Thanks,

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
