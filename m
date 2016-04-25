From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 25 Apr 2016 16:59:22 +0100
Subject: [PATCHv3 1/5] efi/runtime-wrappers: detect FW irq flag corruption
In-Reply-To: <20160425142735.GA14974@leverpostej>
References: <1461591994-14918-1-git-send-email-mark.rutland@arm.com>
 <1461591994-14918-2-git-send-email-mark.rutland@arm.com>
 <571E25B1.8070305@arm.com>
 <20160425141557.GA2829@codeblueprint.co.uk>
 <CAKv+Gu8yH4u0-DNezUTk5b1DQJdEaH4RxR7YMQcwmkuRmEaNEw@mail.gmail.com>
 <20160425142435.GB2829@codeblueprint.co.uk>
 <20160425142735.GA14974@leverpostej>
Message-ID: <20160425155922.GC2829@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Apr, at 03:27:35PM, Mark Rutland wrote:
> 
> I have no strong preference so long as the code is correct.
> 
> Another option is to get rid of the bool entirely:
> 
> 	flags ^= cur_flags;
> 	if (!WARN_ON(flags & ARCH_EFI_IRQ_FLAGS_MASK))
> 		return;

OK, let's do the following because we need flags to be preserved for
printing,

---

	unsigned long cur_flags, mismatch;

	local_save_flags(cur_flags);

	mismatch = flags ^ cur_flags;
	if (!WARN_ON_ONCE(mismatch & ARCH_EFI_IRQ_FLAGS_MASK))
		return;
