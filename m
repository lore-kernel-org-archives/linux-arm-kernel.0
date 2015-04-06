From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Mon, 6 Apr 2015 20:14:30 +0200
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <20150406174245.GJ18048@atomide.com>
References: <551F186B.90608@gmail.com> <20150403225212.GY10805@atomide.com>
 <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com> <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com> <20150406174245.GJ18048@atomide.com>
Message-ID: <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [150406 10:15]:
> Why custom function, if IBE bit is zero, BTB invalidate instruction is a
> NOP. Do you think that "mcr p15, 0, r2, c7, c5, 6" executed as a NOP will
> put so much overhead, that it deserves a custom function?

Executing them as nop is Cortex-A8 specific. On other ARMv7 CPUs, BTB
invalidation on context switch may be unnecessary yet expensive.

In general I think you'll want a version with and one without BTB
flushing, and select depending on CPUID (ID_MMFR1, bits 28-31), with
overrides for known processor issues (i.e. the cortex-a8 has a wrong
value there in all cases: it reports value 2, while it should be
treated as 1 or 4 depending on cpu revision).


On 6 April 2015 at 19:42, Tony Lindgren <tony@atomide.com> wrote:
> Hmm but it still seems to do something also on cortex-a8 r3p2 that
> is supposedly not affected by 430973.. Based on my tests so far, at least
> armhf running cpuburn-a8 in the background and doing apt-get update
> segfaults constantly without flush BTAC/BTB. This seems to be the case
> no matter how the aux ctrl reg bits are set..

That sounds.... really odd.  The TRM is fairly explicit about BTB
flush executing as nop when IBE is not set. Of course the TRM is not
exactly flawless, but still...


>> 2. For Cortex-A8 revisions affected by 430973, set IBE bit to 1, set it
>>    to 0 for all others.

Note btw that erratum 687067 affects *all* Cortex-A8 revisions, so
there's a bit of a catch-22 there. The proper workaround for it
(zeroing some particular debug register) can only be done in secure
privileged mode, and there's no straightforward way to check whether
this has been done.

However, it only affects BTB invalidate by MVA, afaik BTB invalidate
all is safe.

>>  That should happen as soon as possible,
>>  otherwise kernel may crash on affected revisions if thumb-compiled.

The right place to do this to be honest would be in the bootloader,
but I guess that's not always convenient to arrange...

Matthijs
