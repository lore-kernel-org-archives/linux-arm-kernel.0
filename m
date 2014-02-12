From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 14:10:35 +0100
Subject: [PATCH v2 03/10] ARM: mvebu: add workaround for data abort issue
 on Armada 375
In-Reply-To: <1392200619-3141-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392200619-3141-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2289743.0TLVompA6m@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014 11:23:32 Thomas Petazzoni wrote:
> +/*
> + * Early versions of Armada 375 SoC have a bug where the BootROM
> + * leaves an external data abort pending. The kernel is hit by this
> + * data abort as soon as it enters userspace, because it unmasks the
> + * data aborts at this moment. We register a custom abort handler
> + * below to ignore the first data abort to work around this problem.
> + */
> +static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
> +                                       struct pt_regs *regs)
> +{
> +       static int ignore_first;
> +
> +       if (!ignore_first) {
> +               ignore_first = 1;
> +               return 0;
> +       }
> +
> +       return 1;
> +}

I think this should try to match the fsr and addr field if possible and
only ignore the one external abort you expect.

	Arnd
