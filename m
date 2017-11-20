From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 20 Nov 2017 10:45:59 -0800
Subject: [PATCH 0/2] STRICT_KERNEL_RWX weakened on ARM by CONFIG_ARM_LPAE=y
In-Reply-To: <20171109004144.2246-1-philip@cog.systems>
References: <20171109004144.2246-1-philip@cog.systems>
Message-ID: <79336dcb-fb10-5880-f888-de7179cba576@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2017 04:41 PM, Philip Derrin wrote:
> Hi,
> 
> This patch series fixes a bug which makes CONFIG_STRICT_KERNEL_RWX ineffective
> when CONFIG_ARM_LPAE is enabled. Specifically, the kernel text and rodata are
> mapped writeable. This has been the case since DEBUG_RODATA for ARM was first
> merged in 3.19.
> 
> The cause was an incorrect conflict resolution in 1e3479225acb ("ARM: 8275/1:
> mm: fix PMD_SECT_RDONLY undeclared compile error") between the commit that
> implemented DEBUG_RODATA, 80d6b0c2eed2 ("ARM: mm: allow text and rodata
> sections to be read-only"), and another that moved the LPAE read-only bit into
> a software bit, ded947798469 ("ARM: 8109/1: mm: Modify pte_write and pmd_write
> logic for LPAE").
> 
> The incorrect mappings were not apparent in the debugfs kernel_page_tables
> dump because that was checking only the software RO bit, not the hardware RO
> bit.

FWIW, on an ARCH_BRCMSTB system with ARM_LPAE=y:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
