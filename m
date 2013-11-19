From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Nov 2013 11:02:16 +0000
Subject: [PATCH] ARM: move firmware_ops to drivers/firmware
In-Reply-To: <528A64D2.4020107@codeaurora.org>
References: <1384678169-28228-1-git-send-email-acourbot@nvidia.com>
 <CAHkRjk5LBOFx3ir49RgEsaFwvp5UCpTjYFWto+URXebAsOP0RA@mail.gmail.com>
 <52898417.80601@nvidia.com> <20131118115842.GE4050@arm.com>
 <528A4869.2020701@wwwdotorg.org> <20131118173047.GF9838@arm.com>
 <528A64D2.4020107@codeaurora.org>
Message-ID: <20131119110216.GD26487@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 07:04:50PM +0000, Christopher Covington wrote:
> On 11/18/2013 12:30 PM, Catalin Marinas wrote:
> [...]
> > You can't run legacy AArch32 code at EL3 and have lower levels in AArch64
> > mode (architectural constraint).
> 
> What prevents AArch32 code from running at EL3 and then requesting a reset to
> AArch64 by writing to the Reset Management Register before sliding down to
> lower exception levels?

You can do this for some initial code but the firmware still needs to
switch to AArch64 before dropping to lower exception levels. What this
thread is about is run-time calls to firmware for booting secondary
CPUs, idle, l2x0. At this point, the code at EL3 must run in AArch64
mode. There is no way you can bounce between AArch32 and AArch64 modes
using reset just to handle some SMCs.

-- 
Catalin
