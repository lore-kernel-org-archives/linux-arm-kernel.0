From: james.morse@arm.com (James Morse)
Date: Wed, 13 Apr 2016 17:35:09 +0100
Subject: [PATCH v7 16/16] arm64: hibernate: Prevent resume from a different
 kernel version
In-Reply-To: <CAKv+Gu-3iATexGcGCdqvvWsEya64iMpLKcDhSh-d70MfmV3ZwA@mail.gmail.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>	<1459529620-22150-17-git-send-email-james.morse@arm.com>
 <CAKv+Gu-3iATexGcGCdqvvWsEya64iMpLKcDhSh-d70MfmV3ZwA@mail.gmail.com>
Message-ID: <570E753D.4030508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 10/04/16 13:16, Ard Biesheuvel wrote:
> On 1 April 2016 at 18:53, James Morse <james.morse@arm.com> wrote:
>> Resuming using a different kernel version is fragile, while there are
>> sufficient details in the hibernate arch-header to perform the restore,
>> changes in the boot process can have a long-lasting impact on the system.
>> In particular, if the EFI stub causes more runtime services memory to be
>> allocated,
> 
> Actually, the UEFI stub does not allocate any runtime service code or
> data memory, that is all done by the firmware itself before even
> invoking the kernel or the stub. The allocations performed by the stub
> are for the command line, the UEFI memory map, the kernel image and
> optionally an initrd, none if which have any significance to the
> firmware itself, so allocating runtime services memory for them does
> not make a lot of sense.

Thanks for putting me straight on this. I got these weird failures when
hibernate/restoring over your kaslr series, I mistakenly believed the addition
of locate_protocol/get_random was causing some extra initialisation. In
hindsight it was probably the kernels new ability to use the memory below the
kernel.


Thanks,

James
