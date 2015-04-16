From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Thu, 16 Apr 2015 18:53:42 +0200
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <CANOLnOMyNesvA2nGC2uMnmYGLBQkU1dnfG1rBg1UWeGMrpHFzQ@mail.gmail.com>
References: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com> <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com> <20150406174245.GJ18048@atomide.com>
 <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
 <20150407022312.GK18048@atomide.com>
 <CANOLnOMyNesvA2nGC2uMnmYGLBQkU1dnfG1rBg1UWeGMrpHFzQ@mail.gmail.com>
Message-ID: <CAALWOA-niC8F2S9nTCgMficRqin=z_q_U5ifSVgwTTh537=6og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2015 at 00:37, Grazvydas Ignotas <notasas@gmail.com> wrote:
> May I ask how do you perform the smc call?

A point worth mentioning is that TI advises that r1-r4 may be
clobbered in general, and at least on GP dm814x and am335x devices r4
is in fact clobbered, even though it is normally a callee-save
register.

Also, on aforementioned devices, the secure-world MMU is enabled, with
translation table 0 being 1KB @ 0x402f2000, used for secure VA
0x00000000 - 0x0fffffff (the rest goes via translation table 1 in
secure ROM). It is generally not consulted in practice since secrom
locks two dTLB and two iTLB entries. The GP secure monitor doesn't
actually perform any data access whatsoever, so the two dTLB can and
should be unlocked considering that TLB entries are a rather scarce
resource (32 per side) and a dTLB miss incurs a 24-cycle minimum
penalty (compare with 8-cycle minimum penalty for L1 cache miss).

Unlocking the second iTLB entry is also safe, but if both iTLB entries
are unlocked, you need to preserve or repopulate the relevant
translation entry (VA 0x00300000 -> PA 0x00000000) to be able to
perform an SMC. Everything that happens in secure monitor mode is
heavily double-checked by the SSM, so while you're free to choose a
cache policy, any creativity beyond that will piss off the SSM and
cause it to hit the "MPU security violation" global reset.

Once appropriate fixes to the auxiliary control register have been
applied, generally no further SMCs are needed hence all TLB entries
can be unlocked. Since it would be reasonable for a bootloader to do
this, I recommend checking whether a fix is needed and not
unconditionally performing an SMC.
