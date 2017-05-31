From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 31 May 2017 08:41:01 +0000
Subject: [RFC PATCH v3 0/4] Simplify kernel-mode NEON
In-Reply-To: <20170530180219.GR3559@e103592.cambridge.arm.com>
References: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
 <20170530180219.GR3559@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu-FxRLKxTvC68Wu0_o1zjSfjWDtdA7hdK79ZTNWNXPj=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2017 at 18:02, Dave Martin <Dave.Martin@arm.com> wrote:
> On Thu, May 25, 2017 at 07:24:57PM +0100, Dave Martin wrote:
>> This series aims to simplify kernel-mode NEON.
>
> Hi Ard, do you have any further comments on this series?
>
> I'd like to have it finalised as far as possible (modulo minor tweaks
> and bugfixes) so that I can port the SVE patches on top of it.
>
> Also, how do you think we should handle merging of this change?  There's
> a flag-day issue here, since the kernel_mode_neon() API is being changed
> in an incompatible way.
>

I think the patches look fine now. The best way to merge these imo is
to start with the changes in the clients, i.e., add an arm64 specific
asm/simd.h that defines may_use_simd() as { return true; }, update all
the crypto code with the fallbacks, and put this stuff on top of that.
That way, there is a small window where the 'hint' is interpreted
differently in the sha256 code, but apart from that, we should be
bisection proof without a flag day AFAICT.

BTW I got my ZD1211 working on my MacchiatioBin board. The performance
is terrible, but that should not matter: if I can saturate a CPU doing
NEON from userland and/or kernel process context, the softirq
interruptions by the mac80211 code should exercise the updated code
paths. I haven't tried that yet: let me get the code changes out
today, so you can put your stuff on top. Then we can give it a good
spin.

-- 
Ard.
