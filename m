From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Feb 2014 09:50:52 +0900
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140225165411.GA3883@red-moon>
References: <1393302345-18253-1-git-send-email-broonie@kernel.org>
 <1393302345-18253-2-git-send-email-broonie@kernel.org>
 <20140225165411.GA3883@red-moon>
Message-ID: <20140226005052.GA31120@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 04:54:11PM +0000, Lorenzo Pieralisi wrote:

> I have been clobbering the code with some random dts configs, running on
> top of the patch attached (to make code compliant with default if DT
> info is missing for some CPUs). Can you give it a go please and run your
> tests against it (I have just put it together) ? It should simplify things,
> thoughts ?

> AFAIK it should be correct, at least the info required by the scheduler
> is reset to default (include/linux/topology.h) if DT nodes are
> misconfigured. It applies on top of your series.

It seems to work fine for me, I'll resend with it squashed in though one
thing below which concerns me a bit.  

Can I suggest that given the sort of thing we're looking at here it
might be easier to apply the code as-is and then do any further work
incrementally?

> If the device tree does not contain topology information for a CPU,
> kernel code should set-up topology information for the CPU according
> to the default values defined in Documentation/cputopology.txt.

> +		pr_warn("CPU%u: No topology information configured\n", cpuid);
> +		cpuid_topo->core_id = 0;

I know this is what the document says and the scheduler copes but it
does make me a bit nervous if we end up with only some CPUs in this
undefined state.  I can't point to any practical problems and it's
going to be the scheduler's fault if it does but I wouldn't be surprised
if there were issues in cases where there is partial topology
information (as opposed to either full topology information or none).

Having said that like I keep saying it seems most sensible to fall back
to MPIDR if we don't have any better idea; it's guaranteed to be
available, may well be correct and helps systems that did a good job
with their hardware.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/3ac1e6bb/attachment-0001.sig>
