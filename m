From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 May 2014 17:35:56 +0100
Subject: [PATCH RFCv2 3/5] ARM: allow CONFIG_SMP_ON_UP on non-SMP
 configurations
In-Reply-To: <1400600105-3013-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140526163556.GC3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:35:03PM +0200, Thomas Petazzoni wrote:
> Currently CONFIG_SMP_ON_UP is used when CONFIG_SMP is enabled to allow
> a SMP kernel to boot on UP platforms that do not support certain
> aspects of SMP platforms.
> 
> However, some of the SMP characteristics are needed on platforms that
> have SMP capabilities but are single core, and use their SMP
> capabilities to provide hardware I/O coherency. This is for example
> the case on Marvell Armada platforms.
> 
> Instead of special casing these platforms to enable the SMP and TLB
> broadcast bit and use shareable pages, this patch proposes to simply
> allow CONFIG_SMP_ON_UP to be enabled even on non-SMP
> configurations. When CONFIG_SMP_ON_UP is enabled in a !CONFIG_SMP
> configuration, it will check that the processor is SMP capable, and if
> yes use all the SMP characteristics (SMP and TLB broadcast bit,
> shareable pages, etc.). It will not support multiprocessing of course,
> but it will have sufficient capabilities to allow hardware I/O
> coherency to work.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Of course, the name of CONFIG_SMP_ON_UP is maybe no longer
> appropriate. Suggestions are welcome to change this: this patch is
> really the minimal set of changes to get things to work.
> 
> We could also decide to completely get rid of CONFIG_SMP_ON_UP and
> make it always on. Suggestions welcome.

This feels very wrong - while you may need a SCU for coherency, which
implies that you have a SMP capable CPU, this feels very much like
overloading a currently well-defined facility with a well-defined
purpose (which gets used for a lot of things) with a new purpose, which
is going to be painful in the future if we ever need to separate the
two things.  So no, I really don't like this.

If we need to change things here, make the change properly even if it
means that it takes more time, and don't do quick sticky-plasters like
this - the quick sticky-plaster method ultimately makes stuff less
maintainable.

Secondly, doesn't this make your first patch redundant - if you need the
SMP instructions, then is_smp() returns true, which then forces WBWA
cache mode.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
