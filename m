From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 May 2014 09:43:29 -0600
Subject: [PATCH v1 1/2] arm64: Fix machine_shutdown() definition
In-Reply-To: <1399426883-13779-1-git-send-email-arunks.linux@gmail.com>
References: <1399426883-13779-1-git-send-email-arunks.linux@gmail.com>
Message-ID: <536A54A1.8060405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 07:41 PM, arunks.linux at gmail.com wrote:
> From: Arun KS <arun.linux@gmail.com>
> 
> This patch ports most of commit 19ab428f4b79 "ARM: 7759/1: decouple CPU
> offlining from reboot/shutdown" by Stephen Warren from arch/arm to
> arch/arm64.
> 
> machine_shutdown() is a hook for kexec. Add a comment saying so, since
> it isn't obvious from the function name.
> 
> Halt, power-off, and restart have different requirements re: stopping
> secondary CPUs than kexec has. The former simply require the secondary
> CPUs to be quiesced somehow, whereas kexec requires them to be
> completely non-operational, so that no matter where the kexec target
> images are written in RAM, they won't influence operation of the
> secondary CPUS,which could happen if the CPUs were still executing some
> kind of pin loop. To this end, modify machine_halt, power_off, and
> restart to call smp_send_stop() directly, rather than calling
> machine_shutdown().
> 
> In machine_shutdown(), replace the call to smp_send_stop() with a call
> to disable_nonboot_cpus(). This completely disables all but one CPU,
> thus satisfying the kexec requirements a couple paragraphs above.

I assume the code changes apply equally well to arm64 so,
Acked-by: Stephen Warren <swarren@nvidia.com>
