From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 May 2014 17:26:43 +0100
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140526162643.GB3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:35:01PM +0200, Thomas Petazzoni wrote:
> Currently, the default cache policy for ARMv6+ platform is writeback
> in UP mode and write allocate in SMP mode
> 
> Some platforms that provide hardware I/O coherency capabilities (such
> as Marvell Armada 370/XP/375/38x) require the cache policy to be write
> allocate even in UP mode. This is especially true on Armada 370, which
> is a single core processor, so even with CONFIG_SMP=y, is_smp()
> returns false and the cache policy remains defined to writeback.
> 
> As suggested by Catalin Marinas and Rob Herring, there is in fact no
> good reason to keep using writeback by default on ARMv6+, and we could
> switch to write allocate by default for all ARMv6+ platforms instead
> of special-casing the Marvell platforms.

Firstly, whether write allocate is beneficial or detrimental depends on
the workload being executed, and I'm not about to change this based on
such loose reasoning.

Secondly, we're losing information.  SMP uses write-allocate not due to
some kind of default, not because of some policy reason, but because SMP
is *required* architecturally to use write-allocate and this must never
allowed to be overridden.  You break this by allowing SMP to specify
writeback read-allocate.

Thirdly, you remove the possiblity of using writeback write-allocate on
ARMv5.  There are ARMv5 CPUs which have caches capable of that.

So, I think this is rather broken.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
