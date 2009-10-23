From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Oct 2009 11:06:39 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091023100639.GA19437@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 10:41:21AM +0100, Catalin Marinas wrote:
> ARMv6 onwards requires that there are no aliases to the same physical
> location using different memory types (i.e. Normal vs Strongly Ordered).
> Access to SO mappings when the unaligned accesses are handled in
> hardware is also Unpredictable (pgprot_noncached() mappings in user
> space).
> 
> The patch modifies the pgprot_noncached() for ARMv6+ architecture
> versions to generate Normal uncached memory attributes rather than
> Strongly Ordered. The patch also modifies the mandatory barriers to use
> dmb() rather than being simple compiler barriers.

It's not this simple - pgprot_noncached() is used for /dev/mem O_SYNC
mappings, which are used for device mappings.  This means you still
end up with the unpredictable issue.
