From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 13 Feb 2013 16:02:33 +0000
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <20130213155220.GC12685@arm.com>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <20130212171310.GS17833@n2100.arm.linux.org.uk>
 <511A7CEB.9000006@codethink.co.uk> <511B69C7.1080200@parrot.com>
 <511B768B.7000302@codethink.co.uk> <20130213155220.GC12685@arm.com>
Message-ID: <511BB919.1070806@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/13 15:52, Catalin Marinas wrote:
> On Wed, Feb 13, 2013 at 11:18:35AM +0000, Ben Dooks wrote:
>> On 13/02/13 10:24, Matthieu CASTET wrote:
>>> Ben Dooks a ?crit :
>>>> On 12/02/13 17:13, Russell King - ARM Linux wrote:
>>>>> On Fri, Feb 08, 2013 at 11:17:30PM +0000, Ben Dooks wrote:
>>>>>> I have been working on getting big-endian kernels working, mainly from
>>>>>> little-endian boot envrionments. The following patch series is what I
>>>>>> have been working on, mainly on the highbank and axp systems.
>>>>> What is missing from this is the justification about why we need this
>>>>> additional pain, given that all the supporting userspaces today are all
>>>>> LE based.
>>>>>
>>>>> Sure, I know that telcos have an endless love of big endian and don't
>>>>> understand anything else, but getting this working on non-telco socs
>>>>> seems to be a little odd.
>>>>
>>>> Our problem is we have some code that works on a lot of big endian data
>>>> but is not easy to re-build to work on ARM little endian. The current
>>>> solution is to change to running the system big endian.
>>>>
>>>> Unfortunately we cannot just run user-space big endian as the MMU is
>>>> fetched in the same endian mode as the processor's data.
>>>>
>>> Which architecture are you using ?
>>>
>>> On armv7 the mmu endian mode is selected by SCTLR.EE [1], but userspace can
>>> change it's endian with setend instruction [2].
>>>
>>> As the endian state is stored in cpsr, it should be preserved across context switch.
>>
>> Ah yes, I got confused as there is also an endian mode for the page
>> tables that needs to match the endian mode that the kernel is doing
>> loads/stores in.
>>
>> However if we had BE userland with LE kernel then things are going to
>> get difficult with a BE<>LE syscall issue.
>
> I had an (insane) idea once but no time to pursue. You can enable the
> 'compat' layer for a 32-bit ARM kernel and define all the compat_* types
> to be the same as the native ones. The compat layer has several handlers
> for syscalls which pretty much do the conversion between compat and
> native structures. The compat structures are read/written from/to user
> using get_user/put_user on each member. You then need change the ARM
> get_user/put_user code to test a new TIF_BE flag and do a 'rev' on the
> data. At this point the native kernel structures would have the correct
> little endianness.
>
> I reckon the above would cover 70-80% of the syscalls. You need to chase
> other syscalls and update the binfmt_elf.c to cope with BE ELF files.
> Probably there are other issues as well.

Yes, it is far more work than just running the entire system BE, but
could be done. I however only have a budget of a beer, or maybe two
beers if pushing it.

I might have a go at this if I have some spare time

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
