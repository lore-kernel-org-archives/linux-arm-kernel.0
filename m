From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Feb 2012 21:54:48 +0000
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F480120.6080409@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
 <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
 <20120223165242.GB22562@n2100.arm.linux.org.uk>
 <4F4671BB.7060409@freescale.com>
 <20120223171407.GC22562@n2100.arm.linux.org.uk>
 <4F480120.6080409@freescale.com>
Message-ID: <20120224215448.GA15120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 03:29:04PM -0600, Timur Tabi wrote:
> Russell King - ARM Linux wrote:
> >> > I'll have to ask around, because I'm sure I'm missing something.
> > If what you say is true, it means we have different semantics for the
> > same accessors on different architectures.  No wonder it's needing
> > drivers to gain ifdefs to select appropriate accessors.
> > 
> > This needs sorting out properly.  It needs the semantics of readl() etc
> > to be fully defined, and all architectures to implement those semantics
> > rather than what they think would be appropriate for them.
> 
> So I asked around, and sure enough, my macro-fu was weak.  On PowerPC,
> readl() maps to in_le32().  Even though PowerPC is big-endian, some
> devices are little endian (e.g. PCI and some PICs).
> 
> in_le32() is the byte-swapping version of in_be32().  Both functions have
> instruction order synchronization instructions in them.
> 
> So replacing in_be32() with readl() will break on PowerPC.

But not a BE variant.  Like ioread32be().

BenH tells me that he'll accept patches which converts in_32be() to
ioread32be(), as in_32be() is ancient PPC cruft that needs to die.
