From: behanw@converseincode.com (Behan Webster)
Date: Thu, 05 Sep 2013 21:10:13 -0400
Subject: [PATCH] ARM: LLVMLinux: Change "extern inline" to "gnu_inline"
 in ARM ftrace.h
In-Reply-To: <20130814224552.GA23006@n2100.arm.linux.org.uk>
References: <1376516261-2071-1-git-send-email-behanw@converseincode.com>
 <1376516261-2071-2-git-send-email-behanw@converseincode.com>
 <20130814224552.GA23006@n2100.arm.linux.org.uk>
Message-ID: <52292B75.8080705@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the delay. A mistake in my email filters ate all your replies. 
Doh!

On 08/14/13 18:45, Russell King - ARM Linux wrote:
> On Wed, Aug 14, 2013 at 05:37:41PM -0400, behanw at converseincode.com wrote:
>> -extern inline void *return_address(unsigned int level)
>> +extern inline __attribute__((gnu_inline))
>> +void *return_address(unsigned int level)
> Well, that should be static inline, not extern inline in any case.  Does
> clang work if that's static inline?

Actually, neither gcc nor clang work with it merely changed to "static 
inline".

Which is why we left it with the explicit GNU89 meaning of "extern 
inline" which is gnu_inline. C99 changed the meaning of what "extern 
inline" means. One of the major issues we've had with the clang kernel 
port is that clang defaults to gnu99 (which is mostly just C99) while 
until recently gcc defaulted to gnu89.

For recent versions of gcc:

     http://gcc.gnu.org/onlinedocs/gcc/Standards.html

"The default, if no C language dialect options are given, is -std=gnu90; 
this will change to -std=gnu99 or -std=gnu11 in some future release when 
the C99 or C11 support is complete. Some features that are part of the 
C99 standard are accepted as extensions in C90 mode, and some features 
that are part of the C11 standard are accepted as extensions in C90 and 
C99 modes."

However, having said all that, it seems if I remove the corresponding 
NULL definition for return_address in arch/arm/kernel/return_address.c, 
I can make it "static inline" and it seems to work for both gcc and clang.

I'll send a new patch. :)

Incidentally the LLVMLinux project tests all the project's patches with 
both gcc and clang. The idea is to make it work with both compilers 
after all.

Behan

-- 
Behan Webster
behanw at converseincode.com
