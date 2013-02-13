From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Wed, 13 Feb 2013 11:24:07 +0100
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <511A7CEB.9000006@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <20130212171310.GS17833@n2100.arm.linux.org.uk>
 <511A7CEB.9000006@codethink.co.uk>
Message-ID: <511B69C7.1080200@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks a ?crit :
> On 12/02/13 17:13, Russell King - ARM Linux wrote:
>> On Fri, Feb 08, 2013 at 11:17:30PM +0000, Ben Dooks wrote:
>>> I have been working on getting big-endian kernels working, mainly from
>>> little-endian boot envrionments. The following patch series is what I
>>> have been working on, mainly on the highbank and axp systems.
>> What is missing from this is the justification about why we need this
>> additional pain, given that all the supporting userspaces today are all
>> LE based.
>>
>> Sure, I know that telcos have an endless love of big endian and don't
>> understand anything else, but getting this working on non-telco socs
>> seems to be a little odd.
> 
> Our problem is we have some code that works on a lot of big endian data
> but is not easy to re-build to work on ARM little endian. The current 
> solution is to change to running the system big endian.
> 
> Unfortunately we cannot just run user-space big endian as the MMU is
> fetched in the same endian mode as the processor's data.
> 
Which architecture are you using ?

On armv7 the mmu endian mode is selected by SCTLR.EE [1], but userspace can
change it's endian with setend instruction [2].

As the endian state is stored in cpsr, it should be preserved across context switch.


Matthieu



[1]
Exception Endianness. This bit defines the value of the CPSR.E bit on entry to
an exception vector,
including reset. The possible values of this bit are:
0           Little-endian.
1           Big-endian.
This bit value also defines the endianness of the translation table data for
translation table lookups.
In an implementation that includes the Security Extensions, this bit is Banked
between the Secure
and Non-secure copies of the register.

[2]
The ARM and Thumb instruction sets both include an instruction to manipulate
ENDIANSTATE:
SETEND BE   Sets ENDIANSTATE to 1, for big-endian operation.
SETEND LE   Sets ENDIANSTATE to 0, for little-endian operation.
