From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 15 Apr 2013 10:14:02 +0100
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <d455f2823b9639af8d38d30f2c3234bd@localhost>
 <CAEDV+gJuFG49oQ=BEaCHcTP=nHVyX8ALw6076dR_C1s7TuyqXQ@mail.gmail.com>
 <d47697abd39a0d5d41f5ac110a40e261@localhost>
 <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
Message-ID: <CAFEAcA-bPoa8YoPuHPmupzfUW+yR233XquK79eNorzcRpFiK=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2013 09:54, Christoffer Dall <cdall@cs.columbia.edu> wrote:
> On Mon, Apr 15, 2013 at 1:43 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> As for the affinity, we can enforce this very easily.
>>
> OK, but let's not go down this road until we've verified that this is
> really an issue that needs to be handled by excluding A7s.  Andre, can
> you give us some more details?

We *must* exclude KVM vcpu threads from ever running on A7s,
because the cp15 handling code as it stands does not virtualize
various registers (most notably the ID/feature registers) and
so the vcpu will bounce between "looks like an A15" and "looks
like a weird hybrid between A7 and A15".

Assuming we don't want to tackle full big.LITTLE host support
right now, I can see two options:
 * forbid KVM completely on a system with any non-A15s
 * force KVM vcpus to only ever run on the A15s [Q: does
   all the hyp mode code have to also run on the A15s or
   is it A7-safe?]

-- PMM
