From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Nov 2013 17:30:47 +0000
Subject: [PATCH] ARM: move firmware_ops to drivers/firmware
In-Reply-To: <528A4869.2020701@wwwdotorg.org>
References: <1384678169-28228-1-git-send-email-acourbot@nvidia.com>
 <CAHkRjk5LBOFx3ir49RgEsaFwvp5UCpTjYFWto+URXebAsOP0RA@mail.gmail.com>
 <52898417.80601@nvidia.com> <20131118115842.GE4050@arm.com>
 <528A4869.2020701@wwwdotorg.org>
Message-ID: <20131118173047.GF9838@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 05:03:37PM +0000, Stephen Warren wrote:
> On 11/18/2013 04:58 AM, Catalin Marinas wrote:
> ...
> > Of course, trusted foundations interface could be plugged into cpu_ops
> > on arm64 but I will NAK it on the grounds of not using the PSCI API, nor
> > the SMC calling convention (and it's easy to fix when porting to ARMv8).
> > If a supported standard API is used, then there is no need for
> > additional code in the kernel.
> 
> What happens when someone takes an existing working secure-mode SW stack
> and simply re-uses it on some new ARMv8 SoC. Are you going to force
> people working on upstream to re-write the secure mode firmware in
> shipped hardware before allowing upstream kernel support?

Don't confuse the secure stack with the secure monitor running at EL3.
If you want AArch64 support for lower levels (EL2, EL1, EL0), your
monitor _must_ be AArch64. You can't run legacy AArch32 code at EL3 and
have lower levels in AArch64 mode (architectural constraint). You can
still keep the secure services at S-EL1 in AArch32, only that the SMCs
are handled by EL3 (and that's another aspect the SMC calling convention
spec is trying to address, mixed register-width secure/non-secure OSes).

-- 
Catalin
