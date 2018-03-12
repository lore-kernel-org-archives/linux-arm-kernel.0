From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Mar 2018 11:36:05 +0000
Subject: PSCI version misdetection
In-Reply-To: <CAOMZO5BJ2GuqZS=9C6sA=JXif64OcL1gAbaxbpfdCYEGVM7ZTQ@mail.gmail.com>
References: <CAOMZO5BbxFTfD_ZsL5zVhHU5Ue_J_YGBW35AwNx=PVpu6WsqwQ@mail.gmail.com>
 <20180312100247.qd2cph56bhypzwp7@salmiak>
 <CAOMZO5BJ2GuqZS=9C6sA=JXif64OcL1gAbaxbpfdCYEGVM7ZTQ@mail.gmail.com>
Message-ID: <20180312113604.p36tgtsszfunk2qp@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 08:12:02AM -0300, Fabio Estevam wrote:
> Hi Mark,
> 
> On Mon, Mar 12, 2018 at 7:02 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > It sounds like U-Boot hasn't implemented the PSCI_VERSION call, and is
> > returning NOT_IMPLEMENTED (-1). If so, this is not a conforming PSCI 1.0
> > implementation, as PSCI_VERSION is mandatory.
> >
> > AFAICT, The default implementation in arch/arm/cpu/armv7/psci.S returns
> > NOT_SUPPORTED.
> >
> > Where does the implementation for imx7d-sdb live? Is this upstream?
> 
> Yes, it is in mainline U-Boot.
> 
> As per this commit it would use PSCIv1.0:
> 
> http://git.denx.de/?p=u-boot.git;a=commitdiff;h=0ec3d98f76923619acfd91f93f8221e609e1e5bc;hp=04c28a7810970e404550f3510f8d9dfd90d6dc81

Ok. AFAICT, you need to implement psci_version, and any other mandatory
PSCI features such as affinity info in your board code, as otherwise the
default weak implementation is used.

Defining CONFIG_ARMV7_PSCI_1_0 alone is not sufficient, and I would
strongly recommend reverting the above commit until those functions are
implemented. There is no benefit to an incomplete and non-conforming
PSCI 1.0, and this will cause problems.

I believe that also applies to the uniphier platform code, judging by
include/configs/uniphier.h.

Thanks,
Mark.
