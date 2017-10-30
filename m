From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 30 Oct 2017 13:27:22 -0700
Subject: [PATCH v3 05/12] arm: vdso: do calculations outside reader loops
In-Reply-To: <20171030141517.25ex2os47cyvah2z@lakrids.cambridge.arm.com>
References: <20171027222543.57279-1-salyzyn@android.com>
 <20171030141517.25ex2os47cyvah2z@lakrids.cambridge.arm.com>
Message-ID: <040cf1cc-28a0-0f4c-1c08-7bc8a9dc75a2@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review, am taking all the points into consideration.

On 10/30/2017 07:15 AM, Mark Rutland wrote:
>> +
>> +	typeof(((struct vdso_data *)vd)->xtime_clock_sec) sec;
> Why do we need to do this typeof() magic?
>
> Can't we settle on a consistent type across arches, or have a typedef in
> a header?

Would you accept 'because I do not want to standardize the sizes yet'?

[TL;DR]

We could, if there was one, but there isn't currently, and I do not want 
to invent one within the context of this series. It is also an 
architectural decision to decide on the individual size of 
xtime_clock_sec, rate_time_sec and wtm_clock_nsec (or equivalents, not 
yet common names throughout), because pedantically they must _all_ be 
u64, but realistically they only need to be u32 on the smaller 
platforms. This gets even more complicated for compat (vdso32 etc) 
implementations as to what is optimal, realistic, desired or pedantic; 
and we have not even dealt with that. I'd prefer to be agnostic in that 
debate for now and typeof() (which there is precedence to use in the 
linux code tree outside of a macro) handily deals with that controversy.

As for tv_sec and tv_nsec, there is precedence to override them in 
private product builds or architectures (#define _STRUCT_TIMESPEC) so I? 
could not count on them being __kernel_time_t or long respectively. 
typeof() was used to also allow that flexibility. I am not sure this 
happens, only that the levers are there to allow it. typeof() allows me 
to respect that facility.

Yes, the code gets much more optimal with the help of typeof() for the 
arm architecture if these are all u32 in size. I am wondering out loud 
that we may wish to only use u32 in vdso32, despite the size(s) of all 
of these structure members. But that is another patch series (on hold 
until these are settled).

I am thinking of a nebulous future. The decision for these are being 
deferred because my focus is on arm and arm64 because they are testable 
with my current resources. On purpose am not unifying all the vdso_data 
and vdso.c implementation details as that phase may follow (by me or 
others). In that phase xtime_clock_sec, rate_time_sec and wtm_clock_nsec 
could very well be standardized and these typeof()'s may melt away. mips 
and tile (because they are written in C) could be the next existing 
arches that could serve merged into this, but I do not have the 
platforms to test the changes on.

-- Mark
