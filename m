From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Apr 2017 11:22:59 +0100
Subject: [kernel-hardening] Re: [RFC v2][PATCH 04/11] x86: Implement
 __arch_rare_write_begin/unmap()
In-Reply-To: <CALCETrXQaRcNz7EQW9DHF-LMr5SkooLq=1HKsdOfXH-kY4fcBw@mail.gmail.com>
References: <CA+rthh95rW95woiWvyeCcoJT-qRM18KCDGHGtH=bDHZdExmVmg@mail.gmail.com>
 <alpine.DEB.2.20.1704071048360.1716@nanos>
 <CA+rthh9-EJBBO6nYYY6noP0ybcvk+xJ+S5h6BCNPtidjMCv8VQ@mail.gmail.com>
 <alpine.DEB.2.20.1704071426300.1716@nanos>
 <CA+rthh8TbqU-4tY4Y8trnyMDBe6dRLhVrAnk-COJCZCOyHqSog@mail.gmail.com>
 <CALCETrWuZPDjAuE1jnhJNKiZOOEdbus-O6GY8++0UO56Q84PZw@mail.gmail.com>
 <CA+DvKQKc8uq=1O5d41GRU6u=GkOvuCJzkbPPBcp2ohHLU7A25g@mail.gmail.com>
 <CALCETrUk7k3SFKiu2kykwPM=AQ9q2rczetL4j5XyoOxX_gjCGw@mail.gmail.com>
 <CA+DvKQKQzMk==8Z4sF1pCeDDwE4+m_2Kgtztamaf2BWYm5ENUA@mail.gmail.com>
 <CALCETrXQaRcNz7EQW9DHF-LMr5SkooLq=1HKsdOfXH-kY4fcBw@mail.gmail.com>
Message-ID: <20170410102244.GA13899@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 08:20:03AM -0700, Andy Lutomirski wrote:
> On Sat, Apr 8, 2017 at 12:33 AM, Daniel Micay <danielmicay@gmail.com> wrote:
> > The
> > submitted code is aimed at rare writes to globals, but this feature is
> > more than that and design decisions shouldn't be based on just the
> > short term.
> 
> Then, if you disagree with a proposed design, *explain why* in a
> standalone manner.  Say what future uses a different design would
> have.
> 
> > I actually care a lot more about 64-bit ARM support than I do x86, but
> > using a portable API for pax_open_kernel (for the simple uses at
> > least) is separate from choosing the underlying implementation. There
> > might not be a great way to do it on the architectures I care about
> > but that doesn't need to hinder x86. It's really not that much code...
> > A weaker/slower implementation for x86 also encourages the same
> > elsewhere.
> 
> No one has explained how CR0.WP is weaker or slower than my proposal.
> Here's what I'm proposing:
> 
> At boot, choose a random address A.  Create an mm_struct that has a
> single VMA starting at A that represents the kernel's rarely-written
> section.  Compute O = (A - VA of rarely-written section).  To do a
> rare write, use_mm() the mm, write to (VA + O), then unuse_mm().
> 
> This should work on any arch that has an MMU that allows this type of
> aliasing and that doesn't have PA-based protections on the
> rarely-written section.

Modulo randomization, that sounds exactly like what I had envisaged [1],
so that makes sense to me.

Thanks,
Mark.

[1] http://www.openwall.com/lists/kernel-hardening/2016/11/18/3
