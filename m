From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Apr 2015 18:15:40 +0200
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <5540FB2D.4080905@linaro.org>
References: <D1665A4F.19E17%suravee.suthikulpanit@amd.com>
 <5540FB2D.4080905@linaro.org>
Message-ID: <2718230.tGqneBjFr2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 09:39:25 Al Stone wrote:
> 
> When the spec was being changed for _CCA, it was determined by the ASWG
> that there was no reasonable default -- either choice would break something.
> Multiple OSs, SoC vendors, and platform vendors were asked.  So, the spec
> says for ARMv8, _CCA must be specified when needed and is not assumed to have
> any value.  Obviously, any OS can choose to behave differently, but that's
> what was specified and why it was specified that way.

Ok, so it was essentially a CYA strategy. As we know that for Linux we're
only interested in server parts here, but we also want to be compliant,
I'd still argue that we check the property value and just disallow DMA
for any device that is lacking CCA or contains zero here.

The current patch actually implements non-standard behavior: if _CCA
is missing, it registers the device as dma-capable with coherency turned
off, where my interpretation of the cited standard would be that we
treat a missing _CCA as not being able to perform DMA. What I'd like
to see instead is to only enable DMA support if _CCA is present and
enabled.

	Arnd
