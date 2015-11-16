From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 18:55:19 +0000
Subject: [PATCH v2 07/12] ARM: split off core mapping logic from
 create_mapping
In-Reply-To: <1447698757-8762-8-git-send-email-ard.biesheuvel@linaro.org>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-8-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151116185519.GE8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 07:32:32PM +0100, Ard Biesheuvel wrote:
> In order to be able to reuse the core mapping logic of create_mapping
> for mapping the UEFI Runtime Services into a private set of page tables,
> split it off from create_mapping() into a separate function
> __create_mapping which we will wire up in a subsequent patch.

I'm slightly worried about this.  Generally, these functions setup
global mappings.  If you're wanting to have a private set of page
tables for UEFI, and those private page tables contain global
mappings which are different from the mappings in the kernel's page
tables, then you need careful break-TLBflush-make handling when
switching from the kernel's page tables to the private UEFI ones,
and vice versa.

Has this aspect been considered?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
