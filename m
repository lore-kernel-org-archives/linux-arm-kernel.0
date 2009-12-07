From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2009 15:40:19 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091207145235.GD19348@n2100.arm.linux.org.uk>
References: <4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
	<c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
	<20091207114218.GA19348@n2100.arm.linux.org.uk>
	<4B1CF3ED.9080307@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
Message-ID: <20091207154019.GA26821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 02:52:35PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 07, 2009 at 02:55:52PM +0200, Ronen Shitrit wrote:
> > That also match the theory:
> > When using different processes, the shared area will stay C=1 B=1, 
> > On each context switch L1 will be flushed,
> > Since L2 is PIPT next process will get the correct data...
> 
> Hang on - if L2 is PIPT, then there shouldn't be a problem provided it's
> searched with C=0 B=1 mappings.  Is that the case?

Officially, ARMv5 does not support the 'extended small page' format for
the 2nd level descriptors (ARMv6 and Xscale CPUs added this support.)

That means ARMv5 officially only has support for two bits to control
the caching attributes - the C and B bits.  This means we can't specify
the policy for the L2 cache... unless Feroceon also supports the
'extended small page' format.  This might be a third solution to the
problem, and probably the best - provided Feroceon will allow us to
specify 'inner non-cacheable outer write-back' (TEX=111 CB=00).

If Feroceon did support the 'extended small page' format, why isn't it
already using this?  (It's setup to use the architecturally defined
'small page' format for ARMv3 to ARMv5.)
