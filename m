From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 May 2013 10:24:21 +0100
Subject: VDSO for arm 32bit
In-Reply-To: <634BB1CFA60ED14386C17849392C3EB202E52CA407@HICGWSEX01.ad.harman.com>
References: <634BB1CFA60ED14386C17849392C3EB202E52C9C0A@HICGWSEX01.ad.harman.com>
 <20899.25935.838288.45383@pilspetsen.it.uu.se>
 <634BB1CFA60ED14386C17849392C3EB202E52C9E87@HICGWSEX01.ad.harman.com>
 <20130528092313.GA10474@mudshark.cambridge.arm.com>
 <634BB1CFA60ED14386C17849392C3EB202E52CA407@HICGWSEX01.ad.harman.com>
Message-ID: <20130529092421.GC13095@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 05:00:09AM +0100, Kumar, Ganesh wrote:
>    Hmm, it doesn't seem to be quite straight forward, but thanks for the
>    inputs and caution.  Now that I got a direction, I'm planning to
>    proceed as below: 1. As a first step, get the implementation up and
>    running using the kuser helper (understand the situation and plan to
>    limit my implementation for the ARM Cortex's arch timer clock type) On
>    the user land, does this approach needs a change to the libc, kindly
>    confirm. I read the kernel documentation for kuser helper, it gave a
>    nice overview of how things can be done, but not so clear on how
>    actually the helper functions can be called from the user land (the big
>    picture), does it needs a tweak in the libc in order to enable     the
>    new helper functions defined.

Yes, libc would need updating to direct the various clock system calls via
the vectors page if the kernel is recent enough. Your implementation will
need to fall back to issuing the system call if the arch timer isn't the
current clocksource.

> 2. Plan to get it up through the VDSO, study in progress. One question
> here, was the vdso implementation for 32 bit is not available only because
> of the frequent addition in new clock types or there is any strong reason
> or something I need to take care about, kindly clarify.  I'll start
> looking into the arm64 vdso code as a starting point, is there anything
> else I can refer/read to get going? kindly help. 

This might not be needed after the feedback from Nicolas.

> >>> I know some people were toying with exposing memory-mapped timers to
> >>> userspace, but >>> that really scares me.
> 
>    Just curious, what are the side effects of exposing the memory-mapped
>    timers to user space.

Just that you need to be careful about what you expose and how do you expose
it. For example, control registers may lie in the same page as the actual
counter, and you don't want userspace having access to that if possible.

You'd probably also need to copy code into place, since there are many timer
implementations that could be used.

Will
