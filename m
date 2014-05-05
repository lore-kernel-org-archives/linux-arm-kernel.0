From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 May 2014 19:29:44 +0200
Subject: ACPI vs DT at runtime
In-Reply-To: <5367AE6B.3010105@ahsoftware.de>
References: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <69387177.zGLDjZS0ln@wuerfel> <5367AE6B.3010105@ahsoftware.de>
Message-ID: <7113027.fTBIcKEU63@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 May 2014 17:29:47 Alexander Holler wrote:
> Am 05.05.2014 16:41, schrieb Arnd Bergmann:
> > On Monday 05 May 2014 09:06:14 Alexander Holler wrote:
> >>
> >> A bit late (I don't follow the ML (or what happens in the ARM world)
> >> closely, but as I've recently read that ARM64 will go UEFI and ACPI, I
> >> wonder what was the reasoning behind that decision.
> >>
> >> Does anyone really assume we will become high quality UEFI and ACPI
> >> blobs from vendors? And such with reasonable support/update periods?
> >>
> >> For me that sounds like someone asked dreamers and was unable to adjust
> >> those answers in regard to reality.
> >
> > Where did you read that? It's simply not true and we should make sure
> > people stop spreading dangerous misinformation.
> 
> I've recently read Grant Likely's blog entry about armv8 servers: 
> http://www.secretlab.ca/archives/27 (I've read the disclaimer too  )

Ok, that is fine. Everything he says there is ok, but it's easy to
miss the point that he is only talking about general-purpose servers
there.

> > For all embedded systems, DT remains the way to pass data about
> > nondiscoverable devices on arm64, and I expect that to include
> > "server" machines based on embedded SoCs.
> 
> I usually avoid to talk about embedded systems as something different 
> (e.g. than servers). I think such differentations don't make much sense 
> anymore in times where people are getting in need of an administrator 
> for their phones. 

It's the server people that see themselves as something different
though. Which is funny because they came up with the idea to use
ACPI in order to improve interoperability between hardware vendors,
and now that they actually want to come out with systems, everything
can already be interoperable, except that ACPI support is getting
in the way.

> The problem I see is that if ARM requires UEFI and ACPI for general 
> purpose ARMv8 servers, SOC vendors and the kernel will have to support 
> that (I make the maybe silly assumption every ARMv8 SOC vendor wants to 
> play in the server market). That means the kernel has to support it too.

I don't think they are in a position to make that a requirement
for servers in general. There is a boot architecture document that
requires the use of ACPI for compliant systems. That doesn't prevent
anyone from shipping a noncompliant system. I think it's similar to
the SBSA specification: It's nice for companies to build a system
compliant with that in theory, because then they get support for
any OS that supports compliant systems, but in practice, I expect
most of them to treat the spec as more of a suggestion and take
shortcuts wherever it suits them.

> And nobody likes to support two types of something. So there is a 
> requirement (on paper) for UEFI and ACPI (both likely closed blobs), but 
> none for the open stuff. And when I now start to think about paper 
> loving vogons, I don't need much imagination which type will be 
> streamlined away.

I'm very strongly supporting the idea that we should not have two
different kinds of device abstractions for a given SoC family. I also
think we have two very distinct groups of SoC vendors here:

* One side actively wants to use APCI, as they want to support MS Windows,
  and they have fast and simple general-purpose SoCs designed around
  the ACPI concepts and SBSA compliance. They wouldn't ship an open
  system anyway, and when they can show a reasonable implementation
  of ACPI that works on their systems, we will very likely merge that.

* The other side has existing special-purpose SoC designs with ARM32,
  PowerPC, MIPS or other CPU cores and they want to migrate to ARM64
  because everyone else is doing that too. They ship whatever their
  customers want, but they care little about Windows support, or strict
  standards compliance as long as their customers are happy. There is
  a lot of opposition to ACPI both in the customer base and the upstream
  Linux community for these machines, so these are likely to stay with
  DT for the foreseeable future. In fact, fear over fragmentation with
  ACPI on these systems one of the issues currently holding up merging
  ACPI for the first category.

	Arnd
