From: jcm@jonmasters.org (Jon Masters)
Date: Tue, 24 Nov 2015 23:58:40 -0500
Subject: [GIT PULL] arm64 updates for 4.4
In-Reply-To: <20151106160407.GX7637@e104818-lin.cambridge.arm.com>
References: <20151104182508.GA28726@e104818-lin.cambridge.arm.com>
 <CA+55aFw3Y4x0RQPjgkZSV=NkXEoMWTq7AYRBpkqd-KMt6om6sw@mail.gmail.com>
 <20151105182718.GV7637@e104818-lin.cambridge.arm.com>
 <6512377.hSX37CgtMC@wuerfel>
 <20151106160407.GX7637@e104818-lin.cambridge.arm.com>
Message-ID: <56554000.1000405@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/15, 11:04 AM, Catalin Marinas wrote:

> On Fri, Nov 06, 2015 at 10:57:58AM +0100, Arnd Bergmann wrote:
>> On Thursday 05 November 2015 18:27:18 Catalin Marinas wrote:
>>> On Wed, Nov 04, 2015 at 02:55:01PM -0800, Linus Torvalds wrote:
>>>> On Wed, Nov 4, 2015 at 10:25 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>> It's good for single-process loads - if you do a lot of big fortran
>>>> jobs, or a lot of big database loads, and nothing else, you're fine.
>>>
>>> These are some of the arguments from the server camp: specific
>>> workloads.

On our end, I asked our performance folks (and many others) about 3 or 4 
years ago what they thought would make sense. The numbers suggested that 
16KB might have been ideal (for specific targeted workloads), but since 
that was optional in the architecture (as a later addition) that meant 
"does not exist" as far as server/general purpose goes. Which lead to 
more conversation, followed ultimately by the 64KB choice. The decision 
to go to 64KB was in part based upon various discussion that suggested 
this size was appropriate for workloads, but it is something that is 
under evaluation. And obviously the number of threads on the topic is 
not something that is ignored. 4KB with contiguous hint + huge pages 
might well end up being the sweet spot in the longer term.

One of the purposes of Red Hat Enterprise Linux Server for ARM (RHELSA) 
Development Preview (which I know just rolls off the tongue) is to test 
the water with various decisions and see what works out, and what does 
not. If 64KB does indeed turn out to be a poor decision then the page 
size will be reverted to 4KB at some future time. But it is only once we 
have some of the higher end mainstream systems running RHELSA (like we 
do now) that we can start to actually look at real data and decide.

In addition to the TLB/hardware walker (micro)cache impact of page size 
in terms of levels of walk through the tables (but we have cont. hint 
and aggressive microcaches of interim levels to help us with this), 
there is also the potential impact upon cache design. True we mostly 
claim to be PIPT but underneath implementations might well be able to 
optimize the (parallel) indexing stage given a larger page size. In many 
conversations over the past few years with the architects building the 
impending tsunami of high end v8 server cores, no objections have been 
raised against the choice of 64KB in the first go around.

Anyway. We'll all watch and see :)

Jon.
