From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Feb 2018 15:51:09 +0000
Subject: Internal error: Oops - BUG() / kvm boot race - arm64 kpti
 patchset related
In-Reply-To: <20180228154523.GA29931@akinoame>
References: <20180228154523.GA29931@akinoame>
Message-ID: <CAKv+Gu-AkN=PE7+q2R_QADoAcsd=Z+xgPXutTwSqb_oBUr-gpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 February 2018 at 15:45, Paolo Pisati <p.pisati@gmail.com> wrote:
> Reproducible on 4.16-rc3 and 4.4.20 using defconfig - the failure it's
> intermittent, but i could reproduce it 100% if i boot loop the kvm instance
> (it usually shows up in less than 10 iterations but i tested 32 boots before
> marking it good).
>
> I bisected it down to this interval in linux-4.14.y:
>
> 2feb36e arm64: kpti: Add ->enable callback to remap swapper using nG mappings
> ee28fed arm64: mm: Permit transitioning from Global to Non-Global without BBM
> 6928820 arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
> c98c8c2 arm64: Turn on KPTI only on CPUs that need it
>
> c98c8c2 is good, 2feb36e is bad - couldn't bisect in between, since it didn't
> boot there.
> And yes, when i tested 2feb36e i applied the "el1 trashing fix" mentioned here:
> https://www.spinics.net/lists/arm-kernel/msg636489.html
>
> Anything else i can do to help debug this?

First of al, v4.4.20 ?!? How on earth could that have anything to do with KPTI?

In any case, you could try whether this patch helps at all, or at
least makes your bisect less inconclusive.

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=fixes/core&id=753e8abc36b2c966caea075db0c845563c8a19bf
