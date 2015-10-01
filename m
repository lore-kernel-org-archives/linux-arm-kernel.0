From: drew.richardson@arm.com (Drew Richardson)
Date: Thu, 1 Oct 2015 12:47:06 -0700
Subject: [PATCH] arm: perf: Fix userspace call stack walking
In-Reply-To: <20151001191041.GY21513@n2100.arm.linux.org.uk>
References: <20151001172643.GA23147@dreric01-gentoo.localdomain>
 <20151001191041.GY21513@n2100.arm.linux.org.uk>
Message-ID: <20151001194705.GA24238@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 08:10:41PM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 01, 2015 at 10:26:47AM -0700, Drew Richardson wrote:
> > The layout of stack frames has changed over time. Testing using a
> > arm-linux-gnueabi gcc-4.2 from 2007 the original code didn't work but
> > this new code does. It also works with clang as well as newer versions
> > of gcc.
> 
> Can you point to a modern ARM distribution where perf actually works with
> calltraces into userspace?

I am not aware of an ARM distribution where it works, that's the
problem. I optimistically said 'The layout of stack frames has changed
over time,' but I couldn't find any case where it worked (including
digging up an ARM compiler from 2007)

This is from 4.3-rc3 on Gentoo using 'perf record -ga ./dhrystone'
then 'perf report -g'.


     1.36%        dhrystone  dhrystone          [.] Func_3                               
                  |
                  --- Func_3
                     |          
                     |--85.61%-- 0x59
                     |          
                      --14.39%-- 0x7ec5d5ac


And this is after the proposed changes


     1.99%        dhrystone  dhrystone           [.] Func_3                           
                  |
                  --- Func_3
                     |          
                     |--87.45%-- cmd_report
                     |          Proc_1
                     |          main
                     |          0x0
                     |          
                      --12.55%-- Proc_1
                                main
                                0x0

The call stack unwinding isn't perfect, for example leaf functions may
not write a stack frame at all, but it's hopefully better than it was.

Drew Richardson
