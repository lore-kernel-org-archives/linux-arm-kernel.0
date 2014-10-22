From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Oct 2014 17:59:17 +0100
Subject: [PATCH] arm64/crypto: use crypto instructions for generating AES
 key schedule
In-Reply-To: <CAKv+Gu-C73c5y71338jn2mXsS4t7A7SQZVwuYCGOFpZv=uQJpQ@mail.gmail.com>
References: <1413962132-19882-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141022162548.GH15370@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-C73c5y71338jn2mXsS4t7A7SQZVwuYCGOFpZv=uQJpQ@mail.gmail.com>
Message-ID: <20141022165917.GJ15370@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 05:31:32PM +0100, Ard Biesheuvel wrote:
> On 22 October 2014 18:25, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, Oct 22, 2014 at 08:15:32AM +0100, Ard Biesheuvel wrote:
> >> This patch implements the AES key schedule generation using ARMv8
> >> Crypto Instructions. It replaces the table based C implementation
> >> in aes_generic.ko, which means we can drop the dependency on that
> >> module.
> >
> > I don't really understand the AES stuff but there's something else I
> > noticed: if you build a kernel with the crypto stuff and run it on an
> > implementation that does not have the crypto extensions, there does not
> > seem to be any check for not using these algorithms (or falling back to
> > the generic implementation). Does the kernel end up with undef faults?
> 
> No, that is handled by
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=67bad2fdb754dbef14596c0b5d28b3a12c8dfe84
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3be1a5c4f75989cf457f13f38ff0913dff6d4996
> 
> and the modules use module_cpu_feature_match(), so they are only
> installed if the corresponding hwcap bit is set.

Ah, I remember that now. Does this allow to use the generic C
implementation if the crypto extensions aren't available?

-- 
Catalin
