From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 15 Apr 2013 10:45:14 +0100
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <516BCAD0.9000708@linaro.org>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <d455f2823b9639af8d38d30f2c3234bd@localhost>
 <CAEDV+gJuFG49oQ=BEaCHcTP=nHVyX8ALw6076dR_C1s7TuyqXQ@mail.gmail.com>
 <d47697abd39a0d5d41f5ac110a40e261@localhost>
 <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
 <CAFEAcA-bPoa8YoPuHPmupzfUW+yR233XquK79eNorzcRpFiK=g@mail.gmail.com>
 <516BCAD0.9000708@linaro.org>
Message-ID: <CAFEAcA88OpCB63kYuUHS6fUn027SvVWNEozL0EbrjoMEeQdykg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2013 10:39, Andre Przywara <andre.przywara@linaro.org> wrote:
> On 04/15/2013 11:14 AM, Peter Maydell wrote:
>> We *must* exclude KVM vcpu threads from ever running on A7s,
>> because the cp15 handling code as it stands does not virtualize
>> various registers (most notably the ID/feature registers) and
>> so the vcpu will bounce between "looks like an A15" and "looks
>> like a weird hybrid between A7 and A15".
>
> Can't we propagate some least common denominator or safe values for those
> registers instead of propagating the host ones? Or ignore writes to them? Or
> are there any real showstoppers which I overlooked?

Yes, we could do all these things, and will have to; and
we need to analyse all the cp15 registers to determine which
we need to virtualize and in which of these ways. This is
"tackling full big.LITTLE host support" and it is a big job.
We need to do it at some point but for the moment we should
just make sure we don't do weird and wrong things on an
unsupported host config.

-- PMM
