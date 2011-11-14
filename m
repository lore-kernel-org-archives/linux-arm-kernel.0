From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Nov 2011 20:27:59 +0000
Subject: [PATCH 1/2] ARM: use cache type functions for
 arch_get_unmapped_area
In-Reply-To: <alpine.LFD.2.02.1111141236200.3307@xanadu.home>
References: <1320709421-14469-1-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1111141236200.3307@xanadu.home>
Message-ID: <20111114202759.GA20123@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Nico,

On Mon, Nov 14, 2011 at 05:36:57PM +0000, Nicolas Pitre wrote:
> On Mon, 7 Nov 2011, Rob Herring wrote:
> 
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > There are already cache type decoding functions, so use those instead
> > of custom decode code which only works for ARMv6.
> > 
> > This change also correctly enables cache colour alignment on Cortex-A9
> > whose I-cache is aliasing VIPT.

I appreciate that this is preserving the current behaviour, but why do we need
to ensure colour alignment when only the I-side is aliasing?

In the case that there is a MAP_SHARED, PROT_WRITE|PROT_EXEC mapping then
explicit cache maintenance will still be required by the task writing to the
page and also the task executing the written data (not to mention the
synchronisation requirements). Russell confirmed this recently:

http://lists.arm.linux.org.uk/lurker/message/20110923.193941.47decb13.en.html

no amount of colouring can avoid that, so why not only bother with it when
we alias on the D-side? On a coherent system it's reasonable to expect that
to work across tasks, so we definitely need the colouring correction there.

Will
