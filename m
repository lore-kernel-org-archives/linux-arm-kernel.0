From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 8 Oct 2012 17:52:05 -0400
Subject: [PATCH 14/15] KVM: ARM: Handle I/O aborts
In-Reply-To: <20121008100412.GA2302@linaro.org>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153559.21241.29970.stgit@ubuntu>
 <20120927151108.GM25916@mudshark.cambridge.arm.com>
 <CANM98qKFKU98EWNaOepjxab3h5vQypxdt_YoJbKV9kd31XUfaw@mail.gmail.com>
 <20121001125326.GA2100@linaro.org>
 <20121005090025.GK4625@n2100.arm.linux.org.uk>
 <20121008100412.GA2302@linaro.org>
Message-ID: <CANM98qKeWewjRK1neZ90jk_DYUS=TnpkG3zM47oTWPMcnR0uBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2012 at 6:04 AM, Dave Martin <dave.martin@linaro.org> wrote:
> On Fri, Oct 05, 2012 at 10:00:25AM +0100, Russell King - ARM Linux wrote:
>> On Mon, Oct 01, 2012 at 01:53:26PM +0100, Dave Martin wrote:
>> > A good starting point would be load/store emulation as this seems to be a
>> > common theme, and we would need a credible deployment for any new
>> > framework so that we know it's fit for purpose.
>>
>> Probably not actually, that code is written to be fast, because things
>> like IP stack throughput depend on it - particularly when your network
>> card can only DMA packets to 32-bit aligned addresses (resulting in
>> virtually all network data being misaligned.)
>
> A fair point, but surely it would still be worth a try?
>
> We might decide that a few particular cases of instruction decode
> should not use the generic framework for performance reaons, but in
> most cases being critically dependent on fault-driven software
> emulation for performance would be a serious mistake in the first place
> (discussions about the network code notwithstanding).
>
> This is not an argument for being slower just for the sake of it, but
> it can make sense to factor code on paths where performance is not an
> issue.
>

I'm all for unifying this stuff, but I still think it doesn't qualify
for holding back on merging KVM patches. The ARM mode instruction
decoding can definitely be cleaned up though to look more like the
Thumb2 mode decoding which will be a good step before refactoring to
use a more common framework. Currently we decode too many types of
instructions (not just the ones with cleared HSR.IV) in ARM mode, so
the whole complexity of that code can be reduced.

I'll give that a go before re-sending the KVM patch series.

-Christoffer
