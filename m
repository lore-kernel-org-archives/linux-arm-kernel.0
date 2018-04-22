From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Apr 2018 13:32:15 +0200
Subject: random.c regression on arm64 EFI systems
Message-ID: <CAKv+Gu9yKSF=XdHFD4bQEZar+RQxtPjR+a6NrSXCTdu_j6+iaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Today's pull of random.c changes caused a regression on arm64 UEFI
systems that invoke EFI_RNG_PROTOCOL to obtain strong entropy from the
platform. (arm64 does not have an architected instruction a la RDRAND)

Before (grep'ing dmesg for entropy, rng, random):

  efi:  ...  RNG=0xff7bc898
  efi: seeding entropy pool
  random: fast init done
  ...
  random: crng init done

After:

  efi:  ...  RNG=0xff7ac898
  efi: seeding entropy pool
  ...
  random: get_random_bytes called from start_kernel+0xb4/0x48c with crng_init=0
  ...
  random: fast init done
  ...
  random: systemd: uninitialized urandom read (16 bytes read)
  random: systemd: uninitialized urandom read (16 bytes read)
  random: systemd: uninitialized urandom read (16 bytes read)
  random: systemd: uninitialized urandom read (16 bytes read)
  random: systemd: uninitialized urandom read (16 bytes read)
  random: systemd: uninitialized urandom read (16 bytes read)
  random: systemd: uninitialized urandom read (16 bytes read)
  random: systemd: uninitialized urandom read (16 bytes read)
  random: systemd: uninitialized urandom read (16 bytes read)
  random: systemd: uninitialized urandom read (16 bytes read)
  ...
  random: crng init done

The current EFI code uses add_device_randomness() to pass the firmware
provided strong random seed to the kernel, for lack of a more
appropriate interface (at the time, at least).

I tried to switch to add_hwgenerator_randomness(), which seems more
appropriate, but it appears to me that it is impossible to get the
kernel entropy pool into the fully initialized state (crng_init=2)
using that without some dodgy tricks.

Comments and ideas welcome.

Thanks,
Ard.
