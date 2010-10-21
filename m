From: simon@sequanux.org (Simon Guinot)
Date: Thu, 21 Oct 2010 09:49:14 +0000
Subject: [PATCH 1/2] [ARM] Kirkwood: enhance TLCK detection
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009FD18F0B3F89@IL-MB01.marvell.com>
References: <20101020085720.GA12979@mail.wantstofly.org>
	<1287647127-1434-1-git-send-email-simon@sequanux.org>
	<FCBE654890C0334289D0AD3AF4EF009FD18F0B3F89@IL-MB01.marvell.com>
Message-ID: <20101021094914.GN29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 09:56:08AM +0200, Saeed Bishara wrote:
>  
> 
> >-----Original Message-----
> >From: Simon Guinot [mailto:simon at sequanux.org] 
> >Sent: Thursday, October 21, 2010 9:45 AM
> >To: Lennert Buytenhek; Nicolas Pitre
> >Cc: linux-arm-kernel at lists.infradead.org; Benoit Canet; Saeed 
> >Bishara; Simon Guinot
> >Subject: [PATCH 1/2] [ARM] Kirkwood: enhance TLCK detection
> >
> >From: Simon Guinot <sguinot@lacie.com>
> >
> >According to the Marvell LSP, the Sample at Reset regiter bit 21 can be
> >used to detect TCLK on 6281 and 6282 devices.
> >
> >This patch has only been tested on LaCie boards.
> >
> >Signed-off-by: Simon Guinot <sguinot@lacie.com>
> >---
> > arch/arm/mach-kirkwood/common.c |    7 +++----
> > 1 files changed, 3 insertions(+), 4 deletions(-)
> >
> >diff --git a/arch/arm/mach-kirkwood/common.c 
> >b/arch/arm/mach-kirkwood/common.c
> >index 1c82d42..72bb76f 100644
> >--- a/arch/arm/mach-kirkwood/common.c
> >+++ b/arch/arm/mach-kirkwood/common.c
> >@@ -854,10 +854,9 @@ int __init kirkwood_find_tclk(void)
> > 
> > 	kirkwood_pcie_id(&dev, &rev);
> > 
> >-	if ((dev == MV88F6281_DEV_ID && (rev == MV88F6281_REV_A0 ||
> >-					rev == MV88F6281_REV_A1)) ||
> >-	    (dev == MV88F6282_DEV_ID))
> >-		return 200000000;
> >+	if (dev == MV88F6281_DEV_ID || dev == MV88F6282_DEV_ID)
> >+		if ((readl(SAMPLE_AT_RESET) >> 21 & 1) == 0)
> >+			return 200000000;
> The flow is ok, but the code doesn't look correct, the & precedence is higher thatn >>.

Sorry for missing that. The compiler optimize in the way with and
without parenthesis.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101021/d82303ea/attachment.sig>
