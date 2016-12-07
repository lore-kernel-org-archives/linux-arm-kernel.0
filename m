From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 7 Dec 2016 18:09:44 +0530
Subject: [Question] New mmap64 syscall?
In-Reply-To: <0F280FED-870A-42B5-ABC4-1976ACA32462@theobroma-systems.com>
References: <20161206185440.GA4654@yury-N73SV> <3014428.VXGdOARdm1@wuerfel>
 <20161207103451.GA869@yury-N73SV>
 <0F280FED-870A-42B5-ABC4-1976ACA32462@theobroma-systems.com>
Message-ID: <20161207123944.GA11799@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Wed, Dec 07, 2016 at 12:07:24PM +0100, Dr.Philipp Tomsich wrote:
> [Resend, as my mail-client had insisted on using the wrong MIME type?]
> 
> > On 07 Dec 2016, at 11:34, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > 
> >> If there is a use case for larger than 16TB offsets, we should add
> >> the call on all architectures, probably using your approach 3. I don't
> >> think that we should treat it as anything special for arm64 though.
> > 
> > From this point of view, 16+TB offset is a matter of 16+TB storage,
> > and it's more than real. The other consideration to add it is that
> > we have 64-bit support for offsets in syscalls like sys_llseek().
> > So mmap64() will simply extend this support.
> 
> I believe the question is rather if the 16TB offset is a real use-case for ILP32.

This is not for ilp32, but for all 32-bit architectures - both native
and compat. And because the scope is so generic, I think it's the
strong reason for us to support true 64-bit offset in mmap().

> This seems to bring the discussion full-circle, as this would indicate that 64bit is the 
> preferred bit-width for all sizes, offsets, etc. throughout all filesystem-related calls 
> (i.e. stat, seek, etc.).

AARCH64/ILP32 (and all new arches) exposes ino_t, off_t, blkcnt_t,
fsblkcnt_t, fsfilcnt_t and rlim_t as 64-bit types. (Size_t should
be 32-bit of course, because it's the same lengths as pointer.)

It allows to make syscalls that pass it support 64-bit values, refer
Documentation/arm64/ilp32.txt for details. Stat and seek are both
supporting 64-bit types. From this point of view, mmap() is the (only?)
exception in current ILP32 ABI.

> But if that is the case, then we should have gone with 64bit arguments in a single
> register for our ILP32 definition on AArch64.
 
There are 2 unrelated matters - the size of types, and the size of
register. Most of 32-bit architectures has hardware limitation on
register size (consider aarch32). And it doesn't mean that they are
forced to stuck with 32-bit off_t etc. This is still opened question
how to pass 64-bit parameters in aarch64/ilp32 because there we have
the choice (the reason why it's RFC). If you have new ideas - welcome
to that discussion. This topic also covers architectures that has to
pass 64-bit parameters in a pair.

> In other words: Why not keep ILP32 simple an ask users that need a 16TB+ offset
> to use LP64? It seems much more consistent with the other choices takes so far.

If user can switch to lp64, he doesn't need ilp32 at all, right? :)
Also, I don't understand how true 64-bit offset in mmap64() would
complicate this port.

Yury
