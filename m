From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 14 Aug 2013 11:13:27 -0700
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <CAFEAcA9i59sm2pnX8YRsPsvHeuEiyNOS6yKLG3yoMBrJZz0V0Q@mail.gmail.com>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <c8a1944576151990b3315183acee02be@www.loen.fr>
 <CAFEAcA8jgn9V1ANXXTsA_099BcsbC5NHPEMRh6=Rz1g8EDgBHA@mail.gmail.com>
 <abf9b3ef779ce43b1912bf9e3deea522@www.loen.fr>
 <20130814171854.GA11390@cbox>
 <CAFEAcA9i59sm2pnX8YRsPsvHeuEiyNOS6yKLG3yoMBrJZz0V0Q@mail.gmail.com>
Message-ID: <20130814181327.GG11390@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 07:01:05PM +0100, Peter Maydell wrote:
> On 14 August 2013 18:18, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > How would we distinguish between a PSCI call that the kernel should
> > support and a call to secure firmware that needs to be forwarded to
> > QEMU?  Is this simply a binary config at VM creation time?
> 
> Kernel PSCI is always HVC (right?) so you could just say
> that HVC is the kernel's business and SMC is the guest
> firmware's.
> 

As I understand it, current implementations rely on info from the DT and
guests are therefore told only to use HVCs, but the spec allows both an
HVC and an SMC as the conduit (unless I read this wrong), so I think
it's quite possible that we'll end up supporting something that needs
make PSCI calls via SMC.  On the other hand, if QEMU can make the
distinction and do everything that the kernel would otherwise be able to
do to handle the PSCI, then we can still just let QEMU handle the whole
thing.

(feel free to replace QEMU with "user space" in the above)

> If we make the kernel just restart the guest inside its
> firmware blob without reflecting the SMC out to userspace
> are we going to regret it later?
> 

Are you suggesting that we'd load the secure firmware inside the guest
in a separate address space somehow and just let it execute the binary?
That won't work without considerable emulation efforts in the kernel to
support the privileged operations right?  What if the secure firmware
does something SoC-specific that KVM will never know about, but QEMU
would, then there's still the need for some 'backdoor' out to QEMU.

Did I misunderstand your point here?

I would imagine that at most QEMU can tell KVM to set SMC calls to
exactly one of these modes:
 1) Handle SMCs as undefined
 2) Handle SMCs as PSCI
 3) Forward all SMCs to me

And that would more or less be the end of it as far as KVM is
involved...

-Christoffer
