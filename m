From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 30 Jun 2014 14:56:49 -0700
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <53B18555.2000109@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <20140630144045.GM25779@arm.com> <53B18555.2000109@mentor.com>
Message-ID: <53B1DD21.6020709@mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2014 08:42 AM, Nathan Lynch wrote:
> On 06/30/2014 09:40 AM, Will Deacon wrote:
>> Hi Nathan,
>>
>> On Mon, Jun 23, 2014 at 04:11:49AM +0100, Nathan Lynch wrote:
>>> Provide fast userspace implementations of gettimeofday and
>>> clock_gettime on systems that implement the generic timers extension
>>> defined in ARMv7.  This follows the example of arm64 in conception but
>>> significantly differs in some aspects of the implementation (C vs
>>> assembly, mainly).
>>
>> [...]
>>
>> This series is starting to gain traction now, so it's probably time to start
>> thinking about implementing this for CONFIG_COMPAT on arm64. We currently
>> map a fake vectors page there, but this would be much more flexible,
>> particularly as its written in C (and so we would magically get any new
>> functions added to the 32-bit version).
>>
>> So, there are a couple of questions that spring to mind:
>>
>>   - How difficult is it to share the vdso code with arm64 to build a compat
>>     vdso? (getting the Makefile to work will be hard, as we'll need an arm
>>     toolchain...).
> 
> Not sure.  x86 might be the best example to work from here, although it
> has the advantage of everything living under arch/x86.  64-bit powerpc
> kernels provide a 32-bit VDSO for compat tasks but I think it doesn't
> really share code with the 64-bit VDSO.

Heh.  x86 was not a shining example of how to share code.  It's a little
bit better now (3.16-rc3 and up).

> 
>>
>>   - If we use your code to build an arm64 vdso, how much slower is it than
>>     the handcrafted asm we currently have?
> 
> Someone with access to 64-bit hardware (i.e. not me) would have to find
> this out, but I would not be surprised if the C code could be tightened
> up -- I have not spent much time on optimizing it.
> 

I can't comment on ARM specifically, but the only assembly in the x86
vclock_gettime is an asm volatile (""), which causes gcc to emit more
optimal code.  I doubt I could shave off more than a cycle or two by
rewriting it in assembly.

--Andy
