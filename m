From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 16:59:15 +0100
Subject: [PATCH 45/74] SPEAr : SEV Send event to secondary CPUs
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCED14CF@dbde02.ent.ti.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<861ddbfab51ade4893ef92df4bcfa9b203844a9c.1283161023.git.viresh.kumar@st.com>
	<20100902102256.GO26319@n2100.arm.linux.org.uk>
	<003f01cb4a8b$372d0d00$a5872700$@deacon@arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCED14CF@dbde02.ent.ti.com>
Message-ID: <20100902155915.GQ26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 04:37:37PM +0530, Shilimkar, Santosh wrote:
> May be we should have barrier version of these
> There is one already exist in mainline already in spin lock code
> "dsb_sev(void)"

I don't think so - they're not a general purpose event passing mechanism.
Their use is fairly well limited to two situations:

1. spin locks, where we already have dsb_sev as we care about ordering.
2. smp secondary cpu bring-up code, where we care a little less about the
   ordering.

I think coupling a barrier with these will just make people want to have
a version without the barrier.  At least if we don't provide the barrier,
people have the option of using mb() before sev() if they desire ordering.
