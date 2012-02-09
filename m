From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Feb 2012 08:54:40 +0000
Subject: [PATCH v6 02/15] ARM: SoC: Add per SoC SMP and CPU hotplug
 operations
In-Reply-To: <1328661059-24584-3-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120209085440.GQ889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 12:30:46AM +0000, Marc Zyngier wrote:
> Populate the SoC descriptor structure with the SMP and CPU hotplug
> operations. To allow the kernel to continue building, the platform
> hooks are defined as weak symbols which are overrided by the
> platform code. Once all platforms are converted, the "weak" attribute
> will be removed and the function made static.

NAK.

Why do we need two structures, one for init and one for non-init.  Where
these are used, they're both marked with __initdata.

If anything, you want to separate out the hotplug stuff, because you'll
be referencing __cpu* marked functions from __initdata, which I believe
will give a section mismatch warning.

Also, you'll get section mismatch warnings for calling __cpuinit functions
from __cpuexit marked code.

You did build this with CONFIG_DEBUG_SECTION_MISMATCH=y before sending it
out?

So, all in all this causes a lot of additional section mismatches, and so
needs reworking.
