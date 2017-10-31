From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Oct 2017 13:56:16 +0000
Subject: [PATCH v4 13/21] arm64: cpufeature: Enable IESB on exception
 entry/return for firmware-first
In-Reply-To: <20171019145807.23251-14-james.morse@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-14-james.morse@arm.com>
Message-ID: <20171031135616.GM5584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 03:57:59PM +0100, James Morse wrote:
> ARM v8.2 has a feature to add implicit error synchronization barriers
> whenever the CPU enters or returns from an exception level. Add code to
> detect this feature and enable the SCTLR_ELx.IESB bit.
> 
> This feature causes RAS errors that are not yet visible to software to
> become pending SErrors. We expect to have firmware-first RAS support
> so synchronised RAS errors will be take immediately to EL3.
> Any system without firmware-first handling of errors will take the SError
> either immediatly after exception return, or when we unmask SError after
> entry.S's work.
> 
> Platform level RAS support may require additional firmware support.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

To be honest, I'd just set this bit unconditionally. I realise the
architecture would rather we didn't do that for v8 parts where it's RES0,
but we do this elsewhere (e.g. HD and HA in the TCR) and practically it's
fine.

Will
