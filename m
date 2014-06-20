From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jun 2014 17:42:19 +0200
Subject: [RFC 1/2] pwrseq: Add subsystem to handle complex power sequences
In-Reply-To: <1403183091-27876-2-git-send-email-ulf.hansson@linaro.org>
References: <1403183091-27876-1-git-send-email-ulf.hansson@linaro.org>
 <1403183091-27876-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <4224745.HqdT4QrZdr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 June 2014 15:04:50 Ulf Hansson wrote:
> +Power sequence DT bindings
> +
> +Each power sequence method has a corresponding "power-method" property string.
> +This property shall be set in a subnode for a device. That subnode should also
> +describe resourses which are specific to that power method.
> +
> +Do note, power sequences as such isn't encoded through DT. Instead those are
> +implemented by each power method.
> +
> +Required subnode properties:
> +- power-method: should contain the string for the power method to bind.
> +
> +       Supported power methods: None.
> +
> +Example:
> +
> +Note, the "clock" power method in this example isn't actually supported, but
> +used to visualize how a childnode could be described.

I'm not too thrilled about adding another top-level concept for these.
This seems to duplicate some things that pm-domains do, but does them
in a somewhata different way. Would it be possible to instead integrate
it into the pm-domain code?

I also agree with Olof that having a standalone child device node is
not the best representation. If you want to represent an SDIO device
device that has some references to clocks, regulators, etc, then put
that device into the tree and give it those properties.
That would also let you worry about the sequencing in driver code rather
than trying to come up with a completely generic model for it.

	Arnd
