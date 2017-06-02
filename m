From: james.morse@arm.com (James Morse)
Date: Fri, 02 Jun 2017 09:23:28 +0100
Subject: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
In-Reply-To: <cover.1495514291.git.panand@redhat.com>
References: <cover.1495514291.git.panand@redhat.com>
Message-ID: <59312080.1090906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 23/05/17 06:02, Pratyush Anand wrote:
> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
> is around 13MB and initramfs is around 30MB. It takes more than 20 second
> even when we have -O2 optimization enabled. However, if dcache is enabled
> during purgatory execution then, it takes just a second in SHA
> verification.
> 
> Therefore, these patches adds support for dcache enabling facility during
> purgatory execution.

I'm still not convinced we need this. Moving the SHA verification to happen
before the dcache+mmu are disabled would also solve the delay problem, and we
can print an error message or fail the syscall.

For kexec we don't expect memory corruption, what are we testing for?
I can see the use for kdump, but the kdump-kernel is unmapped so the kernel
can't accidentally write over it.

(we discussed all this last time, but it fizzled-out. If you and the
 kexec-tools maintainer think its necessary, fine by me!)

I have some comments on making this code easier to maintain..


Thanks,

James
