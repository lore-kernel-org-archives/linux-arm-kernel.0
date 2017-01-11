From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jan 2017 15:18:23 +0000
Subject: [PATCH] arm64: assembler: make adr_l work in modules under KASLR
In-Reply-To: <1484146493-18460-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484146493-18460-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170111151822.GC26344@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Wed, Jan 11, 2017 at 02:54:53PM +0000, Ard Biesheuvel wrote:
> When CONFIG_RANDOMIZE_MODULE_REGION_FULL=y, the offset between loaded
> modules and the core kernel may exceed 4 GB, putting symbols exported
> by the core kernel out of the reach of the ordinary adrp/add instruction
> pairs used to generate relative symbol references. So make the adr_l
> macro emit a movz/movk sequence instead when executing in module context.

AFAICT, we only use adr_l in a few assembly files that shouldn't matter
to modules:

* arch/arm64/kernel/head.S
* arch/arm64/kernel/sleep.S
* arch/arm64/kvm/hyp-init.S
* arch/arm64/kvm/hyp/hyp-entry.S

... so I don't follow why we need this.

Have I missed something? Or do you intend to use this in module code in
future?

It seems somewhat surprising to me to have adr_l expand to something
that doesn't use adr/adrp, but that's not necessarily a problem.

Thanks,
Mark.
