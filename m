From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jan 2014 15:44:17 +0000
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <20140124151513.GD19052@arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com>
 <20140122114537.GA15591@e106331-lin.cambridge.arm.com>
 <52E1B1DE.5050507@linaro.org>
 <20140124120815.GH814@e106331-lin.cambridge.arm.com>
 <20140124151513.GD19052@arm.com>
Message-ID: <20140124154417.GB4758@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 03:15:13PM +0000, Catalin Marinas wrote:
> Do we still need the chosen node to be passed via DT for command line,
> even if the kernel uses ACPI?

It depends on how the kernel is booted.

If not booted as a UEFI application, then the user would have to provide
a dtb to pass the command line.

If booted as a UEFI application, the kernel can retrieve the commandline
from UEFI and handle it appropriately (this _might_ involve the EFI stub
building a dtb with a chosen node and pasing that to the kernel, but
that could change as it's within the kernel). In that case, the user
need not build a dtb manually.

However, I'd expect that we use a restricted dtb with only a /chosen
node for passing additional data as an equivalent to x86's bootargs
(which would contain the location of ACPI tables and possibly other
stuff like initrd location if not passed on the command line). That
makes the very early logic in the kernel much simpler, and it gives us
an extensible format that should limit headaches in future.

So if booted with ACPI we _might_ have a restricted chosen-only dtb,
which _might_ be passed to the kernel explicitly by the user.

Thanks,
Mark.
