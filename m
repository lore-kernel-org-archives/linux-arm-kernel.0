From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Apr 2013 16:54:01 +0100
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <201304261703.17798.arnd@arndb.de>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <1577576.O1Cm2pf5KD@wuerfel>
 <CALrVBkuyby_KY_M+yp0e=PLk=7_W_kSxxm62YYSwwp8rwLsCAQ@mail.gmail.com>
 <201304261703.17798.arnd@arndb.de>
Message-ID: <517AA319.5070709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/13 16:03, Arnd Bergmann wrote:
> On Friday 26 April 2013, Anup Patel wrote:
>> I am curious about how smh-based or hypercall-based early prints would
>> be handled in following scenario:
>>
>> "A board is running KVM ARM enabled kernel and linux console on serial
>> port. Now a user remotely connects to the board via telnet/ssh and
>> launches a VM with smh-based or hypercall-based earlyprintk."
>>
>> In the above scenario, will smh-based or hypercall-based earlyprints
>> appear to user on remote shell or not ?
> 
> The implementation of the console device would still be done by KVM,
> as for any other virtual device, so it shows up whereever kvm is
> configured to output the console data.

Actually, at least in the case of smh-based earlyprintk, the output only
appears in the model console, and never reach the rest of the kernel.

And any other non-MMIO approach (like a hypercall) will be very hard to
feed back to the console, as KVM itself has no idea of what a "console"
is. You'd need another side channel to userspace, hoping that it will be
able to merge the multiple streams.

	M.
-- 
Jazz is not dead. It just smells funny...
