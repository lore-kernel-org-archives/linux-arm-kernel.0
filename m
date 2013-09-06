From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 6 Sep 2013 10:48:44 -0600
Subject: [PATCH v3 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20130905090841.GA9696@mudshark.cambridge.arm.com>
References: <20130823103802.GO4600@tarshish> <20130823110748.GD2389@localhost>
 <20130823113225.GF2389@localhost> <20130823114805.GF10971@arm.com>
 <20130830090807.GB25628@mudshark.cambridge.arm.com>
 <20130830091534.GA62188@MacBook-Pro.local>
 <20130830092032.GD25628@mudshark.cambridge.arm.com>
 <20130830100342.GD62188@MacBook-Pro.local>
 <522847FC.1080005@free-electrons.com>
 <20130905090841.GA9696@mudshark.cambridge.arm.com>
Message-ID: <20130906164844.GA2308@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 10:08:42AM +0100, Will Deacon wrote:

> > I would like to make the things move on about this subject. Should it
> > be possible to merge this version of the patch set? Currently the
> > only users of this new API are drivers for ARM SoCs.
> 
> In the short term then, I'd keep this restricted to ARM. Without relaxed
> accessors available across all architectures, I don't think we can make this
> usefully generic (a readX/writeX version would be horribly slow on ARM).

Realistically though, the current use cases for this function have it
called only a few times during startup, so it 'horribly slow' isn't
really important at all.

So why not start with this in generic headers:

extern void atomic_io_modify(void __iomem *reg, u32 mask, u32 set);
#define atomic_io_modify_relaxed atomic_io_modify

And the relaxed optimization can come along in due course?

Jason
