From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Mar 2017 19:41:45 +0000
Subject: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
In-Reply-To: <31da6db5-be22-9e84-5e76-67c519bc0b34@codeaurora.org>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
 <31da6db5-be22-9e84-5e76-67c519bc0b34@codeaurora.org>
Message-ID: <CAKv+Gu8Uw-X3AR6aQYevPdRfcgPNnqL4O3sRoKxsZAiW29sbqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 March 2017 at 19:36, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/22/2017 3:31 PM, Lukas Wunner wrote:
>> On arm64 PCI systems, the entire PCI hierarchy is reconfigured from
>> scratch at boot. This may result in the GOP framebuffer address to
>> become stale, if the BAR covering the framebuffer is modified.
>
> Does this code still work with the case where resources are not reassigned on ARM64?
>
> As far as I know, kernel honors resource assignments done by the UEFI BIOS if
> they are correct. Kernel will reassign the resources only if something is wrong.
>

No, the kernel always reassigns all BARs on arm64.

> Will this code break other platforms/architectures?
>

Which platforms/architectures are you referring to? EFIFB on a PCI
device is currently broken on arm64. On x86, it works, given that BARs
are usually not reassigned, and so the patch should be a no-op in that
case (although I'd argue it is still an improvement to check whether
the device that owns the BAR actually has memory decoding enabled
before we attach the framebuffer driver to it)
