From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Jan 2015 20:48:48 +0100
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <54AD7098.5010700@redhat.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <20150107172741.GY2634@sirena.org.uk> <54AD7098.5010700@redhat.com>
Message-ID: <1610983.9vqJdsL27R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 12:44:56 Jon Masters wrote:
> On 01/07/2015 12:27 PM, Mark Brown wrote:
> > On Wed, Jan 07, 2015 at 02:06:28PM +0100, Arnd Bergmann wrote:
> >> On Wednesday 07 January 2015 11:50:39 Catalin Marinas wrote:
> > 
> >>> From what I gathered so far, the main reason for _some_ vendors is not
> >>> support for "other" OS but actually features that ACPI has and DT
> >>> doesn't (like AML; I deliberately ignore statements like "industry
> >>> standard"). _If_ such reasons are sound, maybe they have a case for
> >>> ACPI-only machines targeted primarily at Linux.
> > 
> >> What I got from the replies from HP, Huawei and from earlier discussions
> >> with Jon is that they all hope to get to the point of relying on AML
> >> alone to bridge the differences between SoC families.
> 
> I'm expecting to need new drivers for SoC IP blocks that are net new,
> but generational differences between iterations of the same SoC should
> be abstracted behind the firmware (and we are already seeing this with
> at least one platform). Platform wise, it's nice to already see e.g.
> mmconfig working to handle the specific ways a platform wires PCI.

Yes, the parts that are mandated by SBSA, like the way that PCI needs
to be done are generally good. Unfortunately a lot of the hardware that
I've seen has a rather lax interpretation of the spec, so just because
something is mandated doesn't mean it's done that way ;-)

In other cases that's actually a good thing. One such example is the
"Principles of ARM Memory Maps" document that tells hardware implementers
to do a rather complex mapping "To support 36-bit x86 PAE compatible operating
systems, such as Linux." but makes life much harder in the process than
any of the random mappings we have seen in the wild.

> > I tend to agree with you that it's an overreach to think that this is
> > going to completely abstract away the differences between SoCs from
> > different vendors without substantial further standardization work.
> 
> (which we plan to do - I intend ultimately for us to have an answer to
> the Windows Hardware Qualification guides for ARM server systems)

Ok, good.

> >> The main problem here is that can AML only cover part of the problem:
> >> it can talk to a clock controller e.g. over I2C, SPI, GPIO, UART
> >> or IPMI, but you still need a device driver in the kernel to talk to
> >> those, and SBSA doesn't mandate a specific implementation so you can
> >> expect every other SoC that is coming out to have a different one.
> > 
> >> Similarly, SBSA is rather vague about some peripherals it mandates,
> >> and if a new SoC has a slightly different AHCI variation, there is
> >> nothing you can do about it in AML.
> > 
> >> x86 gets around this problem by having an extreme level of hardware
> >> backwards compatibility, so you don't even need AML for this and
> >> can generally boot a (almost) full-featured Linux kernel with
> >> acpi=off on the command line.
> > 
> > That level of hardware compatibility does partly come from the need to
> > run existing software.  I'd expect that similar effects will start to
> > come into play with ARMv8 ACPI systems if they become successful; people
> > will do things like ensure compatibility with common IPs that have
> > existing Linux drivers that distros tend to include as standard.
> 
> Agreed.

There are two problems I see in trying to do the same thing on ARM:

* we don't have a single vendor that makes de-facto standards that
  everyone else has to copy in the way that the few remaining x86
  vendors copy everything that Intel does. In fact, we prefer to
  have a large number of independent vendors.

* There is a general mindset about deprecating unwanted features
  early. ARMv8 aarch32 bit mode removes support for older instructions
  or makes them optional. Even the virtualization mode doesn't allow
  to trap on architecture version specific differences, so you can't
  completely emulate an older architecture level.
  This is nice for implementers but not so much for users that rely
  on old (mis-)features. It's also not just the CPU core, other
  components also get easily replaced, like a GICv3 that is not
  a strict superset of GICv2.

	Arnd
