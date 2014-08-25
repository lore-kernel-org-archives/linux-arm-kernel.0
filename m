From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Aug 2014 12:34:25 +0200
Subject: [PATCH] ARM: cns3xxx: Don't allocate PCI addresses on stack
In-Reply-To: <1408927894-30858-1-git-send-email-broonie@kernel.org>
References: <1408927894-30858-1-git-send-email-broonie@kernel.org>
Message-ID: <2492333.HstnrugmgL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 August 2014 19:51:34 Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The cns3xxx PCIe code allocates a PCI bus structure on the stack, causing
> warnings due to the excessibe size of the resulting stack frame:
> 
> arch/arm/mach-cns3xxx/pcie.c:311:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Avoid this by dynamically allocating the structure, though I am not
> convinced that we should be locally creating the struct pci_bus in the
> first place.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> 

We should certainly not make up a pci_bus here just for the purpose
of calling a common code function that comes back through a callback
to the locally defined cns3xxx_pci_read_config/cns3xxx_pci_write_config.

However, refactoring the code to do it right seems like actual work
and I'm not sure we can find anybody to do it, so your hack seems
like the best approximation.

	Arnd
