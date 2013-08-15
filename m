From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 15 Aug 2013 10:24:41 +0200
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <20130815080532.GB7080@kroah.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CABb+yY1YKGkAeb-8GbadUoV5g54iCdrYGnD_VSpaNmtfXXhpyA@mail.gmail.com>
 <CAGsJ_4yZ7Rf7UV-1u3cG_V9mrtCWD=LYBeuKQaz0SWLYoHhwwg@mail.gmail.com>
 <20130815080532.GB7080@kroah.com>
Message-ID: <CAKv+Gu9mOxoTsK5g-GX2Khvu0FSUBZRCL0Jw6F6vrMG=fNfy1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2013 10:05, Greg KH <greg@kroah.com> wrote:
> On Thu, Aug 15, 2013 at 03:45:13PM +0800, Barry Song wrote:
>> 2013/8/15 Jassi Brar <jassisinghbrar@gmail.com>:
>> > On Thu, Aug 15, 2013 at 9:58 AM, Greg KH <greg@kroah.com> wrote:
>> >> On Thu, Aug 15, 2013 at 11:44:30AM +0800, Barry Song wrote:

[...]]

>> we will run rtos+linux instead of linux+linux. typically, Auto
>> industry has long history to use rtos. on the other hand, we need to
>> boot the rtos very fast in hundreds of milliseconds to make sure
>> rearview, early audio have been ready.
>
> But Linux is a RTOS, and a really good one at that.  Linux already boots
> that fast, and solves the rearview/early audio issue just fine (I've
> seen it demoed), so please don't think that Linux can't do this.
>
> Again, what is the requirements of this RTOS that prevent you from using
> Linux instead in that "secure" part of the chip?  What do we need to
> change in order to meet this need?
>

In my experience, there are two similar yet different use cases:
- the desire to co-host a RTOS on the CPU next to Linux, to perform
real-time tasks like software defined radio, fast boot times etc.
- the desire to secure devices using TrustZone, without putting a full
fledged kernel on the secure side due to memory constraints (note that
in many designs, the only secure memory is the on-SoC SRAM)

As the requirements are almost orthogonal, we should not pretend they
are the same thing.

>> > Yes, in fact at least during development Linux usually runs in Secure mode.
>> > Ideally I would love to see 2 instances of Linux running - one in
>> > NonSecure mode and another in Secure mode, getting capabilities via 2
>> > corresponding DTBs reflecting the h/w partitioning done by the TZ.
>>
>> not real. i think there are similar users in linux already. at least
>> omap and exynos have some chip specific codes like omap-smc.S,
>> sleep34xx.S, exynos-smc.S and so on.
>>
>> and i have explained why we don't use linux+linux.
>
> I still don't understand why not.  Boot/audio don't seem like good
> reasons, again because other people have used Linux just fine for that
> application, meeting those legal requirements, in IVI systems.  I know
> of a number of companies that will sell you Linux for that very
> application, so you could just buy it from someone else if you don't
> want to build it yourself :)
>
>> >>> 3. as some CPU time is stolen by security mode, so the scheduler need
>> >>> to get this for load balance
>> >>
>> >> Does the kernel know this time is gone?  Or is it not aware of it (like
>> >> MSIs on x86?)
>> >>
>> > The TrustedOS could share time on the same cpu as the UnTrustedOS or
>> > be assigned a dedicated cpu on an MP.
>>
>> no. TrustedOS will not hold a whole CPU and we don't put a whole core
>> to RTOS as it has low CPU loading.
>> Linux need to know how much time has been taken by TrustOS for every
>> core, and do load balance considering stolen time by TrustOS.
>
> How will it be told that it just lost an amount of time?  How is that
> loss of time supposed to affect the scheduler?  What do you expect the
> scheduler to do in response to this loss?
>
> thanks,
>
> greg k-h
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
