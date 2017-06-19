From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Mon, 19 Jun 2017 15:19:27 -0700
Subject: [PATCH] compiler, clang: Add always_inline attribute to inline
In-Reply-To: <alpine.DEB.2.10.1706191439090.2360@chino.kir.corp.google.com>
References: <20170615155440.GC26471@leverpostej>
 <1497887596-8731-1-git-send-email-psodagud@codeaurora.org>
 <alpine.DEB.2.10.1706191322590.95967@chino.kir.corp.google.com>
 <47bd7df20466d5f7f557ca087b0189cf@codeaurora.org>
 <alpine.DEB.2.10.1706191439090.2360@chino.kir.corp.google.com>
Message-ID: <f8ee882e9859f24dac24832bfb5ae0f1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-19 14:42, David Rientjes wrote:
> On Mon, 19 Jun 2017, Sodagudi Prasad wrote:
> 
>> > > Commit abb2ea7dfd82 ("compiler, clang: suppress warning for unused
>> > > static inline functions") re-defining the 'inline' macro but
>> > > __attribute__((always_inline)) is missing. Some compilers may
>> > > not honor inline hint if always_iniline attribute not there.
>> > > So add always_inline attribute to inline as done by
>> > > compiler-gcc.h file.
>> > >
>> >
>> > IIUC, __attribute__((always_inline)) was only needed for gcc versions < 4
>> > and that the inlining decision making is improved in >= 4.  To make a
>> > change like this, I would think that we would need to show that clang is
>> > making suboptimal decisions.  I don't think there's a downside to making
>> > CONFIG_OPTIMIZE_INLINING specific only to gcc.
>> >
>> > If it is shown that __attribute__((always_inline)) is needed for clang as
>> > well, this should be done as part of compiler-gcc.h to avoid duplicated
>> > code.
>> 
>> Hi David,
>> 
>> Here is the discussion about this change -
>> https://lkml.org/lkml/2017/6/15/396
>> Please check mark and will's comments.
>> 
> 
> Yes, the arch/arm64/include/asm/cmpxchg.h instance appears to need
> __always_inline as several other functions need __always_inline in
> arch/arm64/include/*.  It's worth making that change as you suggested 
> in
> your original patch.
> 
> The concern, however, is inlining all "inline" functions forcefully.  
> The
> only reason this is done for gcc is because of suboptimal inlining
> decisions in gcc < 4.
> 
> So the question is whether this is a single instance that can be fixed
> where clang un-inlining causes problems or whether that instance 
> suggests
> all possible inline usage for clang absolutely requires __always_inline
> due to a suboptimal compiler implementation.  I would suggest the 
> former.

Hi David,

  I am not 100% sure about the best approach for this problem. We may 
have to
replace inline with always_inline for all inline functions where 
BUILD_BUG() used.

So far inline as always_inline for ARM64, if we do not continue same 
settings,
will there not be any performance differences?

Hi Will and Mark,

Please suggest the best solution to this problem. Currently __xchg_mb is 
only having issue
based on compiler -inline-threshold configuration. But there are many 
other instances
in arch/arm64/* where BUILD_BUG() used for inline functions and which 
may fail later.

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
