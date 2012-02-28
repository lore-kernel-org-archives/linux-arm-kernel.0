From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 28 Feb 2012 10:12:50 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <CAFEAcA8PzT9mfnEz60CYvwQWX1OEvejrZvkpuPL2LpTPosp8cA@mail.gmail.com>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1330360043.8557.302.camel@zakaz.uk.xensource.com>
 <CAFEAcA8PzT9mfnEz60CYvwQWX1OEvejrZvkpuPL2LpTPosp8cA@mail.gmail.com>
Message-ID: <1330423970.31269.45.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-27 at 21:05 +0000, Peter Maydell wrote:
> On 27 February 2012 16:27, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> > R12 is not accessible from the 16 bit "T1" Thumb encoding of mov
> > immediate (which can only target r0..r7).
> >
> > Since we support only ARMv7+ there are "T2" and "T3" encodings available
> > which do allow direct mov of an immediate into R12, but are 32 bit Thumb
> > instructions.
> >
> > Should we use r7 instead to maximise instruction density for Thumb code?
> 
> r7 is (used by gcc as) the Thumb frame pointer; I don't know if this
> makes it worth avoiding in this context.

I think it does.

It actually sounds as if using r12 is fine here, the impact on code
density should be pretty small -- there aren't really all that many call
sites which involve hypercalls.

By way of an example I measured an x86 kernel which should be using more
hypercalls due to pv paging etc and found that 0.014% of the lines in
"objdump -d" contained a call to the hypercall_page. (I know not all
lines of objdump -d output are instructions but it's a reasonable approx
IMHO).

So I think using 3 16 bit instructions slots instead of 2 won't make
much impact in practice.

Thanks,
Ian.
