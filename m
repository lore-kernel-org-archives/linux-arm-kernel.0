From: duwe@lst.de (Torsten Duwe)
Date: Mon, 22 Oct 2018 16:54:48 +0200
Subject: [PATCH v3 3/4] arm64: implement live patching
In-Reply-To: <alpine.LSU.2.21.1810221452070.13146@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz>
 <20181018125820.iw54zbirq74ulknj@linux-8ccs>
 <CAKv+Gu_yNBN+Rpw98MAZaxzSjm20qMYD7+fiJ1fBHoUeDr9fBA@mail.gmail.com>
 <alpine.LSU.2.21.1810191714540.4692@pobox.suse.cz>
 <CAKv+Gu8Vg9-CwvU-u9gNGmtB7gTapuCPHjU5v7FWnPsVy6vptA@mail.gmail.com>
 <alpine.LSU.2.21.1810221452070.13146@pobox.suse.cz>
Message-ID: <20181022145448.GA22918@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2018 at 02:53:10PM +0200, Miroslav Benes wrote:
> On Sat, 20 Oct 2018, Ard Biesheuvel wrote:
> > So I suppose this could get interesting in cases where modules are far
> > away from the kernel (i.e., more than -/+ 128 MB). Fortunately, the
> > modules themselves are always placed in a 128 MB window, but this
> > window could be out of reach for branches into the kernel proper. If
> > we find ourselves in the situation where we need to patch calls into
> > the kernel proper to point into this module, this may get interesting,
> > since the PLT entries *must* be allocated along with the module that
> > contains the branch instruction, or the PLT entry itself may be out of
> > range, defeating the purpose.
> 
> Hm... Torsten, didn't you have to solve something similar in powerpc case? 

At address ranges: that was the TOC pointer issue, that is an array of
addresses and other 64-bit constants with a reference to it kept in a register,
whose value is local to any module. PPC64 needs 5 instructions to load a 64-bit
value immediate, arm has the ldr_l macro. So in short: no. We were discussing a
few nasty tricks to reconstruct the TOC value from the code addresses, but
ended up with a solution that is clean in that respect.

At PLTs: ppc64 uses, IIRC, a regular trampoline slot to get to all called
functions, including ftrace and friends. So for e.g. live patch kernels
the total number, as predetermined, is only incremented by 2. Only the
trampoline _code_ for ftrace was modified.
I assume with "branches" you mean "branch with link" a.k.a a subroutine call?
All references to external symbols are allocated a PLT entry, right?

ftrace / live patching calls are alway intercepted at the called function.
                                       ===========--------======---------
The interceptor then uses a special trampoline to go to ftrace_caller, which
does the rest.

Am I missing something?

	Torsten
