From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 12 Sep 2014 01:50:58 -0500
Subject: [PATCH v9 4/6] ARM: add vdso user-space code
In-Reply-To: <20140910164755.GC1710@arm.com>
References: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
 <1408744351-7814-5-git-send-email-nathan_lynch@mentor.com>
 <20140910164755.GC1710@arm.com>
Message-ID: <541297D2.5000705@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2014 11:47 AM, Will Deacon wrote:
> Hi Nathan,
> 
> On Fri, Aug 22, 2014 at 10:52:29PM +0100, Nathan Lynch wrote:
>> Place vdso-related user-space code in arch/arm/kernel/vdso/.
>>
>> It is almost completely written in C with some assembly helpers to
>> load the data page address, sample the counter, and fall back to
>> system calls when necessary.
> 
> I'm still a bit puzzled as to how we can implement a compat version of this
> for a 32-bit userspace running under a 64-bit kernel. Maybe the answer is
> that we don't care enough (programs will still work fine without it), but if
> we did want to then we're going to need to build the kernel with two
> toolchains and it gets really horrible.
> 
> Do you have any ideas?

Assuming a GCC+binutils toolchain, I don't have any workable ideas for
generating ARMv7 shared object during an arm64 kernel build without
relying on a second compiler.  I think theoretically you could do
something like what kuser32.S does, but that would be untenable for
something as complex as a vdso.

I recognize that this might present an awkward situation where an ARMv7
program could incur more system call overhead on arm64 than it does on
arm, but I don't see any way around it.
