From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Sep 2012 14:53:43 +0100
Subject: [PATCH v3 RESEND 05/17] ARM: LPAE: support 64-bit virt_to_phys
 patching
In-Reply-To: <alpine.LFD.2.02.1209241826260.6667@xanadu.home>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-6-git-send-email-cyril@ti.com>
 <20120924151305.GA14198@arm.com>
 <alpine.LFD.2.02.1209241152540.6667@xanadu.home>
 <5060C9C6.8080900@ti.com>
 <alpine.LFD.2.02.1209241709200.6667@xanadu.home>
 <CAHkRjk74aHMNZxOVgsQo-NTm33ALZPVeiPAP5amCdBdF4-yjWw@mail.gmail.com>
 <alpine.LFD.2.02.1209241826260.6667@xanadu.home>
Message-ID: <20120925135343.GD14924@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 11:32:22PM +0100, Nicolas Pitre wrote:
> On Mon, 24 Sep 2012, Catalin Marinas wrote:
> 
> > On 24 September 2012 22:20, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > On Mon, 24 Sep 2012, Cyril Chemparathy wrote:
> > >
> > >> On 9/24/2012 11:56 AM, Nicolas Pitre wrote:
> > >> > On Mon, 24 Sep 2012, Catalin Marinas wrote:
> > >> >
> > >> > > On Fri, Sep 21, 2012 at 04:56:03PM +0100, Cyril Chemparathy wrote:
> > >> > > > This patch adds support for 64-bit physical addresses in virt_to_phys()
> > >> > > > patching.  This does not do real 64-bit add/sub, but instead patches in
> > >> > > > the
> > >> > > > upper 32-bits of the phys_offset directly into the output of
> > >> > > > virt_to_phys.
> > >> > >
> > >> > > So this assumes that for the kernel linear mapping, all the physical
> > >> > > addresses have the same upper 32-bit. That's a good optimisation but I
> > >> > > haven't seen this check when calculating lowmem in sanity_check_meminfo.
> > >> > > Someone may build platform with memory starting at 3GB and going across
> > >> > > the 4GB limit.
> > >> >
> > >> > Good point.  We better get an early warning if that happens.
> > >> >
> > >>
> > >> Thanks.
> > >>
> > >> I'm thinking of splitting the bank at the 32-bit boundary in such an event,
> > >> assuming that the remaining memory should be usable as highmem.
> > >
> > > No.  That's not the point here.
> > >
> > > Let's suppose a system with 1GB of physical RAM starting at 0xe0000000.
> > >
> > > In this case there is no need for highmem.  However the v2p patching
> > > code in the LPAE case assumes the high bits of a physical address are
> > > always the same which wouldn't be the case in this hypothetical example.
> > >
> > > We want to make sure the kernel won't boot if a system with physical RAM
> > > crossing the 4GB address mark is encountered.
> > 
> > I think that's too restrictive. The case with 1 or 2GB below 4GB limit
> > and the rest of the RAM above is a valid one.
> 
> Valid: sure.  Likely: probably not.  That would complicate address 
> decoding in hardware for little gain.

You could have a block of 4GB RAM at 0x100000000 but the top 2GB aliased
at 0x80000000. It is also possible that the top 2GB are not visible to
software directly but only via the 0x80000000 alias.

But with Russell's proposal for full 64-bit address patching, no
limitations are needed.

-- 
Catalin
