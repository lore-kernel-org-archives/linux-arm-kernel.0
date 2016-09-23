From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 23 Sep 2016 11:29:07 +0100
Subject: [PATCH 0/2] ARM: Do not mess with CCI if booted from HYP
In-Reply-To: <1474380833-30121-1-git-send-email-marc.zyngier@arm.com>
References: <1474380833-30121-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160923102907.GB31120@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, Sep 20, 2016 at 03:13:51PM +0100, Marc Zyngier wrote:
> Some systems (such as the VExpress TC2) are built around a CCI-400,
> which is only accessible from secure mode. This obviously breaks if
> the system is booted in non-secure mode. Detecting non-secure is
> pretty hard to do, unless the system is booted from HYP.
> 
> This small patch series makes sure that:
> - The CCI ports are not accessed when the kernel is booted from HYP
> - MCPM (which depends on CCI) is not enabled on VExpress if booted
> from HYP.
> 
> This allows a multi_v7_defconfig kernel to be booted on a TC2 booting
> from HYP, instead of miserably dying very early on.

As discussed I came up with a different set of patches that
detect CCI ports status as reported by DT and prevent enabling
MCPM if the CCI ports are not under kernel control (eg they are
reported as "disabled" by DT since we booted in HYP).

I will post patches for review and test shortly.

Thanks for fixing it anyway,
Lorenzo

> 
> Marc Zyngier (2):
>   ARM: vexpress: Do not enable MCPM if booted from HYP
>   arm-cci: Do not probe the CCI ports if booted from HYP
> 
>  arch/arm/mach-vexpress/platsmp.c |  8 ++++++--
>  drivers/bus/arm-cci.c            | 11 +++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> -- 
> 2.1.4
> 
