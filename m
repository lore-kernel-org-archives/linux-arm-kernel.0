From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 03 Apr 2017 10:21:34 +0100
Subject: [PATCH v35 08/14] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20170403022440.12515-6-takahiro.akashi@linaro.org>
References: <20170403022139.12383-1-takahiro.akashi@linaro.org>
 <20170403022440.12515-6-takahiro.akashi@linaro.org>
Message-ID: <1491211294.6020.21.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-04-03 at 11:24 +0900, AKASHI Takahiro wrote:
> 
> +static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs
> *regs)
> +{
> +#ifdef CONFIG_KEXEC_CORE
> +???????crash_save_cpu(regs, cpu);
> +
> +???????atomic_dec(&waiting_for_crash_ipi);
> +
> +???????local_irq_disable();

Shouldn't the above two be the other way round? Stop handling
interrupts *before* we tell the surviving CPU that we're done?

Also, should the surviving CPU be calling __cpu_die() to attempt to
check that the others really have died? Sure, it can't do much more
than print a warning if the call to ->cpu_kill() times out, but that's
still useful information. And perhaps we could allow platforms to
register a method to shoot other CPUs down forcefully if they don't
respond. My board could apparently support that.

It would certainly be useful to allow smp_send_crash_stop() to be
overridden with a platform-specific method instead of normal IPIs. The
platform might be able to do something... less maskable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/694d66c3/attachment.bin>
