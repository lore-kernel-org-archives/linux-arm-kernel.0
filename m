From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 May 2013 10:23:13 +0100
Subject: VDSO for arm 32bit
In-Reply-To: <634BB1CFA60ED14386C17849392C3EB202E52C9E87@HICGWSEX01.ad.harman.com>
References: <634BB1CFA60ED14386C17849392C3EB202E52C9C0A@HICGWSEX01.ad.harman.com>
 <20899.25935.838288.45383@pilspetsen.it.uu.se>
 <634BB1CFA60ED14386C17849392C3EB202E52C9E87@HICGWSEX01.ad.harman.com>
Message-ID: <20130528092313.GA10474@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 08:48:33AM +0100, Kumar, Ganesh wrote:
> Hi Mikel,
> 
> Kumar, Ganesh writes:
>  > Hi All,
>  >
>  > ? I'm working on OMAP5 on greg's LTS kernel 3.4.25, but I see there is  > no support for vdso for arm 32 bit.
>  > I'm planning to port it to arm 32 bit, is there any work under progress?
>  > would like to understand why the support for arm 32 bit is not there, any idea?
> 
> > 32-bit ARM has a "kuser" page at a fixed virtual address, which exports a few critical routines to user-space.  With that, a vdso is mostly redundant.
> 
>   Thanks for the info, my main idea is to get the gettimeofday exported through the kuser helper,tried looking at the sources
> but I could not find anything related to that seems done in the mainline kernel tree for arm cortex, am I missing something here?
> I plan to do that if its not available yet, right now I've started with the kernel doc for the kuser, any pointers further
> to get the gettimeofday up and running using the kuser, Thanks in advance for your time.

Be careful here. I had a crack at a gtod implementation for the vectors page
in the past, but decided to drop it because it quickly became a maintenance
nightmare. Since the layout of the vectors page must be fixed (as userspace
jumps to the absolute addresses for the helpers), having large, complicated
functions (which gtod does become as you quickly start using the stack to
store all of the shared state with the kernel) means that you can quickly
back yourself into a corner where the layout of the code cannot change
without breaking the ABI.

On top of that, new clock types are added more often than you might think
(not to mention bug fixes in the implementation itself), and you end up in
a horrible situation where you'd end up deprecating one implementation and
adding gettimeofday2 or something equally nasty at a different offset.

Maybe this can be solved by adding loads of padding between the different
functions and hoping for the best, but I think a better solution would be to
try and add something which is actually a vdso but preserves the function
offsets of the current helpers, thus preserving the ABI. That could then
replace the vectors page and newer C libraries could make use of the vdso
functionality. Of course, that's a lot more work and people might have
objections to the approach.

Finally, I assume you're only interested in the co-processor backed
architected timers for this? I know some people were toying with exposing
memory-mapped timers to userspace, but that really scares me.

Will
