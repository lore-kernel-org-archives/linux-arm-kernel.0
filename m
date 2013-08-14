From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 14 Aug 2013 19:22:07 +0100
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <20130814181327.GG11390@cbox>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <c8a1944576151990b3315183acee02be@www.loen.fr>
 <CAFEAcA8jgn9V1ANXXTsA_099BcsbC5NHPEMRh6=Rz1g8EDgBHA@mail.gmail.com>
 <abf9b3ef779ce43b1912bf9e3deea522@www.loen.fr> <20130814171854.GA11390@cbox>
 <CAFEAcA9i59sm2pnX8YRsPsvHeuEiyNOS6yKLG3yoMBrJZz0V0Q@mail.gmail.com>
 <20130814181327.GG11390@cbox>
Message-ID: <CAFEAcA-a0R-aLy0CXVv4HeLXDR5n8ONoPEDOJDh6dvZcwX6rTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2013 19:13, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Wed, Aug 14, 2013 at 07:01:05PM +0100, Peter Maydell wrote:
>> If we make the kernel just restart the guest inside its
>> firmware blob without reflecting the SMC out to userspace
>> are we going to regret it later?
>
> Are you suggesting that we'd load the secure firmware inside the guest
> in a separate address space somehow and just let it execute the binary?
> That won't work without considerable emulation efforts in the kernel to
> support the privileged operations right?  What if the secure firmware
> does something SoC-specific that KVM will never know about, but QEMU
> would, then there's still the need for some 'backdoor' out to QEMU.

No, the suggestion is that the 'firmware' blob is a specifically
written thing to work with QEMU/KVM, so it supports the right
entry points but is written to work within a slightly odd
environment where:
 * the kernel supports an emulated MVBAR
 * SMC causes us to redirect the guest so it enters as per
   the MVBAR, but in EL1, not EL3
 * the "firmware" blob does whatever is necessary before
   returning from the SMC

There is obviously no insulation between the guest kernel and the
firmware blob in this scenario, but if we're not actually trying
to emulate secure mode, just deal somehow with a handful of API
calls, that should be fine.

(This is an idea I've floated before, based partly on what the
current QEMU OMAP3 emulation does. The advantage from my point of
view is that it keeps the details of what the SMC entrypoints
are supposed to do out of QEMU and in the board-specific blob.)

-- PMM
