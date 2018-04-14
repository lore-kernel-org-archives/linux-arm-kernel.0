From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Sun, 15 Apr 2018 01:44:16 +0530
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
In-Reply-To: <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
Message-ID: <CACi5LpNKbSejFecV+G8X53t4VDwsTvJywWLgLVw9qsD7u6REvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, Mar 13, 2018 at 2:28 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 12 March 2018 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> Hi Ard,
>>
>> I remember we had a discussion on this topic some time ago, but I was
>> working on enabling KASLR support on arm64 boards internally and
>> wanted to check your opinion on the following points (especially to
>> understand if there are any changes in the opinions of the ARM
>> maintainers now):
>>
>> A. Randomness / Seeding for arm64 kaslr:
>>
>> - Currently the arm64 kernel requires a bootloader to provide entropy,
>> by passing a
>>  random u64 value in '/chosen/kaslr-seed' at kernel entry (please see [1])
>>
>> - On platforms which support UEFI firmware, its the responsibility of
>> the UEFI firmware to implement EFI_RNG_PROTOCOL to supply the
>> '/chosen/kaslr-seed' property.
>>
>> - I was wondering if we have any possibility to support a random seed
>> generation like the x86 in the efistub only rather than relying on the
>> UEFI firmwares with EFI_RNG_PROTOCOL for the same - for e.g. by using
>> a randomness seed like the boot time or more proper entropy sources
>> like arm64 system timer (see [2] for x86 example).
>>
>> - I guess that the main problem is that most arm64 UEFI firmware
>> vendors still do not support EFI_RNG_PROTOCOL out of the box. We can
>> use the ChaosKey (see [3]) EFI driver and use this USB key as the
>> source of entropy on the arm64 systems for EFI firmwares which do not
>> provide a EFI_RNG_PROTOCOL implementation, but it might not be very
>> feasible to connect it to all boards in a production environment.
>>
>
> The problem is that arm64 does not have an architected means of
> obtaining entropy, and we shouldn't rely on hacks to get pseudo
> entropy.
>
> Note that EFI_RNG_PROTOCOL is not only used for KASLR, it is also used
> to seed the kernel entropy pool if the firmware provides an
> implementation of the protocol.

Coming back on this, I was doing some experimentation with kernel
modules (or extending the argument even
to user-space applications) which relies on random number generation support
from the kernel using 'getrandom' / 'get_random_bytes' kind of
syscall/kernel interface, on platforms where we don't have a
compatible EFI firmware which supports EFI_RNG_PROTOCOL, I was
thinking that there
would not be sufficient entropy (inside '/dev/urandom') available for
the caller kernel modules (or user-space applications)
and I was looking to enable 'CONFIG_WARN_ALL_UNSEEDED_RANDOM=y' to ensure that
callers of unseeded randomness in such kernel modules/user-space
applications are WARN'ed.

1. Instead I saw that random numbers are available on these platforms
starting from early boot (i.e. crng init is already done):

[root at qualcomm-amberwing]# dmesg | grep -i random
random: crng init done

2. The reason is that upstream aarch64 kernel uses the timer counter
value to generate random numbers starting from early boot (which is
probable not a good alternative when we have a compatible EFI firmware
which can pass entropy to the kernel):

'include/linux/timex.h' :
---------------------------

#define random_get_entropy()    get_cycles()

'arch/arm64/include/asm/timex.h' :
-------------------------------------------

/*
 * Use the current timer as a cycle counter since this is what we use for
 * the delay loop.
 */
#define get_cycles()    arch_timer_read_counter()

'drivers/clocksource/arm_arch_timer.c' :
--------------------------------------------------

u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;

3. And when other linux kernel modules (or even userspace
applications) try to do some random number generation using the kernel
support using 'getrandom' / 'get_random_bytes', the entropy is already
available.

So the caller would be supplied with random numbers, as I confirmed on
arm64 platforms which do not support EFI_RNG_PROTOCOL:

Also on such platforms 'wait_for_random_bytes' returns 0 indicating
that the 'urandom' pool has been seeded:

/*
 * Wait for the urandom pool to be seeded and thus guaranteed to supply
 * cryptographically secure random numbers. This applies to: the /dev/urandom
 * device, the get_random_bytes function, and the get_random_{u32,u64,int,long}
 * family of functions. Using any of these functions without first calling
 * this function forfeits the guarantee of security.
 *
 * Returns: 0 if the urandom pool has been seeded.
 *          -ERESTARTSYS if the function was interrupted by a signal.
 */
int wait_for_random_bytes(void)

4. Accordingly, I wanted to get opinions on whether arm64 timer count is a good
entropy source on platforms which indeed support EFI_RNG_PROTOCOL? And
whether we should  be looking to extend 'arch_get_random_*' or
'random_get_entropy' for arm64, to provide seed/entropy using APIs
like 'efi_random_get_seed'?

If this seems feasible I can try to take a stab at the same.

Please share your views.

Thanks,
Bhupesh
